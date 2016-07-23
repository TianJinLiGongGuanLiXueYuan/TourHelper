<?php
namespace Home\Controller;
use Think\Controller;
class HomeInfoController extends Controller {
//1根据景区坐标返回景区名字
	public function GetScenicAreaName(){	
		$scenic_area_location=I('scenic_area_location');
		$result=array(
			'code'=>'',
			'message'=>'',
			'data'=>'');
		//实例化
		$scenic_area_info=M('scenic_area_info');
		$condition['scenic_area_location']=$scenic_area_location;			
		$data=$scenic_area_info->where($condition)->select();

		
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
//2 根据景区名字得到景点文字信息
	public function GetSpotWordInfoWithAreaName(){
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
		$condition_area_id['scenic_area_id']=$scenic_area_id_select[0]['scenic_area_info'];	

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

		$scenic_spot_piclist = M('scenic_spot_piclist');

		$condition_spot_id['scenic_spot_id']=$scenic_spot_id[0]['scenic_spot_id'];	

		$data=$scenic_spot_piclist->where($condition_spot_id)->select();

		
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
	public function GetInfoWithSearch(){
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

		$scenic_spot_piclist = M('scenic_spot_piclist');

		$condition_spot_id['scenic_spot_id']=$scenic_spot_id[0]['scenic_spot_id'];	

		$data=$scenic_spot_piclist->where($condition_spot_id)->select();

		
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

//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetScenicAreaName?self_location=100,100
//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetHomeInfo?scenic_area_name=测试景点
//http://localhost/TourHelperServer/index.php/Home/homeInfo/GetSpotImgInfoWithSpotName?scenic_spot_name=测试景点


}

	