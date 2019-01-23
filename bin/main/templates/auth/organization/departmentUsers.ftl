All users in this department

<!-- Default box -->
  <div class="box box-danger">
    <div class="box-header">
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
          <i class="fa fa-minus"></i></button>
      </div>
    </div>
    <div class="box-body">
        <div id="departUsersGrid">			    
        </div>
        
    	
    </div><!-- /.box-body -->
  </div><!-- /.box -->
  
<script type="text/javascript">
$(document).ready(function () {

	// prepare the data 
	var dfsDeptUsers = [
    	{ name: 'id' },
        { name: 'name' },
        { name: 'nameEng' },			        
        { name: 'costCenter' },
        { name: 'userDetails' },
        { name: 'startDate', type: 'date' },
        { name: 'endDate', type: 'date' }
    ];
    var dsDepartUser = {                
            datatype: "json",
            datafields: dfsDeptUsers,
            //url: "/auth/org/departments",
        };
    var daDepartment = new $.jqx.dataAdapter(dfsDeptUsers);
    daDepartment.dataBind();

})
</script>