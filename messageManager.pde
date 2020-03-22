import java.awt.Robot;
//String[] messengers = {"Ethan", "Asher"};
int numberOfMessages = 0;
int messageIndex = 0;
String latestMessage;
String previousMessage = "";
ArrayList<String> messages = new ArrayList<String>();

void serverRead () {
  Client clients[] = myServer.clients;
  for (int index = 0; index < myServer.clientCount; index++) {
    if (clients[index].active()) {
      while (clients[index].available() > 0) {
        // Checks each client for available bits, if so it reads them
        latestMessage = clients[index].readString();
      }
    }
  }
}

void clientRead () {
  if (myClient.available() > 0) {
    // Check if the number of available bits is greater than 0
    latestMessage = myClient.readString();
    numberOfMessages ++;
  }
}

boolean firstJoin = true;

void broadcastEvents () {
    if (myClient.active()) {
        if (firstJoin) {

            // Forcing a join message
            try {
                logEvent(myName + " has joined the server", 'i');
                typing = myName + " joined the server";
                Robot robot = new Robot();
                robot.keyPress(ENTER); // Forcing the return key to be pressed
                robot.keyRelease(ENTER);
            } catch (Exception e) {
                e.printStackTrace();
            }
            firstJoin = false;
        }
    }
}

void checkForMessages () {

  // Server read is slightly different than client read, so we must switch based upon which is running
  if (state == 1) {
    serverRead();
  } else if (state == 2) {
    clientRead();
    broadcastEvents();
  }

  // Add the latest received string to the messages array (to be displayed in the GUI) | if the message is not nothing (either "" or null), and isn't a duplicate of the previous message
  if (latestMessage != null && latestMessage != "" && latestMessage != previousMessage) {
    updateMessages(latestMessage);
    //println("broadcastEvents called");
    //broadcastEvents();
    previousMessage = latestMessage;
    latestMessage = "";
  }
}

void updateMessages (String latest) {
  // This parses the raw message (sender/divider message/end) into sender & message (available in the messages array)
  if (latest != null) {
    String end[] = latest.split("/end");
    for (int i = 0; i < end.length; i ++) {
      String divider[] = end[i].split("/divider");
      for (int j = 0; j < divider.length; j ++) {
        messages.add(divider[j]);
      }
    }
  }
}

String getLatestSender () {
  // Getter used in the GUI to get the sender after parsing
  if (messages.size() > 0) {
    return messages.get(messages.size() - 2).trim();
  } else {
    return null;
  }
}

ArrayList getAllMessages() {
  return messages;
}
