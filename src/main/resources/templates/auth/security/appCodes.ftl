
  <!-- Default box -->
  <div class="box box-danger">
    <div class="box-header">
      <div class="box-tools pull-right">
        <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
          <i class="fa fa-minus"></i></button>
      </div>
    </div>
    <div class="box-body">
	    <@pw.dataTable
	        fileName="tags/dataTableTag.ftl"
			tableId="tblAppCodes"
			dtAjaxUrl="/auth/security/appCodes"
			crudAjaxUrl="/auth/security/appCode"
			paramsStr="{'isAjaxOptions':true,'uploadType':'security'}"
			columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden','required':'true'},
					     {'th':'program.appCodesController.appName','data':'appName','type':'text','required':'true'},
			             {'th':'program.appCodesController.codeType','data':'codeType','type':'text','required':'true'},
			             {'th':'program.appCodesController.codeValue','data':'codeValue','type':'text','required':'true'},
			             {'th':'program.appCodesController.codeDesc','data':'codeDesc','type':'text'},
				         {'th':'program.appCodesController.codeDescEng','data':'codeDescEng','type':'text'}]"
		/>
    </div><!-- /.box-body -->
  </div><!-- /.box -->


