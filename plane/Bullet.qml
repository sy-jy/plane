import QtQuick

Item {
    property int my_bulletSpeed: 25         //我方子弹的移动速度
    property int enemy_bulletSpeed:5       //敌方子弹的移动速度

    property int bullet_Width:window_Height/5/5           //子弹的图片大小
    property int bullet_Height: 15

    property int bulletX:(window_Width-bullet_Width)/2          //子弹的位置坐标
    property int bulletY:(window_Height*4/5)

    property int maxBullets:window_Height/bullet_Height
    //property var bullets:[]                 //存储子弹的数组
    property bool isShooted_1: false                  //玩家一子弹发射情况
    property bool isShooted_2: false                //玩家二子弹发射情况
    property bool isShooted_mid: false              //玩家1拾取道具后新增子弹样式发射情况
    property bool isShooted_mid2: false             //玩家2拾取道具后新增子弹样式发射情况
    property bool isShooted_enemy: false            //敌机子弹发射情况
    property bool isShooted_boss:false               //boss子弹发射情况
    property bool ammo1: false
    property bool ammo2: false
    property bool isHit_1: false
    property bool isHit_2: false
    property bool isBossHit_1: false
    property bool isBossHit_2: false

    property alias enemy_bullet: _enemy_bullet          //普通敌机子弹
    property alias boss_bullet: _boss_bullet            //boss子弹

    anchors.fill: parent

    property alias shootTimer_1: _shootTimer            //单人模式发射子弹计时器
    property alias shootTimer_2: _shootTimer_2          //玩家2子弹发射计时器
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

    //单人模式子弹位置更新
    //固定子弹初始位置与飞机位置同步
    function updateMybulletPosition1(){
        if(!isShooted_1){
            my_bullet_1.x = content.myplane.myplane_1.x + window_Height/25;
            my_bullet_1.y = content.myplane.myplane_1.y;
            my_bullet_1.visible = false

            my_bullet_mid.x = content.myplane.myplane_1.x + content.myplane.myplane_1.width/2 - my_bullet_mid.width/2;//中间子弹位置调整
            my_bullet_mid.y = content.myplane.myplane_1.y - my_bullet_mid.height/4;
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

            my_bullet_mid2.x = content.myplane.myplane_2.x + content.myplane.myplane_2.width/2 - my_bullet_mid2.width/2;//中间子弹位置调整
            my_bullet_mid2.y = content.myplane.myplane_2.y - my_bullet_mid2.height/4;
            my_bullet_mid2.visible = false

            my_bullet2_2.x = content.myplane.myplane_2.x + window_Height*3/25;
            my_bullet2_2.y = content.myplane.myplane_2.y;
            my_bullet2_2.visible = false
        }
    }

    //普通敌机子弹位置更新
    function updateEnemybulletPosition(){
        for(var i = 0;i<content.enemys.enemys.length;i++){
            _enemy_bullet.x = content.enemys.enemys[i].x + 12
            _enemy_bullet.y = content.enemys.enemys[i].y
            _enemy_bullet.visible = false
        }
    }

    //boss子弹位置更新
    function updateEnemyBossbulletPosition(){
        _boss_bullet.x = content.enemys.boss.x + content.enemys.boss.width /2 - _boss_bullet.width/2
        _boss_bullet.y = content.enemys.boss.y + 180//content.enemys.boss.height
        _boss_bullet.visible = false
    }

    //单人模式
    //子弹射出，从屏幕下方移动到屏幕最上方
    function shoot(){
        bgm.shoot_1_Music.play()
        my_bullet_1.visible = true
        my_bullet_1.y -=my_bulletSpeed;

        my_bullet1_2.visible = true
        my_bullet1_2.y -=my_bulletSpeed;
        isShooted_1 = true; // 设置为true，表示子弹正在飞行中

        if(ammo1){
            my_bullet_mid.visible = true
            my_bullet_mid.y -=my_bulletSpeed;
        }

        if(my_bullet_1.y + my_bullet_1.height< 0){
            isShooted_1 = false
        }
    }

    // //获取道具后增加的子弹样式1
    // //玩家1
    // function shoot_mid(){

    //     my_bullet_mid.visible = true
    //     my_bullet_mid.y -=my_bulletSpeed/2;

    //     isShooted_mid = true

    //     if(my_bullet_mid.y + my_bullet_mid.height< 0){
    //         isShooted_mid = false
    //     }
    // }
    // //玩家2
    // function shoot_mid2(){
    //     my_bullet_mid2.visible = true
    //     my_bullet_mid2.y -=my_bulletSpeed/2;

    //     isShooted_mid2 = true

    //     if(my_bullet_mid2.y + my_bullet_mid2.height< 0)
    //         isShooted_mid2 = false
    // }

    //双人模式
    function shoot2(){
        bgm.shoot_2_Music.play()
        my_bullet_2.visible = true
        my_bullet_2.y -=my_bulletSpeed;

        my_bullet2_2.visible = true
        my_bullet2_2.y -=my_bulletSpeed;

        isShooted_2 = true; // 设置为true，表示子弹正在飞行中
        if(ammo2){
            my_bullet_mid2.visible = true
            my_bullet_mid2.y -=my_bulletSpeed;
        }
        if(my_bullet_2.y + my_bullet_2.height < 0){
            isShooted_2 = false
        }
    }

    //普通敌机发射子弹
    function shoot_enemy(){
        isShooted_enemy = true
        _enemy_bullet.visible = true
        _enemy_bullet.y +=enemy_bulletSpeed;

        if(_enemy_bullet.y > window_Height){
            isShooted_enemy = false
        }
    }

    //boss发射子弹
    function shoot_boss(){
        isShooted_boss = true
        _boss_bullet.visible = true
        _boss_bullet.y +=enemy_bulletSpeed;

        if(_boss_bullet.y > window_Height){
            isShooted_boss = false
        }
    }

    //碰撞检测
    //我方发射子弹与敌机的碰撞检测
    function checkCollision(){
        for(var i =0; i<content.enemys.enemys.length;i++){
            //我方玩家1击中普通敌机
            if(my_bullet_1.x+my_bullet_1.width >content.enemys.enemys[i].x
                    && my_bullet_1.x<content.enemys.enemys[i].x + 65
                    && my_bullet_1.y+my_bullet_1.height>content.enemys.enemys[i].y
                    && my_bullet_1.y<content.enemys.enemys[i].y+65){
                isShooted_1 = false
                my_bullet_1.visible = false
                content.enemys.enemys[i].visible = false
                if(!isDouble){
                    score1++
                }else{
                    score2++
                }
                break;
                if(content.enemys.enemys[i].visible === false){
                    console.log("子弹爆炸")
                    content.boom.enemyboom.visible = true
                    content.boom.enemyboom.running = true
                    break;
                }
                // break;
            }
            if(my_bullet1_2.x+my_bullet1_2.width >content.enemys.enemys[i].x
                    && my_bullet1_2.x<content.enemys.enemys[i].x + 65
                    && my_bullet1_2.y+my_bullet1_2.height>content.enemys.enemys[i].y
                    && my_bullet1_2.y<content.enemys.enemys[i].y+65){

                my_bullet1_2.visible = false
                content.enemys.enemys[i].visible = false
                if(!isDouble){
                    score1++
                }else{
                    score2++
                }
                break;
                if(content.enemys.enemys[i].visible === false){
                    console.log("子弹爆炸")
                    content.boom.enemyboom.visible = true
                    content.boom.enemyboom.running = true
                    break;
                }
                // break;
            }
            //我方玩家2击中普通敌机
            if(my_bullet_2.x+my_bullet_2.width >content.enemys.enemys[i].x
                    && my_bullet_2.x<content.enemys.enemys[i].x + 65
                    && my_bullet_2.y+my_bullet_2.height>content.enemys.enemys[i].y
                    && my_bullet_2.y<content.enemys.enemys[i].y+65){

                my_bullet_2.visible = false
                content.enemys.enemys[i].visible = false
                if(!isDouble){
                    score1++
                }else{
                    score2++
                }
                break;
                if(content.enemys.enemys[i].visible === false){
                    console.log("子弹爆炸")
                    content.boom.enemyboom.visible = true
                    content.boom.enemyboom.running = true
                    break;
                }
                // break;
            }
            if(my_bullet2_2.x+my_bullet2_2.width >content.enemys.enemys[i].x
                    && my_bullet2_2.x<content.enemys.enemys[i].x + 65
                    && my_bullet2_2.y+my_bullet2_2.height>content.enemys.enemys[i].y
                    && my_bullet2_2.y<content.enemys.enemys[i].y+65){

                my_bullet2_2.visible = false
                content.enemys.enemys[i].visible = false
                if(!isDouble){
                    score1++
                }else{
                    score2++
                }
                break;
                if(content.enemys.enemys[i].visible === false){
                    console.log("子弹爆炸")
                    content.boom.enemyboom.visible = true
                    content.boom.enemyboom.running = true
                    break;
                }
                // break;
            }
            //击中boss碰撞检测
            if(!enemys.bossAppeared){continue}
            if(my_bullet_1.x+my_bullet_1.width >content.enemys.boss.x
                    && my_bullet_1.x<content.enemys.boss.x + content.enemys.boss.width
                    && my_bullet_1.y+my_bullet_1.height>content.enemys.boss.y
                    && my_bullet_1.y<content.enemys.boss.y+content.enemys.boss.height){

                my_bullet_1.visible = false
                if(!isDouble){
                    bossbloodProgress1.value -=5                 //单人模式：击中boss后boss血量减少
                    break;
                }else{
                    bossbloodProgress2.value -=5
                    break;
                }
                if(bossbloodProgress1.value === 0 || bossbloodProgress2.value === 0){
                    content.enemys.boss.visible = false
                    console.log("爆炸")
                    content.boom.bossboom.visible = true
                    content.boom.bossboom.running = true
                    break;
                }
                // break;
            }
            if(my_bullet1_2.x+my_bullet1_2.width >content.enemys.boss.x
                    && my_bullet1_2.x<content.enemys.boss.x + content.enemys.boss.width
                    && my_bullet1_2.y+my_bullet1_2.height>content.enemys.boss.y
                    && my_bullet1_2.y<content.enemys.boss.y+content.enemys.boss.height){

                my_bullet1_2.visible = false
                if(!isDouble){
                    bossbloodProgress1.value -=5                 //单人模式：击中boss后boss血量减少
                    break;
                }else{
                    bossbloodProgress2.value -=5
                    break;
                }
                if(bossbloodProgress1.value === 0|| bossbloodProgress2.value === 0){
                    content.enemys.boss.visible = false
                    console.log("爆炸")
                    content.boom.bossboom.visible = true
                    content.boom.bossboom.running = true
                    break;
                }
                // break;
            }
            if(my_bullet_2.x+my_bullet_2.width >content.enemys.boss.x
                    && my_bullet_2.x<content.enemys.boss.x + content.enemys.boss.width
                    && my_bullet_2.y+my_bullet_2.height>content.enemys.boss.y
                    && my_bullet_2.y<content.enemys.boss.y+content.enemys.boss.height){

                my_bullet_2.visible = false
                if(!isDouble){
                    bossbloodProgress1.value -=5                 //单人模式：击中boss后boss血量减少
                    break;
                }else{
                    bossbloodProgress2.value -=5
                    break;
                }
                if(bossbloodProgress1.value === 0|| bossbloodProgress2.value === 0){
                    content.enemys.boss.visible = false
                    console.log("爆炸")
                    content.boom.bossboom.visible = true
                    content.boom.bossboom.running = true
                    break;
                }
                // break;
            }
            if(my_bullet2_2.x+my_bullet2_2.width >content.enemys.boss.x
                    && my_bullet2_2.x<content.enemys.boss.x + content.enemys.boss.width
                    && my_bullet2_2.y+my_bullet2_2.height>content.enemys.boss.y
                    && my_bullet2_2.y<content.enemys.boss.y+content.enemys.boss.height){

                my_bullet2_2.visible = false
                if(!isDouble){
                    bossbloodProgress1.value -=5                 //单人模式：击中boss后boss血量减少
                    break;
                }else{
                    bossbloodProgress2.value -=5
                    break;
                }
                if(bossbloodProgress1.value === 0|| bossbloodProgress2.value === 0){
                    content.enemys.boss.visible = false
                    console.log("爆炸")
                    content.boom.bossboom.visible = true
                    content.boom.bossboom.running = true
                    break;
                }
                // break;
            }
        }
    }

    //敌机发射子弹与我方飞机的碰撞检测
    function checkCollision2(){
        //普通敌机发射子弹碰撞检测
        if(_enemy_bullet.x + _enemy_bullet.width > content.myplane.myplane_1.x
                && _enemy_bullet.x < content.myplane.myplane_1.x + content.myplane.myplane_1.width
                && _enemy_bullet.y + _enemy_bullet.height > content.myplane.myplane_1.y
                && _enemy_bullet.y < content.myplane.myplane_1.y + content.myplane.myplane_1.height){
            _enemy_bullet.visible = false
            if(!myplane.isShield_1){
                isHit_1 = true
            }
        }
        if(_enemy_bullet.x + _enemy_bullet.width > content.myplane.myplane_2.x
                && _enemy_bullet.x < content.myplane.myplane_2.x + content.myplane.myplane_2.width
                && _enemy_bullet.y + _enemy_bullet.height > content.myplane.myplane_2.y
                && _enemy_bullet.y < content.myplane.myplane_2.y + content.myplane.myplane_2.height){
            _enemy_bullet.visible = false
            if(!myplane.isShield_2){
                isHit_2 = true          //双人模式：普通敌机子弹击中我方玩家2之后，玩家2血量减少
            }
        }
        if(enemys.bossAppeared){
            //boss发射子弹碰撞检测
            if(_boss_bullet.x + _boss_bullet.width > content.myplane.myplane_1.x
                    && _boss_bullet.x < content.myplane.myplane_1.x + content.myplane.myplane_1.width
                    && _boss_bullet.y + _boss_bullet.height > content.myplane.myplane_1.y
                    && _boss_bullet.y < content.myplane.myplane_1.y + content.myplane.myplane_1.height){
                _boss_bullet.visible = false
                if(!myplane.isShield_1){
                    isBossHit_1 = true
                }
            }
            if(_boss_bullet.x + _boss_bullet.width > content.myplane.myplane_2.x
                    && _boss_bullet.x < content.myplane.myplane_2.x + content.myplane.myplane_2.width
                    && _boss_bullet.y + _boss_bullet.height > content.myplane.myplane_2.y
                    && _boss_bullet.y < content.myplane.myplane_2.y + content.myplane.myplane_2.height){
                _boss_bullet.visible = false
                if(!myplane.isShield_2){
                    isBossHit_2 = true          //双人模式：boss子弹击中我方玩家2之后，玩家2血量减少
                }
            }
        }
    }

    //冲击波和敌机碰撞检测
    function checkCollisionBomb(){
        for(var i = content.enemys.enemys.length - 1; i >= 0; i--){
            var enemy = content.enemys.enemys[i];
            var enemyWidth = enemy.width;
            var enemyHeight = enemy.height;

            // 计算敌机的边界框
            var enemyLeft = enemy.x - enemyWidth / 2;
            var enemyRight = enemy.x + enemyWidth / 2;
            var enemyTop = enemy.y - enemyHeight / 2;
            var enemyBottom = enemy.y + enemyHeight / 2;

            // 检查敌机边界框的四个角是否在冲击波区域内
            var corners = [
                { x: enemyLeft, y: enemyTop },
                { x: enemyRight, y: enemyTop },
                { x: enemyLeft, y: enemyBottom },
                { x: enemyRight, y: enemyBottom }
            ];
            for(var j = 0; j < corners.length; j++){
                var corner = corners[j];
                var dx = corner.x - myplane.bombCenterX;
                var dy = corner.y - myplane.bombCenterY;
                var distance = Math.sqrt(dx * dx + dy * dy);

                // 如果任何一个角的距离小于或等于冲击波的半径，那么发生碰撞
                if(distance <= myplane.bombRadius){
                    // 处理碰撞销毁敌机
                    enemy.destroy()
                    // 从数组中移除敌机
                    content.enemys.enemys.splice(i, 1);
                    //消除所有子弹
                    _enemy_bullet.visible = false
                    _boss_bullet.visible = false
                    break;
                }
            }
        }
    }


    function cleanBullt(){
        my_bullet_1.visible = false
        my_bullet_2.visible = false
        my_bullet1_2.visible = false
        my_bullet2_2.visible = false
        my_bullet_mid.visible = false
        _enemy_bullet.visible = false
        _boss_bullet.visible = false
        my_bullet_mid.visible = false
        my_bullet_mid2.visible = false

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
        width: bullet_Width*2
        height: bullet_Height*4
    }
    Image {
        id: my_bullet_mid2
        source: "images/bullet_mid.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:window_Height
        width: bullet_Width*2
        height: bullet_Height*4
    }
    Image {
        id: _enemy_bullet
        visible: false
        source: "images/enemy_bullet1.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:0
        width: bullet_Width*2
        height: bullet_Height*5
    }
    Image{
        id:_boss_bullet
        visible:false
        source: "images/boss_bullet1.png"
        fillMode: Image.PreserveAspectFit
        x:window_Width/2
        y:0
        width: bullet_Width*2
        height: bullet_Height*5
    }
}
