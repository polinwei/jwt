<#include "/layout/AdminLTE2/html-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">

<style>

table.dataTable tbody tr:hover {
  background-color: #ffa;
}
table.dataTable tbody tr:hover > .sorting_1 {
  background-color: #ffa;
}
table.dataTable thead:hover {
  background-color: #ffa;
}
table.dataTable tr.selected {
    background-color: #B0BED9; !important; /* Add !important to make sure override datables base styles */
 }

</style>	
			
	<div class="row">
        <div class="col-md-3">

          <!-- Companies -->
          <div class="box box-primary">
            <div class="box-body box-profile">
            <div class="box-header with-border">
              <h3 class="box-title">Compnay List</h3>
            </div>
            <!-- /.box-header -->
	            <table id="tblCompanies" class="table table-bordered table-striped" style="width:100%">
		            <thead>
		            <tr>
		              <th>company_id</th>              
		              <th><@spring.message "program.companyController.companyCode" /></th>
		              <th><@spring.message "program.companyController.companyName" /></th>
		            </tr>
		            </thead>
	          	</table>              
              
              
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

          <!-- Users List Box -->
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Users List</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="tblCompanyUsers" class="table table-bordered table-striped" style="width:100%">
		            <thead>
		            <tr>		              
		              <th>id</th>
		              <th><@spring.message "program.userDetailsController.empNo" /></th>             
		              <th><@spring.message "label.username" /></th>
		              <th><@spring.message "program.userController.fullName" /></th>
		            </tr>
		            </thead>
	          	</table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        <div class="col-md-9">
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab_userDetails" data-toggle="tab"><@spring.message "program.userDetailsController.programName" /></a></li>
              <li><a href="#timeline" data-toggle="tab">Timeline</a></li>
              <li><a href="#settings" data-toggle="tab">Settings</a></li>
            </ul>
            <div class="tab-content">
              <div class="active tab-pane" id="tab_userDetails">

				<!-- ajax-form id="authorityAjaxForm" -->
				<form id="userDetailAjaxForm" action="/auth/org/user" method="post" autocomplete = "off">				
				  <input type="hidden" id="companyId" name="company_id" >
				  <input type="hidden" id="departId" name="depart_id" >
				  <input type="hidden" id="userManagerId" name="userManager_id" v-model="userByManagerId.id" >		  
				  <input type="hidden" id="uerId" name="user_id" v-model="userByUserId.id">
				  <input type="hidden" id="opName" name="opName" >
				  <div class="box box-danger">
					<!-- /.box-header -->
					<div class="box-body">
					
					  <div class="row">
						<div class="col-md-6">

							<@pw.LOV 
							  	fileName="tags/lovTag.ftl"				  	
							  	lovTableId="tblUserAccountList"
							  	dtAjaxUrl="/auth/security/users"
							  	paramsStr="{'isSelect':true}"
							  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
								     {'th':'label.username','data':'username','type':'text'},
						             {'th':'program.userController.firstName','data':'firstname','type':'text'},
						             {'th':'program.userController.lastName','data':'lastname','type':'text'},
						             {'th':'program.common.avatar','data':'avatar','type':'image'}]"
							  	inputStr="{'inputName':'username', 'inputLabel':'label.username' }"
							  	returnStr="[{'jsonKey':'username','targetId':'id_username'},
							  		        {'jsonKey':'id','targetId':'uerId'},
							  		        {'jsonKey':'firstname','targetId':'user-firstName'},
							  		        {'jsonKey':'lastname','targetId':'user-lastName'}]"
						    />

						</div><!-- /.col -->
						<div class="col-md-3">
						  <div class="form-group">
						    <label for="user-firstName"><@spring.message "program.userController.firstName" /></label>
						  	<input type="text" class="form-control" id="user-firstName" v-model="userByUserId.firstname" readonly>						  	          
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->
						<div class="col-md-3">
						  <div class="form-group">
						    <label for="user-firstName"><@spring.message "program.userController.lastName" /></label>						  	
						  	<input type="text" class="form-control" id="user-lastName" v-model="userByUserId.lastname" readonly>                 
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->
					  </div><!-- /.row -->
					  
					  <div class="row">
						<div class="col-md-6">
						  <div class="form-group">                
							<label for="empNo"><@spring.message "program.userDetailsController.empNo" /></label>
							<input type="text" class="form-control" id="empNo" placeholder="<@spring.message "program.userDetailsController.empNo" />" name="empNo" required>             
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->					  
						<div class="col-md-6">
							<@pw.LOV 
							  	fileName="tags/lovTag.ftl"				  	
							  	lovTableId="tblDepartmentList"
							  	dtAjaxUrl="/auth/org/departments"
							  	paramsStr="{'isSelect':true}"
							  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
								     {'th':'program.departmentController.departmentName','data':'name','type':'text'},
						             {'th':'program.departmentController.departmentNameEng','data':'nameEng','type':'text'},
						             {'th':'program.common.costCenter','data':'costCenter','type':'text'}]"
							  	inputStr="{'inputName':'departmentName', 'inputLabel':'program.departmentController.departmentName' }"
							  	returnStr="[{'jsonKey':'name','targetId':'id_departmentName'},
							  		 {'jsonKey':'id','targetId':'departId'}]"
						    />	
						</div>				
					  </div><!-- /.row -->						  

					  <div class="row">
						<div class="col-md-6">
						  <@pw.LOV 
						  	fileName="tags/lovTag.ftl"				  	
						  	lovTableId="tblDepartmentManagerList"
						  	dtAjaxUrl="/auth/security/users"
						  	paramsStr="{'isSelect':true}"
						  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
							     {'th':'label.username','data':'username','type':'text'},
					             {'th':'program.userController.fullName','data':'id','type':'text','render':'row.firstname+row.lastname'},
					             {'th':'program.common.avatar','data':'avatar','type':'image'}]"
						  	inputStr="{'inputName':'userManagerName', 'inputLabel':'program.userDetailsController.userManager' }"
						  	returnStr="[{'jsonKey':'avatar','targetId':'userManagerAvatar', 'type':'image','imageType':'AVATAR_FOLDER' },
						  		 {'jsonKey':'username','targetId':'id_userManagerName'},
						  		 {'jsonKey':'id','targetId':'userManagerId'} ]"
						  />
						</div>
						<div class="col-md-6">
						  <div class="form-group">
						    <span v-if="userByManagerId.avatar!=null">             
								<div class="attachment-block clearfix"><img height="48" width="48" id="userManagerAvatar" class="attachment-img" v-bind:src="userByManagerId.avatar|imgSrc" alt="User Avatar" class="margin" /> </div>
						  	</span>
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->				
					  </div><!-- /.row -->
					  
					  <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			              	<label for="startDate"><@spring.message "program.userDetailsController.hireDate" /></label>
			              	<div class="input-group date">
			                  <div class="input-group-addon">
			                    <i class="fa fa-calendar"></i>
			                  </div>
			              	  <input type="text" class="form-control date" name="hireDate" data-date-format="yyyy/mm/dd" data-mask>
			              	</div>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->
			            <div class="col-md-6">
			              <div class="form-group">                
			                <label for="endDate"><@spring.message "program.userDetailsController.resignationDate" /></label>
			                <div class="input-group date">
			                  <div class="input-group-addon">
			                    <i class="fa fa-calendar"></i>
			                  </div>
			                  <input type="text" class="form-control date" name="resignationDate" data-date-format="yyyy/mm/dd" data-mask>
			                </div>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->			  
					  
					  <div class="box-footer">
					  <div class="row">
						  <div class="col-xs-12">
							  <button type="submit" class="btn btn-primary btnAdd"><@spring.message "label.submit"/></button>
							  <button type="reset" class="btn btn-danger"><@spring.message "label.reset"/></button>
							  <button type="button" class="btn bg-yellow" data-dismiss="modal">Close</button>
						  </div>          
					  </div> <!-- /.row -->
					  </div>
					</div><!-- /.box-body -->
				  </div><!-- /.box -->				  
				  </form>
				  				  

              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="timeline">
                <!-- The timeline -->
                <ul class="timeline timeline-inverse">
                  <!-- timeline time label -->
                  <li class="time-label">
                        <span class="bg-red">
                          10 Feb. 2014
                        </span>
                  </li>
                  <!-- /.timeline-label -->
                  <!-- timeline item -->
                  <li>
                    <i class="fa fa-envelope bg-blue"></i>

                    <div class="timeline-item">
                      <span class="time"><i class="fa fa-clock-o"></i> 12:05</span>

                      <h3 class="timeline-header"><a href="#">Support Team</a> sent you an email</h3>

                      <div class="timeline-body">
                        Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles,
                        weebly ning heekya handango imeem plugg dopplr jibjab, movity
                        jajah plickers sifteo edmodo ifttt zimbra. Babblely odeo kaboodle
                        quora plaxo ideeli hulu weebly balihoo...
                      </div>
                      <div class="timeline-footer">
                        <a class="btn btn-primary btn-xs">Read more</a>
                        <a class="btn btn-danger btn-xs">Delete</a>
                      </div>
                    </div>
                  </li>
                  <!-- END timeline item -->
                  <!-- timeline item -->
                  <li>
                    <i class="fa fa-user bg-aqua"></i>

                    <div class="timeline-item">
                      <span class="time"><i class="fa fa-clock-o"></i> 5 mins ago</span>

                      <h3 class="timeline-header no-border"><a href="#">Sarah Young</a> accepted your friend request
                      </h3>
                    </div>
                  </li>
                  <!-- END timeline item -->
                  <!-- timeline item -->
                  <li>
                    <i class="fa fa-comments bg-yellow"></i>

                    <div class="timeline-item">
                      <span class="time"><i class="fa fa-clock-o"></i> 27 mins ago</span>

                      <h3 class="timeline-header"><a href="#">Jay White</a> commented on your post</h3>

                      <div class="timeline-body">
                        Take me to your leader!
                        Switzerland is small and neutral!
                        We are more like Germany, ambitious and misunderstood!
                      </div>
                      <div class="timeline-footer">
                        <a class="btn btn-warning btn-flat btn-xs">View comment</a>
                      </div>
                    </div>
                  </li>
                  <!-- END timeline item -->
                  <!-- timeline time label -->
                  <li class="time-label">
                        <span class="bg-green">
                          3 Jan. 2014
                        </span>
                  </li>
                  <!-- /.timeline-label -->
                  <!-- timeline item -->
                  <li>
                    <i class="fa fa-camera bg-purple"></i>

                    <div class="timeline-item">
                      <span class="time"><i class="fa fa-clock-o"></i> 2 days ago</span>

                      <h3 class="timeline-header"><a href="#">Mina Lee</a> uploaded new photos</h3>

                      <div class="timeline-body">
                        <img src="http://placehold.it/150x100" alt="..." class="margin">
                        <img src="http://placehold.it/150x100" alt="..." class="margin">
                        <img src="http://placehold.it/150x100" alt="..." class="margin">
                        <img src="http://placehold.it/150x100" alt="..." class="margin">
                      </div>
                    </div>
                  </li>
                  <!-- END timeline item -->
                  <li>
                    <i class="fa fa-clock-o bg-gray"></i>
                  </li>
                </ul>
              </div>
              <!-- /.tab-pane -->

              <div class="tab-pane" id="settings">
                <form class="form-horizontal">
                  <div class="form-group">
                    <label for="inputName" class="col-sm-2 control-label">Name</label>

                    <div class="col-sm-10">
                      <input type="email" class="form-control" id="inputName" placeholder="Name">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 control-label">Email</label>

                    <div class="col-sm-10">
                      <input type="email" class="form-control" id="inputEmail" placeholder="Email">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputName" class="col-sm-2 control-label">Name</label>

                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="inputName" placeholder="Name">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputExperience" class="col-sm-2 control-label">Experience</label>

                    <div class="col-sm-10">
                      <textarea class="form-control" id="inputExperience" placeholder="Experience"></textarea>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputSkills" class="col-sm-2 control-label">Skills</label>

                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="inputSkills" placeholder="Skills">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <div class="checkbox">
                        <label>
                          <input type="checkbox"> I agree to the <a href="#">terms and conditions</a>
                        </label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-danger">Submit</button>
                    </div>
                  </div>
                </form>
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
          <!-- /.nav-tabs-custom -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
