import QtQuick

Item {
    property int my_bulletSpeed: 10         //我方子弹的移动速度
    property int moveSpeed:5

    property int bullet_Width:window_Height/5           //子弹的图片大小
    property int bullet_Height: 20

    property int bulletX:(window_Width-bullet_Width)/2          //子弹的位置坐标
    property int bulletY:(window_Height*4/5)

    property int maxBullets:window_Height/bullet_Height
    property var bullets:[]                 //存储子弹的数组
    property int my_bullet_1

    anchors.fill: parent

    // signal startShooting()
    // signal stopShooting()

    // property alias timerbullet: bulletTimer
    // Timer{
    //     id:bulletTimer
    //     interval: shootInterval
    //     repeat: true
    //     running: false
    //     onTriggered: {
    //         updateMybulletPosition();
    //     }
    // }

    //固定子弹初始位置与飞机位置同步
    function updateMybulletPosition(){
        if(movingLeft_P1 && bulletX > 0) bulletX -=moveSpeed;
        if(movingRight_P1 && bulletX < parent.width - window_Height/5) bulletX += moveSpeed;
        if(movingUp_P1 && bulletY > 0) bulletY -=moveSpeed;
        if(movingDown_P1 && bulletY < parent.height - window_Height/5) bulletY += moveSpeed;
        my_bullet_1.x = bulletX;
        my_bullet_1.y = bulletY;
    }

    //子弹射出，从屏幕下方移动到屏幕最上方
    function shoot(){
        my_bullet_1.y -=my_bulletSpeed;
        if(my_bullet_1.y + my_bullet_1.height < 0)
            my_bullet_1.y = bulletY
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
}
