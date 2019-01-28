
  <!-- Default box -->
  <div class="box box-danger">
    <div class="box-header">
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
          <i class="fa fa-minus"></i></button>
      </div>
    </div>
    <div class="box-body">
    		            
        <div id="companyGrid">
			<script type="text/javascript">	            

	            
	        </script>        
        </div>
        <div class="box-footer">
        	<span id="eventLogCompany" class="text-red"/>
    	</div>
    </div><!-- /.box-body -->
  </div><!-- /.box -->


        <div class="modal fade" id="modal-companyDetail">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"><@spring.message "program.companyController.programName" /></h4>
              </div>
              <div class="modal-body">

				<!-- ajax-form id="authorityAjaxForm" -->
				<form id="companyDetailForm" action="/auth/org/company" method="post">
			      <input type="hidden" id="companyId" name="id" >
			      <div class="box box-danger">
			        <!-- /.box-header -->
			        <div class="box-body">
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="companyCode"><@spring.message "program.companyController.companyCode" /></label>
			                <input type="text" class="form-control" id="companyCode" placeholder="<@spring.message "program.companyController.companyCode" />" name="code" required>             
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->
			            <div class="col-md-6">
			              <div class="form-group">                
			                <label for="companyName"><@spring.message "program.companyController.companyName" /></label>
			                <input type="text" class="form-control" id="companyName" placeholder="<@spring.message "program.companyController.companyName" />" name="name" required>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="CompanyNameEng"><@spring.message "program.companyController.companyNameEng" /></label>
			                <input type="text" class="form-control" id="CompanyNameEng" placeholder="<@spring.message "program.companyController.companyNameEng" />" name="nameEng" >             
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->
			            <div class="col-md-6">
			              <div class="form-group">                
			                <label for="Superintendent"><@spring.message "program.companyController.superintendent" /></label>
			                <input type="text" class="form-control" id="Superintendent" placeholder="<@spring.message "program.companyController.superintendent" />" name="superintendent" required>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="address"><@spring.message "program.common.address" /></label>
			                <input type="text" class="form-control" id="address" placeholder="<@spring.message "program.common.address" />" name="address" >             
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->
			            <div class="col-md-6">
			              <div class="form-group">                
			                <label for="addressEng"><@spring.message "program.common.addressEng" /></label>
			                <input type="text" class="form-control" id="addressEng" placeholder="<@spring.message "program.common.addressEng" />" name="addressEng" >
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="telephone"><@spring.message "program.common.telephone" /></label>
			                <input type="text" class="form-control" id="telephone" placeholder="<@spring.message "program.common.telephone" />" name="telephone" >             
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->
			            <div class="col-md-6">
			              <div class="form-group">                
			                <label for="fax"><@spring.message "program.common.fax" /></label>
			                <input type="text" class="form-control" id="fax" placeholder="<@spring.message "program.common.fax" />" name="fax" >
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			                <label for="website"><@spring.message "program.common.website" /></label>
			                <input type="text" class="form-control" id="website" placeholder="<@spring.message "program.common.website" />" name="website" >             
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->
			            <div class="col-md-6">
			              <div class="form-group">                
			                <label for="note"><@spring.message "program.common.note" /></label>
			                <input type="text" class="form-control" id="note" placeholder="<@spring.message "program.common.note" />" name="note" >
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->			          			          			          
			          <div class="row">
			            <div class="col-md-6">
			              <div class="form-group">
			              	<label for="startDate"><@spring.message "program.common.createDate" /></label>
			              	<div class="input-group date">
			                  <div class="input-group-addon">
			                    <i class="fa fa-calendar"></i>
			                  </div>
			              	  <input type="text" class="form-control" id="startDate" name="startDate" data-date-format="yyyy/mm/dd" data-mask>
			              	</div>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->
			            <div class="col-md-6">
			              <div class="form-group">                
			                <label for="endDate"><@spring.message "program.common.endDate" /></label>
			                <div class="input-group date">
			                  <div class="input-group-addon">
			                    <i class="fa fa-calendar"></i>
			                  </div>
			                  <input type="text" class="form-control" id="endDate" name="endDate" data-date-format="yyyy/mm/dd" data-mask>
			                </div>
			              </div><!-- /.form-group -->
			            </div><!-- /.col -->			            
			          </div><!-- /.row -->			          
			          
			          <div class="row">
					      <div class="col-xs-6">
					          <button type="submit" class="btn btn-primary btnAdd"><@spring.message "label.submit"/></button>
					          <button type="reset" class="btn btn-danger"><@spring.message "label.reset"/></button>
					          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					      </div>          
			          </div> <!-- /.row -->
			        </div><!-- /.box-body -->
			      </div><!-- /.box -->
			      </form>
				<!-- /.ajax-form id="authorityAjaxForm" --> 

              </div> <!-- /.modal-body -->
            </div>   <!-- /.modal-content -->
          </div>     <!-- /.modal-dialog -->
        </div>       <!-- /.modal --> 




