<#include "layout/AdminLTE2/html-begin.ftl">
<#include "layout/AdminLTE2/content-auth-begin.ftl">

This place put Main Content 放主要的程式

<@security.authorize access="hasRole('ADMIN')">
<br/>Admin can read
</@security.authorize>

<@security.authorize access="hasRole('USER')">
<br/>User can read
</@security.authorize>

<@security.authorize access="isAuthenticated()">
<br/>    authenticated as <@security.authentication property="principal.username" /> 
</@security.authorize>
${Request.lang!"no Lang"}<br/>

locale:${.locale}<br/>

<p>測試從模版中讀取信息</p>
<@pw.FtlSampleTemplate fileName="demo/ftlTagSample.ftl" 
	paramsStr="{'Avatar':'B0253.jpg','userName':'Polin WEI','userTitle':'IT Director'}" 
	columnsStr="{'select':'label.select','id':'id','username':'label.username','fullName':'program.userController.fullName','avatar':'program.common.avatar'}"/>




<#include "layout/AdminLTE2/controlSidebar.ftl">
<#include "layout/AdminLTE2/content-auth-end.ftl">
<#include "layout/AdminLTE2/html-end.ftl">