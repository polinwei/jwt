<#include "/layout/AdminLTE2/html-begin.ftl">
<#include "/layout/AdminLTE2/content-begin.ftl">

      <!-- Content Header (Page header) -->
      <section class="content-header">
		JQwidget Demo
      </section>

<!-- add one of the jQWidgets styles -->
    <link rel="stylesheet" 
    href="/AdminLTE2/bower_components/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" 
    href="/AdminLTE2/bower_components/jqwidgets/styles/jqx.darkblue.css" type="text/css" />

<!-- add the jQWidgets framework -->
    <script type="text/javascript" src="/AdminLTE2/bower_components/jqwidgets/jqx-all.js"></script>
    
<script type="text/javascript">
        $(document).ready(function () {
            // prepare the data
            var data = new Array();
            var firstNames =
            [
                "Andrew", "Nancy", "Shelley", "Regina", "Yoshi", "Antoni", "Mayumi", "Ian", "Peter", "Lars", "Petra", "Martin", "Sven", "Elio", "Beate", "Cheryl", "Michael", "Guylene"
            ];
            var lastNames =
            [
                "Fuller", "Davolio", "Burke", "Murphy", "Nagase", "Saavedra", "Ohno", "Devling", "Wilson", "Peterson", "Winkler", "Bein", "Petersen", "Rossi", "Vileid", "Saylor", "Bjorn", "Nodier"
            ];
            var productNames =
            [
                "Black Tea", "Green Tea", "Caffe Espresso", "Doubleshot Espresso", "Caffe Latte", "White Chocolate Mocha", "Cramel Latte", "Caffe Americano", "Cappuccino", "Espresso Truffle", "Espresso con Panna", "Peppermint Mocha Twist"
            ];
            var priceValues =
            [
                "2.25", "1.5", "3.0", "3.3", "4.5", "3.6", "3.8", "2.5", "5.0", "1.75", "3.25", "4.0"
            ];
            for (var i = 0; i < 10000; i++) {
                var row = {};
                var productindex = Math.floor(Math.random() * productNames.length);
                var price = parseFloat(priceValues[productindex]);
                var quantity = 1 + Math.round(Math.random() * 10);
                row["firstname"] = firstNames[Math.floor(Math.random() * firstNames.length)];
                row["lastname"] = lastNames[Math.floor(Math.random() * lastNames.length)];
                row["productname"] = productNames[productindex];
                row["price"] = price;
                row["quantity"] = quantity;
                row["total"] = price * quantity;
                data[i] = row;
            }
            var source =
            {
                localdata: data,
                datatype: "array"
            };
            var dataAdapter = new $.jqx.dataAdapter(source, {
                loadComplete: function (data) { },
                loadError: function (xhr, status, error) { }      
            });
            $("#jqxgrid").jqxGrid(
            {
                source: dataAdapter,
                sortable: true,
                columns: [
                  { text: 'First Name', datafield: 'firstname', width: 100 },
                  { text: 'Last Name', datafield: 'lastname', width: 100 },
                  { text: 'Product', datafield: 'productname', width: 180 },
                  { text: 'Quantity', datafield: 'quantity', width: 80, cellsalign: 'right' },
                  { text: 'Unit Price', datafield: 'price', width: 90, cellsalign: 'right', cellsformat: 'c2' },
                  { text: 'Total', datafield: 'total', width: 100, cellsalign: 'right', cellsformat: 'c2' }
                ]
            });
        });
    </script>
    
      <!-- Main content -->
      <section class="content">    
    
		<div id='jqxWidget'>
	        <div id="jqxgrid"></div>
	    </div>    

      </section>
      <!-- /.content -->
<#include "/layout/AdminLTE2/controlSidebar.ftl">
<#include "/layout/AdminLTE2/content-end.ftl">
<#include "/layout/AdminLTE2/html-end.ftl">