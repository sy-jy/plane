import QtQuick
import QtMultimedia
Item {
    property alias gameMusic: gameMusic
    property alias gameVolume: gameVolume
    property string gameMusicPath: "./wav/music_game.wav"
    property alias life_loseMusic: life_loseMusic
    property string life_loseMusicPath: "./wav/life_lose.wav"
    property alias life_loseMusicVolume: life_loseMusicVolume

    property alias upAmmo: upAmmo
    property string upAmmoPath: "./wav/power.wav"
    property alias upAmmoVolume: upAmmoVolume

    property alias game_defeatMusic:_game_defeatMusic
    property string game_defeatMusicPath: "./wav/defeat.mp3"
    property alias game_defeatMusicVolume: _game_defeatMusicVolume

    property alias shoot_1_Music: shoot_1_Music
    property string shootMusicPath: "./wav/shoot.mp3"
    property alias shoot_1_MusicVolume: shoot_1_MusicVolume
    property alias shoot_2_Music: shoot_2_Music
    property alias shoot_2_MusicVolume: shoot_2_MusicVolume

    property string testVolumePath: "./wav/volume.mp3"
    property alias testMusic: testMusic
    property alias testSound: testSound
    property alias testMusicVolume: testMusicVolume
    property alias testSoundVolume: testSoundVolume

    property alias focusSound: focusSound
    property string focusVolumePath: "./wav/focus.mp3"
    property alias focusSoundVolume: focusSoundVolume
    MediaPlayer {
        id:gameMusic
        source: gameMusicPath
        // 设置循环播放
        loops: MediaPlayer.Infinite
        // 设置音频输出
        audioOutput: AudioOutput {
            id:gameVolume
            volume: 1
        }
    }
    MediaPlayer {
        id:testMusic
        source: testVolumePath
        // 设置音频输出
        audioOutput: AudioOutput {
            id:testMusicVolume
            volume: 1
        }
    }
    MediaPlayer{
        id:life_loseMusic
        source: life_loseMusicPath
        // 设置音频输出
        audioOutput: AudioOutput {
            id:life_loseMusicVolume
            volume: 1
        }
    }
    MediaPlayer{
        id:upAmmo
        source: upAmmoPath
        // 设置音频输出
        audioOutput: AudioOutput {
            id:upAmmoVolume
            volume: 1
        }
    }
    MediaPlayer{
        id:_game_defeatMusic
        source: game_defeatMusicPath
        // 设置音频输出
        audioOutput: AudioOutput {
            id:_game_defeatMusicVolume
            volume: 1
        }
    }
    MediaPlayer{
        id:shoot_1_Music
        source: shootMusicPath
        // 设置音频输出
        audioOutput: AudioOutput {
            id:shoot_1_MusicVolume
            volume: 1
        }
    }
    MediaPlayer{
        id:shoot_2_Music
        source: shootMusicPath
        // 设置音频输出
        audioOutput: AudioOutput {
            id:shoot_2_MusicVolume
            volume: 1
        }
    }

    MediaPlayer {
        id:testSound
        source: testVolumePath
        // 设置音频输出
        audioOutput: AudioOutput {
            id:testSoundVolume
            volume: 1
        }
    }

    MediaPlayer {
        id:focusSound
        source: focusVolumePath
        // 设置音频输出
        audioOutput: AudioOutput {
            id:focusSoundVolume
            volume: 1
        }
    }
}
