//敌机的出现
import QtQuick
import QtQuick.Controls

Item {
    id: gameArea
    anchors.fill: parent
    property int enemySpeed: 2
    property alias enemyComponent:enemyComponent
    //property alias enemy:newEnemy
    focusPolicy: Qt.NoFocus
    //property alias gameTimer: _gameTimer
    visible: false
    property var enemys: []     // 敌机数组
    property alias gameTime: _gameTime
    property string path
    property var boss: null     // Boss对象
    property int bossSpeed: 2
    property alias bossTime: bossTime
    property int bossDirection: 1 // 初始方向 1 表示向右，-1 表示向左
    property bool bossAppeared: false
    property int currentBossIndex: 0

    // 敌机图片的ListModel
    ListModel {
        id: enemyImageModel
        ListElement { source: "images/enemy1.png";name:"normal";shootCooldown:0 }
        ListElement { source: "images/enemy2.png";name:"fast";shootCooldown:0}
        ListElement { source: "images/enemy3.png";name:"track";shootCooldown:0}
        ListElement { source: "images/enemy4.png";name:"meatshield";shootCooldown:0}
    }

    // 敌机组件
    Component {
        id: enemyComponent
        Rectangle {
            width: 65
            height: 65
            color: "transparent"
            property string sourcePath
            property string name // 添加敌机名字属性
            property int shootCooldown

            Image {
                id: _enemys
                source: sourcePath
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
        }
    }
    // 敌机图片的ListModel
    ListModel {
        id: bossImageModel
        ListElement { source: "images/boss2.png";name:"boss1"}
        ListElement { source: "images/boss3.png";name:"boss2"}
    }

    // Boss组件
    Component {
        id: bossComponent
        Rectangle {
            id: boss
            width: 400
            height: 200
            color: "transparent"
            property string sourcePath
            property string name // 添加敌机名字属性
            property alias boss1: boss
            Image {
                id: _boss
                source: sourcePath
                anchors.fill: parent
            }

            //boss固定上方位置水平移动
            function updateBossPosition() {
                if(boss.y >= 0){
                    content.bossbloodProgress1.visible=true
                    content.bossbloodProgress2.visible=true
                    boss.x += bossSpeed*bossDirection
                    if (boss.x + bossSpeed <= 0 || boss.x + bossSpeed >= gameArea.width - boss.width) {
                        bossDirection *= -1 // 反转移动方向
                    }
                }else{
                    boss.y += bossSpeed
                }
            }
        }
    }

    // 创建敌机
    function createEnemy() {
        var newEnemy = enemyComponent.createObject(gameArea)
        newEnemy.x = Math.random() * (gameArea.width - newEnemy.width)
        newEnemy.y = -newEnemy.height
        var randomIndex = Math.floor(Math.random() * enemyImageModel.count)
        newEnemy.sourcePath = enemyImageModel.get(randomIndex).source
        newEnemy.name = enemyImageModel.get(randomIndex).name // 设置敌机名字
        newEnemy.shootCooldown = enemyImageModel.get(randomIndex).shootCooldown
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
            switch (enemy.name) {
                case "normal":
                    // 普通敌机
                    enemy.y += enemySpeed
                    break
                case "fast":
                    // 快速敌机
                    enemy.y += enemySpeed * 2
                    break
                case "track":
                    // 跟踪敌机
                    // 计算敌机与我方战机的相对位置
                    var dx = content.myplane.myplane_1.x - enemy.x;
                    var dy = content.myplane.myplane_1.y - enemy.y;
                    // 计算移动方向
                    var angle = Math.atan2(dy, dx);
                    // 根据恒定合速度更新敌机位置
                    enemy.x += enemySpeed * Math.cos(angle);
                    enemy.y += enemySpeed * Math.sin(angle);
                    break
                case "meatshield":
                    enemy.y += enemySpeed
                    break
                }
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
            newBoss.sourcePath = bossImageModel.get(currentBossIndex).source
            newBoss.name = bossImageModel.get(currentBossIndex).name
            boss = newBoss
            newBoss.y = -300
            boss = newBoss
            bossAppeared = true
        }
    }
    function destroyBoss(){
        if(boss){//防止摧毁空的boss
            boss.destroy()
        }
    }
    function bossNext(){
        currentBossIndex = (currentBossIndex+1)%bossImageModel.count
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
        interval: 1000//10000  //10s
        running: false
        onTriggered: {
            createBoss()
        }
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
