import 'package:flutter/material.dart';
import 'package:flutter_osm_interface/flutter_osm_interface.dart';

import 'base_map_controller.dart';

/// class [MapController] : map controller that will control map by select position,enable current location,
/// draw road , show static geoPoint,
///
/// [initMapWithUserPosition] : (bool) if is true, map will show your current location
///
/// [initPosition] : (GeoPoint) if it isn't null, the map will be pointed at this position
class MapController extends BaseMapController {
  MapController({
    bool initMapWithUserPosition = true,
    GeoPoint? initPosition,
  })  : assert(
          initMapWithUserPosition || initPosition != null,
        ),
        super(
          initMapWithUserPosition: initMapWithUserPosition,
          initPosition: initPosition,
        );

  void dispose() {
    listenerMapLongTapping.dispose();
    listenerMapSingleTapping.dispose();
  }

  /// initialise or change of position with creating marker in that specific position
  ///
  /// [p] : geoPoint
  ///
  Future<void> changeLocation(GeoPoint p) async {
    await osmBaseController.changeLocation(p);
  }

  ///animate  to specific position with out add marker into the map
  ///
  /// [p] : (GeoPoint) position that will be go to map
  Future<void> goToLocation(GeoPoint p) async {
    await osmBaseController.goToPosition(p);
  }

  ///remove marker from map of position
  /// [p] : geoPoint
  Future<void> removeMarker(GeoPoint p) async {
    osmBaseController.removeMarker(p);
  }

  ///change Icon Marker
  /// we need to global key to recuperate widget from tree element
  /// [key] : (GlobalKey) key of widget that represent the new marker
  Future changeIconMarker(GlobalKey key) async {
    await osmBaseController.changeDefaultIconMarker(key);
  }

  /*///change advanced picker Icon Marker
  /// we need to global key to recuperate widget from tree element
  /// [key] : (GlobalKey) key of widget that represent the new marker
  Future changeAdvPickerIconMarker(GlobalKey key) async {
    await osmBaseController.changeIconAdvPickerMarker(key);
  }*/

  /// change static position in runtime
  ///  [geoPoints] : list of static geoPoint
  ///  [id] : String of that list of static geoPoint
  Future<void> setStaticPosition(List<GeoPoint> geoPoints, String id) async {
    await osmBaseController.setStaticPosition(geoPoints, id);
  }

  ///change  Marker of specific static points
  /// we need to global key to recuperate widget from tree element
  /// [id] : (String) id  of the static group geopoint
  /// [markerIcon] : (MarkerIcon) new marker that will set to the static group geopoint
  Future<void> setMarkerOfStaticPoint({
    required String id,
    required MarkerIcon markerIcon,
  }) async {
    await osmBaseController.setIconStaticPositions(id, markerIcon);
  }

  /// zoom in/out
  /// [zoom] : (double) positive value:zoomIN or negative value:zoomOut
  Future<void> zoom(double zoom) async {
    await osmBaseController.zoom(zoom);
  }

  /// zoomIn use defaultZoom
  /// positive value:zoomIN
  Future<void> zoomIn() async {
    await osmBaseController.zoomIn();
  }

  /// zoomOut use defaultZoom
  /// negative value:zoomOut
  Future<void> zoomOut() async {
    await osmBaseController.zoom(-1);
  }

  /// activate current location position
  Future<void> currentLocation() async {
    await osmBaseController.currentLocation();
  }

  /// recuperation of user current position
  Future<GeoPoint> myLocation() async {
    return await osmBaseController.myLocation();
  }

  /// enabled tracking user location
  Future<void> enableTracking() async {
    await osmBaseController.enableTracking();
  }

  /// disabled tracking user location
  Future<void> disabledTracking() async {
    await osmBaseController.disabledTracking();
  }

  /// pick Position in map
  Future<GeoPoint> selectPosition({
    MarkerIcon? icon,
    String imageURL = "",
  }) async {
    GeoPoint p = await osmBaseController.selectPosition(
      icon: icon,
      imageURL: imageURL,
    );
    return p;
  }

  /// draw road
  ///  [start] : started point of your Road
  ///
  ///  [end] : last point of your road
  ///
  ///  [intersectPoint] : (List of GeoPoint) middle position that you want you road to pass through it
  ///
  ///  [roadColor] : (Color) indicate the color that you want to be drawing the road, if Color null will draw with default color that specified in OSMFlutter or red color (default of osm map)
  ///
  ///  [roadWidth] : (double) indicate the width of  your road
  Future<RoadInfo> drawRoad(
    GeoPoint start,
    GeoPoint end, {
    List<GeoPoint>? intersectPoint,
    RoadOption? roadOption,
  }) async {
    return await osmBaseController.drawRoad(
      start,
      end,
      interestPoints: intersectPoint,
      roadOption: roadOption,
    );
  }

  ///delete last road draw in the map
  Future<void> removeLastRoad() async {
    await osmBaseController.removeLastRoad();
  }

  /// draw circle into map
  Future<void> drawCircle(CircleOSM circleOSM) async {
    await osmBaseController.drawCircle(circleOSM);
  }

  /// remove specific circle in the map
  Future<void> removeCircle(String keyCircle) async {
    await osmBaseController.removeCircle(keyCircle);
  }

  /// draw rect into map
  Future<void> drawRect(RectOSM rectOSM) async {
    await osmBaseController.drawRect(rectOSM);
  }

  /// remove specific region in the map
  Future<void> removeRect(String keyRect) async {
    await osmBaseController.removeRect(keyRect);
  }

  /// remove all rect shape from map
  Future<void> removeAllRect() async {
    return await osmBaseController.removeAllRect();
  }

  /// clear all circle
  Future<void> removeAllCircle() async {
    await osmBaseController.removeAllCircle();
  }

  /// remove all shape from map
  Future<void> removeAllShapes() async {
    await osmBaseController.removeAllShapes();
  }

  Future<void> advancedPositionPicker() async {
    await osmBaseController.advancedPositionPicker();
  }

  /// select current position and finish advanced picker
  Future<GeoPoint> selectAdvancedPositionPicker() async {
    return await osmBaseController.selectAdvancedPositionPicker();
  }

  /// get current position
  Future<GeoPoint> getCurrentPositionAdvancedPositionPicker() async {
    return await osmBaseController.getCurrentPositionAdvancedPositionPicker();
  }

  /// cancel advanced picker
  Future<void> cancelAdvancedPositionPicker() async {
    return await osmBaseController.cancelAdvancedPositionPicker();
  }

  /// rotate camera of osm map
  Future<void> rotateMapCamera(double? degree) async {
    return await osmBaseController.mapOrientation(degree);
  }

  /// draw road manually
  ///  [path] : (list of GeoPoint) path of the road
  ///  [roadColor] : (Color) the color that uses to change the  default road color
  ///  [roadWidth] : (double) uses to change width of the  road
  Future<void> drawRoadManually(
    List<GeoPoint> path,
    Color roadColor,
    double roadWidth,
  ) async {
    assert(path.length > 3);
    await osmBaseController.drawRoadManually(
      path,
      roadColor,
      roadWidth,
    );
  }

  void init(IBaseOSMController controller) {
    setBaseOSMController(controller);
    Future.delayed(Duration(milliseconds: 1250), () async {
      await controller.initMap(
        initPosition: initPosition,
        initWithUserPosition: initMapWithUserPosition,
      );
    });
  }
}


