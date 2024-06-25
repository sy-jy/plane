//敌机的出现
import QtQuick
import QtQuick.Controls

Item {
    id: gameArea
    anchors.fill: parent
    property int enemySpeed: 2
    focusPolicy: Qt.NoFocus

    visible: false

    property var enemys: []     // 敌机数组
    property alias gameTime: _gameTime
    property string path
    property var boss: null     // Boss对象
    property int bossSpeed: 2
    property alias bossTime: bossTime
    property int bossDirection: 1 // 初始方向 1 表示向右，-1 表示向左

    // 敌机图片的ListModel
    ListModel {
        id: enemyImageModel
        ListElement { source: "images/enemy1.png" }
        ListElement { source: "images/enemy2.png" }
        ListElement { source: "images/enemy3.png" }
        ListElement { source: "images/enemy4.png" }
    }

    // 敌机组件
    Component {
        id: enemyComponent
        Rectangle {
            width: 65
            height: 65
            color: "transparent"
            property string sourcePath

            Image {
                id: _enemys
                source: sourcePath
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }
    }

    // Boss组件
    Component {
        id: bossComponent
        Rectangle {
            id: boss1
            width: 400
            height: 200
            color: "transparent"
            property alias boss1: boss1
            // focusPolicy: Qt.NoFocus
            Image {
                id: _boss1
                source: "images/boss2.png"
                anchors.fill: parent
            }

            //boss固定上方位置水平移动
            function updateBossPosition() {
                // boss1.y += bossSpeed
                if(boss1.y >= 0){
                    content.bossbloodProgress1.visible=true
                    content.bossbloodProgress2.visible=true
                    boss1.x += bossSpeed*bossDirection
                    if (boss1.x + bossSpeed <= 0 || boss1.x + bossSpeed >= gameArea.width - boss1.width) {
                        bossDirection *= -1 // 反转移动方向
                    }
                }else{
                    boss1.y += bossSpeed
                }
            }
            //boss垂直运动直到消失于界面
            // function updateBossPosition() {
            //     boss1.y += bossSpeed
            //     if (boss1.y > gameArea.height) {
            //         boss1.destroy()
            //         gameArea.boss = null
            //     }
            // }
        }
    }

    // 创建敌机
    function createEnemy() {
        var newEnemy = enemyComponent.createObject(gameArea)
        newEnemy.x = Math.random() * (gameArea.width - newEnemy.width)
        newEnemy.y = -newEnemy.height
        var randomIndex = Math.floor(Math.random() * enemyImageModel.count)
        newEnemy.sourcePath = enemyImageModel.get(randomIndex).source
        enemys.push(newEnemy)
    }

    function destroyEnemy(){
        while(enemys.length!==0){
            var enemy = enemys[enemys.length-1]
            enemy.destroy()
            enemys.pop()
        }
    }

    // 更新所有敌机位置
    function updateEnemys() {
        for (var i = enemys.length - 1; i >= 0; i--) {
            var enemy = enemys[i]
            enemy.y += enemySpeed
            if (enemy.y >= gameArea.height) {
                enemy.destroy()
                enemys.splice(i, 1)
            }
        }
    }

    // 创建boss
    function createBoss() {
        if (!boss) {
            var newBoss = bossComponent.createObject(gameArea)
            newBoss.x = (gameArea.width - newBoss.width) / 2
            newBoss.y = -200
            boss = newBoss
            newBoss.y = -300
            boss = newBoss
        }
    }
    function destroyBoss(){
        if(boss){//防止摧毁空的boss
            boss.destroy()
        }
    }

    // 更新boss出现后的游戏界面
    function updateGame() {
        updateEnemys()
        if (boss) {
            boss.updateBossPosition()
        }
    }

    // 敌机生成
    Timer {
        id: _gameTime
        interval: 450
        running: false
        repeat: true
        onTriggered: {
            interval: 1000
            createEnemy()
        }
    }

    // Boss生成（先暂定为时间，之后会改为击败敌机数或者获得的score来生成boss）
    Timer {
        id: bossTime
        interval: 10000  //10s
        running: true
        onTriggered: createBoss()
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
