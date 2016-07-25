<?php
namespace Home\Controller;
use Think\Controller;
class HomeInfoController extends Controller {
//1根据景区坐标返回景区名字
	//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetScenicAreaName?scenic_area_latitude=33.273342&scenic_area_longitude=103.924245
	public function GetScenicAreaName(){	
		$scenic_area_latitude=I('scenic_area_latitude');
		$scenic_area_longitude=I('scenic_area_longitude');
		$result=array(
			'code'=>'',
			'message'=>'',
			'data'=>'');
		//实例化
		$scenic_area_info=M('scenic_area_info');
		
		$t1 = $scenic_area_latitude-0.01;
		$t2 = $scenic_area_latitude+0.01;
		$t3 = $scenic_area_longitude-0.01;
		$t4 = $scenic_area_longitude+0.01;

		$condition['scenic_area_latitude'] = array(array('egt',"$t1"),array('elt',"$t2"),'and');
		$condition['scenic_area_longitude'] = array(array('egt',"$t3"),array('elt',"$t4"),'and');
		$data = $scenic_area_info -> where($condition) -> select();

		if($data !=false){
			//查询成功
			$result['code']='200';
			$result['message']='查询成功';
			$result['data']=$data;

		}else{
			//查询失败
			$result['code']='500';
			$result['message']='您所在地方并没有景点';

			}		
	echo json_encode($result);
	}
//2 根据景区名字得到景点信息
	//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetSpotInfoWithAreaName?scenic_area_name=九寨沟
	public function GetSpotInfoWithAreaName(){
		//传进来的参数
		$scenic_area_name=I('scenic_area_name');
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
		$scenic_area_id_select = $scenic_area_info -> where($condition) -> select();

		$scenic_spot_info = M('scenic_spot_info');
		$condition_area_id['scenic_area_id']=$scenic_area_id_select[0]['scenic_area_id'];	

		$data=$scenic_spot_info->where($condition_area_id)->select();

		
		if($data !=false){
			//查询成功
			$result['code']='200';
			$result['message']='查询成功';
			$result['data']=$data;

		}else{
			//查询失败
			$result['code']='500';
			$result['message']='您所在地方并没有景点';

			}		
	echo json_encode($result);
	}
//3 根据景点名字得到景点图片信息
	//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetSpotImgInfoWithSpotName?scenic_spot_name=卧龙海
	public function GetSpotImgInfoWithSpotName(){
		//传进来的参数
		$scenic_spot_name=I('scenic_spot_name');
		//返回字典
		$result=array(
			'code'=>'',
			'message'=>'',
			'data'=>'');
		//实例化一个表
		$scenic_spot_info=M('scenic_spot_info');
		//查询条件
		$condition['scenic_spot_name']=$scenic_spot_name;
		//接受返回值
		$scenic_spot_id = $scenic_spot_info -> where($condition) -> select();
		//echo '$scenic_spot_id';

		$scenic_spot_piclist = M('scenic_spot_piclist');

		$condition_spot_id['scenic_spot_id']=$scenic_spot_id[0]['scenic_spot_id'];
		$condition_spot_id['scenic_area_id']=$scenic_spot_id[0]['scenic_area_id'];	

		$data =  $scenic_spot_piclist->where($condition_spot_id)->select();

		
		if($data !=false){
			//查询成功
			$result['code']='200';
			$result['message']='查询成功';
			$result['data']=$data;

		}else{
			//查询失败
			$result['code']='500';
			$result['message']='您所在地方并没有景点';

			}		
	echo json_encode($result);
	}
//4 地图页搜索
	//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetInfoWithSearch?scenic_facility_name=吸烟处
	public function GetInfoWithSearch(){
		//传进来的参数
		$scenic_facility_name=I('scenic_facility_name');
		//返回字典
		$result=array(
			'code'=>'',
			'message'=>'',
			'data'=>'');
		//实例化一个表
		$map_content_info=M('map_content_info');
		//查询条件
		$condition['scenic_facility_name']=$scenic_facility_name;
		//接受返回值
		$data = $scenic_spot_info -> where($condition) -> select();
		
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

	