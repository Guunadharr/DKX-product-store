import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class AgreeTermsAndConditionTextWidget extends StatefulWidget {
  @override
  _AgreeTermsAndConditionTextWidgetState createState() {
    return _AgreeTermsAndConditionTextWidgetState();
  }
}

class _AgreeTermsAndConditionTextWidgetState
    extends State<AgreeTermsAndConditionTextWidget> {
  late AboutUsProvider aboutUsProvider;
  PsValueHolder? psValueHolder;

  @override
  Widget build(BuildContext context) {
    aboutUsProvider = Provider.of<AboutUsProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: aboutUsProvider.hasData
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PsDimens.space6),
                    border: Border.all(color: Colors.grey[300]!, width: 1.5)),
                margin:
                    const EdgeInsets.symmetric(horizontal: PsDimens.space16),
                padding: const EdgeInsets.all(PsDimens.space16),
                height: MediaQuery.of(context).size.height / 10 * 7,
                width: MediaQuery.of(context).size.width,
                // child: PsHTMLTextWidget(
                //   style: Style(
                //       fontWeight: FontWeight.normal,
                //       textAlign: TextAlign.justify),
                //   htmlData: aboutUsProvider.aboutUs.data!.termsAndConditions!,
                // ),
                child: SingleChildScrollView(
                  child: Text(
                    aboutUsProvider.aboutUs.data!.termsAndConditions!,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: PsColors.textColor3,
                    ),
                  ),
                ),
              )
            : const Text(''));
  }
}
