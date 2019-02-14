
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

<#include "/auth/organization/modalDepartment.ftl">

  
<script type="text/javascript">

$(document).ready(function () {

	// prepare the data 
	var dfsDepartment = [
    	{ name: 'id' },
        { name: 'name' },
        { name: 'nameEng' },			        
        { name: 'costCenter' },
        { name: 'userDetails' },
        { name: 'userDetailses' },
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
        var departments = event.args.row.departments;
        var dataSource = {
        		datatype: "json",
                datafields: dfsDepartment,
                localdata: departments,
            }
        var adapter = new $.jqx.dataAdapter(dataSource);    
        // update department data source.
        $("#departmentGrid").jqxGrid({ source: adapter });
        $('#departmentGrid').jqxGrid({ selectedrowindex: 0});            
        // 部門內沒有成員時, 清空 departUsersGrid 裡的資料
        if (departments.length==0){
        	 // update user data source.
            var dataSource = {
            		datatype: "json",
                    localdata: null,
                }
            var adapter = new $.jqx.dataAdapter(dataSource);    
            // update data source.
            $("#departUsersGrid").jqxGrid({ source: adapter });
        }
       
    });    
    
    $("#departmentGrid").jqxGrid({
    	width: '100%',
        height: '100%',
        sortable: true,
        //editmode: 'selectedrow',
        altRows: true,
        showtoolbar: true,                
        rendertoolbar: function (toolbar) {
        	var container = $("<div style='margin: 5px;'></div>");
            toolbar.append(container);
            container.append('<input id="btnAddDept" style="margin-left: 5px;" class="btn btn-xs btn-primary" type="button" value="Add" />');
            container.append('<input id="btnEditDept" style="margin-left: 5px;" class="btn btn-xs btn-primary" type="button" value="Edit" />');
            container.append('<input id="btnDelDept" style="margin-left: 5px;" class="btn btn-xs btn-danger" type="button" value="Del" />');
        },
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
        		text: '<@spring.message "program.departmentController.departmentNameEng" />', datafield: 'nameEng'
        	},
        	{
        		text: '<@spring.message "program.common.costCenter" />', datafield: 'costCenter'
        	},
        	{
        		text: '<@spring.message "program.departmentController.departmentManager" />', datafield: 'userDetails',
        		width: 100, sortable: false,cellsalign: 'center',
        		cellsRenderer: function (rowid, column, value) {
        			var manager = value;
        			var authUser = value['authUser'];
        			if (manager){        				
        				return authUser.username+"[" +manager.userId+"]";
        			}      			
        		}
        	},
        	{ text: '<@spring.message "program.common.startDate" />', datafield: 'startDate' , cellsformat: 'yyyy/MM/dd', columntype: 'datetimeinput',
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
    
    $('#btnAddDept').click(function () {
    	var rowidCompany = $('#companyGrid').jqxGrid('getselectedrowindex');
    	var rowdataCompany = $("#companyGrid").jqxGrid('getrowdata', rowidCompany);
    	
    	//getselectedrowindex
    	var rowidDept = $('#departmentGrid').jqxGrid('getselectedrowindex');
    	// get current row data
    	var rowdataDept = $("#departmentGrid").jqxGrid('getrowdata', rowidDept);
    	
    	if (rowdataCompany){
    		$("#companyTitle").html(rowdataCompany.name);
    		$('#modalDepartment').modal('show');
    		
    	} else {
    		$.alert({
	            title: 'Alert',
	            content: "請先選擇公司",
	        });
    	}
    	
    });
    
    
    $('#btnEditDept').click(function () {
    	var rowidCompany = $('#companyGrid').jqxGrid('getselectedrowindex');
    	var rowdataCompany = $("#companyGrid").jqxGrid('getrowdata', rowidCompany);
    	console.log(rowdataCompany);
    	//getselectedrowindex
    	var rowidDept = $('#departmentGrid').jqxGrid('getselectedrowindex');
    	// get current row data
    	var rowdataDept = $("#departmentGrid").jqxGrid('getrowdata', rowidDept);
    	
    	console.log(rowdataDept);
    });
    
})
</script>