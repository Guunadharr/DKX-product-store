import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/item_location/item_location_provider.dart';

class ExploreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemLocationProvider _provider = Provider.of(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16,
          top: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space16),
      child: InkWell(
        onTap: () async {
          if (_provider.itemLocationId == '') {
            await _provider.replaceItemLocationData(
                '',
                'product_list__category_all'.tr,
                PsConst.INVALID_LAT_LNG,
                PsConst.INVALID_LAT_LNG);

            await _provider.replaceItemLocationTownshipData(
              '',
              '',
              'product_list__category_all'.tr,
              PsConst.INVALID_LAT_LNG,
              PsConst.INVALID_LAT_LNG,
            );
            Navigator.pushReplacementNamed(context, RoutePaths.home);
          } else {
            await _provider.replaceItemLocationData(
              _provider.itemLocationId!,
              _provider.itemLocationName!,
              _provider.itemLocationLat!,
              _provider.itemLocationLng!,
            );
            await _provider.replaceItemLocationTownshipData(
                _provider.itemLocationTownshipId!,
                _provider.itemLocationId!,
                _provider.itemLocationTownshipName!,
                _provider.itemLocationTownshipLat!,
                _provider.itemLocationTownshipLng!);
            Navigator.pushReplacementNamed(context, RoutePaths.home);
          }
        },
        child: Container(
          height: PsDimens.space44,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: PsColors.mainColor,
            borderRadius: BorderRadius.circular(PsDimens.space4),
          ),
          child: Text('Get Started'.tr,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: PsColors.baseColor)),
        ),
      ),
    );
  }
}
