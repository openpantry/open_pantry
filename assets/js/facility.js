export default function(channel){
  const intFromFindClass = (parent, className) => parseInt(parent.find(className).html(), 10)
  const getAvailable     = (row) => intFromFindClass(row, '.js-available-quantity')
  const getQuantity      = (row) => intFromFindClass(row, '.js-current-quantity')
  const getCost          = (row) => intFromFindClass(row, '.js-credit-cost')
  const getCredits       = (row) => intFromFindClass(row.parents('.js-stock-type'), '.js-credit-count')
  const getType          = (row) => row.parents('.js-stock-type').find('.js-credit-count').data('credit-type')
  const setUserQuantity  = (row, newQuantity) => row.find('.js-current-quantity').html(newQuantity)
  const setTotalQuantity = (row, newQuantity) => row.find('.js-available-quantity').html(newQuantity)
  const setCredits       = (row, newQuantity) => row.parents('.js-stock-type').find('.js-credit-count').html(newQuantity)
  var fn;
  let handlers = {
    "js-add-stock": function(row){
      const credits = getCredits(row);
      const cost    = getCost(row);
      if (getAvailable(row) > 0 && credits >= cost) {
        channel.push('request_stock', { id: row.data('stock-id'), quantity: 1, type: getType(row) });
        setUserQuantity(row, getQuantity(row) + 1);
        setCredits(row, credits - cost);
      }
    },
    "js-remove-stock": function(row){
      const currentQuantity = getQuantity(row)
      if (currentQuantity > 0) {
        const credits = getCredits(row);
        const cost    = getCost(row);
        channel.push('release_stock', { id: row.data('stock-id'), quantity: 1, type: getType(row) });
        setUserQuantity(row, currentQuantity - 1);
        setCredits(row, credits + cost);
      }
    },
    "js-clear-stock": function(row){
      const currentQuantity = getQuantity(row)
      if (currentQuantity > 0) {
        const credits = getCredits(row);
        const cost    = getCost(row);
        channel.push('release_stock', { id: row.data('stock-id'), quantity: getQuantity(row), type: getType(row) });
        setUserQuantity(row, 0)
        setCredits(row, credits + cost * currentQuantity);
      }
    }
  }


  $('.js-stock-row').on('click', function(el){
    if (fn = handlers[el.target.className]){
      fn($(el.currentTarget));
    };
  })

  channel.on('set_stock', payload => {
    const {id, quantity} = payload;
    setTotalQuantity($(`*[data-stock-id="${id}"]`), quantity);
  });

  channel.on('current_credits', payload => {
    $.each(payload, (type, credits) => $(`#${type}`).find('.js-credit-count').html(credits) )
  });

  channel.on('update_distribution', payload => {
    const {id, html} = payload;
    const $html = $(html)
    const existing = $('.js-cart').find(`*[data-stock-distribution-id="${id}"]`).first();
    const quantity = intFromFindClass($html, '.js-quantity-requested')

    if (existing.length && quantity > 0) {
      $(existing).html($html.html())
    } else if (existing.length && quantity == 0) {
      $(existing).remove()
    } else {
      $('.js-cart').find('tbody').append(html)
    }
  });

}