<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="defaultNoBD.aspx.cs" Inherits="visor2018._defaultNoBD" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Visor 2018</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
        <meta http-equiv="X.UA.Compatible" content="IE=edge"/>
        <meta name="description" content="Nova versió del visor de la IDE Menorca."/>
        <style>
            .marker {
                background-image: url("icon_default.png");
            }
        </style>

        <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/058887ff/fd04ecf1.js?bu=B-0EigWdBZ8F3wSiBfIE"></script>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/5ae0dbce/92508bd0.js?bu=AdAE"></script>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/48935db6/b61f17c4.js?bu=A-0E9gXyBA"></script>
        <link type="text/css" rel="stylesheet" href="https://www.bing.com/rb/3x/cir2,cc,nc/51bcf5f1/15b94764.css?bu=AvsFgQY"/>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/34882521/8130a2be.js?bu=BO0EpgaUBvIE"></script>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/32ebea07/2c9d82e1.js?bu=Fe0EpgWsBccFvgXKBc0F0AXTBdYF3AXZBd8F4gXlBegF6wXuBfEFqQXyBA"></script>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/f4b4c1a8/20109818.js?bu=A-0E1QfyBA"></script>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/1985e5c6/c0351642.js?bu=A-0E2gfyBA"></script>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/af9fe586/88a015c2.js?bu=A-0E3QbyBA"></script>
        <link type="text/css" rel="stylesheet" href="https://www.bing.com/rs/3x/3y/cir2,cc,nc/16dd2534/b10763c1.css"/>
        <script type="text/javascript" src="https://www.bing.com/rb/3x/cj,nj/e984f2b2/320a4c37.js?bu=BO0E3QTfAfIE"></script>
    </head>
    <body>
        <div id="mapa"></div>
        <script src="js/SilmeTree.js" type="text/javascript"></script>
        <script src="js/SilmeMap.js" type="text/javascript"></script>
        <script src="js/SilmeModal.js" type="text/javascript"></script>
        <script src="js/Autocomplete.js" type="text/javascript"></script>
        <script src="lib/api-sitna-master-silme/build/sitna.js" type="text/javascript"></script>
        <script src="lib/api-sitna-master-silme/lib/OpenLayers/OpenLayers.js" type="text/javascript"></script>
        <script src="js/LonLat.js" type="text/javascript"></script>
        <script>            
            SITNA.Cfg.proxy = "http://ide.cime.es/infoide/proxy.ashx?";
            SITNA.Cfg.crs = "EPSG:3857";
            SITNA.Cfg.controls.featureInfo = true;
            SITNA.Cfg.controls.scale = true;
            SITNA.Cfg.controls.scaleBar = false;
            SITNA.Cfg.OverviewMapOptions = true;

            SITNA.Cfg.controls.overviewMap = {
                div: "ovmap",
                layer: "mapabase"
            }
            SITNA.Cfg.controls.workLayerManager = {
                div: "toc"
            };
            SITNA.Cfg.controls.legend = {
                div: "legend"
            };
            SITNA.Cfg.controls.layerCatalog = {
                div: "catalog",
                enableSearch: true,
                layerTreeGroups: [{
                    id: "node0"
                , title: "Serveis IDE Menorca"
                }, {
                    id: "node2"
                    , title: "Ortofotos"
                }, {
                id: "node1"
                , title: "Serveis temàtics IDEIB"
                }, {
                    id: "node3"
                    , title: "Serveis bàsics IDEIB"
                }, {
                id: "node4"
                , title: "Serveis bàsics IDEE"
                }
                ],
                layers: [
                    {
                    id: "turisme"
                    , title: "Turisme"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://ide.cime.es/geoserver/turisme/wms/"
                    , hideTree: false
                    , parentGroupNode: "node0"
                }, {
                    id: "ambiental"
                    , title: "Ambiental"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://ide.cime.es/geoserver/ambiental/wms/"
                    , hideTree: false
                    , parentGroupNode: "node0"
                }, {
                    id: "equipaments"
                    , title: "Equipaments"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://ide.cime.es/geoserver/equipaments/wms/"
                    , hideTree: false
                    , parentGroupNode: "node0"
                }, {
                    id: "ordenacio"
                    , title: "Ordenacio"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://ide.cime.es/geoserver/ordenacio/wms/"
                    , hideTree: false
                    , parentGroupNode: "node0"
                }, {
                    id: "base_referencia"
                    , title: "Base Referència"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://ide.cime.es/geoserver2/base_referencia/wms/"
                    , hideTree: false
                    , parentGroupNode: "node0"
                }
                //Ortofotos
                /*, {
                    id: "GOIB_Ortofoto_1956_IB"
                    , title: "Ortofoto 1956"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    //, url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_1956_IB/MapServer/WMSServer/"
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Ortofoto_1956_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }*/
                , {
                    id: "GOIB_Ortofoto_1989_IB"
                    , title: "Ortofoto 1989"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_1989_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2002_IB"
                    , title: "Ortofoto 2002"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2002_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2004_05_06_nuclis"
                    , title: "Ortofoto 2004 05 06 nuclis"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2004_05_06_nuclis/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2006_IB"
                    , title: "Ortofoto 2006"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2006_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2008_nuclis_costa"
                    , title: "Ortofoto 2008 nuclis costa"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2008_nuclis_costa/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2008_IB"
                    , title: "Ortofoto 2008"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2008_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2009_nuclis"
                    , title: "Ortofoto 2009 nuclis"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2009_nuclis/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2010_nuclis"
                    , title: "Ortofoto 2010 nuclis"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2010_nuclis/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2010_IB"
                    , title: "Ortofoto 2010"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2010_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2011_nuclis"
                    , title: "Ortofoto 2011 nuclis"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2011_nuclis/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2012_nuclis"
                    , title: "Ortofoto 2012 nuclis"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2012_nuclis/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2012_IB"
                    , title: "Ortofoto 2012"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2012_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Ortofoto_2015_IB"
                    , title: "Ortofoto 2015"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Ortofoto_2015_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                }, {
                    id: "GOIB_Orto_IB"
                    , title: "Ortofoto"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Orto_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node2"
                },



                //Serveis temàtics IDEIB
                {
                    id: "GOIB_OrdLitoral_IB"
                    , title: "Ordenació del litorial"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_OrdLitoral_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Hidrografia_IB"
                    , title: "Hidrografia"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Hidrografia_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_ControlAigSuperf_IB"
                    , title: "Control aigües superficials"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    //, url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_ControlAigSuperf_IB/MapServer/WMSServer/"
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_ControlAigSuperf_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_ARPSI_IB"
                    , title: "ARPSI"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_ARPSI_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Hidrogeologia_IB"
                    , title: "Hidrogeologia"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Hidrogeologia_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Mines_IB"
                    , title: "Mines"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Mines_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Geologia_IB"
                    , title: "Geologia"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Geologia_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_OrdRecMiners_IB"
                    , title: "Ord. recursos miners"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_OrdRecMiners_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_SolVacant_IB"
                    , title: "Sol vacant"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_SolVacant_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_MUIB"
                    , title: "MUIB"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MUIB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_OrdTerr_IB"
                    , title: "Ordenació territori"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_OrdTerr_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_PTI_PIT"
                    , title: "PTI"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    //, url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_PTI_PIT/MapServer/WMSServer/"
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_PTI_PIT/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_OrdLitoral_IB"
                    , title: "Ordenació litoral"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    //, url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_OrdLitoral_IB/MapServer/WMSServer/"
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_OrdLitoral_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Meteo_IB"
                    , title: "Meteo"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Meteo_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }/*NO VA, {
                    id: "GOIB_InstalProdIndust_IB"
                    , title: "IDEIB - Instal. prod. industrial"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_InstalProdIndust_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }*/, {
                    id: "GOIB_Xarxa_de_transports_IB"
                    , title: "Xarxa de transports"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Xarxa_de_transports_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_RegTurisme_IB"
                    , title: "Reg. turisme"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_RegTurisme_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }/*, {
                    id: "GOIB_Utilitat_Publica_IB"
                    , title: "IDEIB - Utilitat pública"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Utilitat_Publica_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }*/, {
                    id: "GOIB_ProdDistr_energia_IB"
                    , title: "Producció i distribució energètica"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_ProdDistr_energia_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Fotovo_Eol_IB"
                    , title: "Fotovoltaica i eòlica"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Fotovo_Eol_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Abocaments_IB"
                    , title: "Abocaments"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Abocaments_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_UnitatsEstadist_IB"
                    , title: "Unitats estadist."
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_UnitatsEstadist_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_RegEspaisNaturals_IB"
                    , title: "Reg. espais naturals"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_RegEspaisNaturals_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_UnitAdm_IB"
                    , title: "Unit. admin."
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_UnitAdm_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_RiscIncendi_IB"
                    , title: "Risc d'incendi"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_RiscIncendi_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_RegEspaisNaturals_IB"
                    , title: "Reg. Espais Naturals"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_RegEspaisNaturals_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_DistEspecies_IB"
                    , title: "DIst. espècies"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    //, url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_DistEspecies_IB/MapServer/WMSServer/"
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_DistEspecies_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Habitats_IB"
                    , title: "Habitats"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Habitats_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Foto_2002_IB"
                    , title: "Foto 2002"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Foto_2002_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Foto_2001_IB"
                    , title: "Foto 2001"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Foto_2001_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }/*NO VA, {
                    id: "GOIB_InvForestal_IB"
                    , title: "IDEIB - Inventari Forestal"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_InvForestal_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }*/, {
                    id: "GOIB_SIOSE14_IB"
                    , title: "SIOSE"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_SIOSE14_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_FactorsPastures_IB"
                    , title: "Factors Pastures"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_FactorsPastures_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Foto_2015_IB"
                    , title: "Foto 2015"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Foto_2015_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Fotocentres_IB"
                    , title: "Fotocentres"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Fotocentres_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_ToponimiaImatges_IB"
                    , title: "Toponimia per imatges"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_ToponimiaImatges_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Toponimia_IB"
                    , title: "Toponimia"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Toponimia_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Foto_2000_nuclis"
                    , title: "Foto nuclis 2000"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Foto_2000_nuclis/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Foto_1995_Ma"
                    , title: "Foto 1995 Mallorca"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Foto_1995_Ma/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Foto_1995_nuclis"
                    , title: "Foto 1995 nuclis"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/imatges/GOIB_Foto_1995_nuclis/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_MapaBase_IB"
                    , title: "Mapa base Illes Balears"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MapaBase_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_MTB_1995_IB"
                    , title: "MTB 1995"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MTB_1995_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Altimetria_IB"
                    , title: "Altimetria"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Altimetria_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }, {
                    id: "GOIB_Relleu_IB"
                    , title: "Relleu"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_Relleu_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }/*, {
                    id: "GOIB_Adreces_IB"
                    , title: "IDEIB - Adreces"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/rest/services/public/GOIB_Adreces_IB/MapServer/"
                    , hideTree: false
                    , parentGroupNode: "node1"
                }*/

                //Serveis bàsics IDEIB
                , {
                    id: "GOIB_MTIB5m2012_Me"
                    , title: "Topogràfic 1:1000 Illes Balears"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MTIB1m_IB/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node3"
                }, {
                    id: "GOIB_MTIB5m2012_Me"
                    , title: "Topogràfic 1:5000 2012 Menorca"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MTIB5m2012_Me/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node3"
                }, {
                    id: "GOIB_MTIB5m2010_Ma"
                    , title: "Topogràfic 1:5000 2010 Mallorca"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MTIB5m2010_Ma/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node3"
                }, {
                    id: "GOIB_MTIB5m2008_MeEiFo"
                    , title: "Topogràfic 1:5000 2008 Menorca, Eivissa i Formentera"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MTIB5m2008_MeEiFo/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node3"
                }, {
                    id: "GOIB_MTIB5m2006_Ma"
                    , title: "Topogràfic 1:5000 2006 Mallorca"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MTIB5m2006_Ma/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node3"
                }, {
                    id: "GOIB_MTIB5m2002_MeEiFo"
                    , title: "Topogràfic 1:5000 2002 Menorca, Eivissa i Formentera"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "https://ideib.caib.es/geoserveis/services/public/GOIB_MTIB5m2002_MeEiFo/MapServer/WMSServer/"
                    , hideTree: false
                    , parentGroupNode: "node3"
                }, {
                    id: "OGC:WMS"
                    , title: "Cadastre"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://ovc.catastro.meh.es/Cartografia/WMS/ServidorWMS.aspx"
                    , hideTree: false
                    , parentGroupNode: "node4"
                }, {
                    id: "DPMT Costes"
                    , title: "DPMT Costas"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://wms.mapama.es/sig/Costas/DPMT/wms.aspx"
                    , hideTree: false
                    , parentGroupNode: "node4"
                }, {
                    id: "IDEE base"
                    , title: "IGNbase"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://www.ign.es/wms-inspire/ign-base"
                    , hideTree: false
                    , parentGroupNode: "node4"
                }, {
                    id: "MARMPosidonia"
                    , title: "Habitats: Posidonia"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://wms.magrama.es/sig/Biodiversidad/Habitat1120/wms.aspx"
                    , hideTree: false
                    , parentGroupNode: "node4"
                }, {
                    id: "MARMAgroclimatica"
                    , title: "Agricultura Caracterització agroclimàtica"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://wms.magrama.es/sig/Agricultura/CaractAgroClimaticas/wms.aspx"
                    , hideTree: false
                    , parentGroupNode: "node4"
                }, {
                    id: "MARMSIGPAC"
                    , title: "SIGPAC"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://wms.magrama.es/wms/wms.aspx"
                    , hideTree: false
                    , parentGroupNode: "node4"
                }, {
                    id: "MTN"
                    , title: "IGN Mapa Topogràfic Nacional (MTN)"
                    , hideTitle: false
                    , type: SITNA.Consts.layerType.WMS
                    , url: "http://www.ign.es/wms/primera-edicion-mtn"
                    , hideTree: false
                    , parentGroupNode: "node4"
                }
                ]
            };

            //Silme
            var silme = silme || {};

            //silme mv lang //var selectedLocale = location.search.substr(location.search.indexOf("?lang=") + 6) || "ca-CA";
            silme.locale = TC.Util.getLocaleUserChoice({
                cookieName: 'SILME.language'
            });
            //silme.locale = location.search.substr(location.search.indexOf("?lang=") + 6) || "ca-CA";

            silme.layout = TC.Util.getParameterByName("layout");

            SITNA.Cfg.layout = "layouts/silme";
           
            SITNA.Cfg.initialExtent = [
                    403281.7612
                    , 4819813.2556
                    , 499821.7280
                    , 4893039.9286
            ];
            
            SITNA.Cfg.maxExtent = [
                    100000
                    , 4660000
                    , 499821.7280
                    , 4893039.9286
            ];            

            SITNA.Cfg.baseLayers = [
                {
                    id: "IDE_WMTS"
                    , url: "http://ide.cime.es/geoserver2/gwc/service/wmts"
                    , layerNames: 'base_referencia:base_referencia'
                    , type: "WMTS"
                    , title: "Mapa base IDE Menorca"
                    , matrixSet: 'EPSG:3857'
                    , thumbnail: "//ide.cime.es/test/api_sitna/api-sitna-master/Build/TC/css/img/IDE_WMTS.png"
                    , isBase: true
                }
            ];

            SITNA.Cfg.defaultBaseLayer = "IDE_WMTS";
            SITNA.Cfg.locale = silme.locale;

            var layout = (silme.layout ? silme.layout : "layouts/silme");
            //en desús //var styleHref = (silme.layout ? silme.layout : TC.apiLocation + 'TC/layout/responsive');

            var map = new SITNA.Map("mapa", {
                layout: silme.layout.length === 0 ? {
                    //La variable accordion fa que nomes permeti un submenu obert dins cada menu alhora.
                    accordion: true,
                    script: layout + '/script.js',
                    style: layout + '/style.css',
                    markup: layout + '/markup.html',
                    config: layout + '/config.json',
                    i18n: layout + '/resources'
                } : silme.layout,
                locale: silme.locale,
                /*Controls disponibles:
                    TC.Consts.searchType = {
                        CADASTRAL: "cadastral",
                        COORDINATES: "coordinates",
                        MUNICIPALITY: "municipality",
                        COUNCIL: "council",
                        LOCALITY: "locality",
                        STREET: "street",
                        NUMBER: "number",
                        URBAN: "urban",
                        COMMONWEALTH: "commonwealth",
                        ROAD: "road",
                        ROADPK: "roadpk",
                        PLACENAME: "placename",
                        PLACENAMEMUNICIPALITY: "placenamemunicipality"
                        */
                controls: {
                    BirdEye: {
                            
                    },
                    FullScreen: {
                        
                    },
                    streetView: {
                        //viewDiv: "sv",
                        googleMapsKey: "AIzaSyAf6ju7n8qUZyrbSI6bVf1DdkzEjOcJG3Q"
                    },
                    search: {
                        //placeHolder: self.getLocaleString('search.list.cadastral'),
                        //placeHolder: '{@i18n $key="search.list.cadastral"/}',
                        //instructions: "search.instructions",
                        //no funciona
                        /*cadastralParcel: { //Això no funciona de moment (geoserver 1)
                            url: 'http://10.1.100.30/geoserver/ordenacio/wfs',
                            featurePrefix: 'ordenacio',
                            geometryName: 'the_geom',
                            featureType: 'ca007rus_parcela_pol',//aqui podem posar varies capes
                            municipality: {
                                featureType: 're007rus_municipis',
                                labelProperty: 'dsmun',
                                idProperty: 'idmun'
                            },
                            //sembla que no es necessari dataIdProperty: ['refcat'],
                            queryProperties: {
                                firstQueryWord: 'municipio', //codigo de municipio
                                secondQueryWord: 'poligon', //poligono
                                thirdQueryWord: 'parcela' //parcela
                            },
                            suggestionListHead: {
                                label: "search.list.cadastral",
                                color: [
                                    {
                                        ca007rus_parcela_pol: {
                                            title: "search.list.cadastral.rustic",
                                            color: [
                                                {
                                                    geomType: "polygon",
                                                    css: "strokeColor"
                                                }
                                            ]
                                        }
                                    }
                                ]
                            },
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#FFFFFF',
                                        fillOpacity: 0.1,
                                        strokeColor: '#555555',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        },*/
                        /*
                        town: {//Nuclis
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007rus_nuclis',
                            dataIdProperty: ['idnucli'],
                            queryProperties: {
                                firstQueryWord: ['dsnucli', 'dsmun', 'idnucli', 'idmun']
                            },
                            suggestionListHead: {
                                label: "search.list.urban",
                                color: "strokeColor"
                            },
                            outputProperties: ['dsnucli', 'dsmun'],
                            outputFormatLabel: '{0}',
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#000000',
                                        fillOpacity: 0.1,
                                        strokeColor: '#666',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        },*/
                        town: {
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007rus_xarxaviaria',
                            dataIdProperty: ['idcami'],
                            queryProperties: {
                                firstQueryWord: ['idcami', 'nomcami', 'altresnoms']
                            },
                            suggestionListHead: {
                                label: "xarxaViaria",
                                color: "strokeColor"
                            },
                            outputProperties: ['nomcami'],
                            outputFormatLabel: '{0}',
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#000000',
                                        fillOpacity: 0.1,
                                        strokeColor: '#fe06a5',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        },
                        //Cadastre encobert...
                        council: {
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 'ca007xxx_parcela',
                            dataIdProperty: ['nationalcadastralreference'],
                            queryProperties: {
                                firstQueryWord: ['nationalcadastralreference']
                            },
                            suggestionListHead: {
                                label: "search.list.cadastral",
                                color: "strokeColor"
                            },
                            outputProperties: ['nationalcadastralreference'],
                            outputFormatLabel: '{0}',
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#000000',
                                        fillOpacity: 0.1,
                                        strokeColor: '#ff0000',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        },
                        //toponim encobert...
                        placename: {
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007top_nomenclator_aux',
                            dataIdProperty: ['gid'],
                            queryProperties: {
                                firstQueryWord: ['nom', 'dstipus', 'dsmun']
                            },
                            suggestionListHead: {
                                label: "search.list.placename",
                                color: "strokeColor"
                            },
                            outputProperties: ['nom', 'dstipus', 'dsmun'],
                            outputFormat: TC.Consts.format.JSON,
                            outputFormatLabel: '{0} ({1}) - {2}',
                            searchWeight: 7,
                            styles: [
                                {
                                    point: {
                                        radius: 0,
                                        label: "nom",
                                        //angle: "angle",
                                        fontColor: "#CB0000",
                                        fontSize: 14,
                                        labelOutlineColor: "#FFFFFF",
                                        labelOutlineWidth: 4
                                    }
                                }
                            ]
                        },
                        municipality: {
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007rus_municipis',
                            dataIdProperty: ['idmun'],
                            queryProperties: {
                                firstQueryWord: ['idmun', 'dsmun']
                            },
                            suggestionListHead: {
                                label: "search.list.municipality",
                                color: "strokeColor"
                            },
                            outputProperties: ['dsmun'],
                            outputFormatLabel: '{0}',
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#000000',
                                        fillOpacity: 0.1,
                                        strokeColor: '#fe06a5',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        },
                        street: {
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007urb_eixcarrer',
                            dataIdProperty: ['idcarrer'],
                            queryProperties: {
                                firstQueryWord: ['idcarrer', 'nom']
                            },
                            suggestionListHead: {
                                label: "search.list.street",
                                color: "strokeColor"
                            },
                            outputProperties: ['nom'],
                            outputFormatLabel: '{0}',
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#000000',
                                        fillOpacity: 0.1,
                                        strokeColor: '#fe06a5',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        },
                        postalAddress: {
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007urb_portals',
                            dataIdProperty: ['gid'],
                            queryProperties: {
                                firstQueryWord: ['idmun', 'nommuni'],
                                secondQueryWord: ['idcarrer', 'nomcarrer'],
                                thirdQueryWord: ['nomportal']
                            },
                            suggestionListHead: {
                                label: "search.list.number",
                                color: "strokeColor"
                            },
                            outputProperties: ['nomcarrer', 'nomportal', 'nomnucli'],
                            outputFormatLabel: '{0}, {1}, {2}',
                            styles: [
                                {
                                    point: {
                                        radius: 0,
                                        label: "nomportal",
                                        angle: 0,
                                        fontColor: "#CB0000",
                                        fontSize: 14,
                                        labelOutlineColor: "#FFFFFF",
                                        labelOutlineWidth: 4
                                    }
                                }
                            ]
                        },
                        /*urban: {
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007rus_nuclis',
                            dataIdProperty: ['idnucli'],
                            queryProperties: {
                                firstQueryWord: ['dsnucli', 'dsmun', 'idnucli', 'idmun']
                            },
                            suggestionListHead: {
                                label: "search.list.urban",
                                color: "strokeColor"
                            },
                            outputProperties: ['dsnucli', 'dsmun'],
                            outputFormatLabel: '{0}',
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#000000',
                                        fillOpacity: 0.1,
                                        strokeColor: '#666',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        }*/
                        urban: {//Nuclis
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007rus_nuclis',
                            dataIdProperty: ['idnucli'],
                            queryProperties: {
                                firstQueryWord: ['dsnucli', 'dsmun', 'idnucli', 'idmun']
                            },
                            suggestionListHead: {
                                label: "search.list.urban",
                                color: "strokeColor"
                            },
                            outputProperties: ['dsnucli', 'dsmun'],
                            outputFormatLabel: '{0}',
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#000000',
                                        fillOpacity: 0.1,
                                        strokeColor: '#666',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        }/*
                        urban: {
                            url: 'http://10.1.100.30/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 're007rus_xarxaviaria',
                            dataIdProperty: ['idcami'],
                            queryProperties: {
                                firstQueryWord: ['idcami', 'nomcami', 'altresnoms']
                            },
                            suggestionListHead: {
                                label: "xarxaViaria",
                                color: "strokeColor"
                            },
                            outputProperties: ['nomcami'],
                            outputFormatLabel: '{0}',
                            styles: [
                                {
                                    polygon: {
                                        fillColor: '#000000',
                                        fillOpacity: 0.1,
                                        strokeColor: '#fe06a5',
                                        strokeWidth: 2,
                                        strokeOpacity: 1
                                    }
                                }
                            ]
                        }*/
                    }
                                        <%
                    if (clickCoords == "1")
                    {
                    %>
                    , click: {
                        active: true,
                        callback: function (coord) {
                            console.log("SilmeClick" + coord[0] + ";" + coord[1])
                        }
                    }
                    <%
                    }
                    %>
                }
            });

            map.loaded(function () {
                var lang = silme.locale;
                switch (lang) {
                    case 'en-US':
                        var element = document.getElementsByClassName("en-link")[0];
                        element.classList.add("tc-active");
                        break;
                    case 'es-ES':
                        var element = document.getElementsByClassName("es-link")[0];
                        element.classList.add("tc-active");
                        break;
                    default:
                        var element = document.getElementsByClassName("ca-link")[0];
                        element.classList.add("tc-active");
                        break;
                }
            });


        </script>
        <link rel="stylesheet" type="text/css" href="style/myStyle.css">
        <link rel="stylesheet" type="text/css" href="style/SilmeStyle.css">
        <link rel="stylesheet" type="text/css" href="style/SilmeModal.css">
    </body>
</html>