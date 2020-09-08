const connectedPorts = [];

onconnect = function(e) {
  var port = e.ports[0];

  connectedPorts.push(port);

  port.onmessage = function(e) {
    console.log('received a message at the shared worker', e);
    connectedPorts.forEach(port => {
      port.postMessage('Sending a message back from the shared worker');
    });
  }

}