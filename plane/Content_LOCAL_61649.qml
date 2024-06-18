import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    property alias mode: mode
    property alias player: player
    property alias plane: plane

    anchors.fill: parent
    ColumnLayout{
        visible:false
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
                mode.visible = false
                player.visible = true
                console.log("clicked")
            }
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
                    Qt.quit()
                }
                if(!showDualSelection&&plane.currentIndexWSAD!==-1){
                    Qt.quit()
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
}
