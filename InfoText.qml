import QtQuick 2.7
import QtGraphicalEffects 1.12

Item {
    property alias artist: g_artist.text
    property alias song: g_song.text
    property alias album: g_album.text
    property alias year: g_year.text

    Text {
        id: g_artist
        font.pixelSize: 60
        color: "white"
        clip: true
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right

        style: Text.Outline
        styleColor: "black"
        antialiasing: true
        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
        textFormat: TextEdit.RichText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    DropShadow {
        anchors.fill: g_artist
        source: g_artist
        horizontalOffset: 0
        verticalOffset: 0
        radius: 16
        samples: 16
        color: "#E0000000"  // Semi-transparent black
    }

    Text {
        id: g_song
        font.pixelSize: 45
        color: "white"
        width: parent.width
        style: Text.Outline
        styleColor: "black"
        antialiasing: true
        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
        textFormat: TextEdit.RichText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: g_artist.bottom
        anchors.topMargin: 20
    }

    DropShadow {
        anchors.fill: g_song
        source: g_song
        horizontalOffset: 0
        verticalOffset: 0
        radius: 16
        samples: 16
        color: "#E0000000"  // Semi-transparent black
    }

    Text {
        id: g_album
        font.pixelSize: 40
        color: "white"
        width: parent.width
        style: Text.Outline
        styleColor: "black"
        antialiasing: true
        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
        textFormat: TextEdit.RichText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: g_year.top
        height: parent.height / 4
        onTextChanged: fitText()
        onWidthChanged: fitText()
        onHeightChanged: fitText()
        minimumPixelSize: 28

        function fitText() {
            font.pixelSize = 40 // reset to max trial size

            while ((contentWidth > width || contentHeight > height) && font.pixelSize > minimumPixelSize) {
                font.pixelSize -= 1
            }
        }
    }

    DropShadow {
        anchors.fill: g_album
        source: g_album
        horizontalOffset: 0
        verticalOffset: 0
        radius: 16
        samples: 16
        color: "#E0000000"  // Semi-transparent black
    }


    Text {
        id: g_year
        font.pixelSize: 40
        color: "white"
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        style: Text.Outline
        styleColor: "black"
        antialiasing: true
        wrapMode: Text.Wrap
        fontSizeMode: Text.Fit
        textFormat: TextEdit.RichText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        height: parent.height / 8
    }

    DropShadow {
        anchors.fill: g_year
        source: g_year
        horizontalOffset: 0
        verticalOffset: 0
        radius: 16
        samples: 16
        color: "#E0000000"  // Semi-transparent black
    }

}
