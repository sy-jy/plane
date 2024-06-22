import QtQuick

Item {
    property string itemPath
    property alias item: item
    property int randomIndex
    property int moveSpeed: 3
    property int moveXBreak: 0
    property double deltaX: 0
    Image {
        id: item
        source: itemPath
        width: 50
        height: 50
        fillMode: Image.PreserveAspectFit
        ListModel {
                id: itemModel
                ListElement {
                    name: "shield"
                    itemPath:"./images/powerUpShield"}
                ListElement {
                    name: "ammo"
                    itemPath:"./images/powerUpAmmo"}
            }
        // Component.onCompleted: {
        //     setPosition()
        // }
        function setPosition() {
            item.visible = true
            randomIndex = Math.floor(Math.random() * itemModel.count)
            itemPath = itemModel.get(randomIndex).itemPath
            item.x = Math.random() * (window_Width - width)
            moveXBreak = 0 // 重置moveXBreak
            item.y = -height
        }

        function move() {
            // 随机左右移动
            if(moveXBreak === 0){
                deltaX = Math.random() * moveSpeed * 2 - moveSpeed
                while((deltaX<moveSpeed/2&&deltaX>0)||(deltaX>-moveSpeed/2&&deltaX<0)){
                    deltaX = Math.random() * moveSpeed * 2 - moveSpeed
                }
                moveXBreak = content.desiredFramesPerSecond/2
            }
            moveXBreak--
            console.log(deltaX)
            x += deltaX
            y += moveSpeed
            // 确保道具不会移动到窗口之外
            if (x < 0) {
                x = 0
            } else if (x > window_Width - width) {
                x = window_Width - width
            }
            if (y > window_Height) {
                item.visible = false
            }
        }
        function got(){
            if(content.myplane.myplane_1.x<item.x&&
                content.myplane.myplane_1.x+content.myplane.myplane_1.width>item.x&&
                content.myplane.myplane_1.y<item.y&&
                content.myplane.myplane_1.y+content.myplane.myplane_1.height>item.y){
                item.visible = false
                if(itemModel.get(randomIndex).name ==="shield"){
                    content.myplane.shield_1.activateShield()
                }else if(itemModel.get(randomIndex).name ==="ammo"){
                    content.myplane.myplane_1.activateAmmo()
                }
            }
            if(content.myplane.myplane_2.x<item.x&&
                content.myplane.myplane_2.x+content.myplane.myplane_2.width>item.x&&
                content.myplane.myplane_2.y<item.y&&
                content.myplane.myplane_2.y+content.myplane.myplane_2.height>item.y){
                item.visible = false
                if(itemModel.get(randomIndex).name ==="shield"){
                    content.myplane.shield_2.activateShield()
                }else if(itemModel.get(randomIndex).name ==="ammo"){
                    content.myplane.myplane_2.activateAmmo()
                }
            }
        }
    }
}
