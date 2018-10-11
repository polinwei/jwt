<#include "/layout/AdminLTE2/html-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">

isAdd:${Request.progPermits["isAdd"]?c!""}

<!-- form id="authorityForm" -->
	<form id="authorityForm" action="/auth/security/authorityEdit" method="post" >
      <input type="hidden" id="authorityId" name="id" value='${authority.id!""}' >
      <div class="box box-danger">
        <div class="box-header with-border">
          <h3 class="box-title"><@spring.message "program.block.manipulate" /></h3>

          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
          </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="authorityName"><@spring.message "program.authorityController.name" /></label>
                <input type="text" class="form-control" id="authorityName" placeholder="<@spring.message "program.authorityController.name" />" name="name" value='${authority.name!""}' required>
                <#if authority??>  
                	<@spring.bind "authority.name" />
    				<@spring.showErrors "<br />" "bg-red"/>
                </#if>                
              </div>
              <!-- /.form-group -->
              <div class="form-group">                
                <label for="authorityDescription"><@spring.message "program.authorityController.description" /></label>
                <input type="text" class="form-control" id="authorityDescription" placeholder="<@spring.message "program.authorityController.description" />" name="description" value='${authority.description!""}' required>
                <#if authority??>  
                	<@spring.bind "authority.description" />
    				<@spring.showErrors "<br />" "bg-red"/>
                </#if>
              </div>
              <!-- /.form-group -->
            </div><!-- /.col -->
            
          </div><!-- /.row -->
          <div class="row">
		      <div class="col-xs-6">
		          <button type="submit" class="btn btn-primary btnAdd"><@spring.message "label.submit"/></button>
		      </div>          
          </div> <!-- /.row -->
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
          Visit <a href="/security/authority">Authority</a>
        </div>
      </div>
      <!-- /.box -->
      </form>
<!-- /.form id="authorityForm" -->

      <!-- Default box -->
      <div class="box box-info">
        <div class="box-header">
          <h3 class="box-title"><@spring.message "program.block.datatable" /></h3>

          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                    title="Collapse">
              <i class="fa fa-minus"></i></button>
            <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
              <i class="fa fa-times"></i></button>
          </div>
        </div>
        <div class="box-body">
         
          <table id="tblAuthority" class="table table-bordered table-striped" style="width:100%">
            <thead>
            <tr>
              <th>id</th>
              <th><@spring.message "program.authorityController.name" /></th>
              <th><@spring.message "program.authorityController.description" /></th>
              <th>Submit Options</th>
              <th>Ajax Options</th>
            </tr>
            </thead>
            
            <tfoot>
            <tr>
              <th>id</th>
              <th><@spring.message "program.authorityController.name" /></th>
              <th><@spring.message "program.authorityController.description" /></th>
              <th>Submit Options</th>
            </tr>
            </tfoot>
          </table>
                                             
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
          Footer
        </div>
        <!-- /.box-footer-->
      </div>
      <!-- /.box -->

        <div class="modal fade" id="modal-authority" tabindex="-1">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"><@spring.message "program.block.manipulate" /></h4>
              </div>
              <div class="modal-body">
                
				<!-- ajax-form id="authorityAjaxForm" -->
				<form id="authorityAjaxForm" action="/auth/authentication/authority" method="post">
			      
			      <div class="box box-danger">
			        <!-- /.box-header -->
			        <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="authorityName"><@spring.message "program.authorityController.name" /></label>
			                <input type="text" class="form-control" id="authorityAjaxName" placeholder="<@spring.message "program.authorityController.name" />" name="name" required>             
			              </div>
			              <!-- /.form-group -->
			              <div class="form-group">                
			                <label for="authorityDescription"><@spring.message "program.authorityController.description" /></label>
			                <input type="text" class="form-control" id="authorityAjaxDescription" placeholder="<@spring.message "program.authorityController.description" />" name="description" required>
			              </div>
			              <!-- /.form-group -->
			            </div><!-- /.col -->
			            
			          </div><!-- /.row -->
			          <div class="row">
					      <div class="col-xs-6">
					          <button type="submit" class="btn btn-primary btnAdd"><@spring.message "label.submit"/></button>
					          <button type="reset" class="btn btn-danger"><@spring.message "label.reset"/></button>
					          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					      </div>          
			          </div> <!-- /.row -->
			        </div><!-- /.box-body -->
			      </div><!-- /.box -->
			      </form>
				<!-- /.ajax-form id="authorityAjaxForm" --> 
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->


