export default function(channel){
  const getAvailable = (row) => parseInt(row.find('.available').html())
  const getQuantity  = (row) => parseInt(row.find('.current-quantity').html())
  const getCost      = (row) => parseInt(row.find('.js-credit-cost').html())
  const getCredits   = (row) => parseInt(row.parents('.tab-pane').find('.js-credit-count').html())
  const setQuantity  = (row, newQuantity) => row.find('.current-quantity').html(newQuantity)
  const setCredits   = (row, newQuantity) => row.parents('.tab-pane').find('.js-credit-count').html(newQuantity)

  var fn;
  let handlers = {
    "js-add-stock": function(row){
      const credits = getCredits(row);
      const cost    = getCost(row);
      if (getAvailable(row) > 0 && credits >= cost) {
        channel.push('request_stock', { id: row.data('stock-id'), quantity: 1 });
        setQuantity(row, getQuantity(row) + 1);
        setCredits(row, credits - cost);
      }
    },
    "js-remove-stock": function(row){
      const currentQuantity = getQuantity(row)
      if (currentQuantity > 0) {
        const credits = getCredits(row);
        const cost    = getCost(row);
        channel.push('release_stock', { id: row.data('stock-id'), quantity: 1 });
        setQuantity(row, currentQuantity - 1);
        setCredits(row, credits + cost);
      }
    },
    "js-clear-stock": function(row){
      const currentQuantity = getQuantity(row)
      if (currentQuantity > 0) {
        const credits = getCredits(row);
        const cost    = getCost(row);
        channel.push('release_stock', { id: row.data('stock-id'), quantity: getQuantity(row) });
        setQuantity(row, 0)
        setCredits(row, credits + cost * currentQuantity);
      }
    }
  }


  $('.js-stock-row').on('click', function(el){
    if (fn = handlers[el.target.className]){
      fn($(el.currentTarget));
    };
  })

  channel.on('add_stock', payload => {

  });


  channel.on('remove_stock', payload => {

  });

}