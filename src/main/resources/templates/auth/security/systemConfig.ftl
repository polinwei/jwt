

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
			ajaxUrl="/auth/security/systemConfigs"	
			paramsStr="{'isAjaxOptions':true}"
			columnsStr="[{'th':'id','data':'id','visible': 'true'},{'th':'program.common.paramName','data':'paramName'},
			             {'th':'program.common.paramValue','data':'paramValue'},{'th':'program.common.paramDesc','data':'paramDesc'},
				         {'th':'program.common.note','data':'note'}]"
		/>
    </div><!-- /.box-body -->
  </div><!-- /.box -->