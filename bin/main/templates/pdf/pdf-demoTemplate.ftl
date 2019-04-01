<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Sending Email with Freemarker HTML Template Example</title>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'/>

    <!-- use the font -->
    <style>
				
		body {
            font-family: DFKai-SB;
            font-size: 48px;
            margin: 0; padding: 0;
        }
		
		@page {
            size: 210mm 297mm; /*設置紙張大小:A4(210mm 297mm)、A3(297mm 420mm) 橫向則反過來*/
            margin: 0.25in;
            padding: 1em;            
            @bottom-center{            	
                content:"Polin WEI版權所有";
                font-family: DFKai-SB;
                font-size: 12px;
                color:red;
            };
            @top-center { content: element(header) };
            @bottom-right{
                content:"第" counter(page) "頁  共 " counter(pages) "頁"; 
                /*content: "page " counter(page) " of  " counter(pages); */
                font-family: DFKai-SB;
                font-size: 12px;
                color:#000;
            };
        }

    </style>
</head>
<body>

    <table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border-collapse: collapse;">
        <tr>
            <td align="center" bgcolor="#78ab46" style="padding: 40px 0 30px 0;">
                <img src="cid:logo.png" alt="https://tw.yahoo.com" style="display: block;" />
            </td>
        </tr>
        <tr>
            <td bgcolor="#eaeaea" style="padding: 40px 30px 40px 30px;">
                <p>Dear ${name},成霖</p>
                <p>Generate PDF using Spring Boot with <b>FreeMarker template !!!</b></p>
                <p>Thanks</p>
            </td>
        </tr>
        <tr>
            <td bgcolor="#777777" style="padding: 30px 30px 30px 30px;">
                <p>${signature}</p>
                <p>${location}</p>
            </td>
        </tr>
    </table>

</body>
</html>