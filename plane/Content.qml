import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item{
    property alias mode: mode
    property alias player: player
    property alias plane: plane
    property alias homepage: _homepage
    property alias stackview: _stackview
    property alias dialogs: dialogs
    property alias myplane: myplane
    property alias enemys: enemys
    property alias timer: timer


    property alias currentIndexWSAD: plane.currentIndexWSAD
    property alias currentIndexArrows: plane.currentIndexArrows
    property bool condition: true

    property alias mapmodel: control
    property string myplane_1_path        // 玩家1的战机图片源
    property string myplane_2_path        // 玩家2的战机图片源

    property string mybullet_1_path       //子弹图片源1

    property bool isDouble                //是否为双人模式
    property alias timerSingle: timer
    //property alias timermybullet: bulletTimer
    property int desiredFramesPerSecond: 60 // 期望的每秒帧数
    //P1移动状态
    property bool movingLeft_P1: false
    property bool movingRight_P1: false
    property bool movingUp_P1: false
    property bool movingDown_P1: false
    //P2移动状态
    property bool movingLeft_P2: false
    property bool movingRight_P2: false
    property bool movingUp_P2: false
    property bool movingDown_P2: false
    property string map_path: "./images/map1.png"    //地图图片源
    property string mapView: "./images/map1.png"
    property int remainlife_1:myplane.lives-1
    property int remainlife_2:myplane.lives-1
    property alias bloodProgress: bloodProgress
    property alias bloodProgress_1: bloodProgress_1
    property alias bloodProgress_2: bloodProgress_2
    // property alias blood: bloodSlider
    anchors.fill: parent

    //模式选择
    ColumnLayout{

        visible: false
        id:mode
        //难度模式选择
        RowLayout{
            Layout.topMargin: window_Height/15
            Layout.leftMargin: window_Width/25
            spacing: window_Width/10
            // 模式选择标题
            Text {
                // Layout.alignment: Qt.AlignHCenter
                id: modeSet
                text: qsTr("游戏难度")
                font.pointSize: 40
                color: "black"
            }

            //模式选择
            ButtonGroup {
                buttons: modeButton.children
            }
            Row {
                spacing: window_Width/10
                Layout.alignment: Qt.AlignHCenter
                id: modeButton
                RadioButton {
                    id:easy
                    checked: true
                    text: qsTr(" <简单>")
                    font.letterSpacing: 15
                    font.pointSize: 18 // 设置字体大小（以磅为单位）
                    font.bold: true // 设置字体加粗
                    background:Rectangle{
                        implicitHeight: 55
                        implicitWidth: 100
                        radius: 10
                        color:easy.checked? "lightskyblue" :  hoverEasy.hovered ? "lightblue" : "lightsteelblue"
                        HoverHandler {
                             id: hoverEasy
                             acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                             cursorShape: Qt.PointingHandCursor
                         }
                    }
                }

                RadioButton {
                    id:difficult
                    text: qsTr(" <困难>")
                    font.letterSpacing: 15
                    font.pointSize: 18 // 设置字体大小（以磅为单位）
                    font.bold: true // 设置字体加粗
                    background:Rectangle{
                        implicitHeight: 55
                        implicitWidth: 100
                        radius: 10
                        color:difficult.checked? "lightskyblue" :  hoverDifficult.hovered ? "lightblue" : "lightsteelblue"
                        HoverHandler {
                             id: hoverDifficult
                             acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                             cursorShape: Qt.PointingHandCursor
                         }
                    }
                }
            }
        }

        RowLayout{
            Layout.leftMargin: window_Width/25
            spacing: window_Width/10
            // 地图选择标题
            Text {
                id: mapSet
                text: qsTr("地图选择")
                font.pointSize: 40
                color: "black"
            }

            //地图选择
            // 按钮
            Rectangle{
                clip: true
                width: 200
                height:40
                ComboBox {
                    id:control
                    background:Rectangle{
                        implicitWidth: 200
                        implicitHeight: 40
                        color:"black"
                        radius: 20
                    }
                    // 更改显示文本的样式
                    contentItem: Text {
                        text:control.model.get(control.currentIndex).text // 直接绑定到 model 的 text 属性
                        color: "white" // 更改文本颜色
                        font.bold: true // 设置字体为粗体
                        font.pointSize: 20 // 设置字体大小
                        font.letterSpacing: 30
                        horizontalAlignment: Text.AlignHCenter // 水平居中
                        verticalAlignment: Text.AlignVCenter // 垂直居中
                    }
                    // 定义您的模型，不包括 "随机" 元素
                    model: ListModel{
                        ListElement{
                            text:" 戈壁"
                            mapPath: "map1.png" }
                        ListElement{
                            text:" 雨林"
                            mapPath: "map2.png" }
                        ListElement{
                            text:" 墓地"
                            mapPath: "map3.png" }
                    }

                    // 在模型定义之后，添加带有随机 mapPath 的 "随机" 元素
                    Component.onCompleted: {
                        var randomIndex = Math.floor(Math.random() * control.model.count)
                        var randomMapPath = model.get(randomIndex).mapPath
                        model.append({ text: " 随机",mapPath: randomMapPath })
                    }
                    // 监听当前索引的变化
                    onCurrentIndexChanged: {
                        map_path = "./images/"+model.get(mapmodel.currentIndex).mapPath//当前选中的地图路径赋给map_path
                        if(model.get(mapmodel.currentIndex).text === " 随机"){
                            console.log("随机")
                            mapView = "./images/random.png"
                        }else{
                            mapView = map_path
                        }
                        console.log("Selected map source: ",map_path)
                    }

                    //设计右侧的小图标的样式
                    indicator: Canvas {
                        id: canvas
                        x: control.width - width - control.rightPadding
                        y: control.topPadding + (control.availableHeight - height) / 2
                        width: 15
                        height: 10
                        contextType: "2d"
                        Connections {
                            target: control
                            function onPressedChanged() { canvas.requestPaint(); }
                        }
                        onPaint: {
                            context.reset();
                            context.moveTo(0, 0);
                            context.lineTo(width, 0);
                            context.lineTo(width / 2, height);
                            context.closePath();
                            context.fillStyle = control.pressed ? "#d3d3d3" : "#778899";
                            context.fill();
                        }
                    }
                    // 定义下拉列表中每个项的视觉表示
                    delegate: ItemDelegate {
                        width: control.width
                        contentItem: Text {
                            text: model.text
                            color: "white"
                            elide: Text.ElideRight
                            font.pointSize: 16
                            leftPadding: 12
                        }
                        // 高亮选中项
                        highlighted: control.highlightedIndex === index
                    }
                    //设计弹出框的样式(点击下拉按钮后的弹出框)
                    popup: Popup {
                        y: control.height - 1
                        x: 10
                        width: control.width-20
                        implicitHeight: contentItem.implicitHeight
                        padding: 1
                        //弹出框以listview的形式呈现
                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: control.popup.visible ? control.delegateModel : null
                            currentIndex: control.highlightedIndex
                            ScrollIndicator.vertical: ScrollIndicator { }
                        }
                    }
                }
            }

            //地图缩略图位置
            Rectangle {
                width: window_Width/4
                height: window_Height/4
                border.color: "darkgray"
                border.width: 2
                color: "gray"
                Image {
                    anchors.fill: parent
                    source: mapView
                }
            }

        }

        //玩家人数选择
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: window_Height / 10
            spacing: window_Width / 5
            id: player
            Button {
                id: singleButton
                font.pointSize: 25
                font.bold: true
                text: qsTr("单人模式")
                checked:true
                background: Rectangle {
                    implicitHeight: 50
                    implicitWidth: 200
                    color:singleButton.checked? "lightskyblue" :hoverSingle.hovered ? "lightblue" : "lightsteelblue"
                }
                onClicked: {
                    singleButton.checked = true
                    doubleButton.checked = false
                    plane.showDualSelection = false
                    isDouble = false
                }
                HoverHandler {
                    id: hoverSingle
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    cursorShape: Qt.PointingHandCursor
                }
            }
            Button {
                id: doubleButton
                font.pointSize: 25
                font.bold: true
                text: qsTr("双人模式")
                background: Rectangle {
                    implicitHeight: 50
                    implicitWidth: 200
                    color:doubleButton.checked? "lightskyblue" :hoverDouble.hovered ? "lightblue" : "lightsteelblue"
                }
                onClicked: {
                    singleButton.checked = false
                    doubleButton.checked = true
                    plane.showDualSelection = true
                    isDouble = true
                }
                HoverHandler {
                    id: hoverDouble
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }

        //进入下一步选择战机
        Button{
            id:next
            Layout.alignment: Qt.AlignHCenter
            text:qsTr("下 一 步")
            font.pointSize: 25
            font.bold: true // 设置字体加粗
            background:Rectangle{
                implicitHeight: 50
                implicitWidth: 200
                color: "red"
            }
            onClicked: {
                _stackview.push(planeSet)
                plane.visible = true
                plane.focus = true// 确保GridView可以接收键盘事件
                mode.focus = false
                console.log("clicked")
            }
        }
    }

    //游戏主页
    ColumnLayout{
        id:_homepage
        anchors.fill: parent
        visible: true
        //游戏主页大厅标题
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("飞机大战")
            font.letterSpacing: 20
            font.pointSize: 40
            color: "black"
        }

        //按钮垂直排序
        Column{
            id:gameButton
            spacing:25
            Layout.alignment: Qt.AlignHCenter
            Button {
                id:start
                focus:true
                text:qsTr("开始游戏")
                font.pointSize: 25
                font.letterSpacing: 10
                // Image{
                //    source: "images/start.png"
                //    width: 161
                //    height: 43
                //    Layout.alignment: Qt.AlignHCenter
                // }
                background: Rectangle{
                    // width: 150
                    // height: 44
                    border.color: start.focus ? "red" : "white"
                    color: "yellow"
                }
                Component.onCompleted: {
                    start.forceActiveFocus();           //页面加载完成后强制按钮获得焦点
                }

                onClicked: {
                    _stackview.push(mode)                //跳转到mode页面
                    console.log("start clicked")
                }
                Keys.onEscapePressed: {
                    exit.focus = true
                }
                //键盘快捷键响应
                Keys.onSpacePressed: {
                    start.clicked()
                    start.focus = false//解决空格连续跳转问题
                }
            }

            Button {
                id:exit
                text:qsTr("退出游戏")
                font.pointSize: 25
                font.letterSpacing: 10                  //设置文字与文字之间间隔
                //indicator: Image{source:"./picture/退出游戏.jpg"}
                background: Rectangle{
                    border.color: exit.focus ? "red" : "white"
                    color: "blue    "
                }
                onClicked: {
                    Qt.quit()
                    console.log("exit clicked")
                }
                Keys.onUpPressed: {
                    start.focus = true
                }
            }
        }
        //将按钮分组，实现按钮间的互斥选择，也就是一个组内只能选择一个按钮
        ButtonGroup{
            buttons: gameButton.children
        }

        //水平顺序排列
        Row{
            spacing: 20
            Layout.alignment: Qt.AlignHCenter
            id:menu
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 5                 //设置与底部间距

            Button{
                id:skin
                text: qsTr("皮肤")
                background:Rectangle{
                    implicitHeight:60
                    implicitWidth: 60
                    color: "pink"
                }
            }
            Button{
                id:storeButton
                text: qsTr("商店")
                background:Rectangle{
                    implicitHeight:60
                    implicitWidth: 60
                    color: "pink"
                }
                onClicked: {
                     stackview_3.push(store)
                }
            }
            Button{
                id:set
                text: qsTr("设置")
                background:Rectangle{
                    implicitHeight:60
                    implicitWidth: 60
                    color: "pink"
                }
            }
        }
    }
    StackView{
      id:_stackview
      anchors.fill: parent
      onCurrentItemChanged: {
          homepage.visible=depth===0
          mode.visible = depth === 1
      }
    }
    StackView{
      id:stackview_3
      initialItem: homepage
      anchors.fill: parent
      onCurrentItemChanged: {

          store.visible = currentItem === store;
          homepage.visible = currentItem === homepage;

          if(currentItem === homepage){
              start.forceActiveFocus();                 //切换回homepage时强制按钮获得焦点，否则焦点丢失
          }
      }
    }

    Map{
        id:map
    }
    Myplane{
        id:myplane
    }
    Bullet{
        id:bullet
    }
    Items{
        id:items
    }
    Dialogs{
        id:dialogs
    }

    //玩家飞机样式选择
    ColumnLayout{
        id: planeSet
        anchors.fill: parent
        visible: false
        Text {
            text: qsTr("请选择你的战机")
            font.pointSize: 45
            Layout.alignment: Qt.AlignHCenter
        }
        GridView {
            id: plane
            width: 420 // 设置固定的宽度
            height: 270 // 设置固定的高度
            Layout.alignment: Qt.AlignHCenter
            model: ListModel {
                ListElement { imagePath: "plane1.png" }
                ListElement { imagePath: "plane2.png" }
                ListElement { imagePath: "plane3.png" }
                ListElement { imagePath: "plane4.png" }
                ListElement { imagePath: "plane5.png" }
                ListElement { imagePath: "plane6.png" }
            }
            delegate: imageDelegate
            cellWidth: 135
            cellHeight: 135
            // 控制是否显示两个选择框
            property bool showDualSelection: false
            property int columns: 3
            // 高亮显示组件
            Component {
                id: highlightComponent
                Rectangle {
                    property string playerNum   //玩家编号
                    visible: false
                    color: "transparent"
                    border.color: "red"
                    border.width: 3
                    radius: 10
                    // 添加闪烁动画
                    SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    PropertyAnimation { duration: 1000; to: 0.3 }
                    PropertyAnimation { duration: 1000; to: 1.0 }
                    }
                    // 添加Text元素以显示玩家编号
                    Text {
                        anchors.centerIn: parent
                        text: parent.playerNum
                        font.bold: true
                        font.pointSize: 24
                        color: "white"
                    }
                }
            }
            // 两个独立的玩家飞机图片当前索引
            property int currentIndexWSAD: -1
            property int currentIndexArrows: -1
            // 创建两个选择框显示实例
            property var highlightWSAD: highlightComponent.createObject(plane,{"border.color": "red","playerNum": "P1"})
            property var highlightArrows: highlightComponent.createObject(plane,{"border.color": "blue","playerNum": "P2"})
            // 更新选择框显示的位置（到第一行点击Up会直接跳到第一个选项，到最后一行点击Down会直接跳到最后一个选项）
            function updateHighlight(index, highlight) {
                if (index >= 0 && index < model.count) {
                    var columnCount = Math.floor(plane.width / plane.cellWidth)
                    highlight.x = plane.cellWidth * (index % columnCount)
                    highlight.y = plane.cellHeight * Math.floor(index / columnCount)
                    highlight.width = plane.cellWidth-10
                    highlight.height = plane.cellHeight-10
                    highlight.visible = true
                } else {
                    highlight.visible = false
                }
            }
            Keys.onPressed: {
                //双人WSAD和上下左右键的键盘事件处理
                if (showDualSelection) {
                    switch (event.key) {
                    case Qt.Key_W:
                        currentIndexWSAD = Math.max(currentIndexWSAD - 3, 0)
                        updateHighlight(currentIndexWSAD, highlightWSAD)
                        break
                    case Qt.Key_S:
                        currentIndexWSAD = Math.min(currentIndexWSAD + 3, model.count - 1)
                        updateHighlight(currentIndexWSAD, highlightWSAD)
                        break
                    case Qt.Key_A:
                        // 当currentIndexWSAD为0时，跳转到列表的最后一个元素
                        if (currentIndexWSAD === 0) {
                            currentIndexWSAD = model.count - 1
                        } else {
                            currentIndexWSAD = Math.max(currentIndexWSAD - 1, 0)
                        }
                        updateHighlight(currentIndexWSAD, highlightWSAD)
                        break
                    case Qt.Key_D:
                        // 当currentIndexWSAD为model.count - 1时，跳转到列表的第一个元素
                        if (currentIndexWSAD === model.count - 1) {
                            currentIndexWSAD = 0
                        } else {
                            currentIndexWSAD = Math.min(currentIndexWSAD + 1, model.count - 1)
                        }
                        updateHighlight(currentIndexWSAD, highlightWSAD)
                        break
                    case Qt.Key_Up:
                        currentIndexArrows = Math.max(currentIndexArrows - 3, 0)
                        updateHighlight(currentIndexArrows, highlightArrows)
                        break
                    case Qt.Key_Down:
                        currentIndexArrows = Math.min(currentIndexArrows + 3, model.count - 1)
                        updateHighlight(currentIndexArrows, highlightArrows)
                        break
                    case Qt.Key_Left:
                        // 当currentIndexArrows为0时，跳转到列表的最后一个元素
                        if (currentIndexArrows === 0) {
                            currentIndexArrows = model.count - 1
                        } else {
                            currentIndexArrows = Math.max(currentIndexArrows - 1, 0)
                        }
                        updateHighlight(currentIndexArrows, highlightArrows)
                        break
                    case Qt.Key_Right:
                        // 当currentIndexArrows为model.count - 1时，跳转到列表的第一个元素
                        if (currentIndexArrows === model.count - 1) {
                            currentIndexArrows = 0
                        } else {
                            currentIndexArrows = Math.min(currentIndexArrows + 1, model.count - 1)
                        }
                        updateHighlight(currentIndexArrows, highlightArrows)
                        break
                    }
                }
                //单人WSAD的键盘事件处理
                else {
                    switch (event.key) {
                    case Qt.Key_W:
                        currentIndexWSAD = Math.max(currentIndexWSAD - 3, 0)
                        updateHighlight(currentIndexWSAD, highlightWSAD)
                        break
                    case Qt.Key_S:
                        currentIndexWSAD = Math.min(currentIndexWSAD + 3, model.count - 1)
                        updateHighlight(currentIndexWSAD, highlightWSAD)
                        break
                    case Qt.Key_A:
                        // 当currentIndexWSAD为0时，跳转到列表的最后一个元素
                        if (currentIndexWSAD === 0) {
                            currentIndexWSAD = model.count - 1
                        } else {
                            currentIndexWSAD = Math.max(currentIndexWSAD - 1, 0)
                        }
                        updateHighlight(currentIndexWSAD, highlightWSAD)
                        break
                    case Qt.Key_D:
                        // 当currentIndexWSAD为model.count - 1时，跳转到列表的第一个元素
                        if (currentIndexWSAD === model.count - 1) {
                            currentIndexWSAD = 0
                        } else {
                            currentIndexWSAD = Math.min(currentIndexWSAD + 1, model.count - 1)
                        }
                        updateHighlight(currentIndexWSAD, highlightWSAD)
                        break
                    case Qt.Key_J:
                        break
                    }
                }
            }
            function startgame(){
                bgm.gameMusic.play()
                console.log("音效开启,gameMusic.playing:",bgm.gameMusic.playing)
                map.visible = true      //地图显示
                timer.running = true    //开启计时器
                enemys.gameTime.start()
                enemys.visible = true
            }

            Keys.onSpacePressed: {
                console.log("Selected index WSAD: ", plane.currentIndexWSAD)
                console.log("Selected index Arrows: ", plane.currentIndexArrows)
                if(showDualSelection&&plane.currentIndexWSAD!==-1&&plane.currentIndexArrows!==-1){
                    myplane_1_path = "./images/"+model.get(plane.currentIndexWSAD).imagePath//传递出玩家1选中的战机图片源
                    myplane_2_path = "./images/"+model.get(plane.currentIndexArrows).imagePath//传递出玩家2选中的战机图片源
                    console.log("Selected P1 source: ",myplane_1_path)
                    console.log("Selected P2 source: ",myplane_2_path)
                    startgame()
                    myplane.doubleplayer()  //显示双人飞机
                    myplane.shield_1.activateShield()//开局护盾
                    myplane.shield_2.activateShield()//开局护盾
                    doublegamelayout.forceActiveFocus()
                    doublegamelayout.visible = true
                }
                if(!showDualSelection&&plane.currentIndexWSAD!==-1){
                    myplane_1_path = "./images/"+model.get(plane.currentIndexWSAD).imagePath//传递出玩家1选中的战机图片源
                    startgame()
                    myplane.singleplayer()  //显示单人飞机
                    myplane.shield_1.activateShield()//开局护盾
                    singalgamelayout.forceActiveFocus()
                    singalgamelayout.visible = true
                }
            }
        }

        Component {
            id: imageDelegate
            Item {
                id: wrapper
                width: plane.cellWidth-35
                height: plane.cellHeight-35
                Image {
                    id: image
                    x:17.5
                    y:17.5
                    width: parent.width - 10
                    height: parent.height - 10
                    source: "./images/"+imagePath
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
        Text {
            id: tips
            text: qsTr("选择移动P1:WSAD P2:↑↓←→ ，按空格确认选择进入游戏")
            Layout.alignment: Qt.AlignHCenter
        }
    }
    //刷新画面
    Timer{
        id: timer
        interval: 1000 / desiredFramesPerSecond
        repeat: true
        running: false
        onTriggered:
        {
            map.updateMap()
            enemys.updateEnemys()
            //飞机移动重绘
            if(!isDouble){
                //单人
                myplane.updateMyplanePosition(movingLeft_P1,movingRight_P1,movingUp_P1,movingDown_P1)
                // console.log(myplane.isAccelerate_1)//检测是否加速
                if(bullet.isShooted){
                    //发射
                    bullet.shoot()
                }else{
                    //未发射时跟随飞机移动
                    bullet.updateMybulletPosition1()
                }

                if(!myplane.isShield_1){//测试护盾
                    bloodProgress.value-=0.3//测试血量条
                }



                items.item.move()//道具移动
                items.item.got()//道具获得
            }else{
                //双人
                myplane.updateMyplanePositions(movingLeft_P1,movingRight_P1,movingUp_P1,movingDown_P1,
                                                movingLeft_P2,movingRight_P2,movingUp_P2,movingDown_P2)
                if(bullet.isShooted){
                    //发射
                    items.item.setPosition()//测试获得道具
                    bullet.shoot()
                }else{
                    //未发射时跟随飞机移动
                    bullet.updateMybulletPosition1()
                }
                if(bullet.isShooted_2){
                    bullet.shoot2()
                }else{
                    bullet.updateMybulletPosition2()
                }

                items.item.move()//道具移动
                items.item.got()//道具获得
                if(!myplane.isShield_1){//测试护盾
                    bloodProgress_1.value-=0.3//测试血量条
                }
                // bloodProgress_1.value-=1//测试血量条
                if(!myplane.isShield_2){//测试护盾
                    bloodProgress_2.value-=0.1//测试血量条
                }
                // bloodProgress_2.value-=0.5//测试血量条
            }
        }
    }

    //游戏结束后弹窗计时器
    Timer{
        id:gameover_timer
        interval:250
        running:true
        repeat: true

        onTriggered: {
            //单人游戏界面
            if(!isDouble){
                if(bloodProgress.value === 0){
                    dialogs.defeat.open();
                    dialogs.blurRect.visible = true;
                    bgm.game_defeatMusic.play()
                    gameover_timer.stop();
                }
            }else{
                //双人游戏界面
                if(bloodProgress_1.value === 0 &&bloodProgress_2.value === 0){
                    dialogs.defeat.open();
                    dialogs.blurRect.visible = true;
                    bgm.game_defeatMusic.play()
                    gameover_timer.stop();
                }
            }
        }
    }

    //单人游戏界面
    Item{
        id: singalgamelayout
        visible:false
        anchors.fill:parent
        //最上面的水平布局：生命机会 积分 金币值 敌机血量 暂停建
        Item {
            id: up
            anchors.fill: parent
            Column{
                id: upleft
                anchors.fill: parent
                spacing: 4 ;
                padding:4
                // 生命机会 后面会放图片，我机死一次就去掉一个生命
                Row{
                    id: life
                    spacing:2
                    ListModel {
                        id: lifeModel
                        ListElement { visible: true}
                        ListElement { visible: true}
                        ListElement {visible: true}
                    }
                    Repeater {
                        model: lifeModel
                        Rectangle {
                            id: lifeItem
                            height: 20
                            width: 20
                            color: "red"
                            visible: model.visible
                        }
                    }
                    // 占位矩形，确保在所有生命值图标都不可见时，Row仍然保持高度
                    Rectangle {
                        height: 20
                        width: 66
                        color: "transparent"
                    }
                }

                //积分 根据击败敌机获得积分（数值）
                Rectangle{
                        id: scores
                        height: 20
                        width: 70
                        color: "#00F215"
                        Text{
                            text: qsTr("积分值")
                            anchors.centerIn: parent  //居中
                        }
                    }

                // 金币栏 金币图+游戏获得的金币数值
                Row{
                    //金币图
                    Rectangle {
                    id: money
                    height: 20
                    width: 20
                    color: "#FA7E23"
                    }
                    Text {
                        id: moneytext
                        text:"金币值"
                        font.pointSize:  11
                    }
                }
            }
                //敌机Boss的血量条
            Rectangle {
                id: bossblood
                visible:  true  //等Boss出来时血量可见
                height: 25
                width: 535
                color: "red"
                anchors.horizontalCenter: parent.horizontalCenter
                // anchors.left: upleft.right
                Text {
                    id: blood
                    text: qsTr("Boss血量条")
                    anchors.centerIn: parent
                    font.pointSize:  15
                    textFormat: Text.StyledText
                }
            }
            //暂停图标（会放标签图），点击暂停会弹出对话框
            Button{
                id: pause1
                text: " 暂停 "
                height: 50
                width: 50
                font.pointSize:8
                font.bold: true
                anchors.right: parent.right
                onClicked: {
                    dialogs.pause.open()
                    timer.stop()//暂停游戏
                    console.log("暂停建已激活，跳出弹窗")
                }
            }
        }
        //最下方我方飞机血量，会同步游戏  待修改
        Row{
            id: bottom
            Layout.alignment: Qt.AlignHCenter
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 5
            Rectangle {
                id: _playerblood
                height: 20
                width: 345
                color: "transparent"
                ProgressBar {
                    id: bloodProgress
                    anchors.fill: parent
                    value: myplane.blood
                    from: 0
                    to: myplane.blood
                    anchors.centerIn: parent
                    contentItem: Rectangle {
                        width: bloodProgress.value / bloodProgress.to * bloodProgress.width
                        height: bloodProgress.height
                        radius: 20
                        color: "red"
                    }
                    background: Rectangle {
                        implicitWidth: bloodProgress.width
                        implicitHeight: bloodProgress.height
                        radius: 20
                        color: "gray" // 进度条背景的颜色
                    }
                    onValueChanged: {
                        // 添加血量变化的逻辑
                        console.log("当前血量：", bloodProgress.value)
                        if(bloodProgress.value===0&&remainlife_1!==0){
                            if(dialogs.musicEnabled){//开启了音效
                                bgm.life_loseMusic.play()//失去生命的音效
                            }

                            remainlife_1--;
                            lifeModel.get(remainlife_1).visible= false
                            bloodProgress.value = myplane.blood
                            myplane.shield_1.activateShield()//失去一条命，护盾无敌时间
                        }
                    }
                }
                Text {
                    id: _player
                    text: qsTr("血量条")
                    anchors.centerIn: parent
                    font.pointSize:  15
                }
            }
        }
        //操控飞机
        Keys.onPressed:{
            if (event.key === Qt.Key_A)movingLeft_P1 = true;
            else if (event.key === Qt.Key_D) movingRight_P1 = true;
            else if (event.key === Qt.Key_W) movingUp_P1 = true;
            else if (event.key === Qt.Key_S) movingDown_P1 = true;
            else if (event.key === Qt.Key_J){
                items.item.setPosition()//测试获得道具
                bullet.isShooted = true;//攻击
                bullet.shootTimer.start()
                // bullet.setBulletPosition()
            }
        }

        // Keys.onPressed: {
        //     switch(event.key){
        //     case Qt.Key_A:
        //         movingLeft_P1 = true;
        //         break;
        //     case Qt.Key_D:
        //         movingRight_P1 = true;
        //         break;
        //     case Qt.Key_W:
        //         movingUp_P1 = true;
        //         break;
        //     case Qt.Key_S:
        //         movingDown_P1 = true;
        //         break;
        //     case Qt.Key_J:
        //         bullet.isShooted = true;
        //         bullet.shootTimer.start();
        //         break;
        //     }
        // }

        Keys.onReleased:{
            if (event.key === Qt.Key_A) movingLeft_P1 = false;
            else if (event.key === Qt.Key_D) movingRight_P1 = false;
            else if (event.key === Qt.Key_W) movingUp_P1 = false;
            else if (event.key === Qt.Key_S) movingDown_P1 = false;
            else if (event.key === Qt.Key_J){
                bullet.isShooted = false;
                bullet.shootTimer.stop()
            }
        }
    }

    //游戏商店装备购买界面
    ColumnLayout{
        id:store
        visible: false
        anchors.fill: parent
        Text {
            text: qsTr("商店")
            font.pointSize: 20
            Layout.alignment: Qt.AlignHCenter
        }
        Button{
            text:'返回主页'
            onClicked: {
                stackview_3.pop()                   //返回上一页
            }
        }

        GridView{
            id:equipment
            visible: true
            width: 400
            height: 700
            Layout.alignment: Qt.AlignHCenter
            cellWidth: 200
            cellHeight: 100
            model:10
            delegate: Rectangle{
                width: 90
                height: 70
                color: "pink"
            }
            // property bool showDualSelection: false
            // Component{
            //     id: highlightComponent_2
            //     Rectangle{
            //         visible: true
            //         color:  "transparent"
            //         border.color: "red"
            //         border.width: 3
            //         radius: 10
            //         SequentialAnimation on opacity {
            //             loops: Animation.Infinite
            //             PropertyAnimation { duration: 1000; to: 0.0 }
            //             PropertyAnimation { duration: 1000; to: 1.0 }
            //         }
            //     }
            // }
        }
    }

    //双人游戏界面
    Item {
            id: doublegamelayout
            visible:false
            anchors.fill:parent
            //最上面的水平布局： 积分 金币值 敌机Boss血量 暂停建
            Item {
                id: top
                anchors.fill: parent
                Column{
                    id: topleft
                    anchors.fill: parent
                    spacing: 4 ;padding:4

                    //积分 根据击败敌机获得积分（数值）
                    Rectangle{
                            id: scores2
                            height: 20
                            width: 70
                            color: "#00F215"
                            Text{
                                text: qsTr("积分值")
                                anchors.centerIn: parent
                            }
                        }


                        // 金币栏 金币图+游戏获得的金币数值
                        Row{
                            //金币图
                            Rectangle {
                            id: money2
                            height: 20
                            width: 20
                            color: "#FA7E23"
                            }
                            Text {
                                id: moneytext2
                                text:"金币值"
                                font.pointSize:  11
                            }
                        }
                }

                //敌机Boss的血量条
                Rectangle {
                    id: bossblood2
                    visible:  true  //等Boss出来时血量可见
                    height: 25
                    width: 535
                    color: "red"
                    anchors.horizontalCenter: parent.horizontalCenter
                    // anchors.left: jinbi.right
                    Text {
                        id: blood2
                        text: qsTr("Boss血量条")
                        anchors.centerIn: parent
                        font.pointSize:  15
                        textFormat: Text.StyledText
                    }
                    // 血量条背景
                    Rectangle {
                        id: bossbloodBackground
                        anchors.centerIn: parent
                        // width: 300
                        // height: 30
                        color: "gray"
                    }

                    // 血量条当前值
                    Rectangle {
                        id: bossbloodmove
                        anchors.left: bossbloodBackground.left
                        anchors.verticalCenter: bossbloodBackground.verticalCenter
                        width: bossbloodBackground.width * bloodValue
                        height: bossbloodBackground.height
                        color: "red"
                    }

                    // 血量逻辑
                    property real bloodValue: 1.0 // 初始血量为满血

                    // 减少血量的函数
                    function decreaseBlood() {
                        bloodValue -= 0.01; // 每次减少1%
                        if (bloodValue < 0) {
                            bloodValue = 0;
                        }
                        bossbloodmove.width = bossbloodBackground.width * bloodValue;
                    }

                    // Timer用于定期减少血量
                    Timer {
                        id: bloodTimer
                        interval: 1000 // 1秒减少一次血量
                        running: true
                        repeat: true
                        onTriggered: enemys.decreaseBlood()
                    }
                }

                //暂停图标（会放标签图），点击暂停会弹出对话框
                Button{
                    id: pause2
                    text: qsTr(" 暂停 ")
                    height: 50; width: 50
                    font.pointSize:8
                    font.bold: true
                    anchors.right: parent.right
                    onClicked:{
                            dialogs.pause.open()
                            console.log("暂停建已激活，跳出弹窗")
                        }
                    }
            }

            //P1 P2
            Item{
                id: bottom2
                anchors.bottom: parent.bottom
                anchors.fill: parent
                //玩家一的血量 生命机会
                Column{
                    id: _player1
                    anchors.left:  parent.left
                    anchors.bottom: parent.bottom
                    padding: 5
                    Row{
                        spacing:2 ;padding: 2
                        ListModel {
                            id: lifeModel_1
                            ListElement { visible: true}
                            ListElement { visible: true}
                            ListElement {visible: true}
                        }
                        Repeater {
                            model: lifeModel_1
                            Rectangle {
                                id: lifeItem_1
                                height: 20
                                width: 20
                                color: "red"
                                visible: model.visible
                            }
                        }
                        // 占位矩形，确保在所有生命值图标都不可见时，Row仍然保持高度
                        Rectangle {
                            height: 20
                            width: 66
                            color: "transparent"
                        }
                    }
                    //玩家一血量条
                    Rectangle {
                        id: _player1blood
                        height: 20
                        width: 300
                        color: "transparent"
                        ProgressBar {
                                id: bloodProgress_1
                                anchors.fill: parent
                                value: myplane.blood
                                from: 0
                                to: myplane.blood
                                anchors.centerIn: parent
                                contentItem: Rectangle {
                                    width: bloodProgress_1.value / bloodProgress_1.to * bloodProgress_1.width
                                    height: bloodProgress_1.height
                                    radius: 20
                                    color: "red"
                                }
                                background: Rectangle {
                                    implicitWidth: bloodProgress_1.width
                                    implicitHeight: bloodProgress_1.height
                                    radius: 20
                                    color: "gray" // 进度条背景的颜色
                                }
                                onValueChanged: {
                                    // 添加血量变化的逻辑
                                    console.log("当前血量：", bloodProgress_1.value)
                                    if(bloodProgress_1.value===0&&remainlife_1!==0){
                                        if(dialogs.musicEnabled){//开启了音效
                                            bgm.life_loseMusic.play()//失去生命的音效
                                        }
                                        remainlife_1--;
                                        lifeModel_1.get(remainlife_1).visible= false
                                        bloodProgress_1.value = myplane.blood
                                        myplane.shield_1.activateShield()//失去一条命，护盾无敌时间
                                    }
                                }
                            }
                        Text {
                            id: _player1text
                            text: qsTr("P1血量条")
                            anchors.centerIn: parent
                            font.pointSize:  15
                        }
                    }
                }

                //玩家二的血量 生命机会
                Column{
                    id: _player2
                    anchors.right:  parent.right
                    anchors.bottom: parent.bottom
                    padding: 5
                    Row{
                        spacing:2 ; padding: 2
                        ListModel {
                            id: lifeModel_2
                            ListElement { visible: true}
                            ListElement { visible: true}
                            ListElement {visible: true}
                        }
                        Repeater {
                            model: lifeModel_2
                            Rectangle {
                                id: lifeItem_2
                                height: 20
                                width: 20
                                color: "red"
                                visible: model.visible
                            }
                        }
                        // 占位矩形，确保在所有生命值图标都不可见时，Row仍然保持高度
                        Rectangle {
                            height: 20
                            width: 66
                            color: "transparent"
                        }
                    }
                    //玩家二血量条
                    Rectangle {
                        id: _player2blood
                        height: 20
                        width: 300
                        color: "transparent"
                        ProgressBar {
                                id: bloodProgress_2
                                anchors.fill: parent
                                value: myplane.blood
                                from: 0
                                to: myplane.blood
                                anchors.centerIn: parent
                                contentItem: Rectangle {
                                    width: bloodProgress_2.value / bloodProgress_2.to * bloodProgress_2.width
                                    height: bloodProgress_2.height
                                    radius: 20
                                    color: "red"
                                }
                                background: Rectangle {
                                    implicitWidth: bloodProgress_2.width
                                    implicitHeight: bloodProgress_2.height
                                    radius: 20
                                    color: "gray" // 进度条背景的颜色
                                }
                                onValueChanged: {
                                    // 添加血量变化的逻辑
                                    console.log("当前血量：", bloodProgress_2.value)
                                    if(bloodProgress_2.value===0&&remainlife_2!==0){
                                        if(dialogs.musicEnabled){//开启了音效
                                            bgm.life_loseMusic.play()//失去生命的音效
                                        }
                                        remainlife_2--;
                                        lifeModel_2.get(remainlife_2).visible= false
                                        bloodProgress_2.value = myplane.blood
                                        myplane.shield_2.activateShield()//失去一条命，护盾无敌时间
                                    }
                                }
                            }
                        Text {
                            id: _player2text
                            text: qsTr("P2血量条")
                            anchors.centerIn: parent
                            font.pointSize:  15
                        }
                    }
                }
            }
            //暂停键点击会触发弹窗,有重新开始、继续、退出游戏、音效键
            Popup {
                id: dialog2
            }
            //双人模式
            //操控飞机
            Keys.onPressed:{
                //P1
                if (event.key === Qt.Key_A)movingLeft_P1 = true;
                else if (event.key === Qt.Key_D) movingRight_P1 = true;
                else if (event.key === Qt.Key_W) movingUp_P1 = true;
                else if (event.key === Qt.Key_S) movingDown_P1 = true;
                else if (event.key === Qt.Key_J) {
                    bullet.isShooted = true;//攻击
                    bullet.shootTimer.start()
                    items.item.setPosition()
                }

                //P2
                if (event.key === Qt.Key_Left)movingLeft_P2 = true;
                else if (event.key === Qt.Key_Right) movingRight_P2 = true;
                else if (event.key === Qt.Key_Up) movingUp_P2 = true;
                else if (event.key === Qt.Key_Down) movingDown_P2 = true;
                else if (event.key === Qt.Key_0){
                    bullet.isShooted_2 = true;
                    bullet.shootTimer_2.start()
                }
            }
            Keys.onReleased:{
                //P1
                if (event.key === Qt.Key_A) movingLeft_P1 = false;
                else if (event.key === Qt.Key_D) movingRight_P1 = false;
                else if (event.key === Qt.Key_W) movingUp_P1 = false;
                else if (event.key === Qt.Key_S) movingDown_P1 = false;
                else if (event.key === Qt.Key_J){
                    bullet.isShooted = false;
                    bullet.shootTimer.stop()
                }
                //P2
                if (event.key === Qt.Key_Left) movingLeft_P2 = false;
                else if (event.key === Qt.Key_Right) movingRight_P2 = false;
                else if (event.key === Qt.Key_Up) movingUp_P2 = false;
                else if (event.key === Qt.Key_Down) movingDown_P2 = false;
                else if (event.key === Qt.Key_0){
                    bullet.isShooted_2 = false;
                    bullet.shootTimer_2.stop()
                }
            }
         }

    Enemy{
        id:enemys
    }
}

