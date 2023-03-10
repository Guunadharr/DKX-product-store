import 'package:sembast/sembast.dart';

import '../viewobject/user_unread_message.dart';
import 'common/ps_dao.dart';

class UserUnreadMessageDao extends PsDao<UserUnreadMessage> {
  UserUnreadMessageDao._() {
    init(UserUnreadMessage());
  }

  static const String STORE_NAME = 'UserUnreadMessage';
  final String _primaryKey = '';
  // Singleton instance
  static final UserUnreadMessageDao _singleton = UserUnreadMessageDao._();

  // Singleton accessor
  static UserUnreadMessageDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(UserUnreadMessage? object) {
    return '';
  }

  @override
  Filter getFilter(UserUnreadMessage? object) {
    return Filter.equals(_primaryKey, '');
  }
}
