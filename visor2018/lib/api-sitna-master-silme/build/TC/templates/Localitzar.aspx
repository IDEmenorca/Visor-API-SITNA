<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Localitzar.aspx.cs" Inherits="visor2018.lib.api_sitna_master_silme.build.TC.control.Localitzar" %>
<h2>{@i18n $key="localitzar"/} </h2>
<div class="tc-ctl-tctr tc-ctl-tctr-select">
    <form>
        <label class="tc-ctl-tctr-tab tc-ctl-localitzar-cca" style="width:calc(100%/3 - 1px)"><input checked type="radio" name="sctnr-sel" value="cca" /><span>{@i18n $key="fitesCamiCavalls"/}</span></label>
        <label class="tc-ctl-tctr-tab tc-ctl-localitzar-vedca" style="width:calc(100%/3 - 1px)"><input type="radio" name="sctnr-sel" value="vedca" /><span>{@i18n $key="vedatsCaca"/}</span></label>
        <label class="tc-ctl-tctr-tab tc-ctl-localitzar-guica" style="width:calc(100%/3 - 1px)"><input type="radio" name="sctnr-sel" value="guica" /><span>{@i18n $key="guiaCarrers"/}</span></label>
    </form>
</div>
<!-- silme mv -- tc-ctl-tctr-elm-cca fa referencia a el value del label que coincideix amb el darrer guió (cca) -->
<div class="tc-ctl tc-ctl-tctr-elm tc-ctl-tctr-elm-cca tc-group tc-ctl-download-cnt tc-ctl-download-image">
    <form runat="server" >
        <label>{@i18n $key="trams"/}:</label>
        <asp:DropDownList id="ccavallsTrams" runat="server" class="tc-combo" OnSelectedIndexChanged="actualitzaTram">
        </asp:DropDownList>

        <label>{@i18n $key="fites"/}:</label>
        <asp:DropDownList id="ccavallsFites" runat="server" class="tc-combo" AutoPostBack="true" >
        </asp:DropDownList>
    </form>
</div>
<div class="tc-ctl tc-ctl-tctr-elm tc-ctl-tctr-elm-vedca tc-group tc-ctl-download-cnt tc-hidden">
    <label>{@i18n $key="format"/}:</label>
    <select id="download-format" class="tc-combo">
        <option value="GML32">GML</option>
        <option value="application/json">GeoJSON</option>
        <option value="application/vnd.google-earth.kml+xml">KML (Google Earth)</option>
        <option value="shape-zip">Shape (ESRI)</option>
    </select>
    <div class="tc-ctl-download-div">
        <i class="tc-ctl-download-help icon-question-sign" data-toggle="tooltip" data-placement="top" title="{@i18n $key=" showDownloadHelp"/}"></i>
    </div>
    <div class="tc-group tc-group tc-ctl-download-cnt" style="text-align:right;">
        <button type="button" class="tc-ctl-download-btn tc-button tc-icon-button" title="{@i18n $key=" downloadLayersFromCurrentExtent"/}" name="descargar">{@i18n $key="download"/}</button>
    </div>
    <div class="tc-alert alert-warning tc-hidden">
        <p id="zoom-msg"><strong>{@i18n $key="tooManyFeatures"/}: </strong>{@i18n $key="tooManyFeatures.instructions"/}</p>
        <p id="layers-msg"><strong>{@i18n $key="noLayersLoaded"/}: </strong>{@i18n $key="noLayersLoaded.instructions"/}</p>
        <p id="url-msg"><strong>{@i18n $key="tooManySelectedLayers"/}: </strong>{@i18n $key="tooManySelectedLayers.instructions"/}</p>
        <p id="noFeatures-msg"><strong>{@i18n $key="noData"/}: </strong>{@i18n $key="noData.instructions"/}</p>
        <p id="novalid-msg"><strong>{@i18n $key="noValidService"/}: </strong>{@i18n $key="noValidService.instructions"/}</p>
    </div>
</div>