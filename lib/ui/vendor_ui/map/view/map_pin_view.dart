import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/map_pin_call_back_holder.dart';
import '../../common/base/ps_widget_with_appbar_with_no_provider.dart';
import '../../common/ps_button_widget_with_round_corner.dart';

class MapPinView extends StatefulWidget {
  const MapPinView(
      {required this.flag, required this.maplat, required this.maplng});

  final String flag;
  final String? maplat;
  final String? maplng;

  @override
  _MapPinViewState createState() => _MapPinViewState();
}

class _MapPinViewState extends State<MapPinView> with TickerProviderStateMixin {
  LatLng? latlng;
  double defaultRadius = 3000;
  String address = '';

  Future<void> loadAddress() async {
    await placemarkFromCoordinates(latlng!.latitude, latlng!.longitude)
        .then((List<Placemark> placemarks) {
      final Placemark place = placemarks[0];
      setState(() {
        address =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((dynamic e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    latlng ??=
        LatLng(double.parse(widget.maplat!), double.parse(widget.maplng!));

    const double value = 16.0;
    // loadAddress();

    final Widget mapPickLocationWidget = Positioned(
      bottom: 2,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: PSButtonWidgetRoundCorner(
          colorData: PsColors.buttonColor,
          hasShadow: false,
          titleText: 'PICK LOCATION'.tr,
          onPressed: () {
            Navigator.pop(context,
                MapPinCallBackHolder(address: address, latLng: latlng));
          },
        ),
      ),
    );

    print('value $value');

    return PsWidgetWithAppBarWithNoProvider(
        appBarTitle: 'location_tile__title'.tr,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              // Flexible(
              //   child:
              FlutterMap(
                options: MapOptions(
                    center:
                        latlng, //LatLng(51.5, -0.09), //LatLng(45.5231, -122.6765),
                    zoom: value, //10.0,
                    onTap: widget.flag == PsConst.PIN_MAP
                        ? _handleTap
                        : _doNothingTap),
                layers: <LayerOptions>[
                  TileLayerOptions(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  CircleLayerOptions(
                    circles: <CircleMarker>[
                      CircleMarker(
                          point: latlng!,
                          color: Colors.blue.withOpacity(0.7),
                          borderStrokeWidth: 2,
                          useRadiusInMeter: true,
                          radius: 200),
                    ],
                  ),
                ],
              ),
              mapPickLocationWidget
            ],
          ),
        ));
  }

  void _handleTap(dynamic tapPosition, LatLng latlng) {
    setState(() {
      this.latlng = latlng;
    });
  }

  void _doNothingTap(dynamic tapPosition, LatLng latlng) {}
}
