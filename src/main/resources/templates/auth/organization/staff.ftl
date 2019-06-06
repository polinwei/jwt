<#include "/layout/AdminLTE2/vueHtml-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">
<link rel="stylesheet" href="/css/elementUI.css">
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
        <div class="col-md-4">

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
        <div class="col-md-8">
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab_userDetails" data-toggle="tab"><@spring.message "program.userDetailsController.programName" /></a></li>
              <li><a href="#timeline" data-toggle="tab">Timeline</a></li>
              <li><a href="#settings" data-toggle="tab">Settings</a></li>
            </ul>
            <div class="tab-content">
              <div class="active tab-pane" id="tab_userDetails">
				<div id="userDetailAjaxForm">
				<!-- ajax-form id="authorityAjaxForm" -->
				<el-form :model="formData" :rules="userDetailRules" ref="formData" class="" >				
				  <input type="hidden" id="companyId" name="company_id" >
				  <input type="hidden" id="department_id" name="department_id" v-model="formData.departmentId">
				  <input type="hidden" id="manager_id" name="manager_id" v-model="formData.managerId" >		  
				  <input type="hidden" id="user_id" name="user_id" v-model="formData.userId">
				  <input type="hidden" id="userDetailId" name="id" v-model="formData.userDetailId">
				  <div class="row">
					<div class="col-md-6"><label for="opName"> mode:</label>
						<input type="text" class="form-control" id="opName" name="opName" readonly>
					</div>			  	
				  </div>
				  <div class="box box-danger">
					<!-- /.box-header -->
					<div class="box-body">
					<div class="row">
						<div class="col-md-6">
							<@pw.vueComboInput 
								fileName="tags/vueComboInputTag.ftl"
								paramsStr="{'isSelect':true,'isVue':true,'VueElVar':'vueUserDetailForm','VueDataName':'formData'}"
								inputStr="{'inputName':'username', 'inputLabel':'label.username' }"
							/>
						</div>
					</div>
					  <div class="row">
						<div class="col-md-6">

							<@pw.LOV 
							  	fileName="tags/lovTag.ftl"				  	
							  	lovTableId="tblUserAccountList"
							  	dtAjaxUrl="/auth/security/users"
							  	paramsStr="{'isSelect':true,'isVue':true,'VueElVar':'vueUserDetailForm','VueDataName':'formData'}"
							  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
								     {'th':'label.username','data':'username','type':'text'},
						             {'th':'program.userController.firstName','data':'firstname','type':'text'},
						             {'th':'program.userController.lastName','data':'lastname','type':'text'},
						             {'th':'program.common.avatar','data':'avatar','type':'image'}]"
							  	inputStr="{'inputName':'username', 'inputLabel':'label.username' }"
							  	returnStr="[{'jsonKey':'username','targetId':'id_username'},							  				
							  		        {'jsonKey':'id','targetId':'userId'},
							  		        {'jsonKey':'firstname','targetId':'firstname'},
							  		        {'jsonKey':'lastname','targetId':'lastname'}]"
						    />

						</div><!-- /.col -->
						<div class="col-md-3">
						  <div class="form-group">
							<el-form-item label='<@spring.message "program.userController.firstName" />' prop="firstname">
								<el-input v-model="formData.firstname" :disabled="true"></el-input>
							</el-form-item>	
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->
						<div class="col-md-3">
						  <div class="form-group">						  	
							<el-form-item label='<@spring.message "program.userController.lastName" />' prop="lastname">
								<el-input v-model="formData.lastname" :disabled="true"></el-input>
							</el-form-item>						  	                 
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->
					  </div><!-- /.row -->
					  
					  <div class="row">
						<div class="col-md-6">
						  <div class="form-group">						  						  	
							<el-form-item label='<@spring.message "program.userDetailsController.empNo" />' prop="empNo">
								<el-input v-model="formData.empNo" size="medium"></el-input>
							</el-form-item>
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->					  
						<div class="col-md-6">
							<@pw.LOV 
							  	fileName="tags/lovTag.ftl"				  	
							  	lovTableId="tblDepartmentList"
							  	dtAjaxUrl="/auth/org/departments"
							  	paramsStr="{'isSelect':true,'isVue':true,'VueElVar':'vueUserDetailForm'}"
							  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
								     {'th':'program.departmentController.departmentName','data':'name','type':'text'},
						             {'th':'program.departmentController.departmentNameEng','data':'nameEng','type':'text'},
						             {'th':'program.common.costCenter','data':'costCenter','type':'text'}]"
							  	inputStr="{'inputName':'departmentName', 'inputLabel':'program.departmentController.departmentName' }"
							  	returnStr="[{'jsonKey':'name','targetId':'id_departmentName'},
							  		 {'jsonKey':'id','targetId':'departmentId'}]"
						    />	
						</div>				
					  </div><!-- /.row -->						  

					  <div class="row">
						<div class="col-md-6">
						  <@pw.LOV 
						  	fileName="tags/lovTag.ftl"				  	
						  	lovTableId="tblDepartmentManagerList"
						  	dtAjaxUrl="/auth/security/users"
						  	paramsStr="{'isSelect':true,'isVue':true,'VueElVar':'vueUserDetailForm'}"
						  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
							     {'th':'label.username','data':'username','type':'text'},
					             {'th':'program.userController.fullName','data':'id','type':'text','render':'row.firstname+row.lastname'},
					             {'th':'program.common.avatar','data':'avatar','type':'image'}]"
						  	inputStr="{'inputName':'userManager', 'inputLabel':'program.userDetailsController.userManager' }"
						  	returnStr="[{'jsonKey':'avatar','targetId':'managerAvatar', 'type':'image','imageType':'AVATAR_FOLDER' },
						  		 {'jsonKey':'username','targetId':'id_userManager'},
						  		 {'jsonKey':'id','targetId':'managerId'} ]"
						  />
						</div>
						<div class="col-md-6">
						  <div class="form-group">						            
								<div class="attachment-block clearfix"><img height="48" width="48" id="managerAvatar" class="attachment-img" v-bind:src="formData.managerAvatar|imgSrc" alt="User Avatar" class="margin" /> </div>
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->				
					  </div><!-- /.row -->

					  <div class="row">
						<div class="col-md-6">						 
						  <div class="form-group" >
							<el-form-item label='<@spring.message "program.userDetailsController.jobTitle" />' prop="jobTitle">
								<el-input v-model="formData.jobTitle" size="medium"></el-input>
							</el-form-item>
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->
						<div class="col-md-6">
						  <div class="form-group">
							<el-form-item label='<@spring.message "program.userDetailsController.workAddress" />' prop="workAddress">
								<el-input v-model="formData.workAddress" size="medium"></el-input>
							</el-form-item>
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->
					  </div><!-- /.row -->
					  
					  <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
							  <el-form-item label='<@spring.message "program.userDetailsController.hireDate" />' prop="hireDate" required>							      
							        <el-date-picker type="date" placeholder="Pick a date" name="hireDate" v-model="formData.hireDate" style="width: 100%;" size="medium"></el-date-picker>
							  </el-form-item>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->
			            <div class="col-md-6">
			              <div class="form-group">
							  <el-form-item label='<@spring.message "program.userDetailsController.resignationDate" />' prop="resignationDate" >							      
							        <el-date-picker type="date" placeholder="Pick a date" name="resignationDate" v-model="formData.resignationDate" style="width: 100%;" size="medium"></el-date-picker>
							  </el-form-item>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->			  
					  
					  <div class="box-footer">
					  <div class="row">
						<el-form-item>
							<el-button type="primary" @click="submitForm('formData')"><@spring.message "label.submit"/></el-button>
							<el-button type="danger" @click="resetForm('formData')"><@spring.message "label.reset"/></el-button>							  
						</el-form-item>       
					  </div> <!-- /.row -->
					  </div>
					</div><!-- /.box-body -->
				  </div><!-- /.box -->				  
				  </el-form>
			  </div>				  

              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="timeline">
                <!-- The timeline -->
                
              </div>
              <!-- /.tab-pane -->

              <div class="tab-pane" id="settings">
                
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

	
	//To pre-select the first row
    $('#tblCompanies tbody tr:eq(0)').click(); 
	//$('#tblCompanies tbody tr:eq(0)').addClass('selected');
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
 		url:"/auth/org/usersByCompanyNativeQuery/0",dataSrc:"",
 		headers: jwtClient.setAuthorizationTokenHeader(),
 		async: false
	},
 	columns: [
		{ data: "id", visible: false },
		{ data: "emp_no"  },
		{ data: "username" },
		{ data: "id", render: function(data, type, row, meta) {					
	            return row.firstname+" "+row.lastname;
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
		    	 //$("#userDetailAjaxForm")[0].reset();
		    	 $("#opName").val('post');
		    	 <#-- reset form 內的資料 -->	
		    	 vueUserDetailForm.resetForm("formData");
		    	 
		     }
		 }            
 	]
}); 	

$('#tblCompanies tbody').on('click', 'tr', function (){
	   
	var $row = $(this).closest('tr');
	var data =  $('#tblCompanies').DataTable().row($row).data();
	var url = $(this).attr('data-url');		

	<#-- refresh datatable 內的資料 -->	
	tblCompanyUsers.ajax.url( '/auth/org/usersByCompanyNativeQuery/'+data['id']).load();
	//公司id	
	$("#companyId").val(data['id']);
	$("#opName").val('put');
	
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
	
	if ( $(this).hasClass('selected') ) {
        $(this).removeClass('selected');
    }
    else {
    	tblCompanyUsers.$('tr.selected').removeClass('selected');
        $(this).addClass('selected');
    }
	
	vueUserDetailForm.formData = data;

	$("#opName").val('put');
	


});


var userDetail = {
		data(){
			return {
				formData:{
					departmentId:'',
					managerId:'',
					userId:'',
					userDetailId:'',
					username:'',
					firstname:'',
					lastname:'',
					empNo:'',
					departmentName:'',
					userManager:'',
					managerAvatar:'',
					jobTitle:'',
					workAddress:'',
					hireDate:'',
					resignationDate:'',					
				},
				userDetailRules:{
					username: [
			            { required: true, message: 'Please input Activity name', trigger: 'blur' },
			            { min: 3, max: 5, message: 'Length should be 3 to 5', trigger: 'blur' }
			        ],
			        empNo: [
			            { required: true, message: 'Please input emp No', trigger: 'blur' },
			            { min: 3, max: 5, message: 'Length should be 3 to 5', trigger: 'blur' }
			        ],
			        hireDate: [
			            { type: 'date', required: true, message: 'Please input Hire Date', trigger: 'change' }
			        ],
			          
				}
			}
		},
		methods: {
		      submitForm(formName) {
		        this.$refs[formName].validate((valid) => {
		          if (valid) {
		            alert('submit!');
		          } else {
		            console.log('error submit!!');
		            return false;
		          }
		        });
		      },
		      resetForm(formName) {
		        this.$refs[formName].resetFields();
		      }
		}
}
var vueUserDetail = Vue.extend(userDetail);
var vueUserDetailForm = new vueUserDetail().$mount('#userDetailAjaxForm');

</script>
      
                  
<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">      