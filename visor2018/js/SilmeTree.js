var treeLayers;

function silmeTree_update() {
    if ($(".tc-ctl-lcat-tree").html() != null) {
        if (SITNA.Cfg.controls.layerCatalog.layerTreeGroups != null) {

            //Busquem quines capes estiren de cada layerTreeGroups

            var content = "";


            if (SITNA.Cfg.controls.layerCatalog.layerTreeGroups.length > 0) {
                if (treeLayers.length > 0) {

                    var neededNode = false;

                    for (var i = 0; i < SITNA.Cfg.controls.layerCatalog.layerTreeGroups.length; i++) {
                        if (SITNA.Cfg.controls.layerCatalog.layers != null) { //mv 20190307
                            for (var j = 0; j < SITNA.Cfg.controls.layerCatalog.layers.length; j++) {
                                if (SITNA.Cfg.controls.layerCatalog.layers[j].parentGroupNode != null) {
                                    if (SITNA.Cfg.controls.layerCatalog.layers[j].parentGroupNode == SITNA.Cfg.controls.layerCatalog.layerTreeGroups[i].id) {
                                        neededNode = true;
                                        break;
                                    }
                                }
                            }
                        }

                        if (neededNode == true) {
                            if (i == 0)//mv 20190404
                                content += '<ul class="tc-ctl-lcat-branch"><li class="tc-ctl-lcat-node" id="' + SITNA.Cfg.controls.layerCatalog.layerTreeGroups[i].id + '"><span>' + SITNA.Cfg.controls.layerCatalog.layerTreeGroups[i].title + '</span>';
                            else
                                content += '<ul class="tc-ctl-lcat-branch"><li class="tc-ctl-lcat-node tc-collapsed" id="' + SITNA.Cfg.controls.layerCatalog.layerTreeGroups[i].id + '"><span>' + SITNA.Cfg.controls.layerCatalog.layerTreeGroups[i].title + '</span>';

                            content += '<ul class="tc-ctl-lcat-branch tc-collapsed">';

                            //Oplim amb els nodes que toquin
                            for (var k = 0; k < treeLayers.length; k++) {
                                if (treeLayers[k].parentGroupNode != null) {
                                    if (treeLayers[k].parentGroupNode == SITNA.Cfg.controls.layerCatalog.layerTreeGroups[i].id) {
                                        if (treeLayers[k].tree != null) {
                                            content += '<li class="tc-ctl-lcat-node tc-collapsed" data-tc-layer-name="" data-tc-layer-uid="' + treeLayers[k].tree.uid + '">';
                                            var nodeUid = "[data-tc-layer-uid=" + treeLayers[k].tree.uid + "]";
                                            content += $(nodeUid)[0].innerHTML;
                                            content += '</li>';
                                        }
                                    }
                                }
                            }
                            content += '</ul>';
                            content += '</li></ul>';
                        }

                    }

                    //Mirem si hi ha alguna capa sense layerTreeGroups

                    neededNode = false;
                    for (var k = 0; k < treeLayers.length; k++) {
                        if (treeLayers[k].parentGroupNode == null) {
                            neededNode = true;
                            break;
                        }
                    }

                    if (neededNode == true) {
                        var titleOtherLayers = "Otros servicios";
                        if (SITNA.Cfg.locale == "ca-CA") titleOtherLayers = "Altres serveis";
                        content += '<ul class="tc-ctl-lcat-branch"><li class="tc-ctl-lcat-node" id="9999"><span><strong>' + titleOtherLayers + '</strong></span>';
                        content += '<ul class="tc-ctl-lcat-branch">';

                        //Oplim amb els nodes que toquin
                        for (var k = 0; k < treeLayers.length; k++) {
                            if (treeLayers[k].parentGroupNode == null) {
                                //if (treeLayers[k].parentGroupNode == SITNA.Cfg.controls.layerCatalog.layerTreeGroups[i].id){
                                //if (treeLayers[k].tree != null){
                                content += '<li class="tc-ctl-lcat-node tc-collapsed" data-tc-layer-name="" data-tc-layer-uid="' + treeLayers[k].tree.uid + '">';
                                var nodeUid = "[data-tc-layer-uid=" + treeLayers[k].tree.uid + "]";
                                content += $(nodeUid)[0].innerHTML;
                                content += '</li>';
                                //}
                                //}
                            }
                        }
                        content += '</ul>';
                        content += '</li></ul>';
                    }
                    
                } else {
                    content += '<div style="text-align: center; margin-top: 5px"><img src="' + SITNA.Cfg.layout + '/img/spinner.gif" alt="loading" align="middle"></div>';
                }
            }

            if (content != "") {
                $(".tc-ctl-lcat-tree").html("");
                $(".tc-ctl-lcat-tree").html(content);
            }

            if ($('.tc-ctl-lcat-branch').find('ul').first().length > 0)//mv 20190404
            {
                $('.tc-ctl-lcat-branch').find('ul').first().toggleClass(TC.Consts.classes.COLLAPSED);
            }


            $(".tc-ctl-lcat-btn-info").click(function () {
                if (!$(this).hasClass(TC.Consts.classes.CHECKED)) {
                    customShowLayerInfo($(this));
                    $(this).addClass(TC.Consts.classes.CHECKED);

                } else {
                    $(this).removeClass(TC.Consts.classes.CHECKED);
                    self.hideLayerInfo();
                }
                //if (info!="") alert(info.title);
            });


        }
    }

}

