​​let​ Facility = {
​
​    init(socket, element){ ​if​(!element){ ​return​ }

​    ​let​ facilityId  = element.getAttribute(​"data-facility-id"​)
​    socket.connect()
​    this​.onReady(facilityId, socket)
​  },
​
​  onReady(facilityId, socket){
​    ​let​ facilityChannel   = socket.channel(​"facility:"​ + facilityId)
​  }
​}
​export​ ​default​ Facility