
  <#-- bootstrap-modal v2.2.6 注意,與 ckeditor v4 衝突-->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/bootstrap-modal/css/bootstrap-modal.css">  
  <script src="/AdminLTE2/bower_components/bootstrap-modal/js/bootstrap-modalmanager.js"></script>
  <script src="/AdminLTE2/bower_components/bootstrap-modal/js/bootstrap-modal.js"></script>
  
<div class="form-group">
	<label for="userProfileAjaxUsername">${springMacroRequestContext.getMessage(inputLabel)}</label>
	<div class="input-group">
    <input type="text" class="form-control" id="id_${inputName}" placeholder="${springMacroRequestContext.getMessage(inputLabel)}" name="${inputName}" required readonly>
        <span class="input-group-addon"><i class="fa fa-list" id="id_${inputName}_img" style="cursor: pointer;"></i></span>
    </div>
</div><!-- /.form-group -->

<div class="modal fade" id="modal${lovTableId}">
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
              <th>${springMacroRequestContext.getMessage("label.select")}</th>
              <th>id</th>
              <th>${springMacroRequestContext.getMessage("label.username")}</th>
              <th>${springMacroRequestContext.getMessage("program.userController.fullName")}</th>
              <th>${springMacroRequestContext.getMessage("program.common.avatar")}</th>
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
$('#id_${inputName}_img').click(function(){
	$('#modal${lovTableId}').modal('show');
});
$('#id_${inputName}').click(function(){
	$('#modal${lovTableId}').modal('show');
});


$('#${lovTableId}').DataTable({
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
	            return '<a href="#" data-url=/auth/security/userProfile/'+data+' class="btn btn-xs bg-green btnSelect">${springMacroRequestContext.getMessage("label.select")}</a>';
	       	}
		  },		
	 	  { data: "id"},
	 	  { data: "username"},
	      { data: "id", render: function(data, type, row, meta) {	    		
	            return row.firstname+" "+row.lastname;
	       	}
		  },
	      { data: "avatar" , render: function(data, type, row, meta) {	    		
	            return '<img src=/auth/showphoto/AVATAR_FOLDER/'+data+' />';
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

</script> 