var silmeMap;
var silmeLayerCatalog;
var silmeSearch;



function setExtent(extent) {
    silmeMap.map.getView().fit(extent, { maxZoom: 18 });
}

function silmeAddLayer(layerName) {
    /*var $li = $span.parent();
    if (!$li.hasClass(TC.Consts.classes.LOADING) && !$li.hasClass(TC.Consts.classes.CHECKED)) {

        var layer = self._$roots.has($li).data(_dataKeys.LAYER);
        if (!layer) {
            layer = $li.data(_dataKeys.LAYER);
        }*/

        //SILME
        //Busquem la capa en cas que no la trobi:
        var layer
        if (!layer) {
            for (var k = 0; k < silmeLayerCatalog.layers.length; k++) {
                for (var m = 0; m < silmeLayerCatalog.layers[k].tree.children.length; m++) {
                    if (silmeLayerCatalog.layers[k].tree.children[m].name == layerName) {
                        layer = silmeLayerCatalog.layers[k];
                        break;
                    }
                    if (silmeLayerCatalog.layers[k].tree.children[m].children.length > 0) {
                        for (var p = 0; p < silmeLayerCatalog.layers[k].tree.children[m].children.length ; p++) {
                            if (silmeLayerCatalog.layers[k].tree.children[m].children[p].name == layerName) {
                                layer = silmeLayerCatalog.layers[k];
                                break;
                            }
                        }

                    }
                }
            }
        }


        if (layer && layerName) {
            var redrawTime = 1;

            if (/iPad/i.test(navigator.userAgent))
                redrawTime = 10;
            else if (TC.Util.detectFirefox())
                redrawTime = 250;

            if (!layer.title) {
                layer.title = layer.getTree().title;
            }

            //$li.addClass(TC.Consts.classes.LOADING).find('span').attr(TOOLTIP_DATA_ATTR, '');

            var reDraw = function ($element) {
                var deferred = new $.Deferred();
                setTimeout(function () {
                    $element[0].offsetHeight = $element[0].offsetHeight;
                    $element[0].offsetWidth = $element[0].offsetWidth;

                    deferred.resolve();
                }, redrawTime);
                return deferred.promise();
            };

            //reDraw($li).then(function () {
            var laCapaExisteix = false;
            for (var i = 0; i < silmeMap.map.getLayers().array_.length; i++)
            {
                if (silmeMap.map.getLayers().array_[i].values_.source.params_ != undefined)
                {
                    if (silmeMap.map.getLayers().array_[i].values_.source.params_.LAYERS == layerName) {
                        laCapaExisteix = true;
                    }
                }
            }
            if (!laCapaExisteix)
                silmeLayerCatalog.addLayerToMap(layer, layerName);
            //});
        //}
    }
}