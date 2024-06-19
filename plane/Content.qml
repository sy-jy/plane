import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item{
    property alias mode: mode
    property alias player: player
    property alias plane: plane
    property alias homepage: homepage
    property alias stackview: stackview
    anchors.fill: parent
    ColumnLayout{
        visible: false
        id:mode
        anchors.fill: parent
        // 模式选择标题
        Text {
            Layout.alignment: Qt.AlignHCenter
            id: modeSet
            text: qsTr("模式选择")
            font.letterSpacing: 20
            font.pointSize: 40
            color: "black"
        }

        //模式选择
        ButtonGroup {
            buttons: modeButton.children
        }
        Row {
            spacing: 30
            Layout.alignment: Qt.AlignHCenter
            id: modeButton
            RadioButton {
                checked: true
                text: qsTr(" <简单>")
                font.letterSpacing: 15
                font.pointSize: 18 // 设置字体大小（以磅为单位）
                font.bold: true // 设置字体加粗
                background:Rectangle{
                    implicitHeight: 55
                    implicitWidth: 100
                    color: "red"
                }
            }

            RadioButton {
                text: qsTr(" <困难>")
                font.letterSpacing: 15
                font.pointSize: 18 // 设置字体大小（以磅为单位）
                font.bold: true // 设置字体加粗
                background:Rectangle{
                    implicitHeight: 55
                    implicitWidth: 100
                    color: "red"
                }
            }
        }

        // 地图选择标题
        Text {
            Layout.alignment: Qt.AlignHCenter
            id: mapSet
            text: qsTr("地图选择")
            font.letterSpacing: 20
            font.pointSize: 40
            color: "black"
        }

        //地图选择
        ComboBox{
            id: selectBox
            model: ListModel {
                ListElement { text: "戈壁" }
                ListElement { text: "工厂" }
                ListElement { text: "天空" }
                ListElement { text: "随机" }
            }
            Layout.alignment: Qt.AlignHCenter

        }

        //地图缩略图位置
        Rectangle{
            width: 300
            height: 150
            color: "black"
            Layout.alignment: Qt.AlignHCenter
        }
        Button{
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
                stackview.push(player)
                console.log("clicked")
            }
        }
    }

    ColumnLayout{
        id:homepage
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
            spacing:20
            Layout.alignment: Qt.AlignHCenter
            Button {
                id:start
                focus:true
                text:qsTr("开始游戏")
                font.pointSize: 25
                font.letterSpacing: 10
                //indicator: Image{}
                background: Rectangle{
                    border.color: start.focus ? "red" : "white"
                    color: "yellow"
                }
                onClicked: {
                    stackview.push(mode)                //跳转到mode页面
                    console.log("start clicked")
                }
                Keys.onEscapePressed: {
                    exit.focus = true
                }
                //键盘快捷键响应
                Keys.onSpacePressed: {
                    start.clicked()
                }
            }

            Button {
                id:exit
                text:qsTr("退出游戏")
                font.pointSize: 25
                font.letterSpacing: 10
                //indicator: Image{source:"./picture/退出游戏.jpg"}
                background: Rectangle{
                    border.color: exit.focus ? "red" : "white"
                    color: "blue    "
                }
                onClicked: {
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
                id:store
                text: qsTr("商店")
                background:Rectangle{
                    implicitHeight:60
                    implicitWidth: 60
                    color: "pink"
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
      id:stackview
      anchors.fill: parent
      onCurrentItemChanged: {
          homepage.visible=depth===0
          mode.visible = depth === 1
      }
    }


    //玩家人数选择
    ColumnLayout{
        id:player
        visible: false
        anchors.fill: parent
        anchors.topMargin: 200
        anchors.bottomMargin: 200
        Repeater {
            model: [{"name":"单人模式"},
                    {"name":"双人模式"}]
            delegate: Button {
                font.pointSize: 25
                font.bold: true // 设置字体加粗
                text: modelData.name // 显示模型中的数据
                Layout.alignment: Qt.AlignHCenter
                background:Rectangle{
                    implicitHeight: 50
                    implicitWidth: 200
                    color: "red"
                }
                onClicked: {
                    if (text === "单人模式") {
                        plane.showDualSelection = false
                        player.visible = false
                        plane.visible = true
                        planeSet.visible = true
                        plane.focus = true// 确保GridView可以接收键盘事件
                    } else if (text === "双人模式") {
                        plane.showDualSelection = true
                        player.visible = false
                        plane.visible = true
                        planeSet.visible = true
                        plane.focus = true// 确保GridView可以接收键盘事件
                    }
                }
            }
        }
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
            visible: false
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
            // 两个独立的当前索引
            property int currentIndexWSAD: -1
            property int currentIndexArrows: -1
            property int columns: 3
            // 高亮显示组件
            Component {
                id: highlightComponent
                Rectangle {
                    visible: false
                    color: "transparent"
                    border.color: "red"
                    border.width: 3
                    radius: 10
                    // 添加闪烁动画
                    SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    PropertyAnimation { duration: 1000; to: 0.0 }
                    PropertyAnimation { duration: 1000; to: 1.0 }
                   }
                }
            }

            // 创建两个选择框显示实例
            property var highlightWSAD: highlightComponent.createObject(plane,{"border.color": "red",})
            property var highlightArrows: highlightComponent.createObject(plane,{"border.color": "blue"})
            // 更新选择框显示的位置
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
            Keys.onSpacePressed: {
                console.log("Selected index WSAD: ", plane.currentIndexWSAD)
                console.log("Selected index Arrows: ", plane.currentIndexArrows)
                if(showDualSelection&&plane.currentIndexWSAD!==-1&&plane.currentIndexArrows!==-1){
                    // Qt.quit()
                    planeSet.visible = false
                    doublegamelayout.visible = true
                }
                if(!showDualSelection&&plane.currentIndexWSAD!==-1){
                    // Qt.quit()
                    planeSet.visible = false
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
                    // Rectangle {
                    //     id: overlay
                    //     anchors.fill: parent
                    //     color: "black"
                    //     opacity: 0.2 // 设置半透明
                    //     visible: true // 默认不显示
                    // }

                    // // 用于控制覆盖层的显示
                    // property bool selected: false

                    // // 当选中状态改变时，更新覆盖层的可见性
                    // onSelectedChanged: overlay.visible = !selected
                    fillMode: Image.PreserveAspectFit
                }

                // Text {
                //     anchors.bottom: parent.bottom
                //     anchors.horizontalCenter: parent.horizontalCenter
                //     text: "Index: " + index
                // }
            }
        }
        Text {
            id: tips
            text: qsTr("按空格确认选择进入游戏")
            Layout.alignment: Qt.AlignHCenter
        }
    }

    //单人游戏界面
    Column{
            id: singalgamelayout
            visible:false
            anchors.fill:parent
            //最上面的水平布局：生命机会 积分 金币值 敌机血量 暂停建
            Row {
                id: up
                anchors.fill: parent
                Column{
                    id: upleft
                    anchors.fill: parent
                    spacing: 4 ;padding:4
                        // 生命机会 后面会放图片，我机死一次就去掉一个生命
                        Row{
                            id: life
                            spacing:2
                            Rectangle{
                                id:life1
                                height: 20
                                width: 20
                                color: 'red'
                            }
                            Rectangle{
                                 id:life2
                                height: 20
                                width: 20
                                color: 'red'
                            }
                            Rectangle{
                                 id:life3
                                height: 20
                                width: 20
                                color: "red"

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
                    // anchors.left: jinbi.right
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
                    id: pause
                    padding: 3
                    text: qsTr(" 暂停 ")
                    height: 50
                    width: 50
                    font.pointSize:8
                    font.bold: true
                    anchors.right: parent.right
                    onClicked: model.revert()

                }
            }

            //最下方我方飞机血量，会同步游戏  待修改
            Row{
                id: bottom
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 5
                Rectangle {
                    id: _playerblood
                    height: 20
                    width: 345
                    color: "red"
                    Text {
                        id: _player
                        text: qsTr("血量条")
                        anchors.centerIn: parent
                        font.pointSize:  15
                    }
                }

            }

            //暂停键点击会触发弹窗,有重新开始、继续、退出游戏、音效键
            Popup {
                id: dialog

            }

        }

    //双人游戏界面
    Column{
            id: doublegamelayout
            visible:false
            anchors.fill:parent
            //最上面的水平布局： 积分 金币值 敌机Boss血量 暂停建
            Row {
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
                }

                //暂停图标（会放标签图），点击暂停会弹出对话框
                Button{
                    id: pause2
                    padding: 3
                    text: qsTr(" 暂停 ")
                    height: 50
                    width: 50
                    font.pointSize:8
                    font.bold: true
                    anchors.right: parent.right
                    onClicked: model.revert()

                }
            }

            //P1 P2
            Row{
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
                        Rectangle{
                             id: _player1life1
                            height: 20
                            width: 20
                            color: 'red'
                        }
                        Rectangle{
                            id: _player1life2
                            height: 20
                            width: 20
                            color: 'red'
                        }
                        Rectangle{
                            id: _player1life3
                            height: 20
                            width: 20
                            color: "red"

                        }
                    }
                    //玩家一血量条
                    Rectangle {
                        id: _player1blood
                        height: 20
                        width: 300
                        color: "red"
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
                        Rectangle{
                            id: _player2life1
                            height: 20
                            width: 20
                            color: 'red'
                        }
                        Rectangle{
                            id: _player2life2
                            height: 20
                            width: 20
                            color: 'red'
                        }
                        Rectangle{
                            id: _player2life3
                            height: 20
                            width: 20
                            color: "red"

                        }
                    }
                    //玩家二血量条
                    Rectangle {
                        id: _player2blood
                        height: 20
                        width: 300
                        color: "red"
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
         }

}
