      <!-- Default box -->
      <div class="box box-success">
        <div class="box-header">
          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
              <i class="fa fa-minus"></i></button>
          </div>
        </div>
        <div class="box-body">
         
          <table id="tblUserProfile" class="table table-bordered table-striped" style="width:100%">
            <thead>
            <tr>
              <th>id</th>
              <th>user_id</th>
              <th><@spring.message "label.username" /></th>
              <th><@spring.message "program.common.paramName" /></th>
              <th><@spring.message "program.common.paramValue" /></th>
              <th><@spring.message "program.common.paramDesc" /></th>
              <th><@spring.message "program.common.note" /></th>
              <th><@spring.message "label.ajaxOptions" /></th>
            </tr>
            </thead>
          </table>
                                             
        </div>
        <!-- /.box-body -->
      </div>
      <!-- /.box -->
      
        <div class="modal fade" id="modal-userProfile" >
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"><@spring.message "program.block.manipulate" /></h4>
              </div>
              <div class="modal-body">
                
				<!-- ajax-form id="userProfileAjaxForm" -->
				<form id="userProfileAjaxForm" action="/auth/security/userProfile" method="post">
			      <input type="hidden" name="userId" >			      
			      <div class="box box-info">
			        <!-- /.box-header -->
			        <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="userProfileAjaxUsername"><@spring.message "label.username" /></label>
			                <div class="input-group">
				                <input type="text" class="form-control" id="userProfileAjaxUsername" placeholder="<@spring.message "label.username" />" name="username" required readonly>
				                <span class="input-group-addon"><i class="fa fa-list" id="userProfileUsernameList" style="cursor: pointer;"></i></span>
				            </div>
			              </div>
			              <!-- /.form-group -->
			            </div><!-- /.col -->
			          </div><!-- /.row -->
			          
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">                
			                <label for="userProfileAjaxParamName"><@spring.message "program.common.paramName" /></label>
			                <input type="text" class="form-control" id="userProfileAjaxParamName" placeholder="<@spring.message "program.common.paramName" />" name="paramName" required>
			              </div>
			            </div>
			            <div class="col-md-6">
			              <!-- /.form-group -->
			              <div class="form-group">
			                <label for="userProfileAjaxParamValue"><@spring.message "program.common.paramValue" /></label>
			                <input type="text" class="form-control" id="userProfileAjaxParamValue" placeholder="<@spring.message "program.common.paramValue" />" name="paramValue" required>             
			              </div>
			              <!-- /.form-group -->
			            </div><!-- /.col -->
			            
			          </div><!-- /.row -->
			          
			          <div class="row">
			            <div class="col-md-12">
			              <div class="form-group">                
			                <label for="userProfileAjaxParamDesc"><@spring.message "program.common.paramDesc" /></label>
			                <input type="text" class="form-control" id="userProfileAjaxParamDesc" placeholder="<@spring.message "program.common.paramDesc" />" name="paramDesc" required>
			              </div>
			            </div>
			            <div class="col-md-12">
			              <!-- /.form-group -->
			              <div class="form-group">
			                <label for="userProfileAjaxNote"><@spring.message "program.common.note" /></label>			                             
			              	<textarea id="userProfileAjaxNote" name="note" class="form-control"  rows="5" cols="80" ></textarea>
			              
			              </div>
			              <!-- /.form-group -->
			            </div><!-- /.col -->
			            
			          </div><!-- /.row -->
			          
			          <div class="row">
					      <div class="col-xs-6">
					          <button type="submit" class="btn btn-primary btnAdd"><@spring.message "label.submit"/></button>
					          <button type="reset" class="btn btn-danger"><@spring.message "label.reset"/></button>
					          <button type="button" class="btn bg-yellow" data-dismiss="modal">Close</button>
					      </div>          
			          </div> <!-- /.row -->
			        </div><!-- /.box-body -->
			      </div><!-- /.box -->
			      </form> <!-- /.ajax-form id="userProfileAjaxForm" --> 
              </div> <!-- /.modal-body -->
            </div>   <!-- /.modal-content -->
          </div>     <!-- /.modal-dialog -->
        </div>       <!-- /.modal -->      
      

        <div class="modal fade" id="modal-userProfileUsernameList">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"><@spring.message "program.block.datatable" /></h4>
              </div>
              <div class="modal-body">

				<table id="tblUserList" class="table table-bordered table-striped" style="width:100%">
		            <thead>
		            <tr>
		              <th><@spring.message "label.select" /></th>
		              <th>id</th>
		              <th><@spring.message "label.username" /></th>
		              <th><@spring.message "program.userController.fullName" /></th>
		              <th><@spring.message "program.common.avatar" /></th>
		            </tr>
		            </thead>
		          </table>
				<div class="row">
					<div class="col-xs-6">
					    <button type="button" class="btn bg-yellow" data-dismiss="modal">Close</button>
					</div>          
		      	</div> <!-- /.row -->
              </div> <!-- /.modal-body -->
            </div>   <!-- /.modal-content -->
          </div>     <!-- /.modal-dialog -->
        </div>       <!-- /.modal -->  
      
