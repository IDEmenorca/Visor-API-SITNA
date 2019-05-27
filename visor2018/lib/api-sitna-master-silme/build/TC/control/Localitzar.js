TC.control = TC.control || {};

var changeEvt = 'change';
var keyupEvt = 'keyup';

//Silme MV
var done = false;
var timeout = false;
var tramsLoad = false;
var munLoad = false;
var viesLoad = false;
var time;

if (!TC.Control) {
    TC.syncLoadJS(TC.apiLocation + 'TC/Control');
}
if (!TC.filter) {
    TC.syncLoadJS(TC.apiLocation + 'TC/Filter');
}

TC.control.Localitzar = function (options) {
    var self = this;
    self._classSelector = '.' + self.CLASS;

    TC.Control.apply(self, arguments);

    var opts = options || {};
    self._$dialogDiv = $(TC.Util.getDiv(opts.dialogDiv));
    if (!opts.dialogDiv) {
        self._$dialogDiv.appendTo('body');
    }
};

TC.inherit(TC.control.Localitzar, TC.Control);

(function () {
    var ctlProto = TC.control.Localitzar.prototype;

    ctlProto.CLASS = 'tc-ctl-localitzar';

    ctlProto.template = {};

    if (TC.isDebug) {
        ctlProto.template[ctlProto.CLASS] = TC.apiLocation + "TC/templates/Localitzar.html";
        ctlProto.template[ctlProto.CLASS + '-dialog'] = TC.apiLocation + "TC/templates/LocalitzarDialog.html";
    } else {
        //Silme - Còpia de Download.js, hauriem de modificar-lo o si no es necessari eliminar-ho
        ctlProto.template[ctlProto.CLASS] = function () { dust.register(ctlProto.CLASS, body_0); function body_0(chk, ctx) { return chk.w("<h2>").h("i18n", ctx, {}, { "$key": "localitzar" }).w(" </h2><div class=\"tc-ctl-tctr tc-ctl-tctr-select\"><form><label class=\"tc-ctl-tctr-tab tc-ctl-download-image\" style=\"width:calc(100%/2 - 1px)\"><input type=\"radio\" name=\"sctnr-sel\" value=\"image\" /><span>").h("i18n", ctx, {}, { "$key": "dl.export.map" }).w("</span></label><label class=\"tc-ctl-tctr-tab tc-ctl-download-data\" style=\"width:calc(100%/2 - 1px)\"><input type=\"radio\" name=\"sctnr-sel\" value=\"data\" /><span>").h("i18n", ctx, {}, { "$key": "dl.export.vector" }).w("</span></label></form></div><div class=\"tc-ctl tc-ctl-tctr-elm tc-ctl-tctr-elm-image tc-group tc-ctl-download-cnt tc-ctl-download-image tc-hidden\"><label>").h("i18n", ctx, {}, { "$key": "format" }).w(":</label><select id=\"download-format-image\" class=\"tc-combo\"><option value=\"image/png\">PNG</option><option value=\"image/jpeg\">JPEG</option></select><div class=\"tc-ctl-download-div\"><input id=\"tc-ctl-download-image-qr\" class=\"tc-hidden\" type=\"checkbox\" checked style=\"display:none;\" /><label for=\"tc-ctl-download-image-qr\" class=\"tc-ctl-download-image-qr-label\" title=\"").h("i18n", ctx, {}, { "$key": "createQrCodeToImage" }).w("\">").h("i18n", ctx, {}, { "$key": "appendQRCode" }).w("</label></div><div class=\"tc-group tc-group tc-ctl-download-cnt\" style=\"text-align:right;\"><button type=\"button\" class=\"tc-ctl-download-btn tc-button tc-icon-button\" title=\"").h("i18n", ctx, {}, { "$key": "downloadImageFromCurrentMap" }).w("\" name=\"descargar\">").h("i18n", ctx, {}, { "$key": "download" }).w("</button></div></div><div class=\"tc-ctl tc-ctl-tctr-elm tc-ctl-tctr-elm-data tc-group tc-ctl-download-cnt tc-hidden\"><label>").h("i18n", ctx, {}, { "$key": "format" }).w(":</label><select id=\"download-format\" class=\"tc-combo\"><option value=\"GML32\">GML</option><option value=\"application/json\">GeoJSON</option><option value=\"application/vnd.google-earth.kml+xml\">KML (Google Earth)</option><option value=\"shape-zip\">Shape (ESRI)</option></select><div class=\"tc-ctl-download-div\"><i class=\"tc-ctl-download-help icon-question-sign\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"").h("i18n", ctx, {}, { "$key": "showDownloadHelp" }).w("\"></i></div><div class=\"tc-group tc-group tc-ctl-download-cnt\" style=\"text-align:right;\"><button type=\"button\" class=\"tc-ctl-download-btn tc-button tc-icon-button\" title=\"").h("i18n", ctx, {}, { "$key": "downloadLayersFromCurrentExtent" }).w("\" name=\"descargar\">").h("i18n", ctx, {}, { "$key": "download" }).w("</button></div><div class=\"tc-alert alert-warning tc-hidden\"><p id=\"zoom-msg\"><strong>").h("i18n", ctx, {}, { "$key": "tooManyFeatures" }).w(": </strong>").h("i18n", ctx, {}, { "$key": "tooManyFeatures.instructions" }).w("</p><p id=\"layers-msg\"><strong>").h("i18n", ctx, {}, { "$key": "noLayersLoaded" }).w(": </strong>").h("i18n", ctx, {}, { "$key": "noLayersLoaded.instructions" }).w("</p><p id=\"url-msg\"><strong>").h("i18n", ctx, {}, { "$key": "tooManySelectedLayers" }).w(": </strong>").h("i18n", ctx, {}, { "$key": "tooManySelectedLayers.instructions" }).w("</p><p id=\"noFeatures-msg\"><strong>").h("i18n", ctx, {}, { "$key": "noData" }).w(": </strong>").h("i18n", ctx, {}, { "$key": "noData.instructions" }).w("</p><p id=\"novalid-msg\"><strong>").h("i18n", ctx, {}, { "$key": "noValidService" }).w(": </strong>").h("i18n", ctx, {}, { "$key": "noValidService.instructions" }).w("</p></div></div>"); } body_0.__dustBody = !0; return body_0 };
        ctlProto.template[ctlProto.CLASS + '-dialog'] = function () { dust.register(ctlProto.CLASS + '-dialog', body_0); function body_0(chk, ctx) { return chk.w(" <div class=\"tc-ctl-download-help-dialog tc-modal\"><div class=\"tc-modal-background tc-modal-close\"></div><div class=\"tc-modal-window\"><div class=\"tc-modal-header\"><h3>").h("i18n", ctx, {}, { "$key": "downloadData" }).w("</h3><div class=\"tc-ctl-popup-close tc-modal-close\"></div></div><div class=\"tc-modal-body\"><p>").h("i18n", ctx, {}, { "$key": "dl.instructions.1|s" }).w("</p><ul><li>").h("i18n", ctx, {}, { "$key": "dl.instructions.2|s" }).w("</li><li>").h("i18n", ctx, {}, { "$key": "dl.instructions.3|s" }).w("</li><li>").h("i18n", ctx, {}, { "$key": "dl.instructions.4|s" }).w("<ul><li>").h("i18n", ctx, {}, { "$key": "dl.instructions.5|s" }).w("</li><li>").h("i18n", ctx, {}, { "$key": "dl.instructions.6|s" }).w("</li></ul></li></ul></div><div class=\"tc-modal-footer\"><button type=\"button\" class=\"tc-button tc-modal-close\">").h("i18n", ctx, {}, { "$key": "close" }).w("</button></div></div></div>"); } body_0.__dustBody = !0; return body_0 };
    }

    ctlProto.render = function (callback) {
        var self = this;
        self.getRenderedHtml(self.CLASS + '-dialog', null, function (html) {
            self._$dialogDiv.html(html);
        }).then(function () {
            TC.Control.prototype.render.call(self, function () {
                var selDisabledCLASS = self.CLASS + '-seldisabled';

                var cs = '.tc-ctl-tctr';
                self._selectors = {
                    TAB: cs + '-tab',
                    RADIOBUTTON: 'input[type=radio][name=sctnr-sel]',
                    ELEMENT: cs + '-elm'
                };

                var clickHandler = function (e) {
                    var $cb = $(this).closest(self._selectors.TAB).find(self._selectors.RADIOBUTTON);
                    var newValue = $cb.val();
                    var $elms = self._$div.find(self._selectors.ELEMENT);
                    if (self._oldValue === newValue && self.options.deselectable) {
                        setTimeout(function () {
                            $cb.prop("checked", false);
                        }, 0);
                        self._oldValue = null;
                        $active = $();
                        $hidden = $elms;
                    }
                    else {
                        $active = $elms.filter(self._selectors.ELEMENT + '-' + newValue);
                        $hidden = $elms.not($active);
                        self._oldValue = newValue;
                    }

                    $active.removeClass(TC.Consts.classes.HIDDEN);
                    $hidden.addClass(TC.Consts.classes.HIDDEN);
                    $cb.prop("checked", true);
                };

                self._$div.find('span').on(TC.Consts.event.CLICK, clickHandler);

                if (callback)
                    callback();
            });

            time = Date.now() + 10000;//Ara mes 10 seg.

            /*while (!timeout && !done) {
                if (!tramsLoad)
                    trams_load();
                if (!munLoad)
                    municipis_load();
                if (!viesLoad)
                    vies_load();

                if (tramsLoad && munLoad && viesLoad)
                    done = true;
                if (Date.now() > time)
                    timeout = true;
            }*/
            trams_load();
            municipis_load();
            vies_load();
        });
    };

    ctlProto.register = function (map) {
        var self = this;
        TC.Control.prototype.register.call(self, map);

        // GLS: Añado el flag al mapa para tenerlo en cuenta cuando se establece la función de carga de imágenes
        self.map.mustBeExportable = true;

        var _showHelp = function (evt) {
            evt.stopPropagation();
        };

        var veureTram = function (evt) {
            evt.stopPropagation();
            //fer zoom al tram corresponent
            var tramId = document.getElementById("ccavallsTrams")[document.getElementById("ccavallsTrams").selectedIndex].id
            var layerName = "ordenacio:or007cca_ccavalls";
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/tramExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "tram": tramId, "srs": srs }),
                success: function (data) {
                    var extent = data.d.split(';');
                    setExtent(extent);
                    silmeAddLayer(layerName);
                },
                error: function () { alert("Error") }
            })
        };

        var veureFita = function (evt) {
            //TODO Carregar capa cami de cavalls

            //fer zoom a la fita corresponent
            var fitaId = document.getElementById("ccavallsFites")[document.getElementById("ccavallsFites").selectedIndex].value;
            var layerName = "ordenacio:or007cca_senyalitzacio";
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/fitaExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "fita": fitaId, "srs": srs }),
                success: function (data) {
                    var extent = data.d.split(';');
                    //map.zoomToExtent(extent);
                    setExtent(extent);
                    silmeAddLayer(layerName);
                },
                error: function () { alert("Error") }
            })
        };

        var veureVia = function (evt) {
            //fer zoom a la via corresponent
            var viaId = document.getElementById("ptsquiVia")[document.getElementById("ptsquiVia").selectedIndex].id
            layerName = "base_referencia:re007rus_puntsquilometrics"
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/viaExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "via": viaId, "srs": srs }),
                success: function (data) {
                    if (data.d != '') {
                        var extent = data.d.split(';');
                        setExtent(extent);
                    }
                    silmeAddLayer(layerName);
                },
                error: function () { alert("Error") }
            })
        };

        var veurePk = function (evt) {
            //fer zoom al pk corresponent
            var pkId = document.getElementById("ptsquiPk")[document.getElementById("ptsquiPk").selectedIndex].id
            layerName = "base_referencia:re007rus_puntsquilometrics"
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/pkExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "pk": pkId, "srs": srs }),
                success: function (data) {
                    if (data.d != '') {
                        var extent = data.d.split(';');
                        setExtent(extent);
                    }
                    silmeAddLayer(layerName);
                },
                error: function () {
                    alert("Error")
                }
            })
        };

        var veureMuni = function (evt) {
            //fer zoom al municipi corresponent
            var munId = document.getElementById("guica_mun")[document.getElementById("guica_mun").selectedIndex].id
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/municipiExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "mun": munId, "srs": srs }),
                success: function (data) {
                    if (data.d != '') {
                        //var extent = data.d.split(';');
                        var obj = JSON.parse(data.d);
                        var extent = [obj.coords.x_min, obj.coords.y_min, obj.coords.x_max, obj.coords.y_max];
                        setExtent(extent);
                        silmeSearch.goToResult(obj.id, "municipality");
                    }
                },
                error: function () { alert("Error") }
            })
        };

        var veureNucl = function (evt) {
            //fer zoom al nucli corresponent
            var nucId = document.getElementById("guica_nuc")[document.getElementById("guica_nuc").selectedIndex].id
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/nucliExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "nuc": nucId, "srs": srs }),
                success: function (data) {
                    if (data.d != '') {
                        //var extent = data.d.split(';');
                        var obj = JSON.parse(data.d);
                        var extent = [obj.coords.x_min, obj.coords.y_min, obj.coords.x_max, obj.coords.y_max];
                        setExtent(extent);
                        silmeSearch.goToResult(obj.id, "urban");
                    }
                },
                error: function () { alert("Error") }
            })
        };

        var veureCarr = function (evt) {
            //fer zoom al carrer corresponent
            var munId = document.getElementById("guica_mun")[document.getElementById("guica_mun").selectedIndex].id;
            var carId = document.getElementById("guica_car")[document.getElementById("guica_car").selectedIndex].id;
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/carrerExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "car": carId, "mun": munId, "srs": srs }),
                success: function (data) {
                    if (data.d != '') {
                        //var extent = data.d.split(';');
                        var obj = JSON.parse(data.d);
                        var extent = [obj.coords.x_min, obj.coords.y_min, obj.coords.x_max, obj.coords.y_max];
                        setExtent(extent);
                        silmeSearch.goToResult(obj.id, "street");
                        //silmeSearch.goToResult("29_07032", "street");
                    }
                },
                error: function () { alert("Error") }
            })
        };

        var veurePort = function (evt) {
            //fer zoom al carrer corresponent
            var munId = document.getElementById("guica_mun")[document.getElementById("guica_mun").selectedIndex].id;
            var porId = document.getElementById("guica_por")[document.getElementById("guica_por").selectedIndex].id;
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/portalExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "por": porId, "mun": munId, "srs": srs }),
                success: function (data) {
                    if (data.d != '') {
                        var obj = JSON.parse(data.d);
                        //var extent = [obj.coords.x_min, obj.coords.y_min, obj.coords.x_max, obj.coords.y_max];
                        silmeSearch.goToResult(obj.id, "number");
                        //setExtent(extent);
                    }
                },
                error: function () { alert("Error") }
            })
        };

        var tramsChanged = function (evt) {
            //Actualitzam les fites
            var tramId = document.getElementById("ccavallsTrams")[document.getElementById("ccavallsTrams").selectedIndex].id

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/actualitzaTram",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "tram": tramId }),
                success: function (data) {
                    var options = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectFita') + ' -- </option>';
                    if (data.d != '') {
                        var dades = data.d.split(';');
                        $.each(dades, function (index, value) {
                            options += '<option >' + value + '</option>';
                        });
                    }
                    var selectTrams = document.getElementById("ccavallsFites");
                    selectTrams.innerHTML = options;
                },
                error: function () { alert("Error") }
            })
        };

        var viaChanged = function (evt) {
            var viaId = document.getElementById("ptsquiVia")[document.getElementById("ptsquiVia").selectedIndex].id

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/actualitzaPk",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "via": viaId }),
                success: function (data) {
                    var options = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectPK') + ' -- </option>';
                    if (data.d != '') {
                        var dades = data.d.split(';');
                        $.each(dades, function (index, value) {
                            var split = value.split('*');
                            options += '<option id=\'' + split[0] + '\'>' + split[1] + '</option>';
                        });
                    }
                    var selectTrams = document.getElementById("ptsquiPk");
                    selectTrams.innerHTML = options;
                },
                error: function () { alert("Error") }
            })
        };

        var muniChanged = function (evt) {
            var munId = document.getElementById("guica_mun")[document.getElementById("guica_mun").selectedIndex].id

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/actualitzaNuclis",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "mun": munId }),
                success: function (data) {
                    var options = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectNucli') + ' -- </option>';
                    if (data.d != '') {
                        var dades = data.d.split(';');
                        $.each(dades, function (index, value) {
                            var split = value.split('*');
                            options += '<option id=\'' + split[0] + '\'>' + split[1] + '</option>';
                        });
                    }
                    var selectTrams = document.getElementById("guica_nuc");
                    selectTrams.innerHTML = options;

                    nuclChanged();
                },
                error: function () { alert("Error") }
            })
        };

        var nuclChanged = function (evt) {
            var nucId = document.getElementById("guica_nuc")[document.getElementById("guica_nuc").selectedIndex].id

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/actualitzaCarrers",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "nuc": nucId }),
                success: function (data) {
                    var options = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectCarrer') + ' -- </option>';
                    if (data.d != '') {
                        var dades = data.d.split(';');
                        $.each(dades, function (index, value) {
                            var split = value.split('*');
                            options += '<option id=\'' + split[0] + '\'>' + split[1] + '</option>';
                        });
                    }
                    var selectTrams = document.getElementById("guica_car");
                    selectTrams.innerHTML = options;

                    carrChanged();
                },
                error: function () { alert("Error") }
            })
        };
        
        var carrChanged = function (evt) {
            var carId = document.getElementById("guica_car")[document.getElementById("guica_car").selectedIndex].id
            var nucId = document.getElementById("guica_nuc")[document.getElementById("guica_nuc").selectedIndex].id

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/actualitzaPortals",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "car": carId, "nuc": nucId }),
                success: function (data) {
                    var options = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectPortal') + ' -- </option>';
                    if (data.d != '') {
                        var dades = data.d.split(';');
                        $.each(dades, function (index, value) {
                            var split = value.split('*');
                            options += '<option id=\'' + split[0] + '\'>' + split[1] + '</option>';
                        });
                    }
                    var selectTrams = document.getElementById("guica_por");
                    selectTrams.innerHTML = options;
                },
                error: function () { alert("Error") }
            })
        };

        var vedatsLoad = function (evt) {
            var vedatsTxt = document.getElementById("vedats").value;
            if (vedatsTxt.length >= 3) {
                $.ajax({
                    type: "POST",
                    url: "src/DBRequest.aspx/carregaVedats",
                    data: JSON.stringify({ "vedats": vedatsTxt }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var selectTrams = document.getElementById("ved_cac");
                        // no funciona el placeholder selectTrams.innerHTML = "<input onkeyup=\"vedats_load()\" id=\"vedats\" type=\"text\" placeholder=\"{@i18n $key=\"cercaVedatsCaca\"/}\" class=\"tc-ctl-search-txt\" style=\"width:70%\" />";
                        //selectTrams.innerHTML = "<input onkeyup=\"vedats_load()\" id=\"vedats\" type=\"text\" class=\"tc-ctl-search-txt\" style=\"width:70%\" /><div class=\"dropdown-content autocomplete\" class=\"dropdown-content autocomplete\" style=\"width:300px;max-height: 350px;overflow-y: scroll;\"></div>";
                        selectTrams.innerHTML = '';
                        var options = '';
                        if (data.d != '') {
                            var dades = data.d.split(';');
                            $.each(dades, function (index, value) {
                                var split = value.split('*');
                                options += '<a id=\'' + split[0] + '\' class=\"clickVedat' + split[0] + '\" >' + split[1] + '</a>';
                                //options += '<a id=\'' + split[0] + '\' onclick=\"clickVedat(this.id)\" >' + split[1] + '</a>';
                                self._$div.on(TC.Consts.event.CLICK, '.clickVedat' + split[0], clickVedat);
                            });
                        }
                        selectTrams.innerHTML += options;
                        //document.getElementById("vedats").value = vedatsTxt;
                        document.getElementById("vedats").focus();
                    },
                    error: function () { alert("Error") }
                })
            }
            else {
                //var selectTrams = document.getElementById("ved_cac");
                //selectTrams.innerHTML = "<input onkeyup=\"vedats_load()\" id=\"vedats\" type=\"text\" class=\"tc-ctl-search-txt\" style=\"width:70%\" /><div class=\"dropdown-content autocomplete\" class=\"dropdown-content autocomplete\" style=\"width:300px;max-height: 350px;overflow-y: scroll;\"></div>";
                //document.getElementById("vedats").value = vedatsTxt;
                //document.getElementById("vedats").focus();
            }
        };

        var clickVedat = function (evt) {
            layerName = "ambiental:am007cac_vedats";
            var srs = silmeMap.map.getView().projection_.code_.substr(silmeMap.map.getView().projection_.code_.indexOf(':') + 1);

            $.ajax({
                type: "POST",
                url: "src/DBRequest.aspx/vedatCoordsExtent",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ "ved": evt.currentTarget.id, "srs": srs }),
                success: function (data) {
                    var coordsExt = data.d.split('*');
                    var coords = coordsExt[0];
                    var splitCoords = coords.split(';');
                    var markerOptions = {
                        url: "layouts/silme/img/colgante.png",
                        group: "Vedats"
                    };
                    map.addMarker([splitCoords[0], splitCoords[1]], markerOptions);
                    var ext = coordsExt[1];
                    var extent = ext.split(';');
                    setExtent(extent);
                    silmeAddLayer(layerName);
                },
                error: function () { alert("Error") }
            })
        };

        self._$div.on(TC.Consts.event.CLICK, '.tc-btn-localitza-tram', veureTram);
        self._$div.on(TC.Consts.event.CLICK, '.tc-btn-localitza-fita', veureFita);
        self._$div.on(TC.Consts.event.CLICK, '.tc-btn-localitza-via', veureVia);
        self._$div.on(TC.Consts.event.CLICK, '.tc-btn-localitza-pk', veurePk);
        self._$div.on(TC.Consts.event.CLICK, '.tc-btn-localitza-muni', veureMuni);
        self._$div.on(TC.Consts.event.CLICK, '.tc-btn-localitza-nucl', veureNucl);
        self._$div.on(TC.Consts.event.CLICK, '.tc-btn-localitza-carr', veureCarr);
        self._$div.on(TC.Consts.event.CLICK, '.tc-btn-localitza-port', veurePort);

        self._$div.on(changeEvt, '.tc-combo-localitza-tram', tramsChanged);
        self._$div.on(changeEvt, '.tc-combo-localitza-via', viaChanged);
        self._$div.on(changeEvt, '.tc-combo-localitza-muni', muniChanged);
        self._$div.on(changeEvt, '.tc-combo-localitza-nucl', nuclChanged);
        self._$div.on(changeEvt, '.tc-combo-localitza-carr', carrChanged);

        self._$div.on(keyupEvt, '.tc-ctl-search-txt-ved', vedatsLoad);
    };


    function trams_load() {
        $.ajax({
            type: "POST",
            url: "src/DBRequest.aspx/carregaTrams",
            data: '',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                var options = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectTram') + ' -- </option>';
                if (data.d != '') {
                    var dades = data.d.split(';');
                    $.each(dades, function (index, value) {
                        var split = value.split('*');
                        options += '<option id=\'' + split[0] + '\'>' + split[1] + '</option>';
                    });
                }
                var selectTrams = document.getElementById("ccavallsTrams");
                if (selectTrams != null) {
                    selectTrams.innerHTML = options;

                    fites_load();
                    tramsLoad = true;
                } else if (Date.now() < time)//si han passat menys de 10 segons
                {
                    trams_load();
                }
            },
            error: function () { alert("Error") }
        })

    }

    function vies_load() {
        $.ajax({
            type: "POST",
            url: "src/DBRequest.aspx/carregaVies",
            data: '',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                var options = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectVia') + ' -- </option>';
                if (data.d != '') {
                    var dades = data.d.split(';');
                    $.each(dades, function (index, value) {
                        var split = value.split('*');
                        options += '<option id=\'' + split[0] + '\'>' + split[1] + '</option>';
                    });
                }
                var selectMun = document.getElementById("ptsquiVia");
                if (selectMun != null)
                {
                    selectMun.innerHTML = options;

                    pk_load();
                    viesLoad = true;
                } else if(Date.now() < time)//si han passat menys de 10 segons
                {
                    vies_load();
                }
            },
            error: function () { alert("Error") }
        })
    }

    function municipis_load() {
        $.ajax({
            type: "POST",
            url: "src/DBRequest.aspx/carregaMunicipi",
            data: '',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                var options = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectMunicipi') + ' -- </option>';
                if (data.d != '') {
                    var dades = data.d.split(';');
                    $.each(dades, function (index, value) {
                        var split = value.split('*');
                        options += '<option id=\'' + split[0] + '\'>' + split[1] + '</option>';
                    });
                }
                var selectMun = document.getElementById("guica_mun");
                if (selectMun != null) {
                    selectMun.innerHTML = options;

                    carrerer_load();
                    munLoad = true;
                } else if (Date.now() < time)//si han passat menys de 10 segons
                {
                    municipis_load();
                }
            },
            error: function () { alert("Error") }
        })
    }

    function pk_load() {
        var selectPk = document.getElementById("ptsquiPk");
        selectPk.innerHTML = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectPK') + ' -- </option>';
    }

    function carrerer_load() {
        var selectNuc = document.getElementById("guica_nuc");
        selectNuc.innerHTML = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectNucli') + ' -- </option>';

        var selectCarr = document.getElementById("guica_car");
        selectCarr.innerHTML = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectCarrer') + ' -- </option>';

        var selectPort = document.getElementById("guica_por");
        selectPort.innerHTML = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectPortal') + ' -- </option>';
    }

    function fites_load() {
        var selectFites = document.getElementById("ccavallsFites");
        selectFites.innerHTML = '<option disabled selected value> -- ' + TC.Util.getLocaleString(SITNA.Cfg.locale, 'selectFita') + ' -- </option>';
    }
})();
