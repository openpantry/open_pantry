// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"
socket.connect();
let channel = socket.channel(`facility:${window.facilityId}`, {});
channel.join();
$(function(){
  const getAvailable = (row) => parseInt(row.find('.available').html())
  const getQuantity = (row) => parseInt(row.find('.current-quantity').html())
  const setQuantity = (row, newQuantity) => row.find('.current-quantity').html(newQuantity)

  var fn;
  let handlers = {
    "js-add-stock": function(row){
      if (getAvailable(row) > 0) {
        channel.push('request_stock', { id: row.data('stock-id'), quantity: 1 });
        setQuantity(row, getQuantity(row) + 1)
      }
    },
    "js-remove-stock": function(row){
      const currentQuantity = getQuantity(row)
      if (currentQuantity > 0) {
        channel.push('release_stock', { id: row.data('stock-id'), quantity: 1 });
        setQuantity(row, currentQuantity - 1)
      }
    },
    "js-clear-stock": function(row){
      channel.push('release_stock', { id: row.data('stock-id'), quantity: getQuantity(row) });
      setQuantity(row, 0)
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

})
