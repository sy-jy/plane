import QtQuick
import QtQuick.Controls

Item {
    anchors.fill: parent
    // SequentialAnimation {
    //     id: boom
    // }

    SpriteSequence {
        id: enemyboom; width: 90; height: 85; goalSprite: "boom1"
        Sprite{
            name: "boom1"; source: "images/enemyboom.png"
             frameX:35 ;frameY: 60; frameWidth: 85; frameHeight: 85; frameDuration: 200
            to: {"boom2":1}
        }
        Sprite{
            name: "boom2"; source: "images/enemyboom.png"
             frameX: 225; frameY: 55; frameWidth: 85; frameHeight: 85; frameDuration: 200
            to: {"boom3":1}
        }
        Sprite{
            name: "boom3"; source: "images/enemyboom.png"
             frameX: 410; frameY: 50; frameWidth: 85; frameHeight: 85; frameDuration: 200
            to: {"boom4":1}
        }
        Sprite{
            name: "boom4"; source: "images/enemyboom.png"
             frameX: 600; frameY: 50; frameWidth: 85; frameHeight: 85; frameDuration: 200
            to: {"boom1":0}
        }
        // 使用PropertyAnimation来在boom4播放结束后改变透明度
           ParallelAnimation on opacity {
               SpriteSequenceAnimation { spriteSequence: enemyboom }
               PropertyAnimation { to: 0; duration: 200; easing.type: Easing.InQuad }
           }
    }

    SpriteSequence {
        id: enemyboomplus; width: 160; height: 180; goalSprite: "boom1"
        Sprite{
            name: "boom1"; source: "images/enemyboom.png"
             frameX:35 ;frameY: 60; frameWidth: 85; frameHeight: 85; frameDuration: 200
            to: {"boom2":1}
        }
        Sprite{
            name: "boom2"; source: "images/enemyboom.png"
             frameX: 225; frameY: 55; frameWidth: 85; frameHeight: 85; frameDuration: 200
            to: {"boom3":1}
        }
        Sprite{
            name: "boom3"; source: "images/enemyboom.png"
             frameX: 410; frameY: 50; frameWidth: 85; frameHeight: 85; frameDuration: 200
            to: {"boom4":1}
        }
        Sprite{
            name: "boom4"; source: "images/enemyboom.png"
             frameX: 600; frameY: 50; frameWidth: 85; frameHeight: 85; frameDuration: 200
            to: {"boom1":0}
        }
    }

    SpriteSequence {
        id: bossboom; width: 205; height: 260; goalSprite: "boom1"
        // c interpolate:false
        Sprite{
            name: "boom1"; source: "images/Bossboom.png"
            frameCount:5;frameWidth: 190; frameHeight: 220; frameDuration: 300
            to: {"boom2":1}
        }
        Sprite{
            name: "boom2"; source: "images/Bossboom2.png"
            frameCount:5; frameWidth: 187; frameHeight: 200; frameDuration: 300
            to: {"boom2":1}
        }
    }

}
