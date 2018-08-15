<#include "layout/AdminLTE2/html-begin.ftl">
<#include "layout/AdminLTE2/content-begin.ftl">

<div class="login-box">
  <div class="login-logo">
    <a href="../../index2.html"><b>Globe Union</b></a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Sign in to start your session</p>

    <form action="/auth" method="post">
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
          <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
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



<#include "layout/AdminLTE2/content-end.ftl">
<#include "layout/AdminLTE2/html-end.ftl">