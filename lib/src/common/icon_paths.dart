const String _basePath = 'assets/icons';

class IconPaths {
  static General general = const General();
  static Home home = const Home();
  static Market market = const Market();
  static DetailPlayer detailPlayer = const DetailPlayer();
  static Profile profile = const Profile();
}

class General {
  const General();

  String get homeBottomNav => '$_basePath/home_bottom_nav.png';
  String get marketBottomNav => '$_basePath/market_bottom_nav.png';
  String get cardsBottomNav => '$_basePath/cards_bottom_nav.png';
  String get newsBottomNav => '$_basePath/news_bottom_nav.png';
  String get portfolioBottomNav => '$_basePath/portfolio_bottom_nav.png';
  String get menuBottomNav => '$_basePath/menu_bottom_nav.png';
  String get profile => '$_basePath/profile.png';
  String get wallet => '$_basePath/wallet.png';
  String get bank => '$_basePath/bank.png';
  String get successPayment => '$_basePath/success_payment.png';
  String get favorites => '$_basePath/favorites.png';
}

class Home {
  const Home();

  String get hot => '$_basePath/hot.png';
  String get message => '$_basePath/message.png';
  String get notifications => '$_basePath/notifications.png';
  String get arrowRight => '$_basePath/arrow_right.png';
  String get arrowRight2 => '$_basePath/arrow_right_2.png';
  String get explore => '$_basePath/explore.png';
  String get ss => '$_basePath/ss.png';
  String get file => '$_basePath/file.png';
  String get graph => '$_basePath/graph.png';
}

class Market {
  const Market();

  String get search => '$_basePath/search.png';
}

class DetailPlayer {
  const DetailPlayer();

  String get calendar => '$_basePath/calendar.png';
  String get awards => '$_basePath/awards.png';
  String get height => '$_basePath/height.png';
}

class Profile {
  const Profile();

  String get accountSettings => '$_basePath/account_settings.png';
  String get tradingAccount => '$_basePath/trading_account.png';
  String get preferences => '$_basePath/preferences.png';
  String get inviteSomeone => '$_basePath/invite_someone.png';
  String get whatsapp => '$_basePath/whatsapp_icon.png';
  String get telegram => '$_basePath/telegram_icon.png';
  String get share => '$_basePath/share_icon.png';
  String get credentials => '$_basePath/credentials.png';
  String get personalInfo => '$_basePath/personal_info.png';
  String get delete => '$_basePath/delete.png';
  String get notificationsPref => '$_basePath/notification_pref.png';
  String get security => '$_basePath/security.png';
}
