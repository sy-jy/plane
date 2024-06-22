import QtQuick

Item {
    property int my_bulletSpeed: 50         //我方子弹的移动速度
    property int moveSpeed:5

    property int bullet_Width:window_Height/5           //子弹的图片大小
    property int bullet_Height: 20

    property int bulletX:(window_Width-bullet_Width)/2          //子弹的位置坐标
    property int bulletY:(window_Height*4/5)

    property int maxBullets:window_Height/bullet_Height
    property var bullets:[]                 //存储子弹的数组
    property int my_bullet_1
    property bool isShooted: false

    anchors.fill: parent

     property alias shootTimer: _shootTimer
    Timer{
        id:_shootTimer
        interval: 1
        repeat: true
        running: false
        onTriggered: {
            bullet.shoot()
        }
    }

    //固定子弹初始位置与飞机位置同步
    function updateMybulletPosition(){
        my_bullet_1.x = content.myplane.myplane_1.x;
        my_bullet_1.y = content.myplane.myplane_1.y;
        my_bullet_1.visible = false
    }

    //子弹射出，从屏幕下方移动到屏幕最上方
    function shoot(){
        my_bullet_1.visible = true
        my_bullet_1.y -=my_bulletSpeed;
        if(my_bullet_1.y + my_bullet_1.height < 0){
            isShooted = false
            // my_bullet_1.y = bulletY
        }
    }

    // function setBulletPosition(){
    //     my_bullet_1.x = content.myplane.myplane_1.x + content.myplane.myplane_1.width/2-bullet_Width/2
    //     my_bullet_1.y = content.myplane.myplane_1.y - bullet_Height
    //     visible = true
    // }


    Image {
        id: my_bullet_1
        source: "images/bullet_1.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:window_Height
        width: bullet_Width
        height: bullet_Height
    }
}