<!-- page script -->

<script>
CKEDITOR.replace('userProfileAjaxNote',{
	filebrowserImageUploadUrl: '/auth/upload/ckeditorImage?Type=Images&uploadType=security'
});
$(function () {
    // Replace the <textarea id="editor1"> with a CKEditor
    // instance, using default configuration.
    
    
})
$.fn.dataTable.ext.errMode = function ( settings, helpPage, message ) { 
	alert(message);
    //console.log(message);
};
$('#tblUserProfile').DataTable({
	language: {
        "url": "/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json"
    },
 	ajax: {
 		url:"/auth/security/userProfiles",dataSrc:"",
 		headers: jwtClient.setAuthorizationTokenHeader(),
 		async: false
	},	
 	columns: [
 	  { data: "id" , visible: false},
 	  { data: "userId" , visible: false},
 	  { data: "username"},
      { data: "paramName" },
      { data: "paramValue" },
      { data: "paramDesc"},
      { data: "note"},
      {
    	data: "id", render: function(data, type, row, meta) {
    		<#if Request.progPermits?? && !Request.progPermits["isEdit"] >
    			<#assign isEditDisable = 'disabled="disabled" '>
    		</#if>
    		<#if Request.progPermits?? && !Request.progPermits["isDel"] >
				<#assign isDelDisable = 'disabled="disabled" '>				
			</#if>
			
            return '<a href="#" data-url=/auth/security/userProfile/'+data+' class="btn btn-xs btn-primary btnDTView btnEdit" ${isEditDisable!""}><i class="fa fa-pencil"></i>Edit</a> '+
                   '<a href="#" data-url=/auth/security/userProfile/'+data+' data-ajax="true" class="btn btn-xs btn-danger btnDel" ${isDelDisable!""}><i class="fa fa-trash-o"></i>Delete</a>'
       	}  
      }],
  dom:  "<'row'<'col-sm-6'B><'col-sm-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-4'l><'col-sm-4'i><'col-sm-4'p>>",        
  buttons: [     	
     	{
     		extend: 'copy',
     		text: 'copy',
     		className: "btn btn-xs btn-primary",
     	},
     	{
     		extend: 'excel',
     		text: 'excel',
     		className: "btn btn-xs btn-primary",
     	},     	
     	{
     		extend: 'pdf',
     		text: 'PDF',
     		className: "btn btn-xs btn-primary",
     		'title': 'Authority List',                 
             'download': 'open',//直接在視窗開啟 
     	},
     	{
             extend: 'csv',
             text: 'CSV',
             className: "btn btn-xs btn-primary",
             bom : true
         },
         {
             text: 'Add (Ajax)',
             className: "btn btn-xs btn-primary btnAdd",
             action: function ( e, dt, node, config ) {
                 //alert( 'Button activated' );
                 $("#userProfileAjaxForm").attr("action","/auth/security/userProfile");
                 $("#userProfileAjaxForm").attr("method","post");                 
                 $('#modal-userProfile').modal('show');
             }
         },
         {
             text: 'Reload',
             className: "btn btn-xs btn-primary",
             action: function ( e, dt, node, config ) {            	   
                 dt.ajax.reload();
             }
         }            
     ]
});

//表單以 Ajax 方式執行 CRUD 
$("#userProfileAjaxForm").submit(function(event){	
    event.preventDefault(); //prevent default action
    var post_url = $(this).attr("action"); //get form action url
    var request_method = $(this).attr("method"); //get form GET/POST method
    noteValue = CKEDITOR.instances['userProfileAjaxNote'].getData();
    $('#userProfileAjaxForm textarea[name="note"] ').val(noteValue);
    var form_data = JSON.stringify( $(this).serializeObject() ); //$(this).serialize(); //Encode form elements for submission
   
    $.ajax({
        url : post_url,
        type: request_method,
        contentType: "application/json; charset=utf-8",
        data : form_data,
        headers:jwtClient.setAuthorizationTokenHeader(),
		success:function(data, textStatus, jqXHR){//返回json结果			
			$('#tblUserProfile').DataTable().ajax.reload();
			$('#modal-userProfile').modal('toggle');
			
		},
		complete: function(jqXHR, textStatus) {
		    switch (jqXHR.status) {
		        case 200:
		        	$.alert({
	                    title: 'Congratulations!',
	                    content: 'Manipulation succeeded',
	                    type: 'green'                    
	                });
		            break;
		        case 201:
		        	$.alert({
	                    title: 'Congratulations!',
	                    content: 'Created a new record',
	                    type: 'green'                    
	                });
		        	break;
		        case 404:
		        	$.alert({
		                  title: 'Alert!',
		                  content: 'This record is not found',
		                  icon: 'fa fa-warning',
		                  type: 'red'
		              });
		            break;
		        case 409:
		        	$.alert({
	                    title: 'Alert!',
	                    content: 'This record is conflict',
	                    icon: 'fa fa-warning',
	                    type: 'red'
	                });
		        	break;
		        default:
		        	$.alert({
	                    title: 'Alert!',
	                    content: 'Manipulation failed',
	                    icon: 'fa fa-warning',
	                    type: 'red'
	                });
		    }
		}
    })
});


