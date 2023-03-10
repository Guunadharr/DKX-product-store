

import 'package:sembast/sembast.dart';

import '../viewobject/item_price_type.dart';
import 'common/ps_dao.dart';

class ItemPriceTypeDao extends PsDao<ItemPriceType> {
  ItemPriceTypeDao() {
    init(ItemPriceType());
  }

  static const String STORE_NAME = 'ItemPriceType';
  final String _primaryKey = 'id';

  @override
  String? getPrimaryKey(ItemPriceType object) {
    return object.id;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(ItemPriceType object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
