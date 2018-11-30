

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
			tableId="tblSystemConfig"
			dtAjaxUrl="/auth/security/systemConfigs"
			crudAjaxUrl="/auth/security/systemConfig"
			paramsStr="{'isAjaxOptions':true,'crudKey':'id'}"
			columnsStr="[{'th':'id','data':'id','visible': 'false','type':'hidden','required':'true'},
					     {'th':'program.common.paramName','data':'paramName','type':'text','required':'true'},
			             {'th':'program.common.paramValue','data':'paramValue','type':'text','required':'true'},
			             {'th':'program.common.paramDesc','data':'paramDesc','type':'text'},
				         {'th':'program.common.note','data':'note','type':'textarea'}]"
		/>
    </div><!-- /.box-body -->
  </div><!-- /.box -->