<script type="text/javascript">
$('#btnAddCompany').click(function () {
	var rowscount = $("#companyGrid").jqxGrid('getdatainformation').rowscount;
	$("#companyGrid").jqxGrid('begincelledit', rowscount, "code");
});

$(document).on('click', '#companyGrid .btnRowEdit', function () { 
	var rowid = $(this).attr('data-rowid');	            	
	// get current row data
	  	var rowdata = $("#companyGrid").jqxGrid('getrowdata',  $(this).attr('data-rowid'));
	    var url = $(this).attr('data-url');
	    $("#companyDetailForm").attr("action",url);
	    $("#companyDetailForm").attr("method","put");
	    
		$.each( rowdata, function( key, value ) {		
			$('#companyDetailForm input[name="'+key+'"] ').val(value);
		});
		if (rowdata.startDate){
			$("#companyDetailForm input[name='startDate']").datepicker('update', moment(rowdata.startDate).format('YYYY/MM/DD'));
		}
		if (rowdata.endDate){
			$("#companyDetailForm input[name='endDate']").datepicker('update', moment(rowdata.endDate).format('YYYY/MM/DD'));
		}              		
	    $('#modal-companyDetail').modal('show');
})

$(document).on('click', '#companyGrid .btnRowDel', function () {
	var rowid = $(this).attr('data-rowid');	
	// get current row data
	  	var rowdata = $("#companyGrid").jqxGrid('getrowdata', rowid);
  	  $.confirm({
	        title: '<@spring.message "modal.confirm.del.title"/>',
	        content: '<@spring.message "modal.confirm.del.content"/>',
	        type: 'red',
	        animation: 'zoom',
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
	                            	$("#eventLogCompany").html('刪除成功');
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
	                            	$("#eventLogCompany").html('刪除失敗');
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
});

//表單以 Ajax 方式執行 CRUD 
$("#companyDetailForm").submit(function(event){	
    event.preventDefault(); //prevent default action
    var post_url = $(this).attr("action"); //get form action url
    var request_method = $(this).attr("method"); //get form GET/POST method    
    $('#companyDetailForm input[name="startDate"] ').inputmask('remove');
    $('#companyDetailForm input[name="endDate"] ').inputmask('remove');    
    d = $('#companyDetailForm input[name="startDate"] ').val();
    if(d){
    	var date = d+" "+moment().format("HHmmss");
        $('#companyDetailForm input[name="startDate"] ').val(moment(date).format("YYYY-MM-DDTHH:mm:ssZZ"));
    }    
    d = $('#companyDetailForm input[name="endDate"] ').val();
    if(d){
    	var date = d+" "+moment().format("HHmmss");
        $('#companyDetailForm input[name="endDate"] ').val(moment(d).format("YYYY-MM-DDTHH:mm:ssZZ"));
    }

    var form_data = JSON.stringify( $(this).serializeObject() ); //$(this).serialize(); //Encode form elements for submission
    
    $.ajax({
        url : post_url,
        type: request_method,
        contentType: "application/json; charset=utf-8",
        data : form_data,
        headers:jwtClient.setAuthorizationTokenHeader(),
		success:function(data, textStatus, jqXHR){//返回json结果
			// Reload
			$("#companyGrid").jqxGrid('updatebounddata');
			$('#modal-companyDetail').modal('toggle');
			
			$('#companyDetailForm input[name="startDate"] ').inputmask('yyyy/mm/dd');
			$('#companyDetailForm input[name="endDate"] ').inputmask('yyyy/mm/dd');
			$('[data-mask]').inputmask();
			
		},
		complete: function(jqXHR, textStatus) {
		    switch (jqXHR.status) {
		        case 200:
		        	$.alert({
	                    title: 'Congratulations!',
	                    content: 'Manipulation succeeded',
	                    type: 'green'                    
	                });
		            break;
		        case 201:
		        	$.alert({
	                    title: 'Congratulations!',
	                    content: 'Created a new record',
	                    type: 'green'                    
	                });
		        	break;
		        case 404:
		        	$.alert({
		                  title: 'Alert!',
		                  content: 'This record is not found',
		                  icon: 'fa fa-warning',
		                  type: 'red'
		              });
		            break;
		        case 409:
		        	$.alert({
	                    title: 'Alert!',
	                    content: 'This record is conflict',
	                    icon: 'fa fa-warning',
	                    type: 'red'
	                });
		        	break;
		        default:
		        	$.alert({
	                    title: 'Alert!',
	                    content: 'Manipulation failed',
	                    icon: 'fa fa-warning',
	                    type: 'red'
	                });
			        $('#companyDetailForm input[name="startDate"] ').inputmask('yyyy/mm/dd');
					$('#companyDetailForm input[name="endDate"] ').inputmask('yyyy/mm/dd');
					$('[data-mask]').inputmask();
		    }
		}
    })
});


$(document).ready(function () {	
	$('#companyDetailForm input[name="startDate"] ').datepicker({format: 'yyyy/mm/dd'});
   	$('#companyDetailForm input[name="endDate"] ').datepicker({format: 'yyyy/mm/dd'});
	$('#companyDetailForm input[name="startDate"] ').inputmask('yyyy/mm/dd');
	$('#companyDetailForm input[name="endDate"] ').inputmask('yyyy/mm/dd');
	$('[data-mask]').inputmask();

            // prepare the data
            
            var source = {                
                datatype: "json",
                datafields: [
                	{ name: 'id' },
			        { name: 'code' },
			        { name: 'name' },
			        { name: 'nameEng' },			        
			        { name: 'superintendent' },
			        { name: 'address' },
			        { name: 'addressEng' },
			        { name: 'telephone' },
			        { name: 'fax' },
			        { name: 'website' },
			        { name: 'note' },
			        { name: 'departments' },
			        { name: 'userDetailses' },
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
                    //delete rowdata['departments'];
                    if (rowdata['startDate']){
                    	var d = moment(rowdata['startDate']).format("YYYYMMDD")+" "+moment().format("HHmmss");                    
                        rowdata['startDate'] = moment(d).format("YYYY-MM-DDTHH:mm:ssZZ");
                    }
                    if(rowdata['endDate']){
                    	var d = moment(rowdata['endDate']).format("YYYYMMDD")+" "+moment().format("HHmmss");                    
                        rowdata['endDate'] = moment(d).format("YYYY-MM-DDTHH:mm:ssZZ");
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
								commit(true);
								// Reload
			                	$("#companyGrid").jqxGrid('updatebounddata');
			                	$("#eventLogCompany").html('儲存成功');
                            },
                            error: function (jqXHR, textStatus, errorThrown) {                            	
                            	$("#eventLogCompany").html('刪除失敗');
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
							                	$("#eventLogCompany").html('刪除成功');
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
                height: '250px',
                source: dataAdapter,
                editable: true,
                //selectionmode: 'singlerow',
                //selectionmode: 'singlecell',
                editmode: 'selectedrow',
                pageable: true,
                altRows: true,                
                showtoolbar: true,                
                rendertoolbar: function (toolbar) {
                	var container = $("<div style='margin: 5px;'></div>");
                    toolbar.append(container);
                    container.append('<input id="btnReloadCompany" style="margin-left: 5px;" class="btn btn-xs btn-primary" type="button" value="Reload" />');
                    container.append('<input id="btnAddCompany" style="margin-left: 5px;" class="btn btn-xs btn-primary" type="button" value="Add" />');
                    container.append('<input id="btnEditMoreCompany" style="margin-left: 5px;" class="btn btn-xs btn-primary" type="button" value="EditMore" />');
                    <@security.authorize access="hasRole('ADMIN')">
                    container.append('<input id="btnDelCompany" style="margin-left: 5px;" class="btn btn-xs btn-danger" type="button" value="Del" />');
                    </@security.authorize>
                    // Reload
                    $("#btnReloadCompany").on('click', function () {
                        $("#companyGrid").jqxGrid('updatebounddata');
                    });
                    // create new row.
			        $("#btnAddCompany").bind('click', function () {
			        	var rowscount = $("#companyGrid").jqxGrid('getdatainformation').rowscount;
			        	var commit = $("#companyGrid").jqxGrid('addrow', null, {});			            
			            $("#companyGrid").jqxGrid('begincelledit', rowscount, "code");
			            $("#companyGrid").jqxGrid('ensurerowvisible', rowscount);
			        });
			        // update row.
			        $("#btnEditMoreCompany").bind('click', function () {
			        	
                        var selectedrowindex = $("#companyGrid").jqxGrid('getselectedrowindex');                        
                        var rowscount = $("#companyGrid").jqxGrid('getdatainformation').rowscount;
                        if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
                            var rowid = $("#companyGrid").jqxGrid('getrowid', selectedrowindex);
                            // get current row data
    						var rowdata = $("#companyGrid").jqxGrid('getrowdata', rowid);    						
    	              	    var url = "/auth/org/company/"+rowdata.id;
    	              	    $("#companyDetailForm").attr("action",url);
    	              	    $("#companyDetailForm").attr("method","put");
    	              	    
    	              		$.each( rowdata, function( key, value ) {		
    	              			$('#companyDetailForm input[name="'+key+'"] ').val(value);
    	              		});
    	              		if (rowdata.startDate){
    	              			$("#companyDetailForm input[name='startDate']").datepicker('update', moment(rowdata.startDate).format('YYYY/MM/DD'));
    	              		}
    	              		if (rowdata.endDate){
    	              			$("#companyDetailForm input[name='endDate']").datepicker('update', moment(rowdata.endDate).format('YYYY/MM/DD'));
    	              		}              		
    	              	    $('#modal-companyDetail').modal('show');
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
                  { text: '<@spring.message "program.companyController.companyCode" />', datafield: 'code',
                	validation: function (cell, value) {
                		if ( !value || value =="") {
              			  return { result: false, message: "Company code cannot be empty" };
						}
                		return true;
                	}
                  },
                  { text: '<@spring.message "program.companyController.companyName" />', datafield: 'name',
                	validation: function (cell, value) {
                		if ( !value || value =="") {
              			  return { result: false, message: "Company name cannot be empty" };
						}
                		return true;
                	} 
                  },
                  { text: '<@spring.message "program.companyController.superintendent" />', datafield: 'superintendent',
                	validation: function (cell, value) {
                		if ( !value || value =="") {
              			  return { result: false, message: "Superintendent cannot be empty" };
						}
                		return true;
                	} 
                  },
                  { text: '<@spring.message "program.common.address" />', datafield: 'address' , width: 250,
                	validation: function (cell, value) {
                		if ( !value || value =="") {
              			  return { result: false, message: "Company address cannot be empty" };
						}
                		return true;
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
						var datarow = $("#companyGrid").jqxGrid('getrowdata', cell.row);						
						
						if ( !value || value =="")
						 return true;						

						if (value <= datarow.startDate) {
						  return { result: false, message: "Start Date should be before End Date" };
						}
						return true;
					}
                  },
                  <@security.authorize access="hasRole('ADMIN')">
                  {
                      text: '<@spring.message "label.ajaxOptions" />', cellsAlign: 'center', align: "center", columnType: 'none', editable: false, sortable: false, dataField: null, width: 150,
                      cellsRenderer: function (rowid, column, value) {
                    	  // get current row data
                    	  var datarow = $("#companyGrid").jqxGrid('getrowdata', rowid);
                          // render custom column.
                    	  <#if Request.progPermits?? && !Request.progPermits["isEdit"] >
              				<#assign isEditDisable = 'disabled="disabled" '>
	              		</#if>
	              		<#if Request.progPermits?? && !Request.progPermits["isDel"] >
	          				<#assign isDelDisable = 'disabled="disabled" '>				
	          			</#if>
	          			return '<a href="#"  data-url=/auth/org/company/'+datarow.id+' data-rowid='+rowid+' class="btn btn-xs btn-primary btnDTView btnRowEdit" ${isEditDisable!""}><i class="fa fa-pencil"></i>Edit More</a> '	          			        
                              +'<a href="#"  data-url=/auth/org/company/'+datarow.id+' data-rowid='+rowid+' class="btn btn-xs btn-danger btnRowDel" ${isDelDisable!""}><i class="fa fa-trash-o"></i>Delete</a>' ;
                      }
                  }
                  </@security.authorize>
                ] <!-- ./columns -->
            });
            <#-- 預選第一筆 
            $("#companyGrid").jqxGrid('selectrow', 0);
            -->
        });
</script>