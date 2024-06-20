import QtQuick
import QtQuick.Controls

Item {
    property alias victory: victory_Dialog
    property alias defeat: defeat_Dialog
    anchors.fill: parent

    Timer{
        id:timer
        interval:1000
        running:true
        repeat: true

        property int bossblood_6: 3

        onTriggered: {
            bossblood_6--;
            if(bossblood_6 === 0){
                //defeat_Dialog.open();
                victory_Dialog.open();
                blurRect.visible = true;
                timer.stop();
            }
        }
    }

    Rectangle{
        id: blurRect
        anchors.fill: parent
        visible: false
        color:"dimgray"
        opacity: 0.9

        Dialog{
            id:victory_Dialog
            width: 410
            height:210
            background:Rectangle{
                opacity: 0
            }

            anchors.centerIn: parent

            contentItem: Column{
                width: parent.width
                height: parent.height
                Image {
                    source: "images/victory.png"
                    width: 384
                    height: 182
                    anchors.centerIn: parent
                }
            }
        Row{
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 100
            Button{
                text: "返回"
                onClicked: {
                    victory_Dialog.visible = false;
                    blurRect.visible = false;
                }
            }
            Button{
                text: "下一关"
                onClicked: {
                    blurRect.visible = false;
                    victory_Dialog.visible = false
                    }
                }
            }
        }
        Dialog{
            id:defeat_Dialog
            width: 410
            height: 210
            background:Rectangle{
                opacity: 0
            }

            anchors.centerIn: parent

            contentItem: Column{
                width: parent.width
                height: parent.height
                Image {
                    source: "images/defeat.png"
                    width: 400
                    height: 182
                    anchors.centerIn: parent
                }
            }
            Row{
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 100
                Button{
                    text: "返回"
                    onClicked: {
                        defeat_Dialog.visible = false;
                        blurRect.visible = false;
                    }
                }
                Button{
                    text: "重新开始"
                    onClicked: {
                        defeat_Dialog.visible = false;
                        blurRect.visible = false;
                    }
                }
            }
        }
    }
}
