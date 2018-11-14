
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
programName:${progPermits.programName}
<script>
$('#${tableId}').DataTable({
	language: {
        'url': '/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json'
    },
 	ajax: {
 		url:'${ajaxUrl}',dataSrc:'',
 		headers: jwtClient.setAuthorizationTokenHeader()
	},
	columns: [
	      <#list columns as column>
	      	{
			<#list column as key , value>
				<#if key!='th'>					
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
				
	            return '<a href="#" data-url=/auth/security/userProfile/'+data+' class="btn btn-xs btn-primary btnDTView btn${tableId}Edit" ${isEditDisable!""}><i class="fa fa-pencil"></i>Edit</a>'+
	                   '<a href="#" data-url=/auth/security/userProfile/'+data+' data-ajax="true" class="btn btn-xs btn-danger btn${tableId}Del" ${isDelDisable!""}><i class="fa fa-trash-o"></i>Delete</a>'
	       	}}
	      </#if>

	],
	buttons: [
	       {
	           text: 'Reload',
	           className: 'btn btn-xs btn-primary',
	           action: function ( e, dt, node, config ) {            	   
	               dt.ajax.reload();
	           }
	       }            
	   ]	
});
</script>