$('#userProfileUsernameList').click(function(){
	$('#modal-userProfileUsernameList').modal('show');
});
$('#userProfileAjaxUsername').click(function(){
	$('#modal-userProfileUsernameList').modal('show');
});

$('#tblUserList').DataTable({
	language: {
        "url": "/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json"
    },
 	ajax: {
 		url:"/auth/security/users",dataSrc:"",
 		headers: jwtClient.setAuthorizationTokenHeader(),
 		async: false
	},
	//dom: 'lrBtip',
	columns: [
	      {
	    	data: "id", render: function(data, type, row, meta) {	    		
	            return '<a href="#" data-url=/auth/security/userProfile/'+data+' class="btn btn-xs bg-green btnSelect"><@spring.message "label.select" /></a>';
	       	}
		  },		
	 	  { data: "id"},
	 	  { data: "username"},
	      { data: "id", render: function(data, type, row, meta) {	    		
	            return row.firstname+" "+row.lastname;
	       	}
		  },
	      { data: "avatar" , render: function(data, type, row, meta) {	    		
	            return '<img  height="48" width="48" src=/auth/showphoto/AVATAR_FOLDER/'+data+' />';
	       	}
		  },

	],
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

$('#tblUserList tbody').on('click', '.btnSelect', function (){
	   
	var $row = $(this).closest('tr');
	var data =  $('#tblUserList').DataTable().row($row).data();
	var url = $(this).attr('data-url');
	
	//console.log('data', data);
	//console.log('Record ID is', data['id']);

	$('#userProfileAjaxForm input[name="userId"] ').val(data['id']);
	$('#userProfileAjaxForm input[name="username"] ').val(data['username']);
	
	$('#modal-userProfileUsernameList').modal('toggle');	

});

$('#tblUserProfile tbody').on('click', '.btnDTView', function (){
	   
	var $row = $(this).closest('tr');
	var data =  $('#tblUserProfile').DataTable().row($row).data();
	var url = $(this).attr('data-url');
	
	//console.log('data', data);
	//console.log('Record ID is', data['id']);
	
	$("#userProfileAjaxForm").attr("action",url);
	$("#userProfileAjaxForm").attr("method","put");
	
	$.each( data, function( key, value ) {		
		$('#userProfileAjaxForm input[name="'+key+'"] ').val(value);
		if (key=='note'){
			CKEDITOR.instances['userProfileAjaxNote'].setData(value);
		}
	});
	
	$('#modal-userProfile').modal('show');

});

<#if Request.progPermits?? && Request.progPermits["isDel"] >
$(document).on('click', '.btnDel', function () {         	          
    var url = $(this).attr('data-url');
    var isAjax = $(this).attr('data-ajax');
    
    $.confirm({
        title: '<@spring.message "modal.confirm.del.title"/>',
        content: '<@spring.message "modal.confirm.del.content"/>',
        type: 'red',
        icon: 'fa fa-warning',
        buttons: {
            cancel: {
                text: '<@spring.message "modal.button.cancel" />',                
                keys: ['esc'],
                action: function(){                	
                }
            },
            confirm: {
                text: '<@spring.message "modal.button.confirm" />',
                btnClass: 'btn-danger',
                keys: ['enter'],
                action: function(){
                	if (isAjax){
                		// 表單以 Ajax 方式執行 CRUD
               		    $.ajax({
               		        url : url,
               		        type: "delete",
               		        contentType: "application/json; charset=utf-8",
               		        headers:jwtClient.setAuthorizationTokenHeader(),
               				success:function(data, textStatus, jqXHR){//返回json结果			
               					$('#tblUserProfile').DataTable().ajax.reload();
               				},
               				complete: function(jqXHR, textStatus) {
               				    switch (jqXHR.status) {
               				        case 200:
               				        	$.alert({
               			                    title: 'Congratulations!',
               			                    content: 'Manipulation succeeded',
               			                    type: 'green'                    
               			                });
               				            break;
               				        default:
               				        	$.alert({
               			                    title: 'Alert!',
               			                    content: 'Manipulation failed',
               			                    icon: 'fa fa-warning',
               			                    type: 'red'
               			                });
               				    }
               				}
               		    });
                		
                	} else {
                		location.href = url;
                	}                	
                }
            }
        }
    });    
    
});
</#if>

</script>      