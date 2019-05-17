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

				<!-- ajax-form id="authorityAjaxForm" -->
				<form id="userDetailAjaxForm" action="/auth/org/userDetail" method="post" autocomplete = "off" @submit.prevent="submitForm">				
				  <input type="hidden" id="companyId" name="company_id" >
				  <input type="hidden" id="department_id" name="department_id" v-model="form_data.department_id">
				  <input type="hidden" id="manager_id" name="manager_id" v-model="form_data.manager_id" >		  
				  <input type="hidden" id="user_id" name="user_id" v-model="form_data.user_id">
				  <input type="hidden" id="userDetailId" name="id" v-model="form_data.id">
				  <div class="row"><div class="col-md-6"><label for="opName"> mode:</label>
				  	<input type="text" class="form-control" id="opName" name="opName" readonly>
				  </div></div>
				  <div class="box box-danger">
					<!-- /.box-header -->
					<div class="box-body">
					
					  <div class="row">
						<div class="col-md-6">

							<@pw.LOV 
							  	fileName="tags/lovTag.ftl"				  	
							  	lovTableId="tblUserAccountList"
							  	dtAjaxUrl="/auth/security/users"
							  	paramsStr="{'isSelect':true,'isVue':true,'VueElVar':'vueUserDetailAjaxForm','VueDataName':'form_data'}"
							  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
								     {'th':'label.username','data':'username','type':'text'},
						             {'th':'program.userController.firstName','data':'firstname','type':'text'},
						             {'th':'program.userController.lastName','data':'lastname','type':'text'},
						             {'th':'program.common.avatar','data':'avatar','type':'image'}]"
							  	inputStr="{'inputName':'username', 'inputLabel':'label.username' }"
							  	returnStr="[{'jsonKey':'username','targetId':'id_username'},
							  		        {'jsonKey':'id','targetId':'user_id'},
							  		        {'jsonKey':'firstname','targetId':'firstname'},
							  		        {'jsonKey':'lastname','targetId':'lastname'}]"
						    />

						</div><!-- /.col -->
						<div class="col-md-3">
						  <div class="form-group">
						    <label for="user-firstName"><@spring.message "program.userController.firstName" /></label>
						  	<input type="text" class="form-control" id="firstname" v-model="form_data.firstname" readonly required>						  	          
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->
						<div class="col-md-3">
						  <div class="form-group">
						    <label for="user-firstName"><@spring.message "program.userController.lastName" /></label>						  	
						  	<input type="text" class="form-control" id="lastname" v-model="form_data.firstname" readonly>                 
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->
					  </div><!-- /.row -->
					  
					  <div class="row">
						<div class="col-md-6">
						  <div class="form-group">                
							<label for="empNo"><@spring.message "program.userDetailsController.empNo" /></label>
							<input type="text" class="form-control" id="empNo" placeholder="<@spring.message "program.userDetailsController.empNo" />" name="empNo" v-model="form_data.emp_no" required>             
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->					  
						<div class="col-md-6">
							<@pw.LOV 
							  	fileName="tags/lovTag.ftl"				  	
							  	lovTableId="tblDepartmentList"
							  	dtAjaxUrl="/auth/org/departments"
							  	paramsStr="{'isSelect':true,'isVue':true,'VueElVar':'vueUserDetailAjaxForm'}"
							  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
								     {'th':'program.departmentController.departmentName','data':'name','type':'text'},
						             {'th':'program.departmentController.departmentNameEng','data':'nameEng','type':'text'},
						             {'th':'program.common.costCenter','data':'costCenter','type':'text'}]"
							  	inputStr="{'inputName':'department_name', 'inputLabel':'program.departmentController.departmentName' }"
							  	returnStr="[{'jsonKey':'name','targetId':'id_department_name'},
							  		 {'jsonKey':'id','targetId':'department_id'}]"
						    />	
						</div>				
					  </div><!-- /.row -->						  

					  <div class="row">
						<div class="col-md-6">
						  <@pw.LOV 
						  	fileName="tags/lovTag.ftl"				  	
						  	lovTableId="tblDepartmentManagerList"
						  	dtAjaxUrl="/auth/security/users"
						  	paramsStr="{'isSelect':true,'isVue':true,'VueElVar':'vueUserDetailAjaxForm'}"
						  	columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden'},
							     {'th':'label.username','data':'username','type':'text'},
					             {'th':'program.userController.fullName','data':'id','type':'text','render':'row.firstname+row.lastname'},
					             {'th':'program.common.avatar','data':'avatar','type':'image'}]"
						  	inputStr="{'inputName':'manager_username', 'inputLabel':'program.userDetailsController.userManager' }"
						  	returnStr="[{'jsonKey':'avatar','targetId':'manager_avatar', 'type':'image','imageType':'AVATAR_FOLDER' },
						  		 {'jsonKey':'username','targetId':'id_manager_username'},
						  		 {'jsonKey':'id','targetId':'manager_id'} ]"
						  />
						</div>
						<div class="col-md-6">
						  <div class="form-group">						            
								<div class="attachment-block clearfix"><img height="48" width="48" id="manager_avatar" class="attachment-img" v-bind:src="form_data.manager_avatar|imgSrc" alt="User Avatar" class="margin" /> </div>
						  </div>
						  <!-- /.form-group -->
						</div><!-- /.col -->				
					  </div><!-- /.row -->

					  <div class="row">
						<div class="col-md-6">						 
						  <div class="form-group" :class="{ 'form-group--error': $v.form_data.job_title.$error }">
						    <label for="jobTitle"><@spring.message "program.userDetailsController.jobTitle" /></label>
						  	<input type="text" class="form-control form__input" name="jobTitle" v-model.trim="$v.form_data.job_title.$model" >
						  </div>
						  <div class="error" v-if="!$v.form_data.job_title.required">Field is required</div>
			  			  <div class="error" v-if="!$v.form_data.job_title.minLength">Name must have at least {{$v.form_data.job_title.$params.minLength.min}} letters.</div>						  						  	          
						  <!-- /.form-group -->
						</div><!-- /.col -->
						<div class="col-md-6">
						  <div class="form-group">
						    <label for="workAddress"><@spring.message "program.userDetailsController.workAddress" /></label>						  	
						  	<input type="text" class="form-control" name="workAddress" v-model="form_data.work_address" required>                 
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
			              	  <input type="text" class="form-control date" name="hireDate" v-model="form_data.hire_date" data-date-format="yyyy/mm/dd" data-mask required>
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
			                  <input type="text" class="form-control date" name="resignationDate" v-model="form_data.resignation_date" data-date-format="yyyy/mm/dd" data-mask>
			                </div>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->			  
					  
					  <div class="box-footer">
					  <div class="row">
						  <div class="col-xs-12">
							  <button type="submit" class="btn btn-primary btnAdd" :disabled="submitStatus === 'PENDING'"><@spring.message "label.submit"/></button>
							  <button type="reset" class="btn btn-danger" @click.prevent="resetForm"><@spring.message "label.reset"/></button>							  
						  </div>          
					  </div> <!-- /.row -->
					  <div class="row">
						<p class="typo__p" v-if="submitStatus === 'OK'">Thanks for your submission!</p>
						<p class="typo__p" v-if="submitStatus === 'ERROR'">Please fill the form correctly.</p>
						<p class="typo__p" v-if="submitStatus === 'PENDING'">Sending...</p>
					  </div>
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
	
	$('.date').datepicker().on('changeDate', function(e) {
	    // `e` here contains the extra attributes
	    console.log(e);
	    
	    if (this.name){	    	    	
	    	vueUserDetailAjaxForm.form_data.hire_date = e.date;	    	
	    }
	});
	
	//To pre-select the first row
    $('#tblCompanies tbody tr:eq(0)').click(); 
	//$('#tblCompanies tbody tr:eq(0)').addClass('selected');

});

