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


<#include "layout/AdminLTE2/controlSidebar.ftl">
<#include "layout/AdminLTE2/content-auth-end.ftl">
<#include "layout/AdminLTE2/html-end.ftl">