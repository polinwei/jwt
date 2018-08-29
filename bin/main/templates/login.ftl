<#include "layout/AdminLTE2/html-normal-begin.ftl">

<body class="hold-transition login-page">


<div class="login-box">
  <div class="login-logo">
    <a href="/"><b>Globe Union</b></a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Sign in to start your session</p>
	<#if SPRING_SECURITY_LAST_EXCEPTION?? && SPRING_SECURITY_LAST_EXCEPTION.message?has_content>
		<p class="alert alert-danger"><@spring.message "label.loginError"/></p>
		${SPRING_SECURITY_LAST_EXCEPTION.message}
		
	</#if>
	

    <form id="sloginForm" action="/login" method="post">      
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="<@spring.message "label.username"/>" required name="username">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="<@spring.message "label.password"/>" required name="password">
        <span class="glyphicon glyphicon-lock form-control-feedback" ></span>
      </div>
      <div class="row">
        <div class="col-xs-4 pull-right">
          <button type="submit" class="btn btn-primary btn-block btn-flat"><@spring.message "label.signIn"/></button>
        </div>
        <!-- /.col -->
      </div>
    </form>

    <a href="#">I forgot my password</a><br>
    <a href="register.html" class="text-center">Register a new membership</a>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

</body>
<#include "layout/AdminLTE2/html-normal-end.ftl">