import 'package:quiver/core.dart';

import 'common/ps_object.dart';
import 'default_photo.dart';
import 'item_location.dart';

class Blog extends PsObject<Blog> {
  Blog({
    this.id,
    this.name,
    this.description,
    this.status,
    this.addedDate,
    this.addedUserId,
    this.updatedDate,
    this.updatedUserId,
    this.addedDateStr,
    this.defaultPhoto,
    this.cityId,
    this.city,
  });
  String? id;
  String? name;
  String? description;
  String? status;
  String? addedDate;
  String? addedUserId;
  String? updatedDate;
  String? updatedUserId;
  String? addedDateStr;
  DefaultPhoto? defaultPhoto;
  String? cityId;
  ItemLocation? city;

  @override
  bool operator ==(dynamic other) => other is Blog && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  Blog fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return Blog(
      id: dynamicData['id'],
      name: dynamicData['name'],
      description: dynamicData['description'],
      status: dynamicData['status'],
      addedDate: dynamicData['added_date'],
      addedUserId: dynamicData['added_user_id'],
      updatedDate: dynamicData['updated_date'],
      updatedUserId: dynamicData['updated_user_id'],
      addedDateStr: dynamicData['added_date_str'],
      defaultPhoto: DefaultPhoto().fromMap(dynamicData['default_photo']),
      cityId: dynamicData['location_city_id'],
      city: ItemLocation().fromMap(dynamicData['city']),
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(Blog? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['name'] = object.name;
      data['description'] = object.description;
      data['status'] = object.status;
      data['added_date'] = object.addedDate;
      data['added_user_id'] = object.addedUserId;
      data['updated_user_id'] = object.updatedUserId;
      data['added_date_str'] = object.addedDateStr;
      data['default_photo'] = DefaultPhoto().toMap(object.defaultPhoto);
      data['location_city_id'] = object.cityId;
      data['city'] = ItemLocation().toMap(object.city);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Blog> fromMapList(List<dynamic> dynamicDataList) {
    final List<Blog> blogList = <Blog>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Blog?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Blog? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
