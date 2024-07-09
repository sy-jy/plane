import QtQuick

Item {
    id:gameBullets
    property int my_bulletSpeed: 25         //我方子弹的移动速度
    property int enemy_bulletSpeed:10       //敌方子弹的移动速度

    property int bullet_Width:window_Height/5/5           //子弹的图片大小
    property int bullet_Height: 15

    property int bulletX:(window_Width-bullet_Width)/2          //子弹的位置坐标
    property int bulletY:(window_Height*4/5)
    property int maxBullets:window_Height/bullet_Height
    property int boss2ShootCooldown: 0
    property var enemyBullets: []
    property var boss2Bullets: []
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
    property alias boss2_bullet_special: _boss2_bullet_special
    property Item target

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
    Component {
        id: meatshieldBulletComponent
        Image {
            source: "images/enemy_bullet2.png"
            property int angle: 0 // 子弹发射角度
            property int speed: 5 // 子弹速度

            // 更新子弹位置
            function updatePosition() {
                x += speed * Math.cos(angle)
                y += speed * Math.sin(angle)
            }
        }
    }
    // 肉盾敌机发射子弹
    function shoot_meatshield(enemy) {
        var angleIncrement = (Math.PI * 2) / 8 // 360度(2π弧度)除以8个点
        var radius = Math.max(enemy.width, enemy.height) / 2 // 子弹应该从enemy的边缘发射
        for (var j = 0; j < 8; j++) {
            var bullet = meatshieldBulletComponent.createObject(gameBullets)
            // 计算子弹的x和y位置，使其围绕enemy中心点均匀分布
            bullet.x = enemy.x + enemy.width / 2 - bullet.width / 2 + radius * Math.cos(angleIncrement * j)
            bullet.y = enemy.y + enemy.height / 2 - bullet.height / 2 + radius * Math.sin(angleIncrement * j)
            bullet.angle = angleIncrement * j // 设置不同的发射角度
            enemyBullets.push(bullet)
        }
    }

    function updateMeatshieldBullets() {
        // 遍历所有子弹并更新位置
        for (var i = gameBullets.children.length - 1; i >= 0; i--) {
            var bullet = gameBullets.children[i];
            if (bullet.objectType === meatshieldBulletComponent.objectType) {
                if(bullet&&bullet.updatePosition){
                    bullet.updatePosition()
                }
                // 如果子弹超出屏幕，则销毁
                if (bullet.y > gameBullets.height || bullet.x < 0 || bullet.x > gameBullets.width) {
                    bullet.destroy();
                }
            }
        }
    }

    property int bulletDirection: 1 // 控制子弹移动方向的属性
    //boss发射子弹
    function shoot_boss(boss){
        boss2ShootCooldown--
        switch (boss.name){
        case "boss1":
            isShooted_boss = true
            _boss_bullet.visible = true
            _boss_bullet.y += enemy_bulletSpeed

            if(_boss_bullet.y > window_Height){
                isShooted_boss = false
            }
            break
        case "boss2":
            if(boss2ShootCooldown<=0){
                for (var i = 0; i < 20; i++) {
                    var bullet = boss2BulletComponent.createObject(boss)
                    bullet.x = boss.x   // 设置初始x位置
                    bullet.y = boss.y + boss.height  // 设置初始y位置
                    boss2Bullets.push(bullet)
                    boss2ShootCooldown = 20
                }
            }
            // 更新子弹位置
            for (i = 0; i < boss2Bullets.length; i++) {
                boss2Bullets[i].visible = true;
                if (boss2Bullets[i] && boss2Bullets[i].updateBulletPosition) {
                    boss2Bullets[i].updateBulletPosition();
                }

            }
            if(content.bossbloodProgress1.value/content.bossbloodProgress1.to<=0.5
                ||content.bossbloodProgress2.value/content.bossbloodProgress2.to<=0.5){
                // 血量低于一半，发射特殊子弹
                if (!content.myplane.target1&&!content.myplane.target2) {
                    target = content.isDouble ? Math.random() > 0.5 ? content.myplane.myplane_1 : content.myplane.myplane_2
                                : content.myplane.myplane_1// 随机选择追踪的战机
                    specialBulletTimer.start() // 启动计时器
                }
            }
            break
        case "boss3":
            isShooted_boss = true
            _boss_bullet.visible = true
            if(!content.isDouble){
                content.bossbloodProgress1.value += 1
            }else{
                content.bossbloodProgress2.value += 1
            }
            if(content.bossbloodProgress1.value/content.bossbloodProgress1.to<=0.5
                ||content.bossbloodProgress2.value/content.bossbloodProgress2.to<=0.5){
                _boss_bullet.y += enemy_bulletSpeed*2
            }else{
                _boss_bullet.y += enemy_bulletSpeed
            }
            if(_boss_bullet.y > window_Height){
                isShooted_boss = false
            }
            break
        }
    }
    function pauseSpecialBullet(){
        if(myplane.target_1.visible === true){
            myplane.targetFadeAnimation1.pause()
        }else{
            specialBulletTimer.stop()
        }
        if(myplane.target_2.visible === true){
            myplane.targetFadeAnimation2.pause()
        }else{
            specialBulletTimer.stop()
        }
    }

    Timer{
        id:specialBulletTimer
        interval: 2000
        repeat: false
        running: false
        onTriggered: {
            if(target === content.myplane.myplane_1){
                content.myplane.target_1.visible = true
                content.myplane.target1 = true
                content.myplane.targetFadeAnimation1.start()
            }
            if(target === content.myplane.myplane_2){
                content.myplane.target_2.visible = true
                content.myplane.target2 = true
                content.myplane.targetFadeAnimation2.start()
            }
        }
    }
    function shootSpecialBullet(){
        boss2_bullet_special.visible = true
        boss2_bullet_special.y += enemy_bulletSpeed
        if(boss2_bullet_special.y > window_Height){
            resetSpecialBullet()
        }
    }
    function resetSpecialBullet(){
        boss2_bullet_special.visible = false
        content.myplane.target1 = false
        content.myplane.target2 = false
        boss2_bullet_special.y = -boss2_bullet_special.height
    }

    function bossDie(){
        content.enemys.destroyBoss()
        enemys.bossAppeared = false
    }

    //碰撞检测
    //我方发射子弹与敌机的碰撞检测
    function checkCollision(){
        for(var i = content.enemys.enemys.length-1; i>=0;i--){
            //我方玩家1击中普通敌机
            if(my_bullet_1.x+my_bullet_1.width >content.enemys.enemys[i].x
                    && my_bullet_1.x<content.enemys.enemys[i].x + 65
                    && my_bullet_1.y+my_bullet_1.height>content.enemys.enemys[i].y
                    && my_bullet_1.y<content.enemys.enemys[i].y+65){
                isShooted_1 = false
                my_bullet_1.visible = false
                // 销毁敌机
                content.enemys.enemys[i].destroy()
                // 从数组中移除敌机
                content.enemys.enemys.splice(i, 1);
                if(!isDouble){
                    score1++
                    money_number1 +=5
                }else{
                    score2++
                    money_number2 +=5
                }
                bgm.boomMusic.play()
                console.log("子弹爆炸")/*
                content.boom.enemyboom.visible = true
                content.boom.enemyboom.running = true*/
                content.boom.enemyExplosion()
                content.boom.enemyboom.x = content.enemys.enemys[i].x
                content.boom.enemyboom.y = content.enemys.enemys[i].y
                break;
            }
            if(my_bullet1_2.x+my_bullet1_2.width >content.enemys.enemys[i].x
                    && my_bullet1_2.x<content.enemys.enemys[i].x + 65
                    && my_bullet1_2.y+my_bullet1_2.height>content.enemys.enemys[i].y
                    && my_bullet1_2.y<content.enemys.enemys[i].y+65){

                my_bullet1_2.visible = false
                // 销毁敌机
                content.enemys.enemys[i].destroy()
                // 从数组中移除敌机
                content.enemys.enemys.splice(i, 1);
                if(!isDouble){
                    score1++
                    money_number1 +=5
                }else{
                    score2++
                    money_number2 +=5
                }
                bgm.boomMusic.play()
                console.log("子弹爆炸")
                // content.boom.enemyboom.visible = true
                // content.boom.enemyboom.running = true
                content.boom.enemyExplosion()
                content.boom.enemyboom.x = content.enemys.enemys[i].x
                content.boom.enemyboom.y = content.enemys.enemys[i].y
                break;
            }
            //我方玩家2击中普通敌机
            if(my_bullet_2.x+my_bullet_2.width >content.enemys.enemys[i].x
                    && my_bullet_2.x<content.enemys.enemys[i].x + 65
                    && my_bullet_2.y+my_bullet_2.height>content.enemys.enemys[i].y
                    && my_bullet_2.y<content.enemys.enemys[i].y+65){

                my_bullet_2.visible = false
                // 销毁敌机
                content.enemys.enemys[i].destroy()
                // 从数组中移除敌机
                content.enemys.enemys.splice(i, 1);
                if(!isDouble){
                    score1++
                    money_number1 +=5
                }else{
                    score2++
                    money_number2 +=5
                }
                bgm.boomMusic.play()
                console.log("子弹爆炸")
                content.boom.enemyboom.visible = true
                content.boom.enemyboom.running = true
                content.boom.enemyboom.x = content.enemys.enemys[i].x
                content.boom.enemyboom.y = content.enemys.enemys[i].y
                break;
                // break;
            }
            if(my_bullet2_2.x+my_bullet2_2.width >content.enemys.enemys[i].x
                    && my_bullet2_2.x<content.enemys.enemys[i].x + 65
                    && my_bullet2_2.y+my_bullet2_2.height>content.enemys.enemys[i].y
                    && my_bullet2_2.y<content.enemys.enemys[i].y+65){

                my_bullet2_2.visible = false
                // 销毁敌机
                content.enemys.enemys[i].destroy()
                // 从数组中移除敌机
                content.enemys.enemys.splice(i, 1);
                if(!isDouble){
                    score1++
                    money_number1 +=5
                }else{
                    score2++
                    money_number2 +=5
                }
                bgm.boomMusic.play()
                console.log("子弹爆炸")
                content.boom.enemyboom.visible = true
                content.boom.enemyboom.running = true
                content.boom.enemyboom.x = content.enemys.enemys[i].x
                content.boom.enemyboom.y = content.enemys.enemys[i].y
                break;
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
                    if(bossbloodProgress1.value === 0){
                        bossDie()
                        bossbloodProgress1.visible = false
                        console.log("爆炸")
                        content.boom.bossboom.visible = true
                        content.boom.bossboom.running = true
                        content.boom.bossboom.x = content.enemys.boss.x
                        content.boom.bossboom.y = content.enemys.boss.y
                        break;
                    }
                    break;
                }else{
                    bossbloodProgress2.value -=5
                    if(bossbloodProgress2.value === 0){
                        bossDie()
                        bossbloodProgress1.visible = false
                        console.log("爆炸")
                        content.boom.bossboom.visible = true
                        content.boom.bossboom.running = true
                        content.boom.bossboom.x = content.enemys.boss.x
                        content.boom.bossboom.y = content.enemys.boss.y
                        break;
                    }
                }
            }
            if(my_bullet1_2.x+my_bullet1_2.width >content.enemys.boss.x
                    && my_bullet1_2.x<content.enemys.boss.x + content.enemys.boss.width
                    && my_bullet1_2.y+my_bullet1_2.height>content.enemys.boss.y
                    && my_bullet1_2.y<content.enemys.boss.y+content.enemys.boss.height){

                my_bullet1_2.visible = false
                if(!isDouble){
                    bossbloodProgress1.value -=5                 //单人模式：击中boss后boss血量减少
                    if(bossbloodProgress1.value === 0){
                        bossDie()
                        bossbloodProgress1.visible = false
                        console.log("爆炸")
                        content.boom.bossboom.visible = true
                        content.boom.bossboom.running = true
                        content.boom.bossboom.x = content.enemys.boss.x
                        content.boom.bossboom.y = content.enemys.boss.y
                        break;
                    }
                    break;
                }else{
                    bossbloodProgress2.value -=5
                    if(bossbloodProgress2.value === 0){
                        bossDie()
                        bossbloodProgress1.visible = false
                        console.log("爆炸")
                        content.boom.bossboom.visible = true
                        content.boom.bossboom.running = true
                        content.boom.bossboom.x = content.enemys.boss.x
                        content.boom.bossboom.y = content.enemys.boss.y
                        break;
                    }
                }
            }
            if(my_bullet_2.x+my_bullet_2.width >content.enemys.boss.x
                    && my_bullet_2.x<content.enemys.boss.x + content.enemys.boss.width
                    && my_bullet_2.y+my_bullet_2.height>content.enemys.boss.y
                    && my_bullet_2.y<content.enemys.boss.y+content.enemys.boss.height){

                my_bullet_2.visible = false
                if(!isDouble){
                    bossbloodProgress1.value -=5                 //单人模式：击中boss后boss血量减少
                    if(bossbloodProgress1.value === 0){
                        bossDie()
                        bossbloodProgress1.visible = false
                        console.log("爆炸")
                        content.boom.bossboom.visible = true
                        content.boom.bossboom.running = true
                        content.boom.bossboom.x = content.enemys.boss.x
                        content.boom.bossboom.y = content.enemys.boss.y
                        break;
                    }
                    break;
                }else{
                    bossbloodProgress2.value -=5
                    if(bossbloodProgress2.value === 0){
                        bossDie()
                        bossbloodProgress1.visible = false
                        console.log("爆炸")
                        content.boom.bossboom.visible = true
                        content.boom.bossboom.running = true
                        content.boom.bossboom.x = content.enemys.boss.x
                        content.boom.bossboom.y = content.enemys.boss.y
                        break;
                    }
                }
            }
            if(my_bullet2_2.x+my_bullet2_2.width >content.enemys.boss.x
                    && my_bullet2_2.x<content.enemys.boss.x + content.enemys.boss.width
                    && my_bullet2_2.y+my_bullet2_2.height>content.enemys.boss.y
                    && my_bullet2_2.y<content.enemys.boss.y+content.enemys.boss.height){

                my_bullet2_2.visible = false
                if(!isDouble){
                    bossbloodProgress1.value -=5                 //单人模式：击中boss后boss血量减少
                    if(bossbloodProgress1.value === 0){
                        bossDie()
                        bossbloodProgress1.visible = false
                        console.log("爆炸")
                        content.boom.bossboom.visible = true
                        content.boom.bossboom.running = true
                        content.boom.bossboom.x = content.enemys.boss.x
                        content.boom.bossboom.y = content.enemys.boss.y
                        break;
                    }
                    break;
                }else{
                    bossbloodProgress2.value -=5
                    if(bossbloodProgress2.value === 0){
                        bossDie()
                        bossbloodProgress1.visible = false
                        console.log("爆炸")
                        content.boom.bossboom.visible = true
                        content.boom.bossboom.running = true
                        content.boom.bossboom.x = content.enemys.boss.x
                        content.boom.bossboom.y = content.enemys.boss.y
                        break;
                    }
                }
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
        for (var j = enemyBullets.length - 1; j >= 0; j--) {
            var bullet = enemyBullets[j]
            // 检查子弹是否与玩家飞机1发生碰撞
            if (bullet.x < content.myplane.myplane_1.x + content.myplane.myplane_1.width &&
                bullet.x + bullet.width > content.myplane.myplane_1.x &&
                bullet.y < content.myplane.myplane_1.y + content.myplane.myplane_1.height &&
                bullet.y + bullet.height > content.myplane.myplane_1.y) {
                console.log("attcked")
                // 碰撞发生，处理碰撞
                if(!myplane.isShield_1){
                    isHit_1 = true
                }
                bullet.destroy()
                enemyBullets.splice(enemyBullets.indexOf(bullet), 1)
            }
            // 检查子弹是否与玩家飞机2发生碰撞（如果存在）
            if (content.myplane.myplane_2 && // 确保玩家飞机2存在
                bullet.x < content.myplane.myplane_2.x + content.myplane.myplane_2.width &&
                bullet.x + bullet.width > content.myplane.myplane_2.x &&
                bullet.y < content.myplane.myplane_2.y + content.myplane.myplane_2.height &&
                bullet.y + bullet.height > content.myplane.myplane_2.y) {
                // 碰撞发生，处理碰撞
                if(!myplane.isShield_2){
                    isHit_2 = true
                }
                bullet.destroy()
                enemyBullets.splice(enemyBullets.indexOf(bullet), 1)
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
            for (j = boss2Bullets.length - 1; j >= 0; j--) {
                var bossbullet = boss2Bullets[j]
                // 检查子弹是否与玩家飞机1发生碰撞
                if (bossbullet.x < content.myplane.myplane_1.x + content.myplane.myplane_1.width &&
                    bossbullet.x + bossbullet.width > content.myplane.myplane_1.x &&
                    bossbullet.y < content.myplane.myplane_1.y + content.myplane.myplane_1.height &&
                    bossbullet.y + bossbullet.height > content.myplane.myplane_1.y) {
                    // 碰撞发生，处理碰撞
                    if(!myplane.isShield_1){
                        isHit_1 = true
                    }
                    bossbullet.destroy()
                    boss2Bullets.splice(boss2Bullets.indexOf(bossbullet), 1)
                }
                // 检查子弹是否与玩家飞机2发生碰撞（如果存在）
                if (content.myplane.myplane_2 && // 确保玩家飞机2存在
                    bossbullet.x < content.myplane.myplane_2.x + content.myplane.myplane_2.width &&
                    bossbullet.x + bossbullet.width > content.myplane.myplane_2.x &&
                    bossbullet.y < content.myplane.myplane_2.y + content.myplane.myplane_2.height &&
                    bossbullet.y + bossbullet.height > content.myplane.myplane_2.y) {
                    // 碰撞发生，处理碰撞
                    if(!myplane.isShield_2){
                        isHit_2 = true
                    }
                    bossbullet.destroy()
                    boss2Bullets.splice(boss2Bullets.indexOf(bossbullet), 1)
                }
            }
            //boss发射特殊子弹碰撞检测
            if(boss2_bullet_special.x + boss2_bullet_special.width > content.myplane.myplane_1.x
                    && boss2_bullet_special.x < content.myplane.myplane_1.x + content.myplane.myplane_1.width
                    && boss2_bullet_special.y + boss2_bullet_special.height > content.myplane.myplane_1.y
                    && boss2_bullet_special.y < content.myplane.myplane_1.y + content.myplane.myplane_1.height){
                resetSpecialBullet()
                if(!myplane.isShield_1){
                    isBossHit_1 = true
                    content.myplane.myplane_1.methysis = true
                    content.myplane.myplane_1.lossBlood = content.myplane.lossBloodFrame
                }
            }
            if(boss2_bullet_special.x + boss2_bullet_special.width > content.myplane.myplane_2.x
                    && boss2_bullet_special.x < content.myplane.myplane_2.x + content.myplane.myplane_2.width
                    && boss2_bullet_special.y + boss2_bullet_special.height > content.myplane.myplane_2.y
                    && boss2_bullet_special.y < content.myplane.myplane_2.y + content.myplane.myplane_2.height){
                resetSpecialBullet()
                if(!myplane.isShield_2){
                    isBossHit_2 = true
                    content.myplane.myplane_2.methysis = true
                    content.myplane.myplane_2.lossBlood = content.myplane.lossBloodFrame
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
                    cleanEnemyBullet()
                    break;
                }
            }
        }
    }


    function checkCollisionPlane(){
        var myPlane_1 = content.myplane.myplane_1
        var myPlaneWidth = myPlane_1.width
        var myPlaneHeight = myPlane_1.height
        // 计算我方飞机的边界框
        var myPlaneLeft_1 = myPlane_1.x - myPlaneWidth / 2;
        var myPlaneRight_1 = myPlane_1.x + myPlaneWidth / 2;
        var myPlaneTop_1 = myPlane_1.y - myPlaneHeight / 2;
        var myPlaneBottom_1 = myPlane_1.y + myPlaneHeight / 2;
        if(isDouble){
            var myPlane_2 = content.myplane.myplane_2
            // 计算我方飞机的边界框
            var myPlaneLeft_2 = myPlane_2.x - myPlaneWidth / 2;
            var myPlaneRight_2 = myPlane_2.x + myPlaneWidth / 2;
            var myPlaneTop_2 = myPlane_2.y - myPlaneHeight / 2;
            var myPlaneBottom_2 = myPlane_2.y + myPlaneHeight / 2;
        }

        // 遍历所有敌机
        for (var i = content.enemys.enemys.length - 1; i >= 0; i--) {
            var enemy = content.enemys.enemys[i];
            var enemyWidth = enemy.width;
            var enemyHeight = enemy.height;

            // 计算敌机的边界框
            var enemyLeft = enemy.x - enemyWidth / 2;
            var enemyRight = enemy.x + enemyWidth / 2;
            var enemyTop = enemy.y - enemyHeight / 2;
            var enemyBottom = enemy.y + enemyHeight / 2;

            // 检测两个边界框是否有交集
            if (myPlaneRight_1 >= enemyLeft && myPlaneLeft_1 <= enemyRight && myPlaneBottom_1 >= enemyTop && myPlaneTop_1 <= enemyBottom) {
                // 处理碰撞，例如减少生命值或游戏结束
                if(!content.myplane.isShield_1){
                    if(!isDouble){
                        content.bloodProgress.value -=20
                        if(content.bloodProgress.value===0&&content.remainlife_1!==0){
                            if(content.dialogs.musicEnabled){//开启了音效
                                bgm.life_loseMusic.play()//失去生命的音效
                            }

                            content.remainlife_1--;
                            content.lifeModel.get(content.remainlife_1).visible= false
                            content.bloodProgress.value = myplane.blood
                            content.myplane.startBomb()
                        }
                        if(content.bloodProgress.value===0&&content.remainlife_1===0){
                            content.myplane.isSurvive_1 = false
                        }
                    }else{
                        content.bloodProgress_1.value -= 20
                        if(content.bloodProgress_1.value===0&&content.remainlife_1!==0){
                            if(content.dialogs.musicEnabled){//开启了音效
                                bgm.life_loseMusic.play()//失去生命的音效
                            }

                            content.remainlife_1--;
                            content.lifeModel_1.get(content.remainlife_1).visible= false
                            content.bloodProgress_1.value = content.myplane.blood
                            content.myplane.startBomb()
                        }
                        if(content.bloodProgress_1.value===0&&content.remainlife_1===0){
                            content.myplane.isSurvive_1 = false
                        }
                    }
                }
                enemy.destroy(); // 销毁敌机
                content.enemys.enemys.splice(i, 1); // 从数组中移除敌机
                break; // 如果需要，可以在这里结束循环
            }
            if(isDouble){
                if (myPlaneRight_2 >= enemyLeft && myPlaneLeft_2 <= enemyRight && myPlaneBottom_2 >= enemyTop && myPlaneTop_2 <= enemyBottom) {
                    // 处理碰撞，例如减少生命值或游戏结束
                    if(!content.myplane.isShield_2){
                        content.bloodProgress_2.value -=10
                        if(content.bloodProgress_2.value===0&&content.remainlife_2!==0){
                            if(content.dialogs.musicEnabled){//开启了音效
                                bgm.life_loseMusic.play()//失去生命的音效
                            }
                            content.remainlife_2--;
                            content.lifeModel_2.get(remainlife_2).visible= false
                            content.bloodProgress_2.value = myplane.blood
                            content.myplane.startBomb()
                        }
                        if(content.bloodProgress_2.value===0&&content.remainlife_2===0){
                            content.myplane.isSurvive_2 = false
                        }
                    }
                    enemy.destroy(); // 销毁敌机
                    content.enemys.enemys.splice(i, 1); // 从数组中移除敌机
                    break; // 如果需要，可以在这里结束循环
                }
            }
        }
    }

    function cleanEnemyBullet(){
        _enemy_bullet.visible = false
        _boss_bullet.visible = false
        // 遍历数组，销毁每个子弹对象
        for (var i = enemyBullets.length - 1; i >= 0; i--) {
            var bullet = enemyBullets[i];
            if (bullet.destroy) {
                bullet.destroy(); // 假设每个子弹都有一个destroy方法
            }
        }
        for (i = boss2Bullets.length - 1; i >= 0; i--) {
            bullet = boss2Bullets[i];
            if (bullet.destroy) {
                bullet.destroy(); // 假设每个子弹都有一个destroy方法
            }
        }
        // 清空数组
        enemyBullets.length = 0;
        boss2Bullets.length = 0
    }

    function cleanBullet(){
        my_bullet_1.visible = false
        my_bullet_2.visible = false
        my_bullet1_2.visible = false
        my_bullet2_2.visible = false
        my_bullet_mid.visible = false
        my_bullet_mid.visible = false
        my_bullet_mid2.visible = false
        cleanEnemyBullet()
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
    // Boss2Bullet组件
    Component {
        id: boss2BulletComponent
        Image {
            id: _boss2_bullet
            source: "images/bossAmmoNormal.png"
            visible: false
            property bool isMovingRight: true // 决定子弹是向右移动还是向左移动
            // 更新子弹位置，实现之字形移动
            function updateBulletPosition() {
                if (isMovingRight) {
                    _boss2_bullet.x += enemy_bulletSpeed*2;
                    if (_boss2_bullet.x >= gameBullets.width - _boss2_bullet.width) {
                        isMovingRight = false;
                    }
                } else {
                    _boss2_bullet.x -= enemy_bulletSpeed*2;
                    if (_boss2_bullet.x <= 0) {
                        isMovingRight = true;
                    }
                }
                _boss2_bullet.y += enemy_bulletSpeed/3; // 子弹沿Y轴向下移动

                // 如果子弹超出屏幕，将其隐藏
                if (_boss2_bullet.y > window_Height) {
                    _boss2_bullet.destroy()
                    boss2Bullets.splice(boss2Bullets.indexOf(_boss2_bullet), 1)
                }
            }
        }
    }
    Image {
        id: _boss2_bullet_special
        source: "images/bossAmmo.png"
        y:-boss2_bullet_special.height
        visible: false
    }
}
