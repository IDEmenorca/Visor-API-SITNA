<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="visor2018._default" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Visor IDE Menorca</title>
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
        <script src="js/SilmeSupport.js" type="text/javascript"></script>
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

            SITNA.Cfg.layout = "layouts/jose";
           
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

            var layout = (silme.layout ? silme.layout : "layouts/jose");
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