import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googlemap;
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/ui/vendor_ui/item/entry/component/entry_data/widgets/phone_list_widget.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/core_field.dart';
import '../../../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../core/vendor/viewobject/product_relation.dart';
import '../../../../../../../core/vendor/viewobject/selected_object.dart';
import '../../../../../../../core/vendor/viewobject/selected_value.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/upload_submit_button.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/choose_category_widget.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/choose_city_widget.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/choose_subcategory_widget.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/choose_township_widget.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/entry_description.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/entry_discount_widget.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/entry_price_widget.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/listing_title.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/phone_list_widget.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/pick_on_map_widget.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/terms_and_policy_checkbox.dart';
import '../../../../../custom_ui/item/entry/component/entry_data/widgets/use_current_location_widget.dart';
import '../../../../common/custom_ui/ps_cutom_widget.dart';

class CoreAndCustomFieldEntryView extends StatefulWidget {
  const CoreAndCustomFieldEntryView(
      {Key? key, this.flag, this.item, this.onItemUploaded})
      : super(key: key);

  final String? flag;
  final Product? item;
  final Function? onItemUploaded;

  @override
  State<CoreAndCustomFieldEntryView> createState() =>
      _CustomFieldEntryContainerState();
}

class _CustomFieldEntryContainerState
    extends State<CoreAndCustomFieldEntryView> {
  late ItemEntryFieldProvider itemEntryFieldProvider;
  late ItemEntryProvider itemEntryProvider;
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController locationTownshipController =
      TextEditingController();
  final TextEditingController currencySymbolController =
      TextEditingController();
  final TextEditingController userInputDiscount = TextEditingController();
  final TextEditingController userInputPriceController =
      TextEditingController();

  List<CustomField> customFieldList = <CustomField>[];

  late PsValueHolder valueHolder;
  final MapController mapController = MapController();
  googlemap.GoogleMapController? googleMapController;
  googlemap.CameraPosition? _kLake;
  double zoom = 13.0;

  dynamic updateMapController(googlemap.GoogleMapController mapController) {
    googleMapController = mapController;
  }

  bool bindDataFirstTime = true;
  bool bindEntryDataFirstTime = true;

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    itemEntryProvider = Provider.of<ItemEntryProvider>(context);
    if (itemEntryProvider.item != null) {
      if (bindDataFirstTime) {
        currencySymbolController.text = itemEntryProvider.currencyName ?? '';
        locationController.text = itemEntryProvider.locationName ?? '';
        locationTownshipController.text =
            itemEntryProvider.locationTownshipName ?? '';
        if (widget.flag == PsConst.EDIT_ITEM &&
            itemEntryProvider.item!.id != null) {
          bindItemData();
        }
        bindDataFirstTime = false;
      }
    }

    return Consumer<ItemEntryFieldProvider>(builder:
        (BuildContext context, ItemEntryFieldProvider provider, Widget? child) {
      itemEntryFieldProvider = provider;
      if (!provider.hasData) {
        return Container(
          margin: const EdgeInsets.only(top: PsDimens.space16),
          child: Center(
            child: CircularProgressIndicator(
              color: PsColors.textColor2,
            ),
          ),
        );
      } else {
        if (bindEntryDataFirstTime) {
          customFieldList =
              provider.itemEntryField.data!.customField ?? <CustomField>[];

          itemEntryFieldProvider.titleCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_TITLE);
          itemEntryFieldProvider.categoryCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_CATEGORY);
          itemEntryFieldProvider.subCategoryCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_SUBCATEGORY);
          itemEntryFieldProvider.currencySymbolCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_CURRENCY);
          itemEntryFieldProvider.priceCoreField = provider
              .getCoreFieldByFieldName(PsConst.FIELD_NAME_ORIGINAL_PRICE);
          itemEntryFieldProvider.discountRateCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_DISCOUNT);
          itemEntryFieldProvider.descriptionCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_DESCRIPTION);
          itemEntryFieldProvider.cityCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_LOCATION);
          itemEntryFieldProvider.townshipCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_TOWNSHIP);
          itemEntryFieldProvider.phoneNumCoreField =
              provider.getCoreFieldByFieldName(PsConst.FIELD_NAME_PHONE);

          bindEntryDataFirstTime = false;
        }
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Title
              CoreFieldContainer(
                child: CustomListingTitle(
                  textEditingController: titleTextEditingController,
                  isMandatory:
                      itemEntryFieldProvider.titleCoreField.isMandatory,
                ),
                coreField: itemEntryFieldProvider.titleCoreField,
              ),
              //Category
              CoreFieldContainer(
                child: CustomChooseCategoryDropDownWidget(
                  categoryController: categoryController,
                  subCategoryController: subCategoryController,
                  isMandatory:
                      itemEntryFieldProvider.categoryCoreField.isMandatory,
                ),
                coreField: itemEntryFieldProvider.categoryCoreField,
              ),
              //SubCategory
              CoreFieldContainer(
                child: CustomChooseSubCategoryDropDownWidget(
                    subCategoryController: subCategoryController,
                    isMandatory: itemEntryFieldProvider
                        .subCategoryCoreField.isMandatory),
                coreField: itemEntryFieldProvider.subCategoryCoreField,
              ),
              //Contact Number
              CoreFieldContainer(
                child: CustomPhoneListWidget(
                  isMandatory:
                      itemEntryFieldProvider.phoneNumCoreField.isMandatory,
                ),
                coreField: itemEntryFieldProvider.phoneNumCoreField,
              ),
              //Price And Currency
              CustomEntryPriceWidget(
                currencySymbolController: currencySymbolController,
                userInputPriceController: userInputPriceController,
                currencyCoreField:
                    itemEntryFieldProvider.currencySymbolCoreField,
                priceCoreField: itemEntryFieldProvider.priceCoreField,
              ),
              //Discount
              CoreFieldContainer(
                child: CustomEntryDiscountWidget(
                    userInputDiscount: userInputDiscount,
                    isMandatory: itemEntryFieldProvider
                        .discountRateCoreField.isMandatory),
                coreField: itemEntryFieldProvider.discountRateCoreField,
              ),
              //Description
              CoreFieldContainer(
                child: CustomEntryDescription(
                  userInputDescription: descriptionTextEditingController,
                  isMandatory:
                      itemEntryFieldProvider.descriptionCoreField.isMandatory,
                ),
                coreField: itemEntryFieldProvider.descriptionCoreField,
              ),
              //Custom Fields
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: customFieldList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final CustomField customField = customFieldList[index];
                    final TextEditingController valueTextController =
                        TextEditingController();
                    final TextEditingController idTextController =
                        TextEditingController();

                    if (customField.coreKeyId != null) {
                      if (widget.flag == PsConst.EDIT_ITEM) {
                        widget.item!.productRelation
                            ?.forEach((ProductRelation element) {
                          if (element.coreKeyId == customField.coreKeyId &&
                              element.selectedValues!.isNotEmpty) {
                            if (customField.uiType?.coreKeyId !=
                                PsConst.MULTI_SELECTION) {
                              idTextController.text =
                                  element.selectedValues?[0].id.toString() ??
                                      '';
                              valueTextController.text =
                                  element.selectedValues?[0].value! ?? '';
                            } else {
                              final List<String> idList = <String>[];
                              final List<String> values = <String>[];
                              element.selectedValues
                                  ?.forEach((SelectedValue element) {
                                idList.add(element.id.toString());
                                values.add(element.value.toString());
                              });
                              idTextController.text = idList.join(',');
                              valueTextController.text = values.join(',');
                            }
                          }
                        });
                      }

                      if (!itemEntryFieldProvider.textControllerMap
                          .containsKey(customField)) {
                        itemEntryFieldProvider.textControllerMap.putIfAbsent(
                          customField,
                          () => SelectedObject(
                            valueTextController: valueTextController,
                            idTextController: idTextController,
                          ),
                        );
                      }
                    }
                    return PsCustomWidget(
                      customField: customField,
                      valueTextController: valueTextController,
                      idTextController: idTextController,
                    );
                  }),
              //Location City
              CoreFieldContainer(
                child: CustomChooseCityDropDownWidget(
                  cityController: locationController,
                  townshipController: locationTownshipController,
                  updateMap: updateMap,
                  isMandatory: itemEntryFieldProvider.cityCoreField.isMandatory,
                ),
                coreField: itemEntryFieldProvider.cityCoreField,
              ),
              //Location Township
              CoreFieldContainer(
                child: CustomChooseTownshipDropDownWidget(
                    townshipController: locationTownshipController,
                    updateMap: updateMap,
                    isMandatory:
                        itemEntryFieldProvider.townshipCoreField.isMandatory),
                coreField: itemEntryFieldProvider.townshipCoreField,
              ),
              CustomUseCurrentLocationWidget(
                androidFusedLocation: true,
                updateMap: updateMap,
              ),
              CustomPickOnMapWidget(
                latLng: itemEntryProvider.latlng,
                updateMap: updateMap,
              ),
              const CustomTermsAndPolicyCheckbox(),
              CustomUploadSubmitButton(
                flag: widget.flag,
                onItemUploaded: widget.onItemUploaded,
                getEntryData: getEntryData,
              ),
            ],
          ),
        );
      }
    });
  }

  void updateMap(double lat, double lng, String address) {
    if (!valueHolder.isUseGoogleMap!) {
      updateGoogleMap(lat, lng, address);
    } else {
      updateFlutterMap(lat, lng, address);
    }
  }

  void updateGoogleMap(double lat, double lng, String address) {
    // setState(() {
    itemEntryProvider.latlng = LatLng(lat, lng);
    _kLake = googlemap.CameraPosition(
        target: googlemap.LatLng(lat, lng), zoom: zoom);
    if (_kLake != null) {
      // googleMapController!
      //     .animateCamera(googlemap.CameraUpdate.newCameraPosition(_kLake!));
    }
    // userInputLattitude.text = lat.toString();
    // userInputLongitude.text = lng.toString();
    // userInputAddress.text = address;
    // });
  }

  void updateFlutterMap(double lat, double lng, String address) {
    // setState(() {
    itemEntryProvider.latlng = LatLng(lat, lng);
    // mapController.move(itemEntryProvider.latlng, zoom);
    // userInputLattitude.text = lat.toString();
    // userInputLongitude.text = lng.toString();
    // userInputAddress.text = address;
    // });
  }

  void getEntryData() {
    itemEntryProvider.title = titleTextEditingController.text;
    itemEntryProvider.categoryName = categoryController.text;
    itemEntryProvider.subCategoryName = subCategoryController.text;
    itemEntryProvider.currencyName = currencySymbolController.text;
    itemEntryProvider.price = userInputPriceController.text;
    itemEntryProvider.discount = userInputDiscount.text;
    itemEntryProvider.description = descriptionTextEditingController.text;
    itemEntryProvider.locationName = locationController.text;
    itemEntryProvider.locationTownshipName = locationTownshipController.text;
  }

  void bindItemData() {
    titleTextEditingController.text = itemEntryProvider.item?.title ?? '';
    descriptionTextEditingController.text =
        itemEntryProvider.item?.description ?? '';
    userInputPriceController.text = itemEntryProvider.item?.originalPrice ?? '';
    userInputDiscount.text = itemEntryProvider.item?.discountRate ?? '';
    subCategoryController.text =
        itemEntryProvider.item?.subCategory?.name ?? '';
    categoryController.text = itemEntryProvider.item?.category?.catName ?? '';
    locationController.text = itemEntryProvider.item?.itemLocation?.name ?? '';
    locationTownshipController.text =
        itemEntryProvider.item?.itemLocationTownship?.townshipName ?? '';
    currencySymbolController.text =
        itemEntryProvider.item?.itemCurrency?.currencySymbol ?? '';

    final List<String> phoneList =
        itemEntryProvider.item?.phoneNumList?.split('#') ?? <String>[];
    for (int i = 0; i < phoneList.length; i++) {
      final List<String> countryCodeAndNum =
          phoneList[i].split('-'); //[+95] - [9971234567]
      if (i == 0 && countryCodeAndNum.length == 2) {
        final PhoneNoController phoneController =
            itemEntryProvider.phoneNumList.elementAt(0);
        phoneController.countryCodeController.text = countryCodeAndNum[0];
        phoneController.phoneNumController.text = countryCodeAndNum[1];
      } else if (countryCodeAndNum.length == 2) {
        final TextEditingController countryCodeController =
            TextEditingController();
        final TextEditingController phoneController = TextEditingController();
        countryCodeController.text = countryCodeAndNum[0];
        phoneController.text = countryCodeAndNum[1];
        itemEntryProvider.phoneNumList.add(PhoneNoController(
            countryCodeController: countryCodeController,
            phoneNumController: phoneController));
      }
    }

    if (itemEntryProvider.item?.itemCurrency?.id != null &&
        itemEntryProvider.item?.itemCurrency?.id != '') {
      itemEntryProvider.itemCurrencyId =
          itemEntryProvider.item?.itemCurrency?.id;
      itemEntryProvider.currencyName =
          itemEntryProvider.item?.itemCurrency?.currencySymbol;
    }

    if (itemEntryProvider.item?.itemLocation?.id != null &&
        itemEntryProvider.item?.itemLocation?.id != '') {
      itemEntryProvider.itemLocationId =
          itemEntryProvider.item?.itemLocation?.id;
      itemEntryProvider.locationName =
          itemEntryProvider.item?.itemLocation?.name;
      itemEntryProvider.latlng = LatLng(
          double.parse(itemEntryProvider.item?.itemLocation?.lat ?? '0.0'),
          double.parse(itemEntryProvider.item?.itemLocation?.lng ?? '0.0'));
    }

    if (itemEntryProvider.item?.itemLocationTownship?.id != null &&
        itemEntryProvider.item?.itemLocationTownship?.id != '') {
      itemEntryProvider.itemLocationTownshipId =
          itemEntryProvider.item?.itemLocationTownship?.id;
      itemEntryProvider.locationTownshipName =
          itemEntryProvider.item?.itemLocationTownship?.townshipName;
      itemEntryProvider.latlng = LatLng(
          double.parse(
              itemEntryProvider.item?.itemLocationTownship?.lat ?? '0.0'),
          double.parse(
              itemEntryProvider.item?.itemLocationTownship?.lng ?? '0.0'));
    }

    if (itemEntryProvider.item?.category?.catId != null &&
        itemEntryProvider.item?.category?.catId != '') {
      itemEntryProvider.categoryId = itemEntryProvider.item?.category?.catId;
    }

    if (itemEntryProvider.item?.subCategory?.id != null &&
        itemEntryProvider.item?.subCategory?.id != '') {
      itemEntryProvider.subCategoryId = itemEntryProvider.item?.subCategory?.id;
      itemEntryProvider.subCategoryName =
          itemEntryProvider.item?.subCategory!.name;
    }

    if (itemEntryProvider.item?.lat != null &&
        itemEntryProvider.item?.lat != '' &&
        itemEntryProvider.item?.lat != '0.0' &&
        double.tryParse(itemEntryProvider.item!.lat!) != null &&
        double.tryParse(itemEntryProvider.item!.lat!)! > -90 &&
        double.tryParse(itemEntryProvider.item!.lat!)! < 90 &&
        double.tryParse(itemEntryProvider.item!.lng!) != null &&
        double.tryParse(itemEntryProvider.item!.lng!)! > -180 &&
        double.tryParse(itemEntryProvider.item!.lng!)! < 180) {
      itemEntryProvider.latlng = LatLng(
          double.parse(itemEntryProvider.item?.lat ?? '0.0'),
          double.parse(itemEntryProvider.item?.lng ?? '0.0'));
    }
  }
}

class CoreFieldContainer extends StatelessWidget {
  const CoreFieldContainer(
      {Key? key, required this.child, required this.coreField})
      : super(key: key);
  final Widget child;
  final CoreField coreField;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: coreField.isVisible,
      child: child,
    );
  }
}
