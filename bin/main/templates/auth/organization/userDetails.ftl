
<!-- Default box -->
  <div class="box box-danger">
    <div class="box-header">
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
          <i class="fa fa-minus"></i></button>
      </div>
    </div>
    <div class="box-body">
        <div id="companyUsersGrid">			    
        </div>
    </div><!-- /.box-body -->
  </div><!-- /.box -->
  
<script type="text/javascript">
$(document).ready(function () {

	// prepare the data 
	var dfsCompanyUsers = [
    	{ name: 'id' },
    	{ name: 'userByUserId' },	
    	{ name: 'empNo' },
        { name: 'jobTitle' },    
        { name: 'hireDate', type: 'date' },
        { name: 'resignationDate', type: 'date' }
    ];
    var dsCompnayUsers = {                
            datatype: "json",
            datafields: dfsCompanyUsers,
            //url: "/auth/org/departments",
        };
    var daCompanyUsers = new $.jqx.dataAdapter(dfsCompanyUsers);
    daCompanyUsers.dataBind();

	$("#companyGrid").on('rowselect', function (event) {
    	
       	var companyId = event.args.row.id;        
        var CompanyUsers = event.args.row.userDetailses;
        var dataSource = {
        		datatype: "json",
                datafields: dfsCompanyUsers,
                localdata: CompanyUsers,
            }
        var adapter = new $.jqx.dataAdapter(dataSource);    
        // update department data source.
        $("#companyUsersGrid").jqxGrid({ source: adapter });
        $('#companyUsersGrid').jqxGrid({ selectedrowindex: 0}); 
       
    });
	
	$("#companyUsersGrid").jqxGrid({
    	width: '100%',
        height: '100%',        
        editmode: 'selectedrow',
        altRows: true,
        pageable: true,
        columns: [
        	{ text: 'id', datafield: 'id' , hidden: true },
        	{ text: '<@spring.message "program.userDetailsController.empNo" />', datafield: 'empNo' },
        	{ text: '<@spring.message "label.username" />', datafield: 'userName', 
        		cellsRenderer: function (rowid, column, value) {   
        			// get current row data
					var datarow = $("#companyUsersGrid").jqxGrid('getrowdata', rowid);
        			var User = datarow.userByUserId;
        			return User.username;
        		} 
        	},
        	{ text: '<@spring.message "program.userDetailsController.fullName" />', datafield: 'fullName', 
        		cellsRenderer: function (rowid, column, value) {
        			// get current row data
					var datarow = $("#companyUsersGrid").jqxGrid('getrowdata', rowid);
        			var User = datarow.userByUserId;
        			return User.firstname + " "+ User.lastname;
        		} 
        	},
        	{ text: '<@spring.message "program.userDetailsController.jobTitle" />', datafield: 'jobTitle' , cellsformat: 'yyyy/MM/dd', columntype: 'datetimeinput'},
        	{ text: '<@spring.message "program.userDetailsController.hireDate" />', datafield: 'hireDate' , cellsformat: 'yyyy/MM/dd', columntype: 'datetimeinput'},
        	{ text: '<@spring.message "program.userDetailsController.resignationDate" />', datafield: 'resignationDate' , cellsformat: 'yyyy/MM/dd', columntype: 'datetimeinput'},
        	{ text: '<@spring.message "program.common.avatar" />', datafield: 'avatar', 
        		cellsRenderer: function (rowid, column, value) {
        			// get current row data
					var datarow = $("#companyUsersGrid").jqxGrid('getrowdata', rowid);
        			var User = datarow.userByUserId;        			
        			return '<img style="margin: 3px;" src=/auth/showphoto/AVATAR_FOLDER/'+User.avatar+' alt="User Avatar" />';
        		} 
        	},
        ]<#-- ./columns -->
    });

})
</script>