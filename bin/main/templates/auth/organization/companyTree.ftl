

<div id="splitter">
	<div>
		<div style="visibility: hidden; border: none;" id='jtCompany'>
			<div id='jtCompany-content'></div>
		</div>
	</div>
	<div id="ContentPanel">
		<div  style="border: none;" id='jtCompany-deptInfo'>
		<span id="vueDeptInfo">
			<div class="row">
			<div class="col-md-4">		        
				  <!-- Profile Image -->
		          <div class="box box-primary">
		            <div class="box-body box-profile">		            	
		              <img height="96" width="96" class="profile-user-img img-responsive img-circle" 
		                   v-bind:src="'/auth/showphoto/AVATAR_FOLDER/'+deptDetail.userByManagerId.avatar" alt="User profile picture">
		
		              <h3 class="profile-username text-center">{{ deptDetail.userByManagerId.lastname +" "+ deptDetail.userByManagerId.firstname}}</h3>
		
		              <p class="text-muted text-center">{{ deptDetail.userByManagerId.jobTitle }}</p>
		
		              <ul class="list-group list-group-unbordered">		                
		                <li class="list-group-item">
		                  <b>信箱</b> <a class="pull-right">{{ deptDetail.userByManagerId.email }}</a>
		                </li>
		              </ul>
		
		              <a href="#" class="btn btn-primary btn-block"><b>部門主管</b></a>
		            </div>
		            <!-- /.box-body -->
		          </div><!-- /.box -->
			</div> <!-- /.col -->
			
			<div class="col-md-8">
				<!-- USERS LIST -->
              <div class="box box-danger">
                <div class="box-header with-border">
                  <h3 class="box-title">All Members</h3>

                  <div class="box-tools pull-right">
                    <span class="label label-danger">{{ totalUsers }} New Members</span>                    
                  </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body no-padding"> 
                	<!-- users-list -->               
                  <ul class="users-list clearfix">
                  	<dept-userlist
                  		v-for="user in userDetails"
					    v-bind:userdetail="user"
					    v-bind:key="user.id"
                  	></dept-userlist>                   
                    
                  </ul>
                  <!-- /.users-list -->
                </div>
                <!-- /.box-body -->
                <div class="box-footer text-center">
                  <a href="javascript:void(0)" class="uppercase">View All Users</a>
                </div> <!-- /.box-footer -->
              </div><!--/.box -->
			</div> <!-- /.col -->
			</div>
		</span>
		</div>
	
	
		<div style="border: none;" id='jtCompany-userInfo'>
		<span id="vueUserInfo">
			<div class="row">		
			<div class="col-md-12">		        
				  <!-- Profile Image -->
		          <div class="box box-primary">
		            <div class="box-body box-profile">
		              <img height="96" width="96" class="profile-user-img img-responsive img-circle" 
		                   v-bind:src="'/auth/showphoto/AVATAR_FOLDER/'+userDetails.userByUserId.avatar" alt="User profile picture">
		
		              <h3 class="profile-username text-center">{{ userDetails.userByUserId.lastname +" "+ userDetails.userByUserId.firstname}}</h3>
		
		              <p class="text-muted text-center">{{ userDetails.jobTitle }}</p>
		
		              <ul class="list-group list-group-unbordered">
		                <li class="list-group-item">
		                  <b>工號</b> <a class="pull-right">{{ userDetails.empNo }}</a>
		                </li>
		                <li class="list-group-item">
		                  <b>到職日</b> <a class="pull-right">{{ userDetails.hireDate | formatDate}}</a>
		                </li>
		                <li class="list-group-item">
		                  <b>信箱</b> <a class="pull-right">{{ userDetails.userByUserId.email }}</a>
		                </li>
		              </ul>
		
		              <a href="#" class="btn btn-primary btn-block"><b>Read More</b></a>
		            </div>
		            <!-- /.box-body -->
		          </div><!-- /.box -->
			</div> <!-- /.col -->
			</div>
		</span>	
		</div><!-- /jtCompany-userInfo -->

	
	</div><!-- /ContentPanel -->
</div>



<script type="text/javascript">
$(document).ready(function () {
    $('#jtCompany-deptInfo').hide();
    $('#jtCompany-userInfo').hide();
    var userInfo = new Vue({
	  	  el: '#vueUserInfo',
	  	  data: {
	  	    userDetails: {},
	  	    message:"使用者訊息區"
	  	  }
  	});
    
    var deptInfo = new Vue({
    	  el: '#vueDeptInfo',
    	  data: {
    	    userDetails: {},
    	    totalUsers: '',
    	    deptDetail: {},
    	    message:"部門訊息區"
    	  }
    });

    Vue.component('dept-userlist', {
    	  props: ['userdetail'],
    	  template: '<li><img height="96" width="96" v-bind:src="userdetail.userByUserId.avatar|imgSrc" alt="User Image"><a class="users-list-name" href="#">{{userdetail.userByUserId.firstname}}</a><span class="users-list-date">{{userdetail.hireDate | formatDate}}</span></li>'
    });
	
	$("#companyGrid").on('rowselect', function (event) {
       	var company = event.args.row;
       	var departments = event.args.row.departments;       	
     	// prepare the data     	
        $.ajax({
            url : "/auth/org/companyTree/"+company.id,
            type: "get",
            contentType: "application/json; charset=utf-8",            
            headers:jwtClient.setAuthorizationTokenHeader(),
    		success:function(data, textStatus, jqXHR){//返回json结果			
    			var companyTree = data;    			
    			<#-- 公司資訊 TREE 結構產生 -->
    	        $('#jtCompany').jqxTree({ source: companyTree, height: '100%', width: '100%' });
    	        $('#jtCompany').css('visibility', 'visible');
    		}
        });       	
    }); 
	
    // Create jqxTree
    $("#splitter").jqxSplitter({  width: '100%', height: 400, panels: [{ size: 250}] });
    $('#jtCompany').on('select', function (event) {
    	
    	var rowidCompany = $('#companyGrid').jqxGrid('getselectedrowindex');
    	var rowdataCompany = $("#companyGrid").jqxGrid('getrowdata', rowidCompany);
    	var companyAllUsers = rowdataCompany.userDetailses;
    	var departments = rowdataCompany.departments;
    	
    	var args = event.args;
        var item = $('#jtCompany').jqxTree('getItem', args.element);
        var items = $('#jtCompany').jqxTree('getItems');
        var label = item.label; 
        var type = args.type; 
        var value = item.value;
        var itemType = value.split(":");
        
        //$("#ContentPanel").html("<div style='margin: 10px;'>" + item.id +item.value+ "</div>");
        if (itemType[0]=="departId"){
        	$('#jtCompany-userInfo').hide();
        	$.map( departments, function( val, i ) {
	        	if(val.id==itemType[1]){
	        		deptInfo.deptDetail = val;
	        		deptInfo.userDetails=val.userDetailses;
	        		deptInfo.totalUsers = deptInfo.userDetails.length;	        			        		
	        	}
        	});
        	$('#jtCompany-deptInfo').show();
        	
        }
        if (itemType[0]=="userId"){
        	$('#jtCompany-deptInfo').hide();
        	$.map( companyAllUsers, function( val, i ) {
        		if(val.id==itemType[1]){
        			userInfo.userDetails = val;        			
        		} 
        	});
        	$('#jtCompany-userInfo').show();
        }

        
        //$("#ContentPanel").load('');
    });
});
 </script>