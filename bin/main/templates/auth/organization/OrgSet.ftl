<#include "/layout/AdminLTE2/html-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">

<!-- START CUSTOM TABS -->
<div class="row">
  <div class="col-md-12">
    <!-- Custom Tabs -->
    <div class="nav-tabs-custom">
      <ul class="nav nav-tabs">
        <li class="active"><a href="#tab_companyDepartment" data-toggle="tab"><@spring.message "program.companyController.programName" /></a></li>
        <li><a href="#tab_userDetails" data-toggle="tab"><@spring.message "program.userDetailsController.programName" /></a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="tab_companyDepartment">
			<#include "/auth/organization/companyDepartment.ftl">
        </div>
        <!-- /.tab-pane -->
        <div class="tab-pane" id="tab_userDetails">
        	<#include "/auth/organization/userDetails.ftl">
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
<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">