function customShowLayerInfo(self) {
    layerName = self.parent()[0].attributes[1].value;
    layerUid = self.parent()[0].attributes[2].value;

    var layer = null;
    var info = "";
    //alert(layerName + " " + layerUid);

    //Silme - Potser ho podem eliminar desde aqui
    /*
    for (var i = 0; i < treeLayers.length; i++) {
        for (var j = 0; j < treeLayers[i].tree.children.length; j++) {
            if (treeLayers[i].tree.children[j].uid == layerUid) {
                layer = treeLayers[i];
                info = layer.wrap.getInfo(layerName);
                break;
            }
        }
    }

    if (info == "") {
        for (var i = 0; i < treeLayers.length; i++) {
            for (var j = 0; j < treeLayers[i].tree.children.length; j++) {
                if (treeLayers[i].tree.children[j].children.length > 0) {
                    for (var k = 0; k < treeLayers[i].tree.children[j].children.length; k++) {
                        if (treeLayers[i].tree.children[j].children[k].uid == layerUid) {
                            layer = treeLayers[i];
                            info = layer.wrap.getInfo(layerName);
                            break;
                        }
                    }
                }
            }
        }
    }
    */
    //Silme - Potser ho podem eliminar fins aqui

    if (!layer) {
        for (var k = 0; k < treeLayers.length; k++) {
            var rama = treeLayers[k].tree;
            cercaNode(rama, layerUid);
            if (ret) {
                layer = treeLayers[k];
                info = layer.wrap.getInfo(layerName);
                ret = false;
                break;
            }
        }
    }

    if (layerName.includes(":"))//Silme
        info.layerid = layerName.substr(layerName.indexOf(":") + 1);
    else
        info.layerid = layerName;


    var $tree = $("#catalog").find('.tc-ctl-lcat-btn-info');
    $tree.removeClass(TC.Consts.classes.CHECKED);

    var $info = $("#catalog").find('.tc-ctl-lcat-info');

    if (!self.hasClass(TC.Consts.classes.CHECKED)) {
        self.addClass(TC.Consts.classes.CHECKED);
        //showLayerInfo
        $info.removeClass(TC.Consts.classes.HIDDEN);
        //$info.html(info.abstract);
        dust.render("tc-ctl-lcat-info", info, function (err, out) {
            $info.html(out)
        });
        $info.find('.tc-ctl-lcat-info-close').on(TC.Consts.event.CLICK, function () {
            $("#catalog").find('.tc-ctl-lcat-info-close').removeClass(TC.Consts.classes.CHECKED);
            $("#catalog").find('.tc-ctl-lcat-info').addClass(TC.Consts.classes.HIDDEN);
            $("#catalog").find('.tc-ctl-lcat-btn-info, .tc-ctl-lcat-search-btn-info').removeClass(TC.Consts.classes.CHECKED);
        });

    } else {
        self.removeClass(TC.Consts.classes.CHECKED);
        $("#catalog").find('.tc-ctl-lcat-btn-info, .tc-ctl-lcat-search-btn-info').removeClass(TC.Consts.classes.CHECKED);
        $("#catalog").find('.tc-ctl-lcat-info').addClass(TC.Consts.classes.HIDDEN);
    }
};

function showLayerInfo (layer, name) {
    var self = this;
    var result = null;

    var $info = self._$div.find('.' + self.CLASS + '-info');

    var toggleInfo = function (layerName, info) {
        var result = false;
        var lName = $info.data(_dataKeys.LAYERNAME);
        //if (lName !== undefined && lName.toString() === layerName) {
        //    $info.data(_dataKeys.LAYERNAME, '');
        //    $info.removeClass(TC.Consts.classes.HIDDEN);
        //}
        //else {
        if (info) {
            result = true;
            $info.data(_dataKeys.LAYERNAME, layerName);
            $info.removeClass(TC.Consts.classes.HIDDEN);
            dust.render(self.CLASS + '-info', info, function (err, out) {
                $info.html(out);
                if (err) {
                    TC.error(err);
                }
                $info.find('.' + self.CLASS + '-info-close').on(TC.Consts.event.CLICK, function () {
                    self.hideLayerInfo();
                });
            });
        }
        //}
        return result;
    };

    self._$div.find('.' + self.CLASS + '-btn-info, .' + self.CLASS + '-search-btn-info').removeClass(TC.Consts.classes.CHECKED);

    self._$roots.each(function (idx, elm) {
        var $root = $(elm);
        if ($root.data(_dataKeys.LAYER) === layer) {
            var $as = $root.find('.' + self.CLASS + '-btn-info');
            $as.each(function (i, e) {
                var $a = $(e);
                var n = $a.parent().data(_dataKeys.LAYERNAME).toString();
                if (n === name) {
                    var info = $a.data(_dataKeys.LAYERINFO);
                    self._$div.find('li [data-tc-layer-name="' + n + '"] > button').toggleClass(TC.Consts.classes.CHECKED, toggleInfo(n, info));
                    result = info;
                    return false;
                }
            });
            return false;
        }
    });

    return result;
};

function hideLayerInfo() {
    $('.tc-ctl-lcat-info').addClass(TC.Consts.classes.HIDDEN);
    /*var self = this;
    self._$div.find('.' + self.CLASS + '-btn-info, .' + self.CLASS + '-search-btn-info').removeClass(TC.Consts.classes.CHECKED);
    self._$div.find('.' + self.CLASS + '-info').addClass(TC.Consts.classes.HIDDEN);*/
};

//Silme - Funció reciursiva que recorre tot l'arbre
function cercaNode(rama, layerUid) {
    if (rama.children.length > 0) {
        for (var m = 0; m < rama.children.length; m++) {
            if (rama.children[m].uid == layerUid) {
                ret = true;
            } else if (rama.children[m].children.length < 0) {
                //
            }
            else if (rama.children[m].children.length > 0) {
                cercaNode(rama.children[m], layerUid)
            }

        }
    }
}