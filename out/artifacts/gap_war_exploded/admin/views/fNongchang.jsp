<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
   
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/demo.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
	<script>
		//提交新用户注册信息    
		function submitForm() {			
			$('#ff').submit(); 
			/* $('#ff1').submit();  */
			
		}
		
		$(function(){
			//确保窗口关闭
			$('#w').window('close');  
			  
			//新用户注册
			$('#ff').form({    
			    url:'${pageContext.request.contextPath}/NongchangAction_regist',    
			    onSubmit: function(){    
			        return true;
			    },    
			    success:function(data){    
			    	$('#w').window('close');
			    	$('#test').datagrid('reload');
			    	$('#ff').form('clear');
			    }    
			});    
			 
			//数据表格属性（重点）
			$('#test').datagrid({
				url:'${pageContext.request.contextPath}/NongchangAction_listAdmin',  //指定表格数据加载路径
				title:'农场列表',         //标题名
				singleSelect:true,		//只允许单选
				iconCls:'icon-tip',     //表格标题图标
				width:800,             //数据表格宽度
				height:390,             //数据表格高度
				nowrap: true,           //较长时是否换行
				striped: true,          //是否隔行变色
				collapsible:false,      //是否折叠表格
				sortName: 'id_ncfarm',      //指定使用哪一列进行排序
				sortOrder: 'asc',       //升序或降序
				remoteSort: false,      //是否支持远程排序
				idField:'id_ncfarm',        //id列
				pagination:true,        //是否分页
				rownumbers:true,        //是否显示行号
				frozenColumns:[[
	                {field:'ck',checkbox:true},  //是否勾选
	                {title:'农场编号',field:'id_ncfarm',width:155,sortable:true}
				]],
				columns:[[
					{field:'id_nh',title:'所属农户号',width:100},
					{field:'name_ncfarm',title:'农场名称',width:100},
					{field:'address_ncfarm',title:'农场地址',width:200},
					{field:'area_ncfarm',title:'农场面积',width:40},
					{field:'areaUnit_ncfarm',title:'单位',width:40},
					{field:'traffic_ncfarm',title:'交通方式',width:85},
					{field:'mainProduct_ncfarm',title:'主要作物',width: 85},
					{field:'condition_ncfarm',title:'状态',width: 55},
					
				]],

				//设置工具栏属性
				toolbar:[
				'-',
					{
						id:'btnadd',
						text:'添加用户',
						handler:function(){
							
							$('#btnsave').linkbutton('enable');
							$('#ff').form('clear');
							$('#w').window('open');
						}
					}
				,'-',
					{
						id:'btncut',
						text:'修改用户',
						handler:function(){
							$('#btnsave').linkbutton('enable');
							//获得被选中id
							var id_ncfarm = getSelected();
							if(!id_ncfarm){
								alert("请选择用户!");
								return;
							}						
							$('#ff').form('load','${pageContext.request.contextPath}/NongchangAction_toEdit=?id_ncfarm='+id_ncfarm);
							//打开窗口
							$('#w').window('open');
						}
					}
				,'-',
					{
						id:'btnsave',
						text:'删除农场',
						disabled:false,
						handler:function(){
							$('#btnsave').linkbutton('enable');//点击后按钮是否可以继续点击
							//获得被选中的用户id
							var id_ncfarm = getSelected();
							//判断id不能为空
							if(!id_ncfarm){
								alert("请选择用户!");
								return;
							}
							//alert(id_nh)
							//调用ajax异步发送请求删除用户
							$.get("${pageContext.request.contextPath}/NongchangAction_delete?id_ncfarm="+id_ncfarm, function(data){
									//删除成功后,刷新列表
								 $('#test').datagrid('reload'); //提交成功,重新加载列表数据   
							});
						}
					}

				,'-']
			});
			var p = $('#test').datagrid('getPager');
			$(p).pagination({
				onBeforeRefresh:function(){
					alert('before refresh');
				}
			});
		});
		function resize(){
			$('#test').datagrid('resize', {
				width:700,
				height:400
			});
		}
		
		//获得被选中的
		function getSelected(){
			var selected = $('#test').datagrid('getSelected');
			if (selected){
				return selected.id_ncfarm;
			}
		}
		
		function getSelections(){
			var ids = [];
			var rows = $('#test').datagrid('getSelections');
			for(var i=0;i<rows.length;i++){
				ids.push(rows[i].code);
			}
			alert(ids.join(':'));
		}
		function clearSelections(){
			$('#test').datagrid('clearSelections');
		}
		function selectRow(){
			$('#test').datagrid('selectRow',2);
		}
		function selectRecord(){
			$('#test').datagrid('selectRecord','002');
		}
		function unselectRow(){
			$('#test').datagrid('unselectRow',2);
		}
		function mergeCells(){
			$('#test').datagrid('mergeCells',{
				index:2,
				field:'addr',
				rowspan:2,
				colspan:2
			});
		}
	</script>
	
	<style type="text/css">
		label{
			width:60px;
			display: inline-block;
		}
		/* id_nh */
		.inputdiv{
			margin: 10px;
		}
		#mm{
			width: 30px;
			height: 100px;
		}
		#box_relative1 {
		  position: relative;
		  top:-150px;
		}
		#box_relative2 {
		  position: relative;
		  top:-140px;
		}
		#box_relative3 {
		  position: relative;
		  top:-130px;
		}
		#box_relative4 {
		  position: relative;
		  top:-120px;
		}
		#box_relative5 {
		  position: relative;
		  top:-110px;
		}
		#box_relative6 {
		  position: relative;
		  top:-100px;
		}	
		#box_relative7 {
		  position: relative;
		  top:-90px;
		}		
	</style>
