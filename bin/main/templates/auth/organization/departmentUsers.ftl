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
    	{ name: 'empNo' },
        { name: 'jobTitle' },        		        
        { name: 'userByUserId' },
        { name: 'hireDate', type: 'date' },
        { name: 'resignationDate', type: 'date' }
    ];
    var dsDeptUsers = {                
            datatype: "json",
            datafields: dfsDeptUsers,
            //url: "/auth/org/departments",
        };
    var daDeptUsers = new $.jqx.dataAdapter(dfsDeptUsers);
    daDeptUsers.dataBind();
    
    $("#departmentGrid").on('rowselect', function (event) {
        if (event.args.row){
            var users = event.args.row.userDetailses;            
            var dataSource = {
            		datatype: "json",
                    datafields: dfsDeptUsers,
                    localdata: users,
                    sortcolumn: 'id',
                    sortdirection: 'asc'
                }
            var adapter = new $.jqx.dataAdapter(dataSource);    
            // update data source.
            $("#departUsersGrid").jqxGrid({ source: adapter });
        }
    });    
    
    
    $("#departUsersGrid").jqxGrid({
    	width: '100%',
        height: '100%',        
        editmode: 'selectedrow',
        altRows: true,
        pageable: true,
        columns: [
        	{ text: 'id', datafield: 'id' , hidden: true },
        	{ text: '<@spring.message "program.userDetailsController.empNo" />', datafield: 'empNo' },
        	{ text: '<@spring.message "label.username" />', datafield: 'userByUserId', 
        		cellsRenderer: function (rowid, column, value) {   
        			var User = value;
        			return User.username;
        		} 
        	}
        ]<#-- ./columns -->
    });

})
</script>