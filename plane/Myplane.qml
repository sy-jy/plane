import QtQuick

Item {
    property alias myplane_1: myplane_1
    property alias myplane_2: myplane_2
    property int myplane_Width: window_Height/5
    property int myplane_Height: window_Height/5
    property int moveSpeed: 5   // 我方飞机初始移动速度
    //单人初始位置
    property int planeX: (window_Width-myplane_Width)/2
    property int planeY: window_Height-myplane_Height
    //双人初始位置
    property int plane_1_X: (window_Width-myplane_Width)/9
    property int plane_1_Y: window_Height-myplane_Height
    property int plane_2_X: (window_Width-myplane_Width)/9*8
    property int plane_2_Y: window_Height-myplane_Height
    property int blood: 100 //每条命的血量
    property int lives: 4   //拥有总生命数
    property bool isSurvive_1: true//玩家1是否存活
    property bool isSurvive_2: true//玩家2是否存活
    //护盾
    property alias shield_1: shield_1
    property alias shield_2: shield_2
    property bool isShield_1: false // 默认护盾不激活
    property bool isShield_2: false // 默认护盾不激活
    property string shieldPath: "./images/heroSuper.png" // 护盾图像路径
    property int shieldDuration: 5000 // 护盾持续时间（毫秒）
    property int shieldFadeDuration: 3000 // 护盾闪烁时间（毫秒）
    property bool isFading: false // 护盾是否正在闪烁
    //速度
    property int upSpeed: 7
    property bool isAccelerate_1: false
    property bool isAccelerate_2: false
    property int accelerateDuration: 3000

    //hp
    property bool canIncreaseHp_1: true // 标志位，用于控制是否可以增加HP
    property bool canIncreaseHp_2: true // 标志位，用于控制是否可以增加HP
    function singleplayer(){
        myplane_1.visible = true
    }
    function doubleplayer(){
        myplane_1.visible = true
        myplane_2.visible = true
    }
    function updateMyplanePosition(movingLeft_P1,movingRight_P1,movingUp_P1,movingDown_P1){
        if (movingLeft_P1 && planeX > 0) planeX -= isAccelerate_1?upSpeed:moveSpeed;
        if (movingRight_P1 && planeX < parent.width - myplane_1.width) planeX += isAccelerate_1?upSpeed:moveSpeed;
        if (movingUp_P1 && planeY > 0) planeY -= isAccelerate_1?upSpeed:moveSpeed;
        if (movingDown_P1 && planeY < parent.height - myplane_1.height) planeY += isAccelerate_1?upSpeed:moveSpeed;
        myplane_1.x = planeX;
        myplane_1.y = planeY;
    }
    function updateMyplanePositions(movingLeft_P1,movingRight_P1,movingUp_P1,movingDown_P1,
                                   movingLeft_P2,movingRight_P2,movingUp_P2,movingDown_P2){
        //P1
        if (movingLeft_P1 && plane_1_X > 0) plane_1_X -= isAccelerate_1?upSpeed:moveSpeed;
        if (movingRight_P1 && plane_1_X < parent.width - myplane_1.width) plane_1_X += isAccelerate_1?upSpeed:moveSpeed;
        if (movingUp_P1 && plane_1_Y > 0) plane_1_Y -= isAccelerate_1?upSpeed:moveSpeed;
        if (movingDown_P1 && plane_1_Y < parent.height - myplane_1.height) plane_1_Y += isAccelerate_1?upSpeed:moveSpeed;
        myplane_1.x = plane_1_X;
        myplane_1.y = plane_1_Y;
        //P2
        if (movingLeft_P2 && plane_2_X > 0) plane_2_X -= isAccelerate_2?upSpeed:moveSpeed;
        if (movingRight_P2 && plane_2_X < parent.width - myplane_2.width) plane_2_X += isAccelerate_2?upSpeed:moveSpeed;
        if (movingUp_P2 && plane_2_Y > 0) plane_2_Y -= isAccelerate_2?upSpeed:moveSpeed;
        if (movingDown_P2 && plane_2_Y < parent.height - myplane_2.height) plane_2_Y += isAccelerate_2?upSpeed:moveSpeed;
        myplane_2.x = plane_2_X;
        myplane_2.y = plane_2_Y;
    }

    //飞机操控
    Image {
        id: myplane_1
        source: myplane_1_path
        width: myplane_Width
        fillMode: Image.PreserveAspectFit
        x:content.isDouble? plane_1_X : planeX  //初始化位置解决开始时飞机闪动
        y:content.isDouble? plane_1_Y : planeY
        visible: false
        // 护盾图像
        Image {
            id: shield_1
            source: shieldPath
            width: parent.width + myplane_Width / 8 * 3
            height: parent.height + myplane_Height / 8 * 3
            visible: isShield_1
            anchors.centerIn: parent
            // 护盾计时器
            Timer {
                id: shield_1_Timer
                interval: shieldDuration
                onTriggered: {
                    shield_1_FadeAnimation.start()
                }
            }
            // 护盾闪烁动画
            SequentialAnimation on opacity {
                id: shield_1_FadeAnimation
                loops: 3 // 循环次数
                running: false // 默认不运行
                onFinished: {
                        shield_1.visible = false
                        isShield_1 = false
                    }
                PropertyAnimation {
                    from: 0.8
                    to: 0.1
                    duration: shieldFadeDuration / shield_1_FadeAnimation.loops / 3 * 2 // 单程动画时间
                    easing.type: Easing.InOutQuad
                }
                PropertyAnimation {
                    from: 0.1
                    to: 0.8
                    duration: shieldFadeDuration / shield_1_FadeAnimation.loops / 3 // 单程动画时间
                    easing.type: Easing.InOutQuad
                }
            }
            // 激活护盾的函数
            function activateShield() {
                isShield_1 = true
                shield_1.visible = true
                shield_1.opacity = 1.0
                shield_1_Timer.start() // 持续时间计时
                shield_1_Timer.triggered.connect(startShieldFadeAnimation) // 持续时间结束连接到开始闪烁动画的函数
            }
            // 开始闪烁动画的函数
            function startShieldFadeAnimation() {
                shield_1_Timer.triggered.disconnect(startShieldFadeAnimation) // 断开连接，防止重复触发
                shield_1_FadeAnimation.start() // 开始闪烁动画
            }    
        }
        function activateAmmo() {
            if(dialogs.musicEnabled){
                bgm.upAmmo.play()
            }
        }
        //hp增加
        Timer {//防止一次道具多次加hp
            id: hpIncreaseTimer_1
            interval: 1000 // 等待1秒
            onTriggered: {
                // 定时器触发时，设置标志位允许下次调用activateHp()
                canIncreaseHp_1 = true
            }
        }
        // 增加HP
        function activateHp(){
            if (canIncreaseHp_1) {
                canIncreaseHp_1 = false // 设置标志位为false，防止重复调用
                if(content.isDouble){
                    console.log("Before increase:", content.bloodProgress_1.value);
                    content.bloodProgress_1.value += blood/2;
                    console.log("After increase:", content.bloodProgress_1.value);
                } else {
                    console.log("Before increase:", content.bloodProgress.value);
                    content.bloodProgress.value += blood/2;
                    console.log("After increase:", content.bloodProgress.value);
                }
                hpIncreaseTimer_1.start() // 启动定时器，1秒后允许再次增加HP
            }
        }
        //速度增加
        // 对于玩家1的飞机
        Timer {
            id: accelerateTimer_1
            interval: accelerateDuration
            onTriggered: {
                isAccelerate_1 = false
            }
        }
        function activateSpeed(){
            isAccelerate_1 = true
            accelerateTimer_1.start()
        }
    }
    Image {
        id: myplane_2
        source: myplane_2_path
        width: myplane_Width
        fillMode: Image.PreserveAspectFit
        x:plane_2_X //初始化位置解决开始时飞机闪动
        y:plane_2_Y
        visible: false
        // 护盾图像
        Image {
            id: shield_2
            source: shieldPath
            width: parent.width + myplane_Width / 8 * 3
            height: parent.height + myplane_Height / 8 * 3
            visible: isShield_2
            anchors.centerIn: parent
            // 护盾计时器
            Timer {
                id: shield_2_Timer
                interval: shieldDuration
                onTriggered: {
                    shield_1_FadeAnimation.start()
                }
            }
            // 护盾闪烁动画
            SequentialAnimation on opacity {
                id: shield_2_FadeAnimation
                loops: 3 // 循环次数
                running: false // 默认不运行
                onFinished: {
                        shield_2.visible = false
                        isShield_2 = false
                    }
                PropertyAnimation {
                    from: 0.8
                    to: 0.1
                    duration: shieldFadeDuration / shield_2_FadeAnimation.loops / 3 * 2 // 单程动画时间
                    easing.type: Easing.InOutQuad
                }
                PropertyAnimation {
                    from: 0.1
                    to: 0.8
                    duration: shieldFadeDuration / shield_2_FadeAnimation.loops / 3 // 单程动画时间
                    easing.type: Easing.InOutQuad
                }
            }
            // 激活护盾的函数
            function activateShield() {
                isShield_2 = true
                shield_2.visible = true
                shield_2.opacity = 1.0
                shield_2_Timer.start() // 持续时间计时
                shield_2_Timer.triggered.connect(startShieldFadeAnimation) // 持续时间结束连接到开始闪烁动画的函数
            }
            // 开始闪烁动画的函数
            function startShieldFadeAnimation() {
                shield_2_Timer.triggered.disconnect(startShieldFadeAnimation) // 断开连接，防止重复触发
                shield_2_FadeAnimation.start() // 开始闪烁动画
            }
        }
        function activateAmmo() {
            bgm.upAmmo.play()
        }
        //hp增加
        //hp增加
        Timer {//防止一次道具多次加hp
            id: hpIncreaseTimer_2
            interval: 1000 // 等待1秒
            onTriggered: {
                // 定时器触发时，设置标志位允许下次调用activateHp()
                canIncreaseHp_2 = true
            }
        }
        // 增加HP
        function activateHp(){
            if (canIncreaseHp_2) {
                canIncreaseHp_2= false // 设置标志位为false，防止重复调用
                content.bloodProgress_2.value += blood/2;
                hpIncreaseTimer_2.start() // 启动定时器，1秒后允许再次增加HP
            }
        }
        //速度增加
        // 对于玩家2的飞机
        Timer {
            id: accelerateTimer_2
            interval: accelerateDuration
            onTriggered: {
                isAccelerate_2 = false
            }
        }
        function activateSpeed(){
            isAccelerate_2 = true
            accelerateTimer_2.start()
        }
    }
}