<script type="text/javascript">

$(document).ready( function () {

	$('.date').datepicker({format: 'yyyy/mm/dd',clearBtn: true,todayHighlight: true,});
	$('.date').datepicker({format: 'yyyy/mm/dd',clearBtn: true,todayHighlight: true,});
	$('.date').inputmask('yyyy/mm/dd');
	$('.date').inputmask('yyyy/mm/dd');
	$('[data-mask]').inputmask();
	
	//To pre-select the first row
    //$('#tblCompanies tbody tr:eq(0)').click(); // 速度太快時,這會讓 table顯示兩筆相同資料 
	$('#tblCompanies tbody tr:eq(0)').addClass('selected');
});

var tblCompanies = $('#tblCompanies').DataTable({
	language: {
    	"url": "/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json"
    },
 	ajax: {
 		url:"/auth/org/companies",dataSrc:"",
 		headers: jwtClient.setAuthorizationTokenHeader(),
 		async: false
	},	
 	columns: [
 		{ data: "id" , visible: false},			
		{ data: "code" },
		{ data: "name"},
	],
	dom:  "<'row'<'col-sm-12'B>>" +
		  "<'row'<'col-sm-12'tr>>" +
		  "<'row'<'col-sm-12'p>>",        
	buttons: [
		 {
		     text: 'Reload',
		     className: "btn btn-xs btn-primary",
		     action: function ( e, dt, node, config ) {            	   
		         dt.ajax.reload();
		     }
		 }            
 	]    
});

