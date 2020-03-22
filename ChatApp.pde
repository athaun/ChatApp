/**
TODO:
- fix occasionally sending empty message (when pressing return...)
- Fix the client button not updating after the server is started and closed
- add scroll
- Log messages for special events (like client leaving, so on)
- Add a ping command
- Change the clientWrite.pde to be more flexible (especially with join messages)
- finish settings
- add send button
- add clipboard
- add edit last message with '*'
- add text wrap- grey out client button when no server is running
- fix "dirty fix" where we are sending "nothing" all the time
- basic emojis
- NOTE: fix error (chatGui.pde:20:0:20:0: IndexOutOfBoundsException: Index: 31, Size: 31)
- NOTE: commented 'dirty fix for null check' on line 15 (clientWrite) and 16 (serverWrite)
*/

import java.util.ArrayList;
import processing.net.*;
Client myClient;
Server myServer;
int port = 8080;

PFont roboto;
PImage cog;

boolean connectedToServer = false;
boolean pressedMouse = false; // Mouse pressed

String clientName = "Ethan"; // The name of the person you are talking to (remote client)
String myName = "Asher";
String serverName = "Asher"; // If you are running as server it should be the same as `myName` if you are the client it is the name of the remote server/person you are chatting with
String serverAddress = "192.168.2.165"; //"68.185.198.252";

color theme = color(70, 90, 180);
String scene = "picker";
int state = 0;

void setup () {
  size(500, 700);
  // myClient = new Client(this, serverAddress, port);
  // myServer = new Server(this, port);
  roboto = createFont("Roboto-Light.ttf", 15);
  cog = loadImage("cog.png");
  surface.setResizable(true);
  //osCheck();
}


void draw () {
  background(30);
  textFont(roboto);
  noStroke();
  textSize(30);

  switch (scene) {
    case "picker":
    textAlign(CENTER, TOP);
    text("Welcome.", width/2, height/2 - 100);
    fill(theme);
    if (mouseX > width/4 && mouseX < width/4 + width/2 && mouseY > height/2 && mouseY < height/2 + 50) {
      fill(theme, 200);
      if (pressedMouse) {
        scene = "chat";
        state = 1; // server
        myServer = new Server(this, port); // EDIT - SEE TODO
      }
    }
    rect(width/4, height/2, width/2, 50);
    fill(255);
    text("Server", width/2, height/2 + 8);

    fill(theme);
    if (mouseX > width/4 && mouseX < width/4 + width/2 && mouseY > height/2 + 80 && mouseY < height/2 + 140) {
      fill(theme, 200);
      if (pressedMouse && connectedToServer) {
        scene = "chat";
        state = 2; // client
      }
    }
    if (!connectedToServer) {
        fill(100);
    }
    rect(width/4, height/2 + 80, width/2, 50);
    fill(255);
    text("Client", width/2, height/2 + 90);
    connectToServer();
      break;
    case "chat":
      checkForMessages();
      chatGui();
      if (!openSettings) {
        if (state == 1) {
          serverMessageSender();
          myName = serverName;
        } else if (state == 2) {
          clientMessageSender();
          myName = clientName;
        }
      }
      break;
    default:
      textAlign(CENTER);
      text("Scene unknown (please restart the program)", width/2, height/2 - 100);
      break;
  }

  pressedMouse = false;
}

void mousePressed () {
  pressedMouse = true;
}

void keyPressed () {
  keyboardInput();
}
