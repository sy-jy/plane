import QtQuick
import QtMultimedia
Item {
    property alias gameMusic: gameMusic
    property string gameMusicPath: "./wav/music_game.wav"
    MediaPlayer {
        id:gameMusic
        source: gameMusicPath
    }
}
