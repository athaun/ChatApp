import processing.net.*;

void clientMessageSender() {
  if (sendMessage == true && keyCode != 0 && userInput != "") {
    // Checks for duplicate messages
    if (userInput != lastUserInput) {
      myClient.write(myName + "/divider " + userInput + "/end"); // Sends the message to the server
      updateMessages(myName + "/divider " + userInput + "/end"); // Displays the message on the client side
      lastUserInput = userInput;
      userInput = ""; // Clears the input text box
      typing = "";
    } else {
      // if (keyCode != 0 && userInput != "") {
        // Just spams the client with nothing if no messages have been sent yet (dirty fix for a null check on the client side)
        // myClient.write(myName + "/divider nothing/end");
      // }
    }
    sendMessage = false;
  }
  fill(255);
  text(userInput, 10, height - 11.5);
}
