import QtQuick 2.7

Item {
    id:marqueeText
    height: scrollingText.height
    clip: true
    property int tempX: 0
    property alias color: propertyHolder.color
    property string text
    property alias font: propertyHolder.font

    Text {
        id: propertyHolder

    }

    Text {
        x: tempX
        id:scrollingText
        style: Text.Outline
        styleColor: "black"
        visible: false
        antialiasing: true
        color: propertyHolder.color
        font: propertyHolder.font
    }

    Text {
        id:scrollingTextStatic
        style: Text.Outline
        styleColor: "black"
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        visible: false
        antialiasing: true
        color: propertyHolder.color
        font: propertyHolder.font
    }

    onTextChanged: {
        console.log(scrollingText.width + " " + marqueeText.width)
        scrollingText.text = text
        scrollingTextStatic.text = text
        if (marqueeText.width <= t_metrics.tightBoundingRect.width) {
            scrollingTextStatic.visible = false
            scrollingText.visible = true
            console.log(text + " movable")
        } else {
            scrollingTextStatic.visible = true
            scrollingText.visible = false
            console.log(text + " static")
        }
    }

    Timer {
        id:timer
        interval: 200; running: true; repeat: true
        onTriggered:{
            tempX = tempX + 5
            scrollingText.x = -tempX;

            if( tempX + marqueeText.width > scrollingText.width ) {
                timer.running = false
                pauseTimer.running = true
            }
        }
    }

    Timer {
        id:pauseTimer
        interval: 500; running: false; repeat: false
        onTriggered: {
            scrollingText.x = 0
            tempX = 0
            timer.running = true
        }
    }

    TextMetrics {
        id:     t_metrics
        font:   scrollingText.font
        text:   scrollingText.text
    }
}
