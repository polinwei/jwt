<#include "/layout/AdminLTE2/html-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">

<!-- START CUSTOM TABS -->
<div class="row">
  <div class="col-md-12">
    <!-- Custom Tabs -->
    <div class="nav-tabs-custom">
      <ul class="nav nav-tabs">
        <li class="active"><a href="#tab_UserProfile" data-toggle="tab"><@spring.message "program.userProfileController.programName" /></a></li>
        <li><a href="#tab_AppCodes" data-toggle="tab"><@spring.message "program.appCodesController.programName" /></a></li>
        <li><a href="#tab_SystemConfig" data-toggle="tab"><@spring.message "program.systemConfigController.programName" /></a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="tab_UserProfile">
			<#include "/auth/security/userProfile.ftl">
        </div>
        <!-- /.tab-pane -->
        <div class="tab-pane" id="tab_AppCodes">
        	<#include "/auth/security/appCodes.ftl">
        </div>
        <!-- /.tab-pane -->
        <div class="tab-pane" id="tab_SystemConfig">
        	<#include "/auth/security/systemConfig.ftl">
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