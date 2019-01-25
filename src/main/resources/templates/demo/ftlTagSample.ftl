  <div class="row">
    <div class="col-md-4">
      <!-- Widget: user widget style 1 -->
      <div class="box box-widget widget-user-2">
        <!-- Add the bg color to the header using any of the bg-* classes -->
        <div class="widget-user-header bg-yellow">
          <div class="widget-user-image">
            <img class="img-circle" src="/auth/showphoto/AVATAR_FOLDER/${Avatar}" alt="User Avatar" />
          </div>
          <!-- /.widget-user-image -->
          <h3 class="widget-user-username">${userName}</h3>
          <h5 class="widget-user-desc">${userTitle}</h5>
        </div>
        <div class="box-footer no-padding">
          <ul class="nav nav-stacked">
            <li><a href="#">Projects <span class="pull-right badge bg-blue">31</span></a></li>
            <li><a href="#">Tasks <span class="pull-right badge bg-aqua">5</span></a></li>
            <li><a href="#">Completed Projects <span class="pull-right badge bg-green">12</span></a></li>
            <li><a href="#">Followers <span class="pull-right badge bg-red">842</span></a></li>
          </ul>
        </div>
      </div>
      <!-- /.widget-user -->
    </div>
    <!-- /.col -->
  </div>

<table id="tblUserList" class="table table-bordered table-striped" style="width:100%">
	<thead>
	<tr>
		<#list columns as key, value>
			<th>${value}</th>    	
		</#list>
	</tr>
	</thead>
</table>

<script>
$('#tblUserList').DataTable({
	language: {
        "url": "/AdminLTE2/bower_components/datatables.net/i18n/${.locale}.json"
    },
 	ajax: {
 		url:"/auth/security/users",dataSrc:"",
 		headers: jwtClient.setAuthorizationTokenHeader(),
 		async: false
	},
	columns: [
	      {
	    	data: "id", render: function(data, type, row, meta) {	    		
	            return '<a href="#" data-url=/auth/security/userProfile/'+data+' class="btn btn-xs bg-green btnSelect"> ${columns.select}</a>';
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
	dom: 'lrBtip',
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
</script>