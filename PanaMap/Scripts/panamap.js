$(document).ready(function(){
	var map;
	var overlay;
	var select;
	var popup = {};

	var epsg3857   = new OpenLayers.Projection("EPSG:3857");
	var epsg4326   = new OpenLayers.Projection("EPSG:4326");

	function init() {
		// The overlay layer for our marker, with a simple diamond as symbol
		overlay = new OpenLayers.Layer.Vector('Overlay', {
		  styleMap: new OpenLayers.StyleMap({
		      externalGraphic: 'http://dev.openlayers.org/img/marker.png',
		      graphicWidth: 20, graphicHeight: 24, graphicYOffset: -24,
		      title: '${tooltip}'
		  })
		});

		overlay.events.on({
		  'featureselected': onFeatureSelect,
		  'featureunselected': onFeatureUnselect
		});

		// Finally we create the map
		map = new OpenLayers.Map("map");

		map.addLayers([new OpenLayers.Layer.OSM(), overlay]);

		// Create a select feature control and add it to the map.
		select = new OpenLayers.Control.SelectFeature(overlay);
		map.addControl(select);
		select.activate();

		// 緯度、経度変更イベントの登録
		map.events.register("moveend" , map, onMapChange);

		// 中心点を日本にする
		var lonlat = new OpenLayers.LonLat(center.lon, center.lat).transform(epsg4326,epsg3857)
		map.setCenter(lonlat, center.zoom);
    }

	function onMapChange() {

		// 中心点
	    var lonLat = map.getCenter().transform(epsg3857,epsg4326);
	    // 切捨て
	    lonLat.lat = Math.round(lonLat.lat*1000000)/1000000;
	    lonLat.lon = Math.round(lonLat.lon*1000000)/1000000;

	    // 表示範囲
	    var bounds = map.getExtent().transform(epsg3857, epsg4326);

	    // データ取ってくる
		var url = '/api/map/' + bounds.top + ',' + bounds.left + ',' + bounds.bottom + ',' + bounds.right;
		$.getJSON(url, function(rows) {
			var features = [];
			$.each(rows, function(key,val) {
				// マーカー座標
				var point = new OpenLayers.Geometry.Point(val.google_latlon.Y, val.google_latlon.X)
					.transform(epsg4326, epsg3857);
				// マーカー生成
				var feature = new OpenLayers.Feature.Vector(point, {
			        tooltip: val.address,
					raw: val
			    });
				features.push(feature);
			});

			if (popup.feature != null) 
			{// ポップアップが開いている場合は1個だけ残す
				var tmp = overlay.features.concat();
				var pos = tmp.indexOf(popup.feature);
				tmp.splice(pos,1);
				overlay.removeFeatures(tmp);
			} 
			else 
			{// ポップアップが開いていない場合は全部消す
				overlay.removeAllFeatures();
			}
			overlay.addFeatures(features);

		});
	}

	function onPopupClose(evt) {
	    select.unselect(this.feature);
	}
	
	function onFeatureSelect(evt) {
	    var feature = evt.feature;
	    var data = feature.data.raw;
	    var address = data.address_fix || data.address;

	    var content = ''
	    			+ '<div sytle="height:100%">'
	    			+ '  <div sytle="height:100%">'
					+ '    <iframe src="/Node/?id=' + data.node_id + '" style="border:none;width:100%;height:100%;padding:0;margin:0;"></iframe>'
	    			+ '  </div>'
	    			+ '</div>'
	    			;

	    popup = new OpenLayers.Popup.FramedCloud("featurePopup",
	                        feature.geometry.getBounds().getCenterLonLat(),
	                        new OpenLayers.Size(100, 100),
	                        content,
	                        null, true, onPopupClose);
	    feature.popup = popup;
	    popup.feature = feature;
	    map.addPopup(popup);

	    // コピペ用にブラウザのアドレスバーを書き換える
	    history.replaceState('','','/map/' + data.google_latlon.X + ',' + data.google_latlon.Y + ',' + map.getZoom());
	}
				
	function onFeatureUnselect(evt) {
	    var feature = evt.feature;
	    if (feature.popup) {
	        popup.feature = null;
	        map.removePopup(feature.popup);
	        feature.popup.destroy();
	        feature.popup = null;
	    }
	} 

	init();
});
