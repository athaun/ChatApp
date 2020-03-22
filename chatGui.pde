import java.net.InetAddress;
boolean openSettings = false;
boolean edit  = false;
int editItemSelected = 0;
int messageScroll = 0;

boolean guiObjectsInitialized = false;


int gripPosition;
boolean scrollBarActive = false;
boolean initializeScrollBar = false;
class Scrollbar {

    int x, y, barHeight, gripHeight;
    Scrollbar (int x, int y, int barHeight) {
        this.x = x;
        this.y = y;
        this.barHeight = barHeight;
        // this.gripPosition = gripPosition;
        this.gripHeight = 40;
    }

    void draw () {
        if (!initializeScrollBar) {
            gripPosition = height - 105;
            initializeScrollBar = true;
        }
        fill(100);
        rect(x, y, 15, barHeight);

        fill(200);
        rectMode(CENTER);
        rect(x  + 7.5, y + gripPosition, 9, gripHeight, 3);
        rectMode(CORNER);
        update();
    }

    void update () {
        if (mouseX >= x - 10 && mouseY >= y && mouseY < (y + barHeight - gripHeight/2)) {
            if (mousePressed) {
                scrollBarActive = true;
            }
        }
        if (!mousePressed) {
            scrollBarActive = false;
        }
        if (scrollBarActive && (mouseY - gripHeight/2) > 40 && (mouseY + gripHeight/2) < (height - 40)) {
            gripPosition = mouseY - y;
        }
    }
}

Scrollbar scrollbar;

void chatGui () {
    scrollbar = new Scrollbar(width - 15, 40, height - 80);
    textFont(roboto);
    noStroke();
    background(30);
    textAlign(CORNER);

    messageScroll = -gripPosition;

    if (getLatestSender() != null) {
        textSize(15);
        fill(200);
        ArrayList < String > messages = getAllMessages();
        for (int i = 0; i < messages.size(); i += 2) {
            fill(255);
            text(messages.get(i), 10, 80 + (20 * i) + messageScroll); // sender
            text(messages.get(i + 1), 60, 80 + (20 * i) + messageScroll); // message
            if (80 + i * 20 + messageScroll > height - 50) {
                messageScroll -= 4; // Should scroll all messages up by 30 px to allow for message overflow
                scrollbar.draw();
            }
        }
    }

    fill(theme);
    rect(0, 0, width, 40);
    textSize(30);
    fill(255);
    if (state == 1) {
        text("Server", 10, 29);
    } else {
        text("Client", 10, 29);
    }

    fill(50);
    rect(0, height - 40, width, 40);

}
