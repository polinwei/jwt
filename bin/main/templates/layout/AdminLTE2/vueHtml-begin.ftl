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
  <link rel="stylesheet" href="/AdminLTE2/bower_components/font-awesome/css/font-awesome.min.css">  
  <#-- Ionicons -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/Ionicons/css/ionicons.min.css">
  <link rel="stylesheet" href="/webjars/flag-icon-css/css/flag-icon.min.css">

  <#-- DataTables -->
  <link rel="stylesheet" href="/AdminLTE2/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
  <#-- jquery-confirm -->
  <link rel="stylesheet" href="/js/jquery-confirm/jquery-confirm.min.css">
  <#-- Theme style -->
  <link rel="stylesheet" href="/AdminLTE2/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="/AdminLTE2/dist/css/skins/_all-skins.min.css">
  
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="/js/oss-maxcdn-com/html5shiv.min.js"></script>
  <script src="/js/oss-maxcdn-com/respond.min.js"></script> 
  <![endif]-->

<#-- jQuery 3 -->
<script src="/AdminLTE2/bower_components/jquery/dist/jquery.min.js"></script>
<#-- Bootstrap 3.3.7 -->
<script src="/AdminLTE2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

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
<#-- moment -->
<script src="/AdminLTE2/bower_components/moment/min/moment.min.js"></script>
<script src="/AdminLTE2/bower_components/moment/min/moment-timezone.min.js"></script>
<script src="/AdminLTE2/bower_components/moment/min/moment-timezone-with-data-2012-2022.min.js"></script>

<#-- AdminLTE App -->
<script src="/AdminLTE2/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/AdminLTE2/dist/js/demo.js"></script>

<script src="/js/jquery-confirm/jquery-confirm.min.js"></script>
<#-- VUE JS -->
<script src="/webjars/vue/2.6.10/dist/vue.js"></script>
<#-- AXIOS JS -->
<script src="/webjars/axios/dist/axios.min.js"></script>
<script src="/webjars/element-ui/2.8.2/lib/index.js"></script>
<link rel="stylesheet" href="/webjars/element-ui/2.8.2/lib/theme-chalk/index.css">
  
<@security.authorize access="isAuthenticated()">
<script src="/js/jwt-decode/jwt-decode.min.js"></script>
<script src="/js/jwt-client.js"></script>
</@security.authorize>

<script>

	<#-- Global filters -->   
	Vue.filter('formatDate', function(value) {
		  if (value) {
		    return moment(String(value)).format('YYYY/MM/DD Z')
		  }
	});
	Vue.filter('imgSrc', function(value) {	
		  if (value) {
		    return '/auth/showphoto/AVATAR_FOLDER/'+value;
		  }
	});
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

$(document).ready(function() {
	<#-- pdfmake 中文字 -->
	pdfMake.fonts = {
			Roboto: {
	            normal: 'kaiu.ttf',
	            bold: 'kaiu.ttf',
	            italics: 'kaiu.ttf',
	            bolditalics: 'kaiu.ttf'
	        }
	    };
		
});

</script>    
  <!-- Google Font -->
  <link rel="stylesheet" href="/fonts/SourceSansPro.css">
</head>