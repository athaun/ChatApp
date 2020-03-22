void pickerGUI () {
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
}
