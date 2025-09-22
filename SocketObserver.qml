import QtQuick 2.7
import CustomControls 1.0

SocketSignal {
    signal dataReady

    property var background
    property var coverart
    property var artist_name
    property var album
    property var release_year
    property var song_name
    property var genre

    onSignalReceived: {
        var jsonData = JSON.parse(data);

        background = jsonData.background
        coverart = jsonData.coverart
        artist_name = jsonData.artist_name
        album = jsonData.album
        release_year = jsonData.release_year
        song_name = jsonData.song_name
        genre = jsonData.genre

        dataReady()
    }
}