</head>


<body>
	

	<!-- <div style="margin:20px 0;"></div> -->
	
	
	<!-- 表单主体 -->
	<table id="test"></table>
	
	
	
	
	<div id="w" class="easyui-window" title="添加农场" iconCls="icon-add" style="width:375px;height:365px;padding:5px;">
		<div style="background:#fafafa;padding:10px;width:330px;height:300px;">
		    <form id="ff" method="post" novalidate >
		    	<input type="hidden" name="id_ncfarm">

		    	<div class="inputdiv">
		            <label class="mylabel1" for="name" >农户代号</label>
		            <input class="easyui-validatebox" type="text" name="id_nh" style="width:100px;"></input>
		        </div>
		        <div class="inputdiv">
		            <label class="mylabel1" for="name" >农场名字</label>
		            <input class="easyui-validatebox" type="text" name="name_ncfarm" style="width:100px;"></input>
		        </div>
		       	<div class="inputdiv">
		            <label class="mylabel1" for="name" >农场地址</label>
		            <input class="easyui-validatebox" type="text" name="address_ncfarm" style="width:210px;"></input>
		        </div>
		        <div class="inputdiv">
		            <label class="mylabel1" for="name" >农场面积</label>
		            <input class="easyui-validatebox" type="text" name="area_ncfarm" style="width:210px;"></input>
		        </div>
		        <div class="inputdiv">
		        	<label class="mylabel1" for="name">单位</label>
		            <input class="easyui-validatebox" type="text" name="areaUnit_ncfarm" style="width:210px;"></input>
		        </div>	
		        <div class="inputdiv">
		        	<label class="mylabel1" for="name">交通方式</label>
		            <input class="easyui-validatebox" type="text" name="traffic_ncfarm" style="width:210px;"></input>
		        </div>
		        <div class="inputdiv">
		        	<label class="mylabel1" for="name">主要作物</label>
		            <input class="easyui-validatebox" type="text" name="mainProduct_ncfarm" style="width:210px;"></input>
		        </div>
		       	<div class="inputdiv">
		        	<label class="mylabel1" for="name">状态</label>
		            <input type="radio" name="condition_nh"  value="1" checked="checked">激活
			        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			        <input type="radio" name="condition_nh"  value="0">禁用
		        </div>	
		       	<div class="inputdiv"><label class="mylabel1" for="name">&nbsp;&nbsp;</label></div>    
		       	<div class="inputdiv"><label class="mylabel1" for="name">&nbsp;&nbsp;</label></div>     	                
		        <div class="inputdiv">
		            <input type="button" value="提交" onclick="submitForm();">
		        </div>
		    </form>
		</div>
	</div>
	
	
	
	

</body>
</html>