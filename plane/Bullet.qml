import QtQuick

Item {
    property int my_bulletSpeed: 25         //我方子弹的移动速度
    property int enemy_bulletSpeed:8       //敌方子弹的移动速度

    property int bullet_Width:window_Height/5/5           //子弹的图片大小
    property int bullet_Height: 15

    property int bulletX:(window_Width-bullet_Width)/2          //子弹的位置坐标
    property int bulletY:(window_Height*4/5)

    property int maxBullets:window_Height/bullet_Height
    //property var bullets:[]                 //存储子弹的数组
    property bool isShooted: false                  //玩家一子弹发射情况
    property bool isShooted_2: false                //玩家二子弹发射情况
    property bool isShooted_enemy: false            //敌机子弹发射情况

    property alias enemy_bullet: _enemy_bullet

    anchors.fill: parent

    property alias shootTimer: _shootTimer
    property alias shootTimer_2: _shootTimer_2
    Timer{
        id:_shootTimer
        interval: 1
        repeat: true
        running: false
        onTriggered: {
            shoot()
        }
    }
    Timer{
        id:_shootTimer_2
        interval: 1
        repeat: true
        running: false
        onTriggered: {
            shoot2()
        }
    }
    // //固定子弹初始位置与飞机位置同步
    // function updateMybulletPosition(){
    //     if(!isShooted){ // 只有当子弹不在飞行中时才更新位置
    //         my_bullet_1.x = content.myplane.myplane_1.x + content.myplane.myplane_1.width/2 - bullet_Width/2;
    //         my_bullet_1.y = content.myplane.myplane_1.y - bullet_Height;
    //         my_bullet_1.visible = false
    //     }
    // }

    //单人模式子弹位置更新
    //固定子弹初始位置与飞机位置同步
    function updateMybulletPosition1(){
        if(!isShooted){
            my_bullet_1.x = content.myplane.myplane_1.x + window_Height/25;
            my_bullet_1.y = content.myplane.myplane_1.y;
            my_bullet_1.visible = false

            my_bullet_mid.x = content.myplane.myplane_1.x + window_Height*2/25;
            my_bullet_mid.y = content.myplane.myplane_1.y;
            my_bullet_mid.visible = false

            my_bullet1_2.x = content.myplane.myplane_1.x + window_Height*3/25;
            my_bullet1_2.y = content.myplane.myplane_1.y;
            my_bullet1_2.visible = false
        }


    }

    //双人模式玩家二子弹位置更新
    function updateMybulletPosition2(){
        if(!isShooted_2){
            my_bullet_2.x = content.myplane.myplane_2.x + window_Height/25;
            my_bullet_2.y = content.myplane.myplane_2.y;
            my_bullet_2.visible = false

            // my_bullet_mid.x = content.myplane.myplane_2.x + window_Height*2/25;
            // my_bullet_mid.y = content.myplane.myplane_2.y;
            // my_bullet_mid.visible = false

            my_bullet2_2.x = content.myplane.myplane_2.x + window_Height*3/25;
            my_bullet2_2.y = content.myplane.myplane_2.y;
            my_bullet2_2.visible = false
        }
    }

    //敌机
    function updateEnemybulletPosition(){
        _enemy_bullet.x = content.enemys.enemy_1.x + 10
        _enemy_bullet.y = content.enemys.enemy_1.y
        _enemy_bullet.visible = false
    }

    //单人模式
    //子弹射出，从屏幕下方移动到屏幕最上方
    function shoot(){
        bgm.shoot_1_Music.play()
        my_bullet_1.visible = true
        my_bullet_1.y -=my_bulletSpeed;

        my_bullet1_2.visible = true
        my_bullet1_2.y -=my_bulletSpeed;


        isShooted = true; // 设置为true，表示子弹正在飞行中
        // my_bullet_mid.visible = true
        // my_bullet_mid.y -=my_bulletSpeed/2;

        if(my_bullet_1.y + my_bullet_1.height< 0){
            isShooted = false
        }
    }

    //获取道具后增加的子弹样式1
    function shoot_mid(){
        my_bullet_mid.visible = true
        my_bullet_mid.y -=my_bulletSpeed/2;

        if(my_bullet_mid.y + my_bullet_mid.height< 0)
            isShooted = false
    }

    //双人模式
    function shoot2(){
        my_bullet_2.visible = true
        my_bullet_2.y -=my_bulletSpeed;

        my_bullet2_2.visible = true
        my_bullet2_2.y -=my_bulletSpeed;

        if(my_bullet_2.y + my_bullet_2.height < 0){
            isShooted_2 = false
        }
    }

    function shoot_enemy(){
        _enemy_bullet.visible = true
        _enemy_bullet.y +=enemy_bulletSpeed;

        if(_enemy_bullet.y > window_Height){
            isShooted_enemy = false
        }
    }



    Image {
        id: my_bullet_1
        source: "images/bullet_1.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:window_Height
        width: bullet_Width
        height: bullet_Height
    }
    Image {
        id: my_bullet_2
        source: "images/bullet_1.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:window_Height
        width: bullet_Width
        height: bullet_Height
    }
    Image {
        id: my_bullet1_2
        source: "images/bullet_1.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:window_Height
        width: bullet_Width
        height: bullet_Height
    }
    Image {
        id: my_bullet2_2
        source: "images/bullet_1.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:window_Height
        width: bullet_Width
        height: bullet_Height
    }
    Image {
        id: my_bullet_mid
        source: "images/bullet_mid.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:window_Height
        width: bullet_Width
        height: bullet_Height*2
    }
    Image {
        id: _enemy_bullet
        visible: false
        source: "images/enemy_bullet1.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:0
        width: bullet_Width
        height: bullet_Height*4
    }
}
