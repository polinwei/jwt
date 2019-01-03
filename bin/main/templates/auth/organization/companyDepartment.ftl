
  <!-- Default box -->
  <div class="box box-danger">
    <div class="box-header">
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
          <i class="fa fa-minus"></i></button>
      </div>
    </div>
    <div class="box-body">
	    <div id='jqxWidgetCompanyDepartment' >
        <@spring.message "program.companyController.programName" />
        <div id="companyGrid"></div>
        <@spring.message "program.departmentController.programName" />
        <div id="departmentGrid"></div>
    	</div>
    </div><!-- /.box-body -->
  </div><!-- /.box -->
  
<script type="text/javascript">
$(document).ready(function () {
            // prepare the data
            
            var source = {                
                datatype: "json",
                datafields: [
                	{ name: 'id' },
			        { name: 'code' },
			        { name: 'name' },			        
			        { name: 'superintendent' },
			        { name: 'address' },
			        { name: 'startDate', type: 'date' },
			        { name: 'endDate', type: 'date' }
			    ],
                url: "/auth/org/companies",
                updaterow: function (rowid, rowdata, commit) {
                    // synchronize with the server - send insert command                    
                    if (rowdata.id!=""){
                    	var post_url = '/auth/org/company/'+rowdata.id;
                    	var request_method = 'put';
                    } else {
                    	var post_url = '/auth/org/company';
                    	var request_method = 'post';
                    }
                    
                    if (rowdata!="") {
                    	$.ajax({
                            cache: false,
                            contentType: "application/json; charset=utf-8",
                            url: post_url ,
                            data: JSON.stringify(rowdata),
                            type: request_method,                            
                            headers:jwtClient.setAuthorizationTokenHeader(),
                            success: function (data, status, xhr) {
                                // insert command is executed.
                                $.alert({
	           			                    title: 'Congratulations!',
	           			                    content: 'Manipulation succeeded',
	           			                    type: 'green'                    
	           			                });
								commit(true);
								// Reload
			                	$("#companyGrid").jqxGrid('updatebounddata');
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                            	$.alert({
       			                    title: 'Alert!',
       			                    content: 'Manipulation failed',
       			                    icon: 'fa fa-warning',
       			                    type: 'red'
       			                }); 
                                //commit(false); // 輸入的資料不要清除
                            }
                        });
                    }
                },
                deleterow: function(rowid, commit) {
                	// get current row data
					var rowdata = $("#companyGrid").jqxGrid('getrowdata', rowid);
                	
					$.confirm({
				        title: '<@spring.message "modal.confirm.del.title"/>',
				        content: '<@spring.message "modal.confirm.del.content"/>',
				        type: 'red',
				        icon: 'fa fa-warning',
				        buttons: {
				            cancel: {
				                text: '<@spring.message "modal.button.cancel" />',                
				                keys: ['esc'],
				                action: function(){
				                	// Reload
				                	$("#companyGrid").jqxGrid('updatebounddata');
				                }
				            },
				            confirm: {
				                text: '<@spring.message "modal.button.confirm" />',
				                btnClass: 'btn-danger',
				                keys: ['enter'],
				                action: function(){
				                	if (rowdata.id!="") {
				                    	$.ajax({
				                            cache: false,
				                            contentType: "application/json; charset=utf-8",
				                            url: '/auth/org/company/'+ rowdata.id,                            
				                            type: 'delete',                            
				                            headers:jwtClient.setAuthorizationTokenHeader(),
				                            success: function (data, status, xhr) {
				                                // delete command is executed.                                
												commit(true);
												// Reload
							                	$("#companyGrid").jqxGrid('updatebounddata');
				                            },
				                            error: function (jqXHR, textStatus, errorThrown) {
				                            	$.alert({
				       			                    title: 'Alert!',
				       			                    content: 'Manipulation failed',
				       			                    icon: 'fa fa-warning',
				       			                    type: 'red'
				       			                });
				                                commit(false);
				                            }
				                        });				                    	
				                	} else {
  				                   		// Reload
			                            $("#companyGrid").jqxGrid('updatebounddata');
  				                    }
				                }
				            }
				        }
				    }); <!--./delete confirm -->
                }
                
            };
            var dataAdapter = new $.jqx.dataAdapter(source, {
                loadComplete: function (data) { },
                loadError: function (xhr, status, error) { }      
            });
            $("#companyGrid").jqxGrid(
            {
            	width: '100%',
                height: '100%',
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                editmode: 'selectedrow',
                altrows: true,
                showtoolbar: true,                
                rendertoolbar: function (toolbar) {
                	var container = $("<div style='margin: 5px;'></div>");
                    toolbar.append(container);
                    container.append('<input id="btnReloadCompany" style="margin-left: 5px;" class="btn btn-xs btn-primary" type="button" value="Reload" />');
                    container.append('<input id="btnAddCompany" style="margin-left: 5px;" class="btn btn-xs btn-primary" type="button" value="Add" />');
                    container.append('<input id="btnDelCompany" style="margin-left: 5px;" class="btn btn-xs btn-danger" type="button" value="Del" />');
                    
                    // Reload
                    $("#btnReloadCompany").on('click', function () {
                        $("#companyGrid").jqxGrid('updatebounddata');
                    });
                    // create new row.
			        $("#btnAddCompany").bind('click', function () {
			            var rowscount = $("#companyGrid").jqxGrid('getdatainformation').rowscount;			           
			            var commit = $("#companyGrid").jqxGrid('addrow', null, {});
			            //$("#companyGrid").jqxGrid('beginrowedit', rowscount);
			        });
			        // update row.
			        $("#btnEditCompany").bind('click', function () {
			        	
                        var selectedrowindex = $("#companyGrid").jqxGrid('getselectedrowindex');                        
                        var rowscount = $("#companyGrid").jqxGrid('getdatainformation').rowscount;
                        if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
                            var id = $("#companyGrid").jqxGrid('getrowid', selectedrowindex);
                            // get current row data
    						var datarow = $("#companyGrid").jqxGrid('getrowdata', id);
    						var griddata = $('#companyGrid').jqxGrid('getdatainformation');
                            $("#companyGrid").jqxGrid('updaterow', id, datarow);
                            $("#companyGrid").jqxGrid('ensurerowvisible', selectedrowindex);
                        }
			        });
			        // delete row
			        $('#btnDelCompany').click(function() {
		                var selectedrowindex = $("#companyGrid").jqxGrid('getselectedrowindex');
		                var rowscount = $("#companyGrid").jqxGrid('getdatainformation').rowscount;
		                if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
		                    var rowid = $("#companyGrid").jqxGrid('getrowid', selectedrowindex);
		                    var commit = $("#companyGrid").jqxGrid('deleterow', rowid);
		                }
		            });
                    
                    
                },
                columns: [
                  { text: 'id', datafield: 'id' , hidden: true },
                  { text: 'Company code', datafield: 'code',
                	validation: function (cell, value) {
                		if ( !value || value =="") {
              			  return { result: false, message: "Company code cannot be empty" };
						}
                		return true;
                	}
                  },
                  { text: 'Company Name', datafield: 'name',
                	validation: function (cell, value) {
                		if ( !value || value =="") {
              			  return { result: false, message: "Company name cannot be empty" };
						}
                		return true;
                	} 
                  },
                  { text: 'Superintendent', datafield: 'superintendent',
                	validation: function (cell, value) {
                		if ( !value || value =="") {
              			  return { result: false, message: "Superintendent cannot be empty" };
						}
                		return true;
                	} 
                  },
                  { text: 'address', datafield: 'address' ,
                	validation: function (cell, value) {
                		if ( !value || value =="") {
              			  return { result: false, message: "Company address cannot be empty" };
						}
                		return true;
                	}
                  },
                  { text: 'Start Date', datafield: 'startDate' , cellsformat: 'yyyy/MM/dd', columntype: 'datetimeinput',
                	validation: function (cell, value) {
                		if ( !value || value =="") {
                			  return { result: false, message: "Start Date cannot be empty" };
						}
                  		return true;
                	  }
                  },
                  { text: 'End Date', datafield: 'endDate' , cellsformat: 'yyyy/MM/dd', columntype: 'datetimeinput' ,
					validation: function (cell, value) {						
						// get current row data
						var datarow = $("#companyGrid").jqxGrid('getrowdata', cell.row);						
						
						if ( !value || value =="")
						 return true;						

						if (value <= datarow.startDate) {
						  return { result: false, message: "Start Date should be before End Date" };
						}
						return true;
					}
                  },
                  { text: '<@spring.message "label.ajaxOptions" />', datafield: 'Del', columntype: 'button', editable:false,
                	  cellsrenderer: 
                		  function () { return 'Del'; }, 
	                	  buttonclick: function (rowid) {
	                		// get current row data
	      					var rowdata = $("#companyGrid").jqxGrid('getrowdata', rowid);
	                		  $.confirm({
	      				        title: '<@spring.message "modal.confirm.del.title"/>',
	      				        content: '<@spring.message "modal.confirm.del.content"/>',
	      				        type: 'red',
	      				        icon: 'fa fa-warning',
	      				        buttons: {
	      				            cancel: {
	      				                text: '<@spring.message "modal.button.cancel" />',                
	      				                keys: ['esc'],
	      				                action: function(){
	      				                	// Reload
	      				                	 $("#companyGrid").jqxGrid('updatebounddata');
	      				                }
	      				            },
	      				            confirm: {
	      				                text: '<@spring.message "modal.button.confirm" />',
	      				                btnClass: 'btn-danger',
	      				                keys: ['enter'],
	      				                action: function(){
	      				                	if (rowdata.id!="") {
	      				                    	$.ajax({
	      				                            cache: false,
	      				                            contentType: "application/json; charset=utf-8",
	      				                            url: '/auth/org/company/'+ rowdata.id,                            
	      				                            type: 'delete',                            
	      				                            headers:jwtClient.setAuthorizationTokenHeader(),
	      				                            success: function (data, status, xhr) {
	      				                            	$("#companyGrid").jqxGrid('updatebounddata');
	      				                                // delete command is executed.				
	      				                            },
	      				                            error: function (jqXHR, textStatus, errorThrown) {
	      				                            	$.alert({
	      				       			                    title: 'Alert!',
	      				       			                    content: 'Manipulation failed',
	      				       			                    icon: 'fa fa-warning',
	      				       			                    type: 'red'
	      				       			                });
	      				                                // Reload
	      				                            	$("#companyGrid").jqxGrid('updatebounddata');
	      				                            }
	      				                        });	      				                    	
	      					                	
	      				                    } else {
	      				                   		// Reload
  				                            	$("#companyGrid").jqxGrid('updatebounddata');
	      				                    }
	      				                }
	      				            }
	      				        }
	      				    }); <!--./delete confirm -->
		                  }
                  }
                  
                ]
            });
        });
</script>