<#include "/layout/AdminLTE2/html-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">

<#-- add one of the jQWidgets styles -->
<link rel="stylesheet" href="/AdminLTE2/bower_components/jqwidgets/styles/jqx.base.css" type="text/css" />  
<#-- add the jQWidgets framework -->
<script type="text/javascript" src="/AdminLTE2/bower_components/jqwidgets/jqx-all.js"></script>
<script type="text/javascript" src="/AdminLTE2/bower_components/jqwidgets/globalization/globalize.js"></script>

  <div class="box box-default">
	<div class="box-header with-border">
	  <h3 class="box-title"><@spring.message "program.companyController.programName" /></h3>

	  <div class="box-tools pull-right">
		<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	  </div>
	</div>
	<!-- /.box-header -->
	<div class="box-body">
	  <div class="row">
		<div class="col-md-12">
			<#include "/auth/organization/company.ftl">
		</div><!-- /.col -->
	  </div> <!-- /.row -->
	  
		<!-- START CUSTOM TABS -->
		<div class="row">
		  <div class="col-md-12">
		    <!-- Custom Tabs -->
		    <div class="nav-tabs-custom">
		      <ul class="nav nav-tabs">
		        <li class="active"><a href="#tab_department" data-toggle="tab"><@spring.message "program.departmentController.programName" /></a></li>
		        <li><a href="#tab_userDetails" data-toggle="tab"><@spring.message "program.userDetailsController.programName" /></a></li>
		        <li><a href="#tab_companyTree" data-toggle="tab"><@spring.message "program.companyController.companyTree" /></a></li>
		      </ul>
		      <div class="tab-content">
		        <div class="tab-pane active" id="tab_department">
		        	<div class="row">
			        	<div class="col-md-12">
							<#include "/auth/organization/department.ftl">
						</div>						
					</div>
		        </div>
		        <!-- /.tab-pane -->
		        <div class="tab-pane" id="tab_userDetails">
		        	<#include "/auth/organization/userDetails.ftl">
		        </div>
		        <!-- /.tab-pane -->
		        <!-- /.tab-pane -->
		        <div class="tab-pane" id="tab_companyTree">
		        	<#include "/auth/organization/companyTree.ftl">
		        </div>
		        <!-- /.tab-pane -->		        
		      </div>
		      <!-- /.tab-content -->
		    </div>
		    <!-- nav-tabs-custom -->
		  </div>
		  <!-- /.col -->
		</div>
		<!-- /.row -->
		<!-- END CUSTOM TABS -->	  
	  
	</div>
	<!-- /.box-body -->
	<div class="box-footer">
	  	公司/部門/人員
	</div>
  </div><!-- /.box -->




<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">