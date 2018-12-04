<#-- 單筆維護畫面 -->
<div class="modal fade" id="modal${tableId}" >
  <div class="modal-dialog modal-lg">
	<div class="modal-content">
	  <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		  <span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title"> ${springMacroRequestContext.getMessage("program.block.manipulate") } </h4>
	  </div>
	  <div class="modal-body">
		
		<#-- ajax-form id="userProfileAjaxForm" -->
		<form id="ajaxForm${tableId}" action="${crudAjaxUrl}" method="post">
		  
		  <div class="box box-info">
			<#-- /.box-header -->
			<div class="box-body">
				
					
				<#list formInputs as key , value>
					<#if key ?contains("hidden")>
						${value}
					</#if>
				</#list>
				
				<#assign i = 0>				
				<#list formInputs as key , value>
					<#if key ?contains("input") >
						<#assign i++ >
						<#if i%2==1>
							<div class="row">
							<#assign isClose=false>
						</#if>
							<div class="col-md-6"><div class="form-group">						
							${value}
							</div><#-- /.form-group --></div><#-- /.col -->
						<#if i%2==0>
							</div><#-- /.row -->
							<#assign isClose=true>
						</#if>
					</#if>
				</#list>
				<#if !isClose>
					</div><#-- /.row -->
				</#if>
				
				
				
				<#list formInputs as key , value>
					<#if key ?contains("textarea") >
							<div class="row"><div class="col-md-12"><div class="form-group">						
							${value}
							</div><#-- /.form-group --></div><#-- /.col --></div><#-- /.row -->
					</#if>
				</#list>

			  
			  <div class="row">
				  <div class="col-md-6">
					  <button type="submit" class="btn btn-primary btnAdd"> ${springMacroRequestContext.getMessage("label.submit")} </button>
					  <button type="reset" class="btn btn-danger"> ${springMacroRequestContext.getMessage("label.reset")} </button>
					  <button type="button" class="btn bg-yellow" data-dismiss="modal">${springMacroRequestContext.getMessage("label.close")} </button>
				  </div>          
			  </div> <#-- /.row -->
			</div><#-- /.box-body -->
		  </div><#-- /.box -->
		  </form> <#-- /.ajax-form  --> 
	  </div> <#-- /.modal-body -->
	</div>   <#-- /.modal-content -->
  </div>     <#-- /.modal-dialog -->
</div>       <#-- /.modal -->  


<#-- HTML for Datatable to show heander of table's column -->
<table id="${tableId}" class="table table-bordered table-striped" style="width:100%">
	<thead>
	<tr>
		<#list columns as column>
			<#list column as key , value>
				<#if key=='th'>
					<th>${value}</th>
				</#if>
			</#list>
		</#list>
		<#if isAjaxOptions!false>			
			<th>${ajaxOptions}</th>
		</#if>
	</tr>
	</thead>
</table>

<script>

CKEDITOR.replace('${tableId}note');

<#-- JS for  grid 顯示資料 -->
$('#${tableId}').DataTable({
	language: {
        'url': '/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json'
    },
 	ajax: {
 		url:'${dtAjaxUrl}',dataSrc:'',
 		headers: jwtClient.setAuthorizationTokenHeader()
	},
	columns: [
	      <#list columns as column>
	      	{
			<#list column as key , value>
				<#if key=='data' || key=='visible'>					
					'${key}':<#if value=='true' || value=='false' > ${value} <#else> '${value}' </#if>,
				</#if>
			</#list>
			},
		  </#list>

	      <#if isAjaxOptions!false>
		    { 'data': 'id', render: function(data, type, row, meta) {
	    		<#if progPermits?? && !progPermits.isEdit >
	    			<#assign isEditDisable = 'disabled="disabled" '>
	    		</#if>
	    		<#if progPermits?? && !progPermits.isDel >
					<#assign isDelDisable = 'disabled="disabled" '>				
				</#if>
				
	            return '<a href="#" data-ajaxUrl=${crudAjaxUrl}/'+data+' class="btn btn-xs btn-primary btn${tableId}Edit" ${isEditDisable!""}><i class="fa fa-pencil"></i>${springMacroRequestContext.getMessage("label.edit")}</a>  '+
	                   '<a href="#" data-ajaxUrl=${crudAjaxUrl}/'+data+' class="btn btn-xs btn-danger  btn${tableId}Del" ${isDelDisable!""}><i class="fa fa-trash-o"></i>${springMacroRequestContext.getMessage("label.delete")}</a>'
	       	}}
	      </#if>

	],
	dom: 'lrBtip',
	buttons: [
		{
		   text: 'Reload',
		   className: 'btn btn-xs btn-primary',
		   action: function ( e, dt, node, config ) {            	   
			   dt.ajax.reload();
		   }
		},
		{
			text: 'Add (Ajax)',
			className: "btn btn-xs btn-primary btnAdd",
			action: function ( e, dt, node, config ) {
			    $("#ajaxForm${tableId} input").val("");
			    CKEDITOR.instances['${tableId}note'].setData("");
				$("#ajaxForm${tableId}").attr("action","${crudAjaxUrl}");
				$("#ajaxForm${tableId}").attr("method","post");                 
				$('#modal${tableId}').modal('show');
		 	}
		}	       
	                   
	]	
});

<#-- 將資料由 datatable 的單一筆 row 截取到 Form 裡維護 -->
$('#${tableId} tbody').on('click', '.btn${tableId}Edit', function (){
	   
	var $row = $(this).closest('tr');
	var data =  $('#${tableId}').DataTable().row($row).data();
	var url = $(this).attr('data-ajaxUrl');
	
	console.log('data', data);
	console.log('Record ID is', data['id']);
	
	$("#ajaxForm${tableId}").attr("action",url);
	$("#ajaxForm${tableId}").attr("method","put");
	
	$.each( data, function( key, value ) {		
		$('#ajaxForm${tableId} input[name="'+key+'"] ').val(value);
		<#-- -->
		if (key=='note'){
			CKEDITOR.instances['${tableId}note'].setData(value);
		}
		 
	});
	
	$('#modal${tableId}').modal('show');

});


<#-- 表單以 Ajax 方式執行 CRU -->
$("#ajaxForm${tableId}").submit(function(event){	
    event.preventDefault(); <#-- prevent default action -->
    var post_url = $(this).attr("action"); <#-- get form action url -->
    var request_method = $(this).attr("method"); <#-- get form GET/POST method -->
    <#-- CKEDITOR 資料取得 -->
    noteValue = CKEDITOR.instances['${tableId}note'].getData();
    $('#ajaxForm${tableId} textarea[name="note"] ').val(noteValue);
    
    var form_data = JSON.stringify( $(this).serializeObject() ); <#-- Encode form elements for submission -->
   
    $.ajax({
        url : post_url,
        type: request_method,
        contentType: "application/json; charset=utf-8",
        data : form_data,
        headers:jwtClient.setAuthorizationTokenHeader(),
        <#-- 返回json结果	-->
		success:function(data, textStatus, jqXHR){
			$('#${tableId}').DataTable().ajax.reload();
			$('#modal${tableId}').modal('toggle');
			
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
<#-- 表單以 Ajax 方式執行D 刪除 -->
<#if progPermits?? && progPermits.isDel >
$(document).on('click', '.btn${tableId}Del', function () {         	          
    var url = $(this).attr('data-ajaxUrl');   
    
    $.confirm({
        title:   '${springMacroRequestContext.getMessage("modal.confirm.del.title")}',
        content: '${springMacroRequestContext.getMessage("modal.confirm.del.content")}',
        type: 'red',
        icon: 'fa fa-warning',
        buttons: {
            cancel: {
                text: '${springMacroRequestContext.getMessage("modal.button.cancel")}',                
                keys: ['esc'],
                action: function(){                	
                }
            },
            confirm: {
                text: '${springMacroRequestContext.getMessage("modal.button.confirm")}',
                btnClass: 'btn-danger',
                keys: ['enter'],
                action: function(){

           		    $.ajax({
           		        url : url,
           		        type: "delete",
           		        contentType: "application/json; charset=utf-8",               		        
           		        headers:jwtClient.setAuthorizationTokenHeader(),
           				success:function(data, textStatus, jqXHR){		
           					$('#${tableId}').DataTable().ajax.reload();
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
               	
                }
            }
        }
    });    
    
});
</#if>


</script>