﻿TC.control = TC.control || {};

if (!TC.control.GeometryFeatureInfo) {
    TC.syncLoadJS(TC.apiLocation + 'TC/control/GeometryFeatureInfo');
}

(function () {
    TC.control.LineFeatureInfo = function () {
        var self = this;
        TC.control.GeometryFeatureInfo.apply(this, arguments);
        self.geometryType = TC.Consts.geom.POLYLINE;
    };

    TC.inherit(TC.control.LineFeatureInfo, TC.control.GeometryFeatureInfo);

    var ctlProto = TC.control.LineFeatureInfo.prototype;

    ctlProto.CLASS = 'tc-ctl-finfo';

    ctlProto.template = {};
    if (TC.isDebug) {
        ctlProto.template[ctlProto.CLASS] = TC.apiLocation + "TC/templates/FeatureInfo.html";
        ctlProto.template[ctlProto.CLASS + '-dialog'] = TC.apiLocation + "TC/templates/FeatureInfoDialog.html";
    }
    else {
        ctlProto.template[ctlProto.CLASS] = function () { dust.register(ctlProto.CLASS, body_0); function body_0(chk, ctx) { return chk.w("<ul class=\"tc-ctl-finfo-services\">").s(ctx.get(["services"], false), ctx, { "else": body_1, "block": body_2 }, {}).w("</ul>").x(ctx.get(["featureCount"], false), ctx, { "block": body_25 }, {}); } body_0.__dustBody = !0; function body_1(chk, ctx) { return chk.w("<li class=\"tc-ctl-finfo-empty\">").h("i18n", ctx, {}, { "$key": "noData" }).w("</li>"); } body_1.__dustBody = !0; function body_2(chk, ctx) { return chk.w("<li><h3>").x(ctx.getPath(false, ["mapLayer", "title"]), ctx, { "else": body_3, "block": body_4 }, {}).w("</h3><div class=\"tc-ctl-finfo-service-content\">").s(ctx.get(["hasLimits"], false), ctx, { "else": body_5, "block": body_24 }, {}).w("</div></li>"); } body_2.__dustBody = !0; function body_3(chk, ctx) { return chk.f(ctx.getPath(false, ["mapLayer", "id"]), ctx, "h"); } body_3.__dustBody = !0; function body_4(chk, ctx) { return chk.f(ctx.getPath(false, ["mapLayer", "title"]), ctx, "h"); } body_4.__dustBody = !0; function body_5(chk, ctx) { return chk.w("<ul class=\"tc-ctl-finfo-layers\">").s(ctx.get(["layers"], false), ctx, { "else": body_6, "block": body_7 }, {}).w("</ul>"); } body_5.__dustBody = !0; function body_6(chk, ctx) { return chk.w("<li class=\"tc-ctl-finfo-empty\">").h("i18n", ctx, {}, { "$key": "noDataAtThisService" }).w("</li>"); } body_6.__dustBody = !0; function body_7(chk, ctx) { return chk.w("<li><h4>").s(ctx.get(["path"], false), ctx, { "block": body_8 }, {}).w(" <span class=\"tc-ctl-finfo-layer-n\">").f(ctx.getPath(false, ["features", "length"]), ctx, "h").w("</span> </h4> <div class=\"tc-ctl-finfo-layer-content\"><ul class=\"tc-ctl-finfo-features\">").s(ctx.get(["features"], false), ctx, { "else": body_10, "block": body_11 }, {}).w("</ul></div></li>"); } body_7.__dustBody = !0; function body_8(chk, ctx) { return chk.f(ctx.getPath(true, []), ctx, "h").h("sep", ctx, { "block": body_9 }, {}); } body_8.__dustBody = !0; function body_9(chk, ctx) { return chk.w(" &bull; "); } body_9.__dustBody = !0; function body_10(chk, ctx) { return chk.w("<li class=\"tc-ctl-finfo-empty\">").h("i18n", ctx, {}, { "$key": "noDataInThisLayer" }).w("</li>"); } body_10.__dustBody = !0; function body_11(chk, ctx) { return chk.w("<li>").x(ctx.get(["rawContent"], false), ctx, { "else": body_12, "block": body_18 }, {}).w("</li>"); } body_11.__dustBody = !0; function body_12(chk, ctx) { return chk.x(ctx.get(["error"], false), ctx, { "else": body_13, "block": body_17 }, {}); } body_12.__dustBody = !0; function body_13(chk, ctx) { return chk.w("<h5>").f(ctx.get(["id"], false), ctx, "h").w("</h5><table").x(ctx.get(["geometry"], false), ctx, { "block": body_14 }, {}).w("><tbody>").s(ctx.get(["attributes"], false), ctx, { "block": body_15 }, {}).w("</tbody></table>").x(ctx.get(["geometry"], false), ctx, { "block": body_16 }, {}); } body_13.__dustBody = !0; function body_14(chk, ctx) { return chk.w(" title=\"").h("i18n", ctx, {}, { "$key": "clickToCenter" }).w("\""); } body_14.__dustBody = !0; function body_15(chk, ctx) { return chk.w("<tr><th class=\"tc-ctl-finfo-attr\">").f(ctx.get(["name"], false), ctx, "h").w("</th><td class=\"tc-ctl-finfo-val\">").f(ctx.get(["value"], false), ctx, "h").w("</td></tr>"); } body_15.__dustBody = !0; function body_16(chk, ctx) { return chk.w("<div class=\"tc-ctl-finfo-tools\"><button class=\"tc-ctl-finfo-tools-btn\" title=\"").h("i18n", ctx, {}, { "$key": "download" }).w("/").h("i18n", ctx, {}, { "$key": "share" }).w("\">").h("i18n", ctx, {}, { "$key": "download" }).w("/").h("i18n", ctx, {}, { "$key": "share" }).w("</button></div>"); } body_16.__dustBody = !0; function body_17(chk, ctx) { return chk.w("<span class=\"tc-ctl-finfo-errors\">").h("i18n", ctx, {}, { "$key": "fi.error" }).w("<span class=\"tc-ctl-finfo-error-text\">").f(ctx.get(["error"], false), ctx, "h").w("</span></span>"); } body_17.__dustBody = !0; function body_18(chk, ctx) { return chk.w("<h5>").h("i18n", ctx, {}, { "$key": "feature" }).w("</h5>").h("eq", ctx, { "else": body_19, "block": body_20 }, { "key": ctx.get(["rawFormat"], false), "value": "text/html" }); } body_18.__dustBody = !0; function body_19(chk, ctx) { return chk.w("<pre>").f(ctx.get(["rawContent"], false), ctx, "h").w("</pre>"); } body_19.__dustBody = !0; function body_20(chk, ctx) { return chk.w(" ").x(ctx.get(["expandUrl"], false), ctx, { "block": body_21 }, {}); } body_20.__dustBody = !0; function body_21(chk, ctx) { return chk.h("ne", ctx, { "else": body_22, "block": body_23 }, { "key": ctx.get(["expandUrl"], false), "value": "" }); } body_21.__dustBody = !0; function body_22(chk, ctx) { return chk.w("<iframe src=\"").f(ctx.get(["rawUrl"], false), ctx, "h").w("\" />"); } body_22.__dustBody = !0; function body_23(chk, ctx) { return chk.w("<div class=\"tc-ctl-finfo-features-iframe-cnt\"><iframe src=\"").f(ctx.get(["rawUrl"], false), ctx, "h").w("\" /><a class=\"tc-ctl-finfo-open\" onclick=\"window.open('").f(ctx.get(["expandUrl"], false), ctx, "h").w("', '_blank')\" title=\"").h("i18n", ctx, {}, { "$key": "expand" }).w("\"></a></div>"); } body_23.__dustBody = !0; function body_24(chk, ctx) { return chk.w("<span class=\"tc-ctl-finfo-errors\">").f(ctx.get(["hasLimits"], false), ctx, "h").w("</span>"); } body_24.__dustBody = !0; function body_25(chk, ctx) { return chk.h("gt", ctx, { "block": body_26 }, { "key": ctx.get(["featureCount"], false), "value": "1", "type": "number" }); } body_25.__dustBody = !0; function body_26(chk, ctx) { return chk.w("<a class=\"tc-ctl-btn tc-ctl-finfo-btn-prev\">").h("i18n", ctx, {}, { "$key": "previous" }).w("</a><div class=\"tc-ctl-finfo-counter\"><span class=\"tc-ctl-finfo-idx\"></span>/").f(ctx.get(["featureCount"], false), ctx, "h").w("</div><a class=\"tc-ctl-btn tc-ctl-finfo-btn-next\">").h("i18n", ctx, {}, { "$key": "next" }).w("</a>"); } body_26.__dustBody = !0; return body_0 };
        ctlProto.template[ctlProto.CLASS + '-dialog'] = function () { dust.register(ctlProto.CLASS + '-dialog', body_0); function body_0(chk, ctx) { return chk.w("<div class=\"tc-ctl-finfo-dialog tc-modal\"><div class=\"tc-modal-background tc-modal-close\"></div><div class=\"tc-modal-window\"><div class=\"tc-modal-header\"><h3>").h("i18n", ctx, {}, { "$key": "feature" }).w("</h3><div class=\"tc-ctl-popup-close tc-modal-close\"></div></div><div class=\"tc-modal-body\"><div class=\"tc-ctl-finfo-dialog-dl\"><h2>").h("i18n", ctx, {}, { "$key": "download" }).w("</h2><div><button class=\"tc-button tc-ctl-finfo-dl-btn-kml\" data-format=\"KML\" title=\"KML\">KML</button><button class=\"tc-button tc-ctl-finfo-dl-btn-gml\" data-format=\"GML\" title=\"GML\">GML</button><button class=\"tc-button tc-ctl-finfo-dl-btn-geojson\" data-format=\"GeoJSON\" title=\"GeoJSON\">GeoJSON</button><button class=\"tc-button tc-ctl-finfo-dl-btn-wkt\" data-format=\"WKT\" title=\"WKT\">WKT</button></div></div><div class=\"tc-ctl-finfo-dialog-share\"></div></div><div class=\"tc-modal-footer\"><button type=\"button\" class=\"tc-button tc-modal-close\">").h("i18n", ctx, {}, { "$key": "close" }).w("</button></div></div></div>"); } body_0.__dustBody = !0; return body_0 };
    }

})();