var tblCompanyUsers = $('#tblCompanyUsers').DataTable({
	language: {
    	"url": "/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json"
    },
    ajax: {
 		url:"/auth/org/usersByCompany/1",dataSrc:"",
 		headers: jwtClient.setAuthorizationTokenHeader(),
 		async: false
	},
 	columns: [
		{ data: "id", visible: false },
		{ data: "empNo"  },
		{ data: "userByUserId.username" },
		{ data: "id", render: function(data, type, row, meta) {					
	            return row.userByUserId.firstname+" "+row.userByUserId.lastname;
	       	}
		 },
	],
	dom:  "<'row'<'col-sm-3'B><'col-sm-6'f>>" +
		  "<'row'<'col-sm-12'tr>>" +
		  "<'row'<'col-sm-12'p>>",        
	buttons: [
		 {
		     text: 'Add User',
		     className: "btn btn-xs btn-primary",
		     action: function ( e, dt, node, config ) {            	   
		    	 $("#userDetailAjaxForm")[0].reset();
		    	 vueUserDetailAjaxForm ={};
		    	 vueUserDetailAjaxForm.userByUserId = {};
		    	 vueUserDetailAjaxForm.userByManagerId = {};
		     }
		 }            
 	]
}); 	

var vueUserDetailAjaxForm = new Vue({
	  el: '#userDetailAjaxForm',
	  data: {
		  username:'',
		  firstName:'',
		  lastName:'',
		  departmentName:'',
		  userManagerName:'',
		  userByUserId:{},
		  userByManagerId:{}
	  }
});

