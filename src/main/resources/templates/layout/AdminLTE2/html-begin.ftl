<#import "/spring.ftl" as spring/>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#assign pw=JspTaglibs["/polinwei/tags"] />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Top Navigation</title>
  <#-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <#-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/bootstrap/dist/css/bootstrap.min.css">
  <#-- Font Awesome -->
  <link rel="stylesheet" href="/webjars/font-awesome/5.2.0/css/all.css"> 
  <link rel="stylesheet" href="/AdminLTE2/bower_components/font-awesome/css/font-awesome.min.css">  
  <#-- Ionicons -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/Ionicons/css/ionicons.min.css">
  <link rel="stylesheet" href="/webjars/flag-icon-css/css/flag-icon.min.css">
  <#-- daterange picker -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/bootstrap-daterangepicker/daterangepicker.css">
  <#-- bootstrap datepicker -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
  <#-- Bootstrap time Picker -->
  <link rel="stylesheet" href="/AdminLTE2/plugins/timepicker/bootstrap-timepicker.min.css">
  <#-- iCheck for checkboxes and radio inputs -->
  <link rel="stylesheet" href="/AdminLTE2/plugins/iCheck/all.css">
  <#--  Bootstrap Color Picker -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css">
  <#-- Select2 -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/select2/dist/css/select2.min.css">
  <#-- DataTables -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
  <#-- Theme style -->
  <link rel="stylesheet" href="/AdminLTE2/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="/AdminLTE2/dist/css/skins/_all-skins.min.css">
  <#-- jquery-ui style -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/jquery-ui/themes/smoothness/jquery-ui.min.css">

  
  
  <link rel="stylesheet" href="/js/jquery-confirm/jquery-confirm.min.css">
  <link rel="stylesheet" href="/js/jquery-fancybox/jquery.fancybox.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="/js/oss-maxcdn-com/html5shiv.min.js"></script>
  <script src="/js/oss-maxcdn-com/respond.min.js"></script> 
  <![endif]-->

<#-- jQuery 3 -->
<script src="/AdminLTE2/bower_components/jquery/dist/jquery.min.js"></script>
<#-- DataTables -->
<script src="/AdminLTE2/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="/AdminLTE2/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="/AdminLTE2/bower_components/datatables.net-extensions/buttons/js/dataTables.buttons.min.js"></script>
<script src="/AdminLTE2/bower_components/datatables.net-extensions/buttons/js/buttons.html5.min.js"></script>
<script src="/AdminLTE2/bower_components/datatables.net-extensions/pdfmake/pdfmake.min.js"></script>
<script src="/AdminLTE2/bower_components/datatables.net-extensions/pdfmake/vfs_fonts.js"></script>
<script src="/AdminLTE2/bower_components/datatables.net-extensions/JSZip/jszip.min.js"></script>

<#-- CK Editor  -->
<script src="/AdminLTE2/bower_components/ckeditor/ckeditor.js"></script>
<#-- use jquery-ui drag function to drag Modal  -->
<script src="/AdminLTE2/bower_components/jquery-ui/jquery-ui.js"></script>

<#-- Bootstrap 3.3.7 -->
<script src="/AdminLTE2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<#-- VUE JS -->
<script src="/webjars/vue/2.5.13/vue.min.js"></script>
<#-- Select2 -->
<script src="/AdminLTE2/bower_components/select2/dist/js/select2.full.min.js"></script>
<#-- FastClick -->
<script src="/AdminLTE2/bower_components/fastclick/lib/fastclick.js"></script>
<#-- AdminLTE App -->
<script src="/AdminLTE2/dist/js/adminlte.min.js"></script>
<#-- Sparkline -->
<script src="/AdminLTE2/bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
<#-- jvectormap  -->
<script src="/AdminLTE2/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/AdminLTE2/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<#-- SlimScroll -->
<script src="/AdminLTE2/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<#-- ChartJS -->
<script src="/AdminLTE2/bower_components/chart.js/Chart.js"></script>

<#-- InputMask -->
<script src="/AdminLTE2/plugins/input-mask/jquery.inputmask.js"></script>
<script src="/AdminLTE2/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="/AdminLTE2/plugins/input-mask/jquery.inputmask.extensions.js"></script>
<#-- date-range-picker -->
<script src="/AdminLTE2/bower_components/moment/min/moment.min.js"></script>
<script src="/AdminLTE2/bower_components/moment/min/moment-timezone.min.js"></script>
<script src="/AdminLTE2/bower_components/moment/min/moment-timezone-with-data-2012-2022.min.js"></script>
<script src="/AdminLTE2/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<#-- bootstrap datepicker -->
<script src="/AdminLTE2/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<#-- bootstrap color picker -->
<script src="/AdminLTE2/bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
<#-- bootstrap time picker -->
<script src="/AdminLTE2/plugins/timepicker/bootstrap-timepicker.min.js"></script>
<#-- iCheck 1.0.1 -->
<script src="/AdminLTE2/plugins/iCheck/icheck.min.js"></script>


<!-- AdminLTE dashboard demo (This is only for demo purposes) -->

<!-- AdminLTE for demo purposes -->
<script src="/AdminLTE2/dist/js/demo.js"></script>

<script src="/js/jquery-confirm/jquery-confirm.min.js"></script>
<script src="/js/jquery-fancybox/jquery.fancybox.min.js"></script>
<script src="/js/jquery-redirect/jquery.redirect.js"></script>
<@security.authorize access="isAuthenticated()">
<script src="/js/jwt-decode/jwt-decode.min.js"></script>
<script src="/js/jwt-client.js"></script>
</@security.authorize>

<script>
$(document).ready(function() {
    
	<#-- use jquery-ui drag function to drag Modal  -->
	$('.modal-dialog').draggable();
	<#-- pdfmake 中文字 -->
	pdfMake.fonts = {
			Roboto: {
	            normal: 'kaiu.ttf',
	            bold: 'kaiu.ttf',
	            italics: 'kaiu.ttf',
	            bolditalics: 'kaiu.ttf'
	        }
	    };
})
<#-- serialize Form into an object, data = JSON.stringify( $('#myForm').serializeObject() ); -->  
$.fn.serializeObject = function(){
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

</script>    
  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>