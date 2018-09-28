<#include "/layout/AdminLTE2/html-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">

<!-- form id="authorityForm" -->
	<form id="authorityForm" action="/security/authorityEdit" method="post" >
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
                <label for="authorityName"><@spring.message "program.authority.name" /></label>
                <input type="text" class="form-control" id="authorityName" placeholder="<@spring.message "program.authority.name" />" name="name" value='${authority.name!""}' required>
                <#if authority??>  
                	<@spring.bind "authority.name" />
    				<@spring.showErrors "<br />" "bg-red"/>
                </#if>                
              </div>
              <!-- /.form-group -->
              <div class="form-group">                
                <label for="authorityDescription"><@spring.message "program.authority.description" /></label>
                <input type="text" class="form-control" id="authorityDescription" placeholder="<@spring.message "program.authority.description" />" name="description" value='${authority.description!""}' required>
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
		          <button id="btn-login" type="submit" class="btn btn-alert "><@spring.message "label.submit"/></button>
		      </div>          
          </div> <!-- /.row -->
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
          Visit <a href="/security/authority">Authority</a>
        </div>
      </div>
      <!-- /.box -->
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
              <th><@spring.message "program.authority.name" /></th>
              <th><@spring.message "program.authority.description" /></th>
              <th>Submit Options</th>
            </tr>
            </thead>
            
            <tfoot>
            <tr>
              <th>id</th>
              <th><@spring.message "program.authority.name" /></th>
              <th><@spring.message "program.authority.description" /></th>
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

<!-- page script -->
<script>
function deleteClick (obj) {
    var url = $(obj).attr('data-url');    
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
                	location.href = url;
                }
            }
        }
    });
}
	
$('#tblAuthority').DataTable({    	
 	ajax: {url:"/authentication/authorities",dataSrc:"",
  		'beforeSend': function (request) {
			        request.setRequestHeader("Authorization", "Bearer "+localStorage.getItem("jwtToken"));
			    }
		},
 	columns: [
 		{ data: "id", visible: false},
      { data: "name" },
      { data: "description" },
      {
        data: "id", render: function(data, type, row, meta) {                  
               return '<a href=/security/authorityEdit/'+data+' class="btn btn-xs btn-primary"><i class="fa fa-pencil"></i>Edit</a>'+
               		  '<a href="#" '+'data-url=/security/authorityDelete/'+data+' class="btn btn-xs btn-danger" onclick="deleteClick(this)"><i class="fa fa-trash-o">Delete</a>'                 		
        },
           className: "center",              
      }],
  dom: 'lrBtip',        
  buttons: [
     	'copy','excel', 
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
             text: 'My button',
             className: "btn btn-xs btn-primary",
             action: function ( e, dt, node, config ) {
                 alert( 'Button activated' );
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


</script>

<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">