<!-- page script -->
<script>

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
               		        headers:{"Authorization": "Bearer " + localStorage.getItem("jwtToken") },
               				success:function(data, textStatus, jqXHR){//返回json结果			
               					$('#tblAuthority').DataTable().ajax.reload();
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

$('#tblAuthority').DataTable({
	language: {
        "url": "/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json"
    },
 	ajax: {url:"/auth/authentication/authorities",dataSrc:"",
  		'beforeSend': function (request) {
			        request.setRequestHeader("Authorization", "Bearer "+localStorage.getItem("jwtToken") );
			    }
		},
 	columns: [
 		{ data: "id", visible: false},
      { data: "name" },
      { data: "description" },
      {
        data: "id", render: function(data, type, row, meta) {                  
               return '<a href=/auth/security/authorityEdit/'+data+' class="btn btn-xs btn-primary btnEdit"><i class="fa fa-pencil"></i>Edit</a>'<@security.authorize access="hasRole('ADMIN')">+
               		  '<a href="#" data-url=/auth/security/authorityDelete/'+data+' class="btn btn-xs btn-danger btnDel"><i class="fa fa-trash-o"></i>Delete</a>' </@security.authorize>                		
        },
           className: "center",              
      },
      {
    	data: "id", render: function(data, type, row, meta) {                  
              return '<a href="#" data-url=/auth/authentication/authority/'+data+' class="btn btn-xs btn-primary btnDTView btnEdit"><i class="fa fa-pencil"></i>Edit</a>'<@security.authorize access="hasRole('ADMIN')">+
              		 '<a href="#" data-url=/auth/authentication/authority/'+data+' data-ajax="true" class="btn btn-xs btn-danger btnDel"><i class="fa fa-trash-o"></i>Delete</a>' </@security.authorize>
       	}  
      }],
  dom: 'lrBtip',        
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
         <@security.authorize access="hasRole('ADMIN')">
         {
             text: 'Add Role (Ajax)',
             className: "btn btn-xs btn-primary btnAdd",
             action: function ( e, dt, node, config ) {
                 //alert( 'Button activated' );
                 $("#authorityAjaxForm").attr("action","/auth/authentication/authority");
                 $("#authorityAjaxForm").attr("method","post");
                 $('#modal-authority').modal('show');
             }
         },
         </@security.authorize>
         {
             text: 'Reload',
             className: "btn btn-xs btn-primary",
             action: function ( e, dt, node, config ) {            	   
                 dt.ajax.reload();
             }
         }            
     ]
});	  

// 表單以 Ajax 方式執行 CRUD 
$("#authorityAjaxForm").submit(function(event){	
    event.preventDefault(); //prevent default action
    var post_url = $(this).attr("action"); //get form action url
    var request_method = $(this).attr("method"); //get form GET/POST method
    var form_data = JSON.stringify( $(this).serializeObject() ); //$(this).serialize(); //Encode form elements for submission
   
    $.ajax({
        url : post_url,
        type: request_method,
        contentType: "application/json; charset=utf-8",
        data : form_data,
        headers:{"Authorization": "Bearer " + localStorage.getItem("jwtToken") },
		success:function(data, textStatus, jqXHR){//返回json结果			
			$('#tblAuthority').DataTable().ajax.reload();
			$('#modal-authority').modal('toggle');
			
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
	                    content: 'Created A New Role',
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
	                    content: 'This record is conflct',
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

$('#tblAuthority tbody').on('click', '.btnDTView', function (){
	   
	   var $row = $(this).closest('tr');
	   var data =  $('#tblAuthority').DataTable().row($row).data();
	   var url = $(this).attr('data-url');

	   console.log('data', data);
	   console.log('Record ID is', data['id']);

	   $("#authorityAjaxForm").attr("action",url);
	   $("#authorityAjaxForm").attr("method","put");
	   $("#authorityAjaxName").val(data.name);
	   $("#authorityAjaxDescription").val(data.description);
	   $('#modal-authority').modal('show');

});

</script>

<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">