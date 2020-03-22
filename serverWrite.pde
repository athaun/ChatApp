import processing.net.*;

String lastUserInput = "";

void serverMessageSender() {
  if (sendMessage == true && keyCode != 0 && userInput != "") {
    if (userInput != lastUserInput) {
      myServer.write(myName + "/divider " + userInput + "/end");// sends message to client (s)
      updateMessages(myName + "/divider " + userInput + "/end");// displays the message on the server side
      lastUserInput = userInput;
      userInput = ""; // Clears the input text box
      typing = "";
    } else {
      // if (keyCode != 0 && userInput != "") {
        // just spams the client with nothing if no messages have been sent yet (dirty fix for a null check on the client side)
        // myServer.write(myName + "/divider nothing/end");
      // }
    }
    sendMessage  = false;
  }
  fill(255);
  text(userInput, 10, height - 11.5);
}
