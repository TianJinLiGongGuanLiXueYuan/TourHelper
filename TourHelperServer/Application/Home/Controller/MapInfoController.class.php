<?php
namespace Home\Controller;
use Think\Controller;
class MapInfoController extends Controller {
// 地图页搜索,根据景区名字和搜索关键字查询设施位置
	//http://localhost/TourHelperServer/index.php/Home/mapinfo/GetInfoWithSearch?scenic_area_name=九寨沟&scenic_facility_name=厕所
	public function GetInfoWithSearch(){
		$scenic_area_name=I('scenic_area_name');
		$scenic_facility_name=I('scenic_facility_name');
		//返回字典
		$result=array(
			'code'=>'',
			'message'=>'',
			'data'=>'');

		//实例化一个表
		$scenic_area_info=M('scenic_area_info');
		//查询条件
		$condition['scenic_area_name']=$scenic_area_name;
		//接受返回值
		$scenic_area_id  = $scenic_area_info-> where($condition) -> select();
		
		$map_content_info = M('map_content_info');

		$condition_facility_id['scenic_area_id']=$scenic_area_id[0]['scenic_area_id'];
		$condition_facility_id['scenic_facility_name']=$scenic_facility_name;	

		$data =  $map_content_info->where($condition_facility_id)->select();

		if($data !=false){
			//查询成功
			$result['code']='200';
			$result['message']='查询成功';
			$result['data']=$data;

		}else{
			//查询失败
			$result['code']='500';
			$result['message']='您所在地方并没有此设施';

			}		
	echo json_encode($result);
	}
//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetScenicAreaName?self_location=100,100
//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetHomeInfo?scenic_area_name=测试景点
//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetSpotImgInfoWithSpotName?scenic_spot_name=测试景点
	///Users/muchen/TourHelper/TourHepler/IntelligentTouristGuide/HomeViewController.m:121:54: Expected method to read array element not found on object of type 'NSDictionary *'
	
}