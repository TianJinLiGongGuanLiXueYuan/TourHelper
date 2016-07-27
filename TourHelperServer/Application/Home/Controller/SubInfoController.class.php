<?php
namespace Home\Controller;
use Think\Controller;
class SubInfoController extends Controller {
// 地图页搜索,根据景区名字和搜索关键字查询设施位置
	//http://localhost/TourHelperServer/index.php/Home/subinfo/SubInfoForWeb?opinion_content=测试提交
	public function SubInfoForWeb(){
	// header("Content-Type:text/html; charset=utf-8");
    $opinion_info = M("opinion_info");
    $opinion_info_id = $opinion_info -> where(1) -> select();
    $opinion_info_id = end($opinion_info_id);
    // 构建写入的数据数组
    $opinion_content = I('opinion_content');
    echo "$opinion_content";
    $data["opinion_id"] = $opinion_info_id["opinion_id"]+1;
    $data["opinion_content"] = $opinion_content;
    // .count(opinion_info_id)
    // 写入数据
    if($lastInsId = $opinion_info->add($data)){
        echo "插入数据成功";
    } else {
        $this->error('数据写入错误！');
    }
	}
//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetScenicAreaName?self_location=100,100
//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetHomeInfo?scenic_area_name=测试景点
//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetSpotImgInfoWithSpotName?scenic_spot_name=测试景点
	///Users/muchen/TourHelper/TourHepler/IntelligentTouristGuide/HomeViewController.m:121:54: Expected method to read array element not found on object of type 'NSDictionary *'
	
}