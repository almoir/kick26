const String _basePath = 'assets/icons';

class IconPaths {
  static General general = const General();
  static Home home = const Home();
  static Market market = const Market();
}

class General {
  const General();

  String get homeBottomNav => '$_basePath/home_bottom_nav.png';
  String get marketBottomNav => '$_basePath/market_bottom_nav.png';
  String get cardsBottomNav => '$_basePath/cards_bottom_nav.png';
  String get newsBottomNav => '$_basePath/news_bottom_nav.png';
  String get portfolioBottomNav => '$_basePath/portfolio_bottom_nav.png';
  String get profileBottomNav => '$_basePath/profile_bottom_nav.png';
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
