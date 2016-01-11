var five = require("johnny-five");
var SerialPort = require("serialport").SerialPort;

console.info("Initializing port...");
var board = new five.Board({
  port: new SerialPort("/dev/ttyAMA0", { baudrate: 57600 })
});

board.on("ready", function() {

  console.info("Board ready. Blinking LED on PIN 13");

  // Create a standard `led` component instance
  var led = new five.Led(13);

  // "blink" the led in 500ms
  // on-off phase periods
  led.blink(500);
});


