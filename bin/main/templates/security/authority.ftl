<#include "/layout/AdminLTE2/html-begin.ftl">
<#include "/layout/AdminLTE2/content-auth-begin.ftl">

<button onclick="down('pdf文件中文顯示')">PDF下載</button>

      <!-- SELECT2 EXAMPLE -->
      <div class="box box-danger">
        <div class="box-header with-border">
          <h3 class="box-title">維護畫面</h3>

          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
          </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="authorityName">Name</label>
                <input type="text" class="form-control" id="authorityName" placeholder="Authority Name" name="name">
                
              </div>
              <!-- /.form-group -->
              <div class="form-group">                
                <label for="authorityDescription">description</label>
                <input type="text" class="form-control" id="authorityDescription" placeholder="Authority Description" name="description">
              </div>
              <!-- /.form-group -->
            </div><!-- /.col -->
            
          </div><!-- /.row -->
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
          Visit <a href="/security/authority">Authority</a>
        </div>
      </div>
      <!-- /.box -->


      <!-- Default box -->
      <div class="box box-info">
        <div class="box-header">
          <h3 class="box-title">角色清單</h3>

          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"
                    title="Collapse">
              <i class="fa fa-minus"></i></button>
            <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
              <i class="fa fa-times"></i></button>
          </div>
        </div>
        <div class="box-body">
         
          <table id="tblAuthority" class="table table-bordered table-striped" style="width:100%">
            <thead>
            <tr>
              <th>id</th>
              <th>name</th>
              <th>description</th>
              <th>Options</th>
            </tr>
            </thead>
            
            <tfoot>
            <tr>
              <th>id</th>
              <th>name</th>
              <th>description</th>
              <th>Options</th>
            </tr>
            </tfoot>
          </table>
                                             
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
          Footer
        </div>
        <!-- /.box-footer-->
      </div>
      <!-- /.box -->

<!-- page script -->
<script>
function down(data) {
    var dd = {
        content: [
            data,
            'Another paragraph, this time a little bit longer to make sure, this line will be divided into at least two lines'
        ],
        defaultStyle: {
            font: 'kaiu'
        }
    };
    pdfMake.fonts = {
    		kaiu: {
            normal: 'kaiu.ttf',
            bold: 'kaiu.ttf',
            italics: 'kaiu.ttf',
            bolditalics: 'kaiu.ttf'
        }
    };
    pdfMake.createPdf(dd).download();
}

$(document).ready(function() {
	
	pdfMake.fonts = {
		Roboto: {
            normal: 'kaiu.ttf',
            bold: 'kaiu.ttf',
            italics: 'kaiu.ttf',
            bolditalics: 'kaiu.ttf'
        }
    };	
	
	  $('#tblAuthority').DataTable({    	
    	ajax: {url:"/authentication/authorities",dataSrc:""},
    	columns: [
    		{ data: "id", visible: false},
            { data: "name" },
            { data: "description" },
            {
              data: "id", render: function(data, type, row, meta) {                  
                  return '<a href='+data+' class="btn btn-xs btn-primary"><i class="fa fa-pencil"></i>Edit</a> <a href='+data+' class="btn btn-xs btn-danger"><i class="fa fa-trash-o">Delete</a>'
              },
              className: "center",              
            }
        ],
        dom: 'lrBtip',        
        buttons: [
        	'copy','excel', 
        	{
        		extend: 'pdf',
        		text: 'PDF',
        		className: "btn btn-xs btn-primary",
        		'title': 'Authority List',                 
                'download': 'open',//直接在視窗開啟 
        	},
        	{
                extend: 'csv',
                text: 'CSV',
                className: "btn btn-xs btn-primary",
                bom : true
            }, 
            {
                text: 'My button',
                className: "btn btn-xs btn-primary",
                action: function ( e, dt, node, config ) {
                    alert( 'Button activated' );
                }
            },
            {
                text: 'Reload',
                className: "btn btn-xs btn-primary",
                action: function ( e, dt, node, config ) {
                    dt.ajax.reload();
                }
            }            
        ]
        
    });	  

  })
</script>

<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-auth-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">