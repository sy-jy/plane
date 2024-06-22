import QtQuick
import QtMultimedia
Item {
    property alias gameMusic: gameMusic
    property string gameMusicPath: "./wav/music_game.wav"
    property alias life_loseMusic: life_loseMusic
    property string life_loseMusicPath: "./wav/life_lose.wav"
    property alias upAmmo: upAmmo
    property string upAmmoPath: "./wav/power.wav"

    property alias game_defeatMusic:_game_defeatMusic
    property string game_defeatMusicPath: "./wav/defeat.mp3"

    MediaPlayer {
        id:gameMusic
        source: gameMusicPath
        // 设置循环播放
        loops: MediaPlayer.Infinite
        // 设置音频输出
        audioOutput: AudioOutput {}
    }
    MediaPlayer{
        id:life_loseMusic
        source: life_loseMusicPath
        // 设置音频输出
        audioOutput: AudioOutput {}
    }
    MediaPlayer{
        id:upAmmo
        source: upAmmoPath        // 设置循环播放
        // 设置音频输出
        audioOutput: AudioOutput {}
    }
    MediaPlayer{
        id:_game_defeatMusic
        source: game_defeatMusicPath
        audioOutput: AudioOutput {}
    }
}