$('#tblCompanies tbody').on('click', 'tr', function (){
	   
	var $row = $(this).closest('tr');
	var data =  $('#tblCompanies').DataTable().row($row).data();
	var url = $(this).attr('data-url');	
	
	<#-- refresh datatable 內的資料 -->	
	tblCompanyUsers.ajax.url( '/auth/org/usersByCompany/'+data['id']).load();
	//公司id
	$("#companyId").val(data['id']);
	
	//console.log('data', data);
	//console.log('Record ID is', data['id']);
	if ( $(this).hasClass('selected') ) {
        $(this).removeClass('selected');
    }
    else {
        tblCompanies.$('tr.selected').removeClass('selected');
        $(this).addClass('selected');
    }	

});	

$('#tblCompanyUsers tbody').on('click', 'tr', function (){
	   
	var $row = $(this).closest('tr');
	var data =  $('#tblCompanyUsers').DataTable().row($row).data();
	var url = $(this).attr('data-url');
	
	//console.log('data', data);
	//console.log('Record ID is', data['id']);
	if ( $(this).hasClass('selected') ) {
        $(this).removeClass('selected');
    }
    else {
    	tblCompanyUsers.$('tr.selected').removeClass('selected');
        $(this).addClass('selected');
    }
	
	if (data.userByUserId) {
		vueUserDetailAjaxForm.userByUserId = data.userByUserId;
		vueUserDetailAjaxForm.username = vueUserDetailAjaxForm.userByUserId.username;
	} else {
		vueUserDetailAjaxForm.userByUserId = {};
		vueUserDetailAjaxForm.username = "";
	}		
	if (data.userByManagerId) {
		vueUserDetailAjaxForm.userByManagerId = data.userByManagerId;
	} else {
		vueUserDetailAjaxForm.userByManagerId = {};
	}
	
	$.each( data, function( key, value ) {			
		$('#userDetailAjaxForm input[name="'+key+'"] ').val(value);			
	});

});
</script>
      
                  
<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">      