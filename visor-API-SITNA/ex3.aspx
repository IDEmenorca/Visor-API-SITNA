<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ex3.aspx.cs" Inherits="visor2018.ex3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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
            SITNA.Cfg.controls.scale = false;
            SITNA.Cfg.controls.scaleBar = true;
            SITNA.Cfg.OverviewMapOptions = true;

            <%=eines%>
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
                layerTreeGroups: [
                    <%=grups%>
                ],
                layers: [
                    <%=serveis%>
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
                <%=mapaDeFons%>
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
                        town: {
                            url: 'http://ide.cime.es/geoserver2/base_referencia/wfs',
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
                            url: 'http://ide.cime.es/geoserver2/base_referencia/wfs',
                            featurePrefix: 'base_referencia',
                            geometryName: 'the_geom',
                            featureType: 'ca007ins_parcela',
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
                            url: 'http://ide.cime.es/geoserver2/base_referencia/wfs',
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
                            url: 'http://ide.cime.es/geoserver2/base_referencia/wfs',
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
                            url: 'http://ide.cime.es/geoserver2/base_referencia/wfs',
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
                            url: 'http://ide.cime.es/geoserver2/base_referencia/wfs',
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
                        urban: {//Nuclis
                            url: 'http://ide.cime.es/geoserver2/base_referencia/wfs',
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
                        }
                    }
                }
            });


        </script>
        <link rel="stylesheet" type="text/css" href="style/myStyle.css">
        <link rel="stylesheet" type="text/css" href="style/SilmeStyle.css">
        <link rel="stylesheet" type="text/css" href="style/SilmeModal.css">
    </body>
</html>
