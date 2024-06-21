import QtQuick
import QtQuick.Controls

//测试boss血量条，但游戏界面没解决
Rectangle {
    width: 400
    height: 200
    color: "transparent"

    // 血量条背景
    Rectangle {
        id: bossbloodBackground
        anchors.centerIn: parent
        // width: 300
        // height: 30
        color: "gray"
    }

    // 血量条当前值
    Rectangle {
        id: bossbloodmove
        anchors.left: bossbloodBackground.left
        anchors.verticalCenter: bossbloodBackground.verticalCenter
        width: bossbloodBackground.width * bloodValue
        height: bossbloodBackground.height
        color: "red"
    }

    // 血量逻辑
    property real bloodValue: 1.0 // 初始血量为满血

    // 减少血量的函数
    function decreaseBlood() {
        bloodValue -= 0.01; // 每次减少1%
        if (bloodValue < 0) {
            bloodValue = 0;
        }
        bossbloodmove.width = bossbloodBackground.width * bloodValue;
    }

    // Timer用于定期减少血量
    Timer {
        id: bloodTimer
        interval: 100 // 每隔100毫秒减少一次血量
        running: true
        repeat: true
        onTriggered: decreaseBlood()
    }
}
