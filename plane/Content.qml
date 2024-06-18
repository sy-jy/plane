import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    property alias mode: mode
    property alias homepage: homepage
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
            text: qsTr("游戏大厅")
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
      }
    }
}
