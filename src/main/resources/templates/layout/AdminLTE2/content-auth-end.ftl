    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
<script>
$(function () {
	<#if Request.progPermits??>
		<#if Request.progPermits["isAdd"]! false>
			$('.btnAdd').attr('disabled',false);
		<#else>
			$('.btnAdd').attr('disabled',true);
			$('.btnAdd').click(function(e){
		         e.preventDefault();
		         return false;
		     });
		</#if>
		<#if Request.progPermits["isEdit"]! false>			
			$('.btnEdit').attr('disabled',false);
		<#else>
			$('.btnEdit').attr('disabled',true);
			$('.btnEdit').click(function(e){
		         e.preventDefault();		         
		         return false;
		     });
		</#if>
		<#if Request.progPermits["isDel"]! false>			
			$('.btnDel').attr('disabled',false);
		<#else>
			$('.btnDel').attr('disabled',true);			
			$('.btnDel').click(function(e){
		         e.preventDefault();		         
		         return false;
		     });
		</#if>
		<#if Request.progPermits["isQuery"]! false>			
			$('.btnQuery').attr('disabled',false);
		<#else>
			$('.btnQuery').attr('disabled',true);
			$('.btnQuery').click(function(e){
		         e.preventDefault();
		         return false;
		     });
		</#if>
		<#if Request.progPermits["isPrint"]! false>			
			$('.btnPrint').attr('disabled',false);
		<#else>
			$('.btnPrint').attr('disabled',true);
			$('.btnPrint').click(function(e){
		         e.preventDefault();
		         return false;
		     });
		</#if>		
	</#if>
})
</script>