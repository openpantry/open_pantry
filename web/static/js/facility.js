export default function(channel){
  const getAvailable     = (row) => parseInt(row.find('.js-available-quantity').html())
  const getQuantity      = (row) => parseInt(row.find('.js-current-quantity').html())
  const getCost          = (row) => parseInt(row.find('.js-credit-cost').html())
  const getCredits       = (row) => parseInt(row.parents('.js-stock-type').find('.js-credit-count').html())
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
    var {id, quantity} = payload;
    setTotalQuantity($(`*[data-stock-id="${id}"]`), quantity);
  });

  channel.on('current_credits', payload => {
    $.each(payload, (type, credits) => $(`#${type}`).find('.js-credit-count').html(credits) )
  });

}