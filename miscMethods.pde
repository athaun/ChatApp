
String ANSI_RESET = "\u001B[0m";
String ANSI_RED = "\u001B[31m";
String ANSI_GREEN = "\u001B[32m";
String ANSI_YELLOW = "\u001B[33m";
String ANSI_BLUE = "\u001B[34m";
String ANSI_WHITE = "\u001B[37m";
void logEvent (String log, char type) {
    String ANSI_COLOR = ANSI_WHITE;
    String logType = "[INFO]";
    switch (type) {
        case 's':
            ANSI_COLOR = ANSI_GREEN;
            logType = "[SUCCESS]";
        break;
        case 'i':
            ANSI_COLOR = ANSI_BLUE;
            logType = "[INFO]";
        break;
        case 'w':
            ANSI_COLOR = ANSI_YELLOW;
            logType = "[WARNING]";
        break;
        case 'e':
            ANSI_COLOR = ANSI_RED;
            logType = "[ERROR]";
        break;
        case 'f':
            ANSI_COLOR = ANSI_RED;
            logType = "[FATAL]";
        break;
    }
    println(ANSI_COLOR + logType + " " + log + ANSI_RESET);
}

void runBashCmd (String command) {
  // Takes an input an attempts to run that input in the shell
  try {
    Runtime rt = Runtime.getRuntime();
    Process pID = rt.exec(command);
  } catch (Exception e) {
    // If the command is invalid, it returns this error
    println("Catch exception | Error running command in miscMethods.runBashCmd()");
  }
}

void connectToServer () {
    if (!connectedToServer) {
        try {
          //  logEvent("Attempting to connect to server " + serverAddress + " on port " + port, 'i');
            myClient = new Client(this, serverAddress, port);
            if (myClient.active()) {
                connectedToServer = true;
            }
          //  println("connection is there");
        } catch (Exception e) {
            logEvent("Couldn't connect to server " + serverAddress + " on port " + port/* + "\n" + e*/, 'w');
        }
    }
}
