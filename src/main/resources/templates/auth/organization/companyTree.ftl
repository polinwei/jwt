

<div id="splitter">
	<div>
		<div style="visibility: hidden; border: none;" id='jtCompany'>
			<div id='jtCompany-content'></div>
		</div>
	</div>
	<div id="ContentPanel">
		<div  border: none;" id='jtCompany-deptInfo'>
			<div class="row">
			<div class="col-md-12">
				<!-- USERS LIST -->
              <div class="box box-danger">
                <div class="box-header with-border">
                  <h3 class="box-title">Latest Members</h3>

                  <div class="box-tools pull-right">
                    <span class="label label-danger">8 New Members</span>
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i>
                    </button>
                  </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body no-padding">
                  <ul class="users-list clearfix">
                    <li>
                      <img src="dist/img/user1-128x128.jpg" alt="User Image">
                      <a class="users-list-name" href="#">Alexander Pierce</a>
                      <span class="users-list-date">Today</span>
                    </li>
                    <li>
                      <img src="dist/img/user8-128x128.jpg" alt="User Image">
                      <a class="users-list-name" href="#">Norman</a>
                      <span class="users-list-date">Yesterday</span>
                    </li>
                    <li>
                      <img src="dist/img/user7-128x128.jpg" alt="User Image">
                      <a class="users-list-name" href="#">Jane</a>
                      <span class="users-list-date">12 Jan</span>
                    </li>
                    <li>
                      <img src="dist/img/user6-128x128.jpg" alt="User Image">
                      <a class="users-list-name" href="#">John</a>
                      <span class="users-list-date">12 Jan</span>
                    </li>
                    <li>
                      <img src="dist/img/user2-160x160.jpg" alt="User Image">
                      <a class="users-list-name" href="#">Alexander</a>
                      <span class="users-list-date">13 Jan</span>
                    </li>
                    <li>
                      <img src="dist/img/user5-128x128.jpg" alt="User Image">
                      <a class="users-list-name" href="#">Sarah</a>
                      <span class="users-list-date">14 Jan</span>
                    </li>
                    <li>
                      <img src="dist/img/user4-128x128.jpg" alt="User Image">
                      <a class="users-list-name" href="#">Nora</a>
                      <span class="users-list-date">15 Jan</span>
                    </li>
                    <li>
                      <img src="dist/img/user3-128x128.jpg" alt="User Image">
                      <a class="users-list-name" href="#">Nadia</a>
                      <span class="users-list-date">15 Jan</span>
                    </li>
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
		</div>
	
	
		<div border: none;" id='jtCompany-userInfo'>
		<span id="vueUserInfo">
			<div class="row">		
			<div class="col-md-12">		        
				  <!-- Profile Image -->
		          <div class="box box-primary">
		            <div class="box-body box-profile">
		              <img class="profile-user-img img-responsive img-circle" 
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
	Vue.filter('formatDate', function(value) {
		  if (value) {
		    return moment(String(value)).format('YYYY/MM/DD ZZ')
		  }
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
    	
    	var args = event.args;
        var item = $('#jtCompany').jqxTree('getItem', args.element);
        var items = $('#jtCompany').jqxTree('getItems');
        var label = item.label; 
        var type = args.type; 
        var value = item.value;
        var itemType = value.split(":");
        
        //$("#ContentPanel").html("<div style='margin: 10px;'>" + item.id +item.value+ "</div>");
        if (itemType[0]=="departId"){
        	$('#jtCompany-deptInfo').show();
        	$('#jtCompany-userInfo').hide();
        }
        if (itemType[0]=="userId"){
        	$('#jtCompany-deptInfo').hide();
        	$.map( companyAllUsers, function( val, i ) {
        		if(val.id==itemType[1]){
        			userInfo.userDetails = val;
        			console.log(userInfo.userDetails);
        		}
        		  
        	});
        	$('#jtCompany-userInfo').show();
        }

        
        //$("#ContentPanel").load('');
    });
});
 </script>