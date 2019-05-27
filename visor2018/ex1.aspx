<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ex1.aspx.cs" Inherits="visor2018.ex1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Visor API IDENA</title>
</head>
    <body>
    <script src="//sitna.tracasa.es/api/" type="text/javascript"></script>

    <div id="mapa"></div>
    <script>
        var map = new SITNA.Map("mapa");
    </script>
    </body>
</html>
