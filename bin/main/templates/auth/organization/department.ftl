
<!-- Default box -->
  <div class="box box-danger">
    <div class="box-header">
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
          <i class="fa fa-minus"></i></button>
      </div>
    </div>
    <div class="box-body">
        <div id="departmentGrid">			    
        </div>
        
    	
    </div><!-- /.box-body -->
  </div><!-- /.box -->

  
<script type="text/javascript">


$(document).ready(function () {

	// prepare the data 
	var dfsDepartment = [
    	{ name: 'id' },
        { name: 'name' },
        { name: 'nameEng' },			        
        { name: 'costCenter' },
        { name: 'userDetails' },
        { name: 'startDate', type: 'date' },
        { name: 'endDate', type: 'date' }
    ];
    var dsDepartment = {                
            datatype: "json",
            datafields: dfsDepartment,
            //url: "/auth/org/departments",
        };
    var daDepartment = new $.jqx.dataAdapter(dsDepartment);
    daDepartment.dataBind();

    $("#companyGrid").on('rowselect', function (event) {    	
        var companyId = event.args.row.id;
        if (companyId){
            var departments = event.args.row.departments;        
            var dataSource = {
            		datatype: "json",
                    datafields: dfsDepartment,
                    localdata: departments,
                    sortcolumn: 'id',
                    sortdirection: 'asc'
                }
            var adapter = new $.jqx.dataAdapter(dataSource);    
            // update data source.
            $("#departmentGrid").jqxGrid({ source: adapter });
        }
    });    
    
    $("#departmentGrid").jqxGrid({
    	width: '100%',
        height: '100%',
        //source: daDepartment,
        editable: true,
        editmode: 'selectedrow',
        altRows: true,
        columns: [
        	{ text: 'id', datafield: 'id' , hidden: true },
        	{
        		text: '<@spring.message "program.departmentController.departmentName" />', datafield: 'name',
            	validation: function (cell, value) {
            		if ( !value || value =="") {
          			  return { result: false, message: "Department name cannot be empty" };
					}
            		return true;
            	}
        	},
        	{
        		text: '<@spring.message "program.companyController.companyNameEng" />', datafield: 'nameEng'
        	},
        	{
        		text: '<@spring.message "program.common.costCenter" />', datafield: 'costCenter'
        	},
        	{
        		text: 'manager_id', datafield: 'userDetails',
        		cellsRenderer: function (rowid, column, value) {
        			var manager = value;
        			if (manager){
        				console.log(manager);
        				return manager.empNo;
        			}      			
        		}
        	},
        	{ text: '<@spring.message "program.common.createDate" />', datafield: 'startDate' , cellsformat: 'yyyy/MM/dd', columntype: 'datetimeinput',
            	validation: function (cell, value) {
            		if ( !value || value =="") {
            			  return { result: false, message: "Start Date cannot be empty" };
					}
              		return true;
            	  },
                  initeditor: function (row, cellvalue, editor) {	                	  
                	  if(!cellvalue || cellvalue=="") {
                		  editor.jqxDateTimeInput('setDate', new Date("1973/01/01")); 
                	  }
                  }
              },
              { text: '<@spring.message "program.common.endDate" />', datafield: 'endDate' , cellsformat: 'yyyy/MM/dd', columntype: 'datetimeinput' ,
				validation: function (cell, value) {						
					// get current row data
					var datarow = $("#departmentGrid").jqxGrid('getrowdata', cell.row);						
					
					if ( !value || value =="")
					 return true;						

					if (value <= datarow.startDate) {
					  return { result: false, message: "Start Date should be before End Date" };
					}
					return true;
				}
              },
        	
		] <#-- ./columns -->
    });
    
	
})

</script>