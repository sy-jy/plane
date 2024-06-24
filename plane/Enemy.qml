import QtQuick
import QtQuick.Controls

Item {
    id: gameArea
    visible: false
    anchors.fill: parent
    focusPolicy: Qt.NoFocus
    property int enemySpeed: 5
    property var enemys: []     // 敌机数组
    property alias gameTime: _gameTime
    property string path

    // 定义一个敌机图片的ListModel
        ListModel {
            id: enemyImageModel
            ListElement { source: "images/enemy1.png" }
            ListElement { source: "images/enemy2.png" }
            ListElement { source: "images/enemy3.png" }
            ListElement { source: "images/enemy4.png" }
            // 添加更多敌机图片路径
        }

        Component {
                id: enemy
                Rectangle {
                    width: 50
                    height: 50
                    color: "transparent"
                    property string sourcePath // 定义一个属性来存储图片路径

                    Image {
                        id: _enemys
                        source: sourcePath // 使用定义的属性
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent
                    }
                }
            }

            // 创建敌机的函数
            function createEnemy() {
                var newEnemy = enemy.createObject(gameArea)
                newEnemy.x = Math.random() * (gameArea.width - newEnemy.width)
                newEnemy.y = -newEnemy.height
                // 设置随机图片路径
                var randomIndex = Math.floor(Math.random() * enemyImageModel.count)
                newEnemy.sourcePath = enemyImageModel.get(randomIndex).source
                enemys.push(newEnemy)  // 创建的新敌机放入数组中
            }

    // 更新所有敌机的位置
    function updateEnemys() {
        for (var i = enemys.length-1; i >= 0; i--) {
            var enemy = enemys[i]
            enemy.y += gameArea.enemySpeed

            // 检测敌机是否超出底部边界
            if (enemy.y >= gameArea.height) {
                enemy.destroy()      // 销毁超出底边的敌机
                enemys.splice(i, 1)  // 从数组中移除敌机
            }
        }
    }

    // 定时器，用于生成敌机
    Timer {
        id:_gameTime
        interval: 450  //新创敌机的时间间隔
        running: false
        repeat: true
        onTriggered: createEnemy()
    }
}

////敌机要走完窗口高度才能重新生成
// Item {
//     id: gameArea
//     visible: false
//     anchors.fill: parent
//     focusPolicy: Qt.NoFocus
//     property string enemyPath
//     property int enemySpeed: 4
//     property alias enemy1: enemy1
//     // property alias Gametime: gametime
//     property alias gameTimer: _gameTimer

//     Rectangle {
//         id: enemy
//         width: 50
//         height: 50
//         color: "transparent"
//         Image {
//             id: enemy1
//             source: "images/enemy1.png"
//             fillMode: Image.PreserveAspectFit
//             anchors.fill: parent
//         }
//         x: Math.random() * (gameArea.width - enemy.width)
//         y: -enemy.height
//     }

//     // 当敌机飞出画面后会重新绘制飞机的随机出场位置
//     function creatEnemy() {
//         enemy.x = Math.random() * (gameArea.width - enemy.width)
//         enemy.y = -enemy.height
//     }

//     function updateGame() {
//         // 更新敌人位置
//         enemy.y += gameArea.enemySpeed

//         // 检测敌人是否超出底部边界
//         if (enemy.y > gameArea.height) {
//             creatEnemy()
//             // destroy() // 销毁超出底边的敌机
//         }
//     }



//     Timer {
//         id: _gameTimer
//         interval: 16
//         running: false
//         repeat: true
//         onTriggered: {
//             updateGame()
//         }
//     }
// }
