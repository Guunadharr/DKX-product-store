// Copyright (c) 2019, the Panacea-Soft.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Panacea-Soft license that can be found in the LICENSE file.

import '../core/vendor/db/common/ps_data_source_manager.dart';
import '../core/vendor/viewobject/common/language.dart';

class PsConfig {
  PsConfig._();

  ///
  /// AppVersion
  /// For your app, you need to change according based on your app version

  static const String app_version = '1.0';

  ///
  /// Bearer Token
  ///
  static const String ps_bearer_token =
      'Bearer zUMi0HNjAtnREMj3weG7XEv6ogEVovsf6eUFgOp4';

  ///
  /// API URL
  /// Change your backend url
  ///
  static const String ps_core_url =
      'https://www.products.panacea-soft.co/psx-mpc-demo';

  static const String ps_app_url = ps_core_url + '/api/v1.0/'; //index.php/';

  static const String ps_app_image_url =
      ps_core_url + '/public/storage/PSX_MPC/uploads/';

  static const String ps_app_image_thumbs_url =
      ps_core_url + '/public/storage/PSX_MPC/uploads/thumbnail/';

  static const String ps_app_image_thumbs_2x_url =
      ps_core_url + '/public/storage/PSX_MPC/uploads/thumbnail2x/';

  static const String ps_app_image_thumbs_3x_url =
      ps_core_url + '/public/storage/PSX_MPC/uploads/thumbnail3x/';

  ///
  /// Chat Setting
  ///
  static const String iosGoogleAppId =
      '1:000000000000:ios:000000000000000000000';
  static const String iosGcmSenderId = '000000000000';
  static const String iosProjectId = 'psx-multi-purpose-classified';
  static const String iosDatabaseUrl =
      'https://psx-multi-purpose-classified-default-rtdb.firebaseio.com';
  static const String iosApiKey = 'AI0000000000000000000000000000000000000';

  static const String androidGoogleAppId =
      '1:1062516847998:android:ec2f1a0518d4dad26cef2f';
  static const String androidGcmSenderId = '000000000000';
  static const String androidProjectId = 'psx-multi-purpose-classified';
  static const String androidApiKey = 'AIzaSyD_glPjz1qONu3Q0o42SBMnYh_m4vNPmf8';
  static const String androidDatabaseUrl =
      'https://nvgair-9f61c-default-rtdb.firebaseio.com/';

  ///
  ///Admob Setting
  ///
  static String androidAdMobAdsIdKey = 'ca-app-pub-0000000000000000~0000000000';
  static String androidAdMobBannerAdUnitId =
      'ca-app-pub-0000000000000000/0000000000';
  static String androidAdMobNativeAdUnitId =
      'ca-app-pub-0000000000000000/0000000000';
  static String androidAdMobInterstitialAdUnitId =
      'ca-app-pub-0000000000000000/0000000000';

  static String iosAdMobAdsIdKey = 'ca-app-pub-0000000000000000~0000000000';
  static String iosAdMobBannerAdUnitId =
      'ca-app-pub-0000000000000000/0000000000';
  static String iosAdMobNativeAdUnitId =
      'ca-app-pub-0000000000000000/0000000000';
  static String iosAdMobInterstitialAdUnitId =
      'ca-app-pub-0000000000000000/0000000000';

  ////if demo url
  static bool isDemo = false;

  ///
  /// Animation Duration
  ///
  static const Duration animation_duration = Duration(milliseconds: 500);

  ///
  /// Fonts Family Config
  /// Before you declare you here,
  /// 1) You need to add font under assets/fonts/
  /// 2) Declare at pubspec.yaml
  /// 3) Update your font family name at below
  ///
  static const String ps_default_font_family = 'Product Sans';

  static const String ps_app_db_name = 'ps_db.db';

  ///
  /// Default Language
  ///
  static final Language defaultLanguage =
      Language(languageCode: 'en', countryCode: 'US', name: 'English US');

  /// For default language change, please check
  /// LanguageFragment for language code and country code
  /// ..............................................................
  /// Language             | Language Code     | Country Code
  /// ..............................................................
  /// "English"            | "en"              | "US"
  /// "Arabic"             | "ar"              | "DZ"
  /// "India (Hindi)"      | "hi"              | "IN"
  /// "German"             | "de"              | "DE"
  /// "Spanish"           | "es"              | "ES"
  /// "French"             | "fr"              | "FR"
  /// "Indonesian"         | "id"              | "ID"
  /// "Italian"            | "it"              | "IT"
  /// "Japanese"           | "ja"              | "JP"
  /// "Korean"             | "ko"              | "KR"
  /// "Malay"              | "ms"              | "MY"
  /// "Portuguese"         | "pt"              | "PT"
  /// "Russian"            | "ru"              | "RU"
  /// "Thai"               | "th"              | "TH"
  /// "Turkish"            | "tr"              | "TR"
  /// "Chinese"            | "zh"              | "CN"
  /// ..............................................................
  ///
  static final List<Language> psSupportedLanguageList = <Language>[
    Language(languageCode: 'en', countryCode: 'US', name: 'English'),
    Language(languageCode: 'ar', countryCode: 'DZ', name: 'Arabic'),
    Language(languageCode: 'hi', countryCode: 'IN', name: 'Hindi'),
    Language(languageCode: 'de', countryCode: 'DE', name: 'German'),
    Language(languageCode: 'es', countryCode: 'ES', name: 'Spainish'),
    Language(languageCode: 'fr', countryCode: 'FR', name: 'French'),
    Language(languageCode: 'id', countryCode: 'ID', name: 'Indonesian'),
    Language(languageCode: 'it', countryCode: 'IT', name: 'Italian'),
    Language(languageCode: 'ja', countryCode: 'JP', name: 'Japanese'),
    Language(languageCode: 'ko', countryCode: 'KR', name: 'Korean'),
    Language(languageCode: 'ms', countryCode: 'MY', name: 'Malay'),
    Language(languageCode: 'pt', countryCode: 'PT', name: 'Portuguese'),
    Language(languageCode: 'ru', countryCode: 'RU', name: 'Russian'),
    Language(languageCode: 'th', countryCode: 'TH', name: 'Thai'),
    Language(languageCode: 'tr', countryCode: 'TR', name: 'Turkish'),
    Language(languageCode: 'zh', countryCode: 'CN', name: 'Chinese'),
  ];

  ///
  /// Tmp Image Folder Name
  ///
  static const String tmpImageFolderName = 'PSXMPC';

  ///
  /// set showLog [True] to enable log
  ///
  static bool showLog = false;
  static void printLog(Object? object, {bool important = false}) {
    if (showLog & important)
      // red
      print('\u001b[31m $object \u001b[0m');
    else
      // green
      print('\u001b[32m $object \u001b[0m');
  }

  ///
  ///
  ///
  static DataConfiguration defaultDataConfig = DataConfiguration(
      dataSourceType: DataSourceType.FULL_CACHE,
      storePeriod: const Duration(days: 1));

  ///
  ///Loading Shimmer Item Count
  ///
  static int loadingShimmerItemCount = 3;

  ///
  ///Recent Search Keyword Limit
  ///
  static int recentSearchKeywordLimit = 2;

  ///
  ///
  ///
  static int phoneListCount = 3;
}
