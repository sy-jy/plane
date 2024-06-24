import QtQuick
import QtQuick.Controls

Item {
        id: gameArea
        anchors.fill: parent
        property int enemySpeed: 4
        // visible: false
        property alias enemy1: enemy1
        focusPolicy: Qt.NoFocus
        property alias gameTimer: _gameTimer

        Rectangle {
            id: enemy
            width: 50
            height: 50
            color: "transparent"
            Image {
                id: enemy1
                source: "images/enemy1.png"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
            x: Math.random() * (gameArea.width - enemy.width)
            y: -enemy.height
        }

        // 当敌机飞出画面后会重新绘制飞机的随机出场位置
        function creatEnemy() {
            enemy.x = Math.random() * (gameArea.width - enemy.width)
            enemy.y = -enemy.height
        }

        function updateGame() {
            // 更新敌人位置
            enemy.y += gameArea.enemySpeed

            // 检测敌人是否超出底部边界
            if (enemy.y > gameArea.height) {
                creatEnemy()
                // destroy() // 销毁超出底边的敌机
            }
        }

        Timer {
            id: _gameTimer
            interval: 16
            running: false
            repeat: true
            // function updateGame() {
            //     // 更新敌人位置
            //     enemy.y += gameArea.enemySpeed

            //     // 检测敌人是否超出底部边界
            //     if (enemy.y > gameArea.height) {
            //         // enemy.resetEnemy()
            //         destroy() // 销毁超出底边的敌机
            //     }
            // }
            onTriggered: {
                updateGame()
            }
        }
    }



// //测试boss血量条，但游戏界面没解决
// Rectangle {
//     width: 400
//     height: 200
//     color: "transparent"

//     // 血量条背景
//     Rectangle {
//         id: bossbloodBackground
//         anchors.centerIn: parent
//         // width: 300
//         // height: 30
//         color: "gray"
//     }

//     // 血量条当前值
//     Rectangle {
//         id: bossbloodmove
//         anchors.left: bossbloodBackground.left
//         anchors.verticalCenter: bossbloodBackground.verticalCenter
//         width: bossbloodBackground.width * bloodValue
//         height: bossbloodBackground.height
//         color: "red"
//     }

//     // 血量逻辑
//     property real bloodValue: 1.0 // 初始血量为满血

//     // 减少血量的函数
//     function decreaseBlood() {
//         bloodValue -= 0.01; // 每次减少1%
//         if (bloodValue < 0) {
//             bloodValue = 0;
//         }
//         bossbloodmove.width = bossbloodBackground.width * bloodValue;
//     }

//     // Timer用于定期减少血量
//     Timer {
//         id: bloodTimer
//         interval: 100 // 每隔100毫秒减少一次血量
//         running: true
//         repeat: true
//         onTriggered: decreaseBlood()
//     }
// }
