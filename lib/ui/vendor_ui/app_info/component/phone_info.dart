import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../core/vendor/utils/utils.dart';

class PhoneInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AboutUsProvider provider = Provider.of<AboutUsProvider>(context);
    final String phoneNum = provider.aboutUs.data!.aboutPhone ?? '';
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse('tel://$phoneNum'))) {
          await launchUrl(Uri.parse('tel://$phoneNum'));
        } else {
          throw 'Could not Call Phone Number 1';
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: Utils.isLightMode(context)
                  ? PsColors.secondary200
                  : PsColors.textPrimaryLightColorForLight!),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.call_outlined,
              color: PsColors.mainColor,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              phoneNum,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Utils.isLightMode(context)
                      ? PsColors.secondary800
                      : PsColors.primaryDarkWhite),
            ),
          ],
        ),
      ),
    );
  }
}
