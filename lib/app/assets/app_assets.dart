class AppAssets {
  // Main assets
  static const String logo = 'assets/images/logo.png';
  static const String heroImage = 'assets/images/hero.png';
  static const String heroBg = 'assets/images/hero_bg.jpg';
  static const String aiEmployee = 'assets/aiemp.png';

  // Client logos - Row 1
  static const String clientPohanka = 'assets/images/clients/pohanka.png';
  static const String clientHudson = 'assets/images/clients/hudson.png';
  static const String clientLearguy = 'assets/images/clients/learguy.png';
  static const String clientSchomp = 'assets/images/clients/schomp.png';
  static const String clientMartin = 'assets/images/clients/martin.png';
  static const String clientHarvey = 'assets/images/clients/harvey.png';
  static const String clientSethWadley = 'images/clients/sethwadley.png';

  // Client logos - Row 2
  static const String clientElko = 'assets/images/clients/elko.png';
  static const String clientMuller = 'assets/images/clients/muller.png';
  static const String clientYork = 'assets/images/clients/york.png';
  static const String clientBergeys = 'assets/images/clients/bergeys.png';
  static const String clientMirak = 'assets/images/clients/mirak.png';
  static const String clientRickenbaugh = 'assets/images/clients/rickenbaugh.png';
  static const String clientPreston = 'assets/images/clients/preston.png';

  // Icons (if using custom icons)
  static const String iconExpand = 'assets/icons/expand.svg';
  static const String iconHeadset = 'assets/icons/headset.svg';
  static const String iconRocket = 'assets/icons/rocket.svg';

  // Add to app_assets.dart
// Testimonial assets
  static const String testimonialVideo = 'assets/images/chadwick.png';

// Brand assets
  static const String brandSubaru = 'assets/images/brands/subaru.png';
  static const String brandNissan = 'assets/images/brands/nissan.png';
  static const String brandToyota = 'assets/images/brands/toyota.png';
  static const String brandHyundai = 'assets/images/brands/hyundai.png';
  static const String brandGenesis = 'assets/images/brands/genesis.png';
  static const String brandDodge = 'assets/images/brands/dodge.png';
  static const String brandAudi = 'assets/images/brands/audi.png';
  static const String brandKia = 'assets/images/brands/kia.png';
  static const String brandHonda = 'assets/images/brands/honda.png';

  // Add to app_assets.dart
  static const String ctaImage = 'assets/images/cta_image.png';

  // Validation method to check all assets exist
  static List<String> get allAssets => [
    logo,
    heroImage,
    heroBg,
    aiEmployee,
    // Client assets
    clientPohanka,
    clientHudson,
    clientLearguy,
    clientSchomp,
    clientMartin,
    clientHarvey,
    clientSethWadley,
    clientElko,
    clientMuller,
    clientYork,
    clientBergeys,
    clientMirak,
    clientRickenbaugh,
    clientPreston,
  ];

  // Helper method to get client assets only
  static List<String> get clientAssets => [
    clientPohanka,
    clientHudson,
    clientLearguy,
    clientSchomp,
    clientMartin,
    clientHarvey,
    clientSethWadley,
    clientElko,
    clientMuller,
    clientYork,
    clientBergeys,
    clientMirak,
    clientRickenbaugh,
    clientPreston,
  ];
}