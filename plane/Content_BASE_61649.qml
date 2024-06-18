import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    property alias mode: mode
    anchors.fill: parent
    ColumnLayout{
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
}
