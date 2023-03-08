import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/chat/user_unread_message_provider.dart';

class ChatListViewAppBar extends StatefulWidget {
  const ChatListViewAppBar(
      {this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      required this.items,
      required this.onItemSelected,
      this.chatFlag})
      : assert(items.length >= 2 && items.length <= 5);

  @override
  _ChatListViewAppBarState createState() {
    return _ChatListViewAppBarState(
        selectedIndexNo: selectedIndex,
        items: items,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final List<ChatListViewAppBarItem> items;
  final ValueChanged<int> onItemSelected;
  final String? chatFlag;
}

class _ChatListViewAppBarState extends State<ChatListViewAppBar> {
  _ChatListViewAppBarState(
      {required this.items,
      this.iconSize,
      this.selectedIndexNo,
      required this.onItemSelected});

  final double? iconSize;
  List<ChatListViewAppBarItem> items;
  int? selectedIndexNo;

  ValueChanged<int> onItemSelected;

  Widget _buildItem(ChatListViewAppBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width / 2,
      height: double.maxFinite,
      duration: const Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                item.title + '  ',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                    color: isSelected ? item.mainColor : item.inmainColor,
                    fontWeight: FontWeight.normal),
              ),
              if (item.unreadMessageProvider!.userUnreadMessage.data != null &&
                  item.flag == PsConst.CHAT_FROM_SELLER &&
                  item.unreadMessageProvider!.userUnreadMessage.data!
                          .buyerUnreadCount !=
                      '0')
                Container(
                  width: 24,
                  height: 20,
                  decoration: BoxDecoration(
                    color: PsColors.mainColor,
                    borderRadius: BorderRadius.circular(PsDimens.space28),
                  ),
                  child: Center(
                    child: Text(
                        item.unreadMessageProvider!.userUnreadMessage.data!
                            .buyerUnreadCount!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: PsColors.baseColor, fontSize: 14)),
                  ),
                ),
              if (item.unreadMessageProvider!.userUnreadMessage.data != null &&
                  item.flag == PsConst.CHAT_FROM_BUYER &&
                  item.unreadMessageProvider!.userUnreadMessage.data!
                          .sellerUnreadCount !=
                      '0')
                Container(
                  width: 24,
                  height: 20,
                  decoration: BoxDecoration(
                    color: PsColors.mainColor,
                    borderRadius: BorderRadius.circular(PsDimens.space28),
                  ),
                  child: Center(
                    child: Text(
                        item.unreadMessageProvider!.userUnreadMessage.data!
                            .sellerUnreadCount!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: PsColors.baseColor, fontSize: 14)),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: PsDimens.space16,
          ),
          if (isSelected)
            Divider(
              color: PsColors.mainColor,
              height: 1,
              thickness: 1.5,
            )
          else
            Divider(
              height: PsDimens.space1,
              color: PsColors.textPrimaryLightColorForLight,
              thickness: 0.2,
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedIndexNo = widget.selectedIndex;
    return Container(
        margin: const EdgeInsets.only(
          top: PsDimens.space16,
        ),
        width: double.infinity,
        height: 52,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              final ChatListViewAppBarItem item = items[index];
              return InkWell(
                onTap: () {
                  onItemSelected(index);
                  setState(() {
                    selectedIndexNo = index;
                  });
                },
                child: _buildItem(item, selectedIndexNo == index),
              );
            }));
  }
}

class ChatListViewAppBarItem {
  ChatListViewAppBarItem(
      {required this.title,
      required this.unreadMessageProvider,
      required this.flag,
      Color? mainColor,
      Color? activeBackgroundColor,
      Color? inmainColor,
      Color? inactiveBackgroundColor})
      : mainColor = mainColor ?? PsColors.mainColor,
        activeBackgroundColor = activeBackgroundColor ?? PsColors.primary50,
        inmainColor = inmainColor ?? PsColors.textColor3,
        inactiveBackgroundColor =
            inactiveBackgroundColor ?? PsColors.grey.withOpacity(0.2);

  final String title;
  final UserUnreadMessageProvider? unreadMessageProvider;
  final String flag;
  final Color? mainColor;
  final Color? activeBackgroundColor;
  final Color? inmainColor;
  final Color inactiveBackgroundColor;
}