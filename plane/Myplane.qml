import QtQuick

Item {

    property int myplane_Width: 128
    property int myplane_Height: 128
    property int moveSpeed: 5               // 我方飞机移动速度
    //单人初始位置
    property int planeX: (window_Width-myplane_Width)/2
    property int planeY: window_Height-myplane_Height
    //双人初始位置
    property int plane_1_X: (window_Width-myplane_Width)/9
    property int plane_1_Y: window_Height-myplane_Height
    property int plane_2_X: (window_Width-myplane_Width)/9*8
    property int plane_2_Y: window_Height-myplane_Height

    function singleplayer(){
        myplane_1.visible = true
    }
    function doubleplayer(){
        myplane_1.visible = true
        myplane_2.visible = true
    }
    function updateMyplanePosition(movingLeft_P1,movingRight_P1,movingUp_P1,movingDown_P1){
        if (movingLeft_P1 && planeX > 0) planeX -= moveSpeed;
        if (movingRight_P1 && planeX < parent.width - myplane_1.width) planeX += moveSpeed;
        if (movingUp_P1 && planeY > 0) planeY -= moveSpeed;
        if (movingDown_P1 && planeY < parent.height - myplane_1.height) planeY += moveSpeed;
        myplane_1.x = planeX;
        myplane_1.y = planeY;
    }
    function updateMyplanePositions(movingLeft_P1,movingRight_P1,movingUp_P1,movingDown_P1,
                                   movingLeft_P2,movingRight_P2,movingUp_P2,movingDown_P2){
        //P1
        if (movingLeft_P1 && plane_1_X > 0) plane_1_X -= moveSpeed;
        if (movingRight_P1 && plane_1_X < parent.width - myplane_1.width) plane_1_X += moveSpeed;
        if (movingUp_P1 && plane_1_Y > 0) plane_1_Y -= moveSpeed;
        if (movingDown_P1 && plane_1_Y < parent.height - myplane_1.height) plane_1_Y += moveSpeed;
        myplane_1.x = plane_1_X;
        myplane_1.y = plane_1_Y;
        //P2
        if (movingLeft_P2 && plane_2_X > 0) plane_2_X -= moveSpeed;
        if (movingRight_P2 && plane_2_X < parent.width - myplane_2.width) plane_2_X += moveSpeed;
        if (movingUp_P2 && plane_2_Y > 0) plane_2_Y -= moveSpeed;
        if (movingDown_P2 && plane_2_Y < parent.height - myplane_2.height) plane_2_Y += moveSpeed;
        myplane_2.x = plane_2_X;
        myplane_2.y = plane_2_Y;
    }

    //飞机操控
    Image {
        id: myplane_1
        source: myplane_1_path
        // focus: true
        visible: false
    }
    Image {
        id: myplane_2
        source: myplane_2_path
        // focus: true
        visible: false
    }

}
