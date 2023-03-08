import 'dart:async';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../db/common/ps_data_source_manager.dart';
import '../../repository/product_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/holder/mark_sold_out_item_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class MarkSoldOutItemProvider extends PsProvider<Product> {
  MarkSoldOutItemProvider({
    required ProductRepository? repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
    _repo = repo;
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
    });

    markSoldOutItemStream = StreamController<PsResource<Product>>.broadcast();

    subscription =
        markSoldOutItemStream!.stream.listen((PsResource<Product> resource) {
      _markSoldOutItem = resource;

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }
  ProductRepository? _repo;
  PsResource<Product> _markSoldOutItem =
      PsResource<Product>(PsStatus.NOACTION, '', null);

  PsResource<Product> get markSoldOutItem => _markSoldOutItem;
  late StreamSubscription<PsResource<Product>> subscription;
  StreamController<PsResource<Product>>? markSoldOutItemStream;
  @override
  void dispose() {
    subscription.cancel();
    isDispose = true;
    super.dispose();
  }

  Future<dynamic> loadmarkSoldOutItem({
    String? loginUserId,
    String? headerToken,
    String? languageCode,
    MarkSoldOutItemParameterHolder? holder,
    DataConfiguration? dataConfiguration,}
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    await _repo!.markSoldOutItem(
      markSoldOutItemStream,
      loginUserId,
      headerToken!,
      languageCode ?? 'en',
      isConnectedToInternet,
      PsStatus.PROGRESS_LOADING,
      holder,
      dataConfiguration ?? super.defaultDataConfig,
    );
  }

  // Future<dynamic> nextmarkSoldOutItem(
  //   String loginUserId,
  //   MarkSoldOutItemParameterHolder holder,
  //   DataConfiguration? dataConfiguration,
  // ) async {
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   if (!isLoading && !isReachMaxData) {
  //     super.isLoading = true;

  //     await _repo!.markSoldOutItem(
  //         markSoldOutItemStream,
  //         loginUserId,
  //         isConnectedToInternet,
  //         PsStatus.PROGRESS_LOADING,
  //         holder,
  //         dataConfiguration ?? super.defaultDataConfig);
  //   }
  // }
}
