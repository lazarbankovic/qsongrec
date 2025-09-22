import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12

ApplicationWindow {
    visibility: Qt.WindowFullScreen
    visible: true
    flags: Qt.FramelessWindowHint
    color: "#1C1C1C"
    height: 800
    width: 1200
    id: root

    Image{
        id: g_background
        mipmap: true
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }

    GaussianBlur {
        anchors.fill: g_background
        source: g_background
        radius: 20
        samples: 16
    }

    Rectangle {
        id: data_container
        anchors.centerIn: parent
        color: "transparent"
        width: parent.width * 0.9
        height: parent.height * 0.8
        clip: true

        Rectangle {
            id: coverimgcontainer
            width: height
            height: parent.width * 0.45
            color: "transparent"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left

            // Album cover
            Image {
                id: albumCover  // replace with your album image
                width: height
                height: parent.height * 0.9
                fillMode: Image.PreserveAspectFit
                smooth: true
                mipmap: true
                anchors.margins: 10
                anchors.centerIn: parent

            }
            DropShadow {
                anchors.fill: albumCover
                source: albumCover
                horizontalOffset: 0
                verticalOffset: 0
                radius: 16
                samples: 16
                color: "#E0000000"  // Semi-transparent black
            }
        }


        InfoText {
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.right: parent.right
            width: parent.width - coverimgcontainer.width
            anchors.left: coverimgcontainer.right
            anchors.top: coverimgcontainer.top
            anchors.bottom: coverimgcontainer.bottom
            height: coverimgcontainer.height
            id: infoText
        }

    }

    SocketObserver {
        id: songrec
        socketPath: "/tmp/qsongrec"
        property int metalPlayed: 0

        onDataReady: {
            albumCover.source = coverart
            g_background.source = background
            infoText.artist = artist_name.toUpperCase()
            infoText.album = "💿 " + album + " 💿"
            infoText.song = "♬ "+song_name + " ♬"
            infoText.year =  release_year
            if (genre === "Metal") {
                metalPlayed++
            } else {
                metalPlayed = 0
            }
            if (metalPlayed % 5 == 0) { // x consecutive metal songs - show metal mood
                moodimg.source = "qrc:///giphy.gif"
                moodimg.visible = 1
            }
        }
    }

    AnimatedImage {
        id: moodimg
        anchors.fill: parent
        anchors.margins: 5
        width: 200
        height: 200
        visible: false
        fillMode: Image.PreserveAspectCrop
        playing: true
        paused: false

        SequentialAnimation {
            id: fadeSequence
            running: false
            PropertyAnimation { target: moodimg; property: "opacity"; from: 0; to: 1; duration: 10 } // fade in
            PauseAnimation { duration: 500 } // stay visible for 1 second
            PropertyAnimation { target: moodimg; property: "opacity"; from: 1; to: 0; duration: 2000 } // fade out
            ScriptAction { script: moodimg.visible = false } // finally hide
        }

        onVisibleChanged: {
            if (visible) {
                visible = true
                opacity = 0
                fadeSequence.restart()
            }
        }
    }

}
