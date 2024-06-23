import QtQuick

Flickable {
    property int mapScrollSpeed: 1  //地图滚动速度
    property int mapWidth:  window_Width
    property int mapHeight: window_Height
    id: flickable
    visible: false
    interactive: false
    anchors.fill: parent
    contentWidth: mapWidth
    contentHeight: mapHeight * 2    // 因为有两张地图，所以高度是两倍
    function updateMap() {
        // 地图滚动
        // 更新两个图片的位置
        map_1_Image.y += mapScrollSpeed;
        map_2_Image.y += mapScrollSpeed;
        // 检查map_1_Image是否完全移出视口
        if (map_1_Image.y > mapHeight) {
            // 重置map_1_Image到map_2_Image的上方
            map_1_Image.y = map_2_Image.y - map_1_Image.height;
        }
        // 检查map_2_Image的底部是否即将移出视口
        if (map_2_Image.y > mapHeight) {
            // 将map_2_Image的y坐标重置到map_1_Image的上方
            map_2_Image.y = map_1_Image.y - map_1_Image.height;
        }
    }

    Image
    {
        id: map_1_Image
        source: map_path
        fillMode: Image.PreserveAspectFit // 使用PreserveAspectFit来保持图片比例
        y: 0
        height: mapHeight
    }
    Image
    {
        id: map_2_Image
        source: map_path
        fillMode: Image.PreserveAspectFit
        y: mapHeight
        height: mapHeight
    }
}
