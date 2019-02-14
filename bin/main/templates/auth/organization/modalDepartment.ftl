<div class="modal fade" id="modalDepartment" >
  <div class="modal-dialog modal-lg">
	<div class="modal-content">
	  <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		  <span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title"><span id="companyTitle"/></h4>
	  </div>
	  <div class="modal-body">
		
		<!-- ajax-form id="authorityAjaxForm" -->
		<form id="departmentAjaxForm" action="/auth/org/department" method="post" autocomplete = "off">
		  <input type="hidden" id="companyId" name="companyId" >
		  <input type="hidden" id="departmentId" name="id" >
		  <div class="box box-danger">
			<!-- /.box-header -->
			<div class="box-body">
			  <div class="row">
				<div class="col-md-6">
				  <div class="form-group">
					<label for="departmentName"><@spring.message "program.departmentController.departmentName" /></label>
					<input type="text" class="form-control" id="departmentName" placeholder="<@spring.message "program.departmentController.departmentName" />" name="name" required>             
				  </div>
				  <!-- /.form-group -->
				</div><!-- /.col -->
				<div class="col-md-6">
				  <div class="form-group">                
					<label for="departmentNameEng"><@spring.message "program.departmentController.departmentNameEng" /></label>
					<input type="text" class="form-control" id="departmentNameEng" placeholder="<@spring.message "program.departmentController.departmentNameEng" />" name="nameEng" required>
				  </div>
				  <!-- /.form-group -->
				</div><!-- /.col -->				
			  </div><!-- /.row -->
			  <div class="row">
				<div class="col-md-6">
				  <div class="form-group">
					<label for="departmentCostCenter"><@spring.message "program.common.costCenter" /></label>
					<input type="text" class="form-control" id="departmentCostCenter" placeholder="<@spring.message "program.common.costCenter" />" name="costCenter" required>             
				  </div> <!-- /.form-group -->
				</div>
				<div class="col-md-6">
				  <div class="form-group">                
					<label for="departmentNameEng"><@spring.message "program.departmentController.departmentManager" /></label>
					<input type="text" class="form-control" id="departmentNameEng" placeholder="<@spring.message "program.departmentController.departmentManager" />" name="departmentManager" >
				  </div>
				  <@pw.LOV 
				  	fileName="tags/lovTag.ftl"
				  	inputStr="{'inputName':'managerName', 'inputLabel':'program.departmentController.departmentManager' }"
				  	lovTableId="tableDepartmentManagerList"
				  	dtAjaxUrl="/auth/security/appCodes"
				  />
				  <!-- /.form-group -->
				</div><!-- /.col -->				
			  </div><!-- /.row -->
			  <div class="row">
				<div class="col-md-6">
				  <div class="form-group">
					<label for="departmentUpperOrder"><@spring.message "program.departmentController.upperOrderDepartment" /></label>
					<input type="text" class="form-control" id="departmentUpperOrder" placeholder="<@spring.message "program.departmentController.upperOrderDepartment" />" name="departmentUpperOrder" >             
				  </div> <!-- /.form-group -->
				</div>
				<div class="col-md-6">
				  <div class="form-group">                
					<span id="departmentManagerAvatar"><img src=/auth/showphoto/AVATAR_FOLDER/B0253.jpg alt="User Avatar" class="margin" /> </span>
				  </div>
				  <!-- /.form-group -->
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
	              	  <input type="text" class="form-control date" name="startDate" data-date-format="yyyy/mm/dd" data-mask>
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
	                  <input type="text" class="form-control date" name="endDate" data-date-format="yyyy/mm/dd" data-mask>
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
	  </div>
	</div>
	<!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript">
	$('.date').datepicker({format: 'yyyy/mm/dd',clearBtn: true,todayHighlight: true,});
	$('.date').datepicker({format: 'yyyy/mm/dd',clearBtn: true,todayHighlight: true,});
	$('.date').inputmask('yyyy/mm/dd');
	$('.date').inputmask('yyyy/mm/dd');
	$('[data-mask]').inputmask();

	//表單以 Ajax 方式執行 CRUD 
	$("#departmentAjaxForm").submit(function(event){	
	    event.preventDefault(); //prevent default action
	    var post_url = $(this).attr("action"); //get form action url
	    var request_method = $(this).attr("method"); //get form GET/POST method    
	    $('#departmentAjaxForm input[name="startDate"] ').inputmask('remove');
	    $('#departmentAjaxForm input[name="endDate"] ').inputmask('remove');    
	    d = $('#departmentAjaxForm input[name="startDate"] ').val();
	    if(d){
	    	var date = d+" "+moment().format("HHmmss");
	        $('#departmentAjaxForm input[name="startDate"] ').val(moment(date).format("YYYY-MM-DDTHH:mm:ssZZ"));
	    }    
	    d = $('#departmentAjaxForm input[name="endDate"] ').val();
	    if(d){
	    	var date = d+" "+moment().format("HHmmss");
	        $('#departmentAjaxForm input[name="endDate"] ').val(moment(d).format("YYYY-MM-DDTHH:mm:ssZZ"));
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
				$("#departmentGrid").jqxGrid('updatebounddata');
				$('#modalDepartment').modal('toggle');
				
				$('#departmentAjaxForm input[name="startDate"] ').inputmask('yyyy/mm/dd');
				$('#departmentAjaxForm input[name="endDate"] ').inputmask('yyyy/mm/dd');
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
				        $('#departmentAjaxForm input[name="startDate"] ').inputmask('yyyy/mm/dd');
						$('#departmentAjaxForm input[name="endDate"] ').inputmask('yyyy/mm/dd');
						$('[data-mask]').inputmask();
			    }
			}
	    })
	});	
	
</script>