var vueUserDetailAjaxForm = new Vue({
	el: '#userDetailAjaxForm',
	data: {
		form_data:{
			job_title:'',
		},		  
	},
	validations:{
		form_data:{
			job_title:{
				required,
		        minLength: minLength(4)
			}
		},
	},
	methods: {
		resetForm() {
			this.form_data = {
					job_title:'',
			};
		},		
		submitForm: function(e) {
		    console.log({ form_data: this.form_data });		    
		    console.log('submit!')
			this.$v.$touch()
			if (this.$v.$invalid) {
			  this.submitStatus = 'ERROR'
			} else {
			  // do your submit logic here
			  this.submitStatus = 'PENDING'
			  setTimeout(() => {
			    this.submitStatus = 'OK'
			  }, 500)
			}
		},		  
	},
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
		    	 vueUserDetailAjaxForm.resetForm();
		     }
		 }            
 	]
}); 	

$('#tblCompanies tbody').on('click', 'tr', function (){
	   
	var $row = $(this).closest('tr');
	var data =  $('#tblCompanies').DataTable().row($row).data();
	var url = $(this).attr('data-url');	
	
	<#-- reset form 內的資料 -->	
	vueUserDetailAjaxForm.resetForm();
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
	
	vueUserDetailAjaxForm.form_data = data;

	$("#opName").val('put');
	
	//console.log('data', data);	
	//console.log('Record ID is', data['id']);
	//$.each( data, function( key, value ) {			
	//	$('#userDetailAjaxForm input[name="'+key+'"] ').val(value);			
	//});

});


//表單以 Ajax 方式執行 CRUD 
$("#userDetailAjaxForm").submit(function(event){
	event.preventDefault(); //prevent default action
	var post_url = $(this).attr("action"); //get form action url
	var request_method = $(this).attr("method"); //get form GET/POST method
	var form_data = JSON.stringify( $(this).serializeObject() ); <#-- Encode form elements for submission, this methos write in html-begin.ftl -->
	
	$.ajax({
		url : post_url,
        type: request_method,
        contentType: "application/json; charset=utf-8",
        data : form_data,
        headers:jwtClient.setAuthorizationTokenHeader(),
		success:function(data, textStatus, jqXHR){//返回json结果
			
		}
	});
	
});


</script>
      
                  
<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">      