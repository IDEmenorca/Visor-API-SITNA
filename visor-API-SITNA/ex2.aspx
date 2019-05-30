<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ex2.aspx.cs" Inherits="visor2018.ex2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Visor 2</title>
</head>
<body>
        <script src="lib/api-sitna-master-silme-clean/build/sitna.js" type="text/javascript"></script>
        <script src="lib/api-sitna-master-silme-clean/lib/OpenLayers/OpenLayers.js" type="text/javascript"></script>

    <div id="mapa"></div>
    <script>
        SITNA.Cfg.proxy = "http://ide.cime.es/infoide/proxy.ashx?";
        SITNA.Cfg.crs = "EPSG:3857";
        SITNA.Cfg.initialExtent = [
        403281.7612
        , 4819813.2556
        , 499821.7280
        , 4893039.9286
        ];
        SITNA.Cfg.baseLayers = [
            /*{
                id: "IDE_WMTS",
                url: "http://ide.cime.es/geoserver2/gwc/service/wmts",
                layerNames: "base_referencia:base_referencia",
                type: "WMTS",
                title: "Mapa base IDE Menorca",
                format: "image/png",
                matrixSet: "EPSG:3857",
                thumbnail: "//ide.cime.es/test/api_sitna/api-sitna-master/Build/TC/css/img/IDE_WMTS.png",
                isBase: true
            }, {
                id: "imatges_GOIB_Ortofoto_2018_IB",
                url: "https://ideib.caib.es/geoserveis/rest/services/imatges/GOIB_Ortofoto_2018_IB/MapServer/WMTS",
                layerNames: "imatges_GOIB_Ortofoto_2018_IB",
                type: "WMTS",
                title: "Ortofoto 2018 IDEIB",
                matrixSet: "default028mm",
                thumbnail: "//ide.cime.es/test/api_sitna/api-sitna-master/Build/TC/css/img/imatges_GOIB_Orto_IB.png",
                isBase: true
            }, "osm"*/

{ id: "IDE_WMTS", url: "http://ide.cime.es/geoserver2/gwc/service/wmts", layerNames: "base_referencia:base_referencia", type: "WMTS", title: "Mapa base IDE Menorca", format: "image/png", matrixSet: "EPSG:3857", thumbnail: "//ide.cime.es/test/api_sitna/api-sitna-master/Build/TC/css/img/IDE_WMTS.png", isBase: true }, { id: "imatges_GOIB_Ortofoto_2018_IB", url: "https://ideib.caib.es/geoserveis/rest/services/imatges/GOIB_Ortofoto_2018_IB/MapServer/WMTS", layerNames: "imatges_GOIB_Ortofoto_2018_IB", type: "WMTS", title: "Ortofoto 2018 IDEIB", matrixSet: "default028mm", thumbnail: "//ide.cime.es/test/api_sitna/api-sitna-master/Build/TC/css/img/imatges_GOIB_Orto_IB.png", isBase: true }, "osm"
        ];
        SITNA.Cfg.defaultBaseLayer = "osm";

        var layout = "layouts/basic";
        var map = new SITNA.Map("mapa", {
            layout: {
                script: layout + '/script.js',
                style: layout + '/style.css',
                markup: layout + '/markup.html',
                config: layout + '/config.json',
                i18n: layout + '/resources'
            }
        });
    </script>
</body>
</html>
