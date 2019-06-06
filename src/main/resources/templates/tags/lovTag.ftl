
<div class="lovTag">
  <#-- bootstrap-modal v2.2.6 注意,與 ckeditor v4 衝突 -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/bootstrap-modal/css/bootstrap-modal.css">  
  <script src="/AdminLTE2/bower_components/bootstrap-modal/js/bootstrap-modalmanager.js"></script>
  <script src="/AdminLTE2/bower_components/bootstrap-modal/js/bootstrap-modal.js"></script>
<div class="form-group">
	<label for="id_${inputName}">${springMacroRequestContext.getMessage(inputLabel)}</label>
	<div class="input-group">
	<#-- 欄位不作提示 placeholder="${springMacroRequestContext.getMessage(inputLabel)}"-->
	<#if isVue!false>
		<#if VueDataName?has_content >
    		<input type="text" class="form-control" id="id_${inputName}" name="${inputName}" v-model="${VueDataName}.${inputName}" required readonly>
    	<#else>
    	    <input type="text" class="form-control" id="id_${inputName}" name="${inputName}" v-model="formData.${inputName}" required readonly> 
    	</#if> 
    <#else>
    	<input type="text" class="form-control" id="id_${inputName}"  name="${inputName}" required readonly>
    </#if>
        <span class="input-group-addon"><i class="fa fa-list" id="id_${inputName}_img" style="cursor: pointer;"></i></span>
    </div>
</div><!-- /.form-group -->

<div class="modal fade" id="modal${lovTableId}" tabindex="-1" data-backdrop="static" >
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">${springMacroRequestContext.getMessage("program.block.datatable")}</h4>
      </div>
      <div class="modal-body">

		<table id="${lovTableId}" class="table table-bordered table-striped" style="width:100%">
            <thead>
            <tr>
				<#if isSelect!false>			
					<th>${springMacroRequestContext.getMessage("label.select")}</th>
				</#if>             
				<#list columns as column>
					<#list column as key , value>
						<#if key=='th'>
							<th>${value}</th>
						</#if>
					</#list>
				</#list>
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


<script>
$(document).ready( function () {

	$('#id_${inputName}_img').click(function(){
		$('#modal${lovTableId}').modal('show');
	});
	$('#id_${inputName}').click(function(){
		$('#modal${lovTableId}').modal('show');
	});
	
	
	var dt_${lovTableId} = $('#${lovTableId}').DataTable({
		language: {
	        "url": "/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json"
	    },
	 	ajax: {
	 		url:'${dtAjaxUrl}',dataSrc:"",
	 		headers: jwtClient.setAuthorizationTokenHeader(),
	 		async: false
		},
		//dom: 'lrBtip',
		columns: [
			  <#if isSelect!false>
		      	{
			    	data: "id", render: function(data, type, row, meta) {	    		
			            return '<a href="#" data-url=${dtAjaxUrl}/'+data+' class="btn btn-xs bg-green btnSelect">${springMacroRequestContext.getMessage("label.select")}</a>';
			       	}
				 },
			  </#if>
		      <#list columns as column>
		      	{
				<#list column as key , value>
					<#if key=='data' || key=='visible'>					
						'${key}':<#if value=='true' || value=='false' > ${value} <#else> '${value}' </#if>,
					</#if>
					<#if key=='type' && value=='image'>
						render: function(data, type, row, meta) {
							if (data){
								return '<img height="48" width="48" class="direct-chat-img" src=/auth/showphoto/AVATAR_FOLDER/'+data+' />';
							} else {
								return '<img height="48" width="48" class="direct-chat-img" src=/auth/showphoto/AVATAR_FOLDER/noImage.jpg />';
							}
				            
				       	},
					</#if>
				    <#if key=='render'>
						render: function(data, type, row, meta) {	    		
				            return ${value};
				       	},
					</#if>
				</#list>
				},
			  </#list>
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
	
	$('#${lovTableId} tbody').on('click', '.btnSelect', function (){
		   
		var $row = $(this).closest('tr');
		var data =  $('#${lovTableId}').DataTable().row($row).data();
		var url = $(this).attr('data-url');
		
		//console.log('data', data);
		//console.log('Record ID is', data['id']);
		<#list returnValues as returnValue>	
			<#list returnValue as key , value>
				$('#${returnValue.targetId}').val(data['${returnValue.jsonKey}']);
				<#if VueElVar?has_content>
					<#if VueDataName?has_content >
				    	${VueElVar}.${VueDataName}.${returnValue.targetId} = data['${returnValue.jsonKey}'];
				    <#else>
						${VueElVar}.formData.${returnValue.targetId} = data['${returnValue.jsonKey}'];						
					</#if>
				</#if>
				<#if key=='type' && value=='image'>
					if (data['${returnValue.jsonKey}']){
						$('#${returnValue.targetId}').attr('src', '/auth/showphoto/${returnValue.imageType}/'+data['${returnValue.jsonKey}']);	
					} else {
						$('#${returnValue.targetId}').attr('src','/auth/showphoto/images/noImage.jpg');
					}	
				</#if>
			</#list>
		</#list>	
		$('#modal${lovTableId}').modal('toggle');	
	});

});
</script>
</div>