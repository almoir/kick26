'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "984f82fe71f332e26342842c9dfc307c",
"assets/AssetManifest.bin.json": "836405b81cc13bfeb4eaad925e65eb5b",
"assets/AssetManifest.json": "29967c278173f8463793218df915df8c",
"assets/assets/animations/cardgold.riv": "e07baeaabce0f927e9a14b4ac959256a",
"assets/assets/animations/splashscreen_kick26.riv": "d65747b4ecb0a70f62583096a62fe087",
"assets/assets/fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/Poppins-ExtraBold.ttf": "d45bdbc2d4a98c1ecb17821a1dbbd3a4",
"assets/assets/fonts/Poppins-ExtraLight.ttf": "6f8391bbdaeaa540388796c858dfd8ca",
"assets/assets/fonts/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/assets/fonts/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/fonts/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/fonts/Poppins-SemiBold.ttf": "6f1520d107205975713ba09df778f93f",
"assets/assets/fonts/Poppins-Thin.ttf": "9ec263601ee3fcd71763941207c9ad0d",
"assets/assets/icons/account_settings.png": "53583e3d13aec5862c3ae099710bdeef",
"assets/assets/icons/arrow_right.png": "6194c532cbb60d75e9942fe896c304c6",
"assets/assets/icons/arrow_right_2.png": "c5db616ac970625555deec4502ad8793",
"assets/assets/icons/awards.png": "530677849c3f00a00e21cb4800a3d50c",
"assets/assets/icons/bank.png": "7021a7fca54492750159ffd20b68c1c8",
"assets/assets/icons/calendar.png": "e9af5af59172cfea2254c3137de93303",
"assets/assets/icons/cards_bottom_nav.png": "005fa43452adfdd606fa6d17f9fe8a6d",
"assets/assets/icons/credentials.png": "6396358be30a89d9f1a2c887ad063621",
"assets/assets/icons/delete.png": "8c6e9291bff5f865b0aa946888579a7f",
"assets/assets/icons/explore.png": "8b5f2e2fc3494cc1780edba87681f31e",
"assets/assets/icons/file.png": "46f9f84211b082765c57843cd8cc6df0",
"assets/assets/icons/graph.png": "79127b053d44ccfdd10237ac3f3bc0f3",
"assets/assets/icons/height.png": "70844b5aa4fabe2cd6e1e23d8e71538c",
"assets/assets/icons/home_bottom_nav.png": "08925345e82994d744c8861df89bf362",
"assets/assets/icons/hot.png": "6c8fa5f52978cd1834411b83e4ed64c3",
"assets/assets/icons/icon_launcher.png": "0fbf58fe1379a3e763ebfdb1320c1c54",
"assets/assets/icons/invite_someone.png": "1b6a356b2819cf2c53b3bcbef4639e88",
"assets/assets/icons/market_bottom_nav.png": "c69d21b25b75feb8137b5a0e65c9219d",
"assets/assets/icons/menu_bottom_nav.png": "d8daf832bd06eb0efd0ffb7ae7fc9c4a",
"assets/assets/icons/message.png": "e1bc47c37461524614978e2174e464cf",
"assets/assets/icons/news_bottom_nav.png": "f54dea3107f622fafb0b762cc3c38612",
"assets/assets/icons/notifications.png": "2db049a45a3bebfa7a3f0709cfb05165",
"assets/assets/icons/notification_pref.png": "7fe50c7f2f22d31bd0f775589df4c9da",
"assets/assets/icons/personal_info.png": "ef0dd7c0513ac53daf6f493028a558bb",
"assets/assets/icons/portfolio_bottom_nav.png": "c56b98c97158468525563ab0f0cb9f4a",
"assets/assets/icons/preferences.png": "b97c43ffc3cce32af4737a91d63d46e9",
"assets/assets/icons/profile.png": "9a5ed1501505b65a7215e447c14b503b",
"assets/assets/icons/search.png": "7e7f9c33af228bead9d9c8aa72e92ed1",
"assets/assets/icons/security.png": "1c6b48b2cde73ec8c9a7a1e74c106846",
"assets/assets/icons/share_icon.png": "cb09c5c194285b56368cd3ace983e2f4",
"assets/assets/icons/ss.png": "c16695188ce6c447468496ce95d32d55",
"assets/assets/icons/success_payment.png": "c89fa102810c1321cccf3d3b05f10dfc",
"assets/assets/icons/telegram_icon.png": "3714aa02d0c91970dc49d8d54b5eb50a",
"assets/assets/icons/trading_account.png": "e6985a9e1266f3f22eb586d9c1297945",
"assets/assets/icons/wallet.png": "a8d8f7c6a08851051b9dd5fa82b658cd",
"assets/assets/icons/whatsapp_icon.png": "ce32ddcedbcd50253a810801d5fd4dd4",
"assets/assets/images/alvarez.png": "2c5ba11e58cffdc18d2dfe70b4f1d3d7",
"assets/assets/images/antony.png": "c255a30a66c39b358d82b20483768aa3",
"assets/assets/images/arsenal.png": "0c978c18e9fcef62508306b2df4a4ebe",
"assets/assets/images/atleticoMadrid.png": "296ec7bdb1df185842aaadf5cdd06c7d",
"assets/assets/images/bayern.png": "d67c800221cf2b360152d4356811e5da",
"assets/assets/images/bellingham.png": "2d19be9d49be0a25dd43ca1307360044",
"assets/assets/images/bernardo.png": "644b2969a818b8ae1e0bc68ae402e3d3",
"assets/assets/images/bilbao.png": "1a8a93cc7d884a71a89afe46e5f5be61",
"assets/assets/images/bruno.png": "f9532200483940add865fac08e6c6109",
"assets/assets/images/camavinga.png": "ec4de6a9523e5190f7a0f2e142b23250",
"assets/assets/images/card_border.png": "688f3e45f89fd3fefe674bbead62b700",
"assets/assets/images/casemiro.png": "f31b622a5ab7660af7ef35580a006cf5",
"assets/assets/images/chart.png": "4f32ccc0ca9626c02b504c96575bd648",
"assets/assets/images/chartDummy.png": "cfdc2ae12b0e603aba832a10e64fa9b1",
"assets/assets/images/chart_down.png": "ad907d04ab7a0fd747e1d3a52ac8f539",
"assets/assets/images/chart_outlined.png": "bd56bba8f2dcabaf6a24173e98b7835b",
"assets/assets/images/chart_up.png": "720506bdd9d8d67c627ee246d114b93b",
"assets/assets/images/chelsea.png": "97e30140815b92eba682fd8808a01be7",
"assets/assets/images/credentials.png": "afd3cae4ddfea70f71bff6651d769134",
"assets/assets/images/daniolmo.png": "44c7edc17fb6b66c49d23a2910ca8e7f",
"assets/assets/images/dejong.png": "09b7b4efb2ce5707c867ab64b49b0e45",
"assets/assets/images/dembele.png": "592509f28bda37b13105665aa9748152",
"assets/assets/images/enzo.png": "3c0c2b9eaca8bdafbbdf936916b00fe6",
"assets/assets/images/fcb.png": "0bcd3585394dff2f3688b1fba6e7a370",
"assets/assets/images/felix.png": "2862d69daef95e07f69e0845c7a6f3a7",
"assets/assets/images/ferran.png": "de4e28640e57b46bd3b3734b272dcbea",
"assets/assets/images/foden.png": "2739195557a107f05d68a6be8b6975dd",
"assets/assets/images/forYou1.png": "c086ffde633d101ed51676b6b755f531",
"assets/assets/images/forYou2.png": "f08f19b1d0cf44338479c00d61205c7a",
"assets/assets/images/forYou3.png": "5eefba4ab27a1833385b167a7589c7dd",
"assets/assets/images/Frame%2520265.png": "54c7677c29bdf6903ab92160fa7c0056",
"assets/assets/images/garnacho.png": "108e8f8ff2287d81cb728e66d23518d4",
"assets/assets/images/gavi.png": "615bca7243b01e084527851c4e1bbf10",
"assets/assets/images/grealish.png": "f1d3fe8615d67498b61513452248eabf",
"assets/assets/images/gyokeres.png": "599793fd0a70cebe29c5894d556506e2",
"assets/assets/images/haaland.png": "489d5a1f100cd5073cdb512f8ba15525",
"assets/assets/images/hakimi.png": "dc4561be1551b8bca260b400b161730a",
"assets/assets/images/havertz.png": "1edc0e79353d34e6d37dda09a4a30c8d",
"assets/assets/images/hernandez.png": "701a6f523883fd5ee382334034e432a3",
"assets/assets/images/hojlund.png": "76e9f370f727870c28f33380e44a6ea7",
"assets/assets/images/inter.png": "a59c0d271935b4f0724cd45f7870bfc3",
"assets/assets/images/invite_friend.png": "e0eab1f2b3695015fb43925436dee50b",
"assets/assets/images/jota.png": "4674fc11c0b35a6a5ae6b617a75cc786",
"assets/assets/images/kane.png": "9f7e31d96df7ed1f7d2b4dfd2f7069ee",
"assets/assets/images/kick26_logo.png": "3e592528d1c49f95f97ef50dfa371a41",
"assets/assets/images/kick26_splash.png": "42439e0f65ea9f846b4c225c764fe435",
"assets/assets/images/kimmich.png": "11da40f2914eb1a445445164a933052b",
"assets/assets/images/kvaratskhelia.png": "73933e6c1d2618bcd22e94d78783db15",
"assets/assets/images/laliga.png": "45570653d7cfeb8454cb2e453156f73a",
"assets/assets/images/leao.png": "ec65814d5fee215fd28eb6915c6494e2",
"assets/assets/images/leverkusen.png": "20e4e25ac756ba122a846abac0726139",
"assets/assets/images/limit_order.png": "fdf17a28020b0ccb44b71b75991df0d0",
"assets/assets/images/listDummy.png": "148c99cfb397af45399307b25e8f1d6b",
"assets/assets/images/liverpool.png": "1d944c330f3da60ce78a3377819ce52b",
"assets/assets/images/live_price_1h.png": "6cf48926c6063ddf1faf42b4c7a6f289",
"assets/assets/images/live_price_24h.png": "8e5bb9b4daf2e3dfc9290627ac1649a4",
"assets/assets/images/live_price_30d.png": "242d48120c124ad10222ee5412b0af46",
"assets/assets/images/live_price_7d.png": "b0fd447fcf1214974a4eb3a561ce445f",
"assets/assets/images/live_price_all.png": "198a3e878bb7742d5495b281678de1dd",
"assets/assets/images/manchesterCity.png": "8dd88644bb05eb8df88709003f755c69",
"assets/assets/images/manchesterUnited.png": "6e826f718a96b96e09815a803bdf9439",
"assets/assets/images/manunited.png": "14628eaeb6ff0b53001b223a2fc9aac8",
"assets/assets/images/market_cap.png": "b58e92ad202683a3d13753cbb9870454",
"assets/assets/images/market_summary.png": "7430d0efa7f2c52f3de9559bce6cc17f",
"assets/assets/images/martinez.png": "09056d6c4f50ff3bec97b967f1f4ae1b",
"assets/assets/images/mbape_detail_img.png": "ce0708b17004472b4d57c56f504c7209",
"assets/assets/images/mbape_history.png": "ff474a5cb6149084df24bb8cdfe3c9d2",
"assets/assets/images/mbape_overview.png": "acc0cfb2c9c05ab2a9d80b0fb2748d25",
"assets/assets/images/mbape_statistic.png": "d74c16999abb4d42d2f8f2f4a4cc1525",
"assets/assets/images/mbappe.png": "53b7aa477d727c736b8d5e506717ebf0",
"assets/assets/images/milan.png": "05e2bcfd8c11242e8ed85bd60e49f7d1",
"assets/assets/images/mosalah.png": "db80f7cf905118b856f6f35aa80ba86c",
"assets/assets/images/mount.png": "54906145d65d8a61acc17739cf4ef137",
"assets/assets/images/musiala.png": "12f5cf38d225ffb4c56b015b546c41b8",
"assets/assets/images/napoli.png": "990b0f4d2b76d85c952c635d5be63b50",
"assets/assets/images/nec.png": "8243ae02a41aebb440aecc0cc3714dc2",
"assets/assets/images/newcastle.png": "9731eebaf348c9447e848491067dcc64",
"assets/assets/images/news1.png": "90b75768c33313310afe06bd9a4be3fc",
"assets/assets/images/news2.png": "c9e9ee54aa20e2f5df520a388ac2e47d",
"assets/assets/images/nico.png": "7caa04b88d806687f725cd0955286058",
"assets/assets/images/nkunku.png": "56e660868110c71429ab1c0ba87d3f15",
"assets/assets/images/nunez.png": "c1098d0a2c38910d12fe88bdec4cfe0f",
"assets/assets/images/odegaard.png": "29168817425a909e2e4e66286a439e4d",
"assets/assets/images/pedri.png": "74bff778b1703211791653bf80e7d8bc",
"assets/assets/images/personal_info.png": "e9e5b993b1e3e9e39db86fafd2ad80c0",
"assets/assets/images/player_card_frame.png": "ead1537f6e8a543bf61f0363782e2595",
"assets/assets/images/portfolio_chart.png": "a3b144c5ee80b0da807320c21046b264",
"assets/assets/images/profile_image.png": "728a5263cddd59ef273482d0cf927a2c",
"assets/assets/images/profile_image2.png": "26fce5260b43101f68a41927981d7adc",
"assets/assets/images/psg.png": "e8fcb0f9b7f0abf4551ec66ada1fca1d",
"assets/assets/images/rashford.png": "5b911ac6f42ff741670fcda9faa19cc1",
"assets/assets/images/rbl.png": "6944dd92e8ec612986fe06651dcd8e56",
"assets/assets/images/real_betis.png": "397682269c5c0e1a3f14cf0af2361160",
"assets/assets/images/real_madrid.png": "7d49e8deda088d9e7c6e0a13adeb7732",
"assets/assets/images/rice.png": "c14c910b5dbd3ead29363023a29bf6b7",
"assets/assets/images/rodrygo.png": "88499b680d6b274fac89cbde734b3d67",
"assets/assets/images/saka.png": "a3c1b15fd09411edee09f34b1f0da6df",
"assets/assets/images/sane.png": "c6597b7aef101ccb3814369625554000",
"assets/assets/images/simons.png": "d9abd0d77ba97a8a2e04294ce32934c1",
"assets/assets/images/son.png": "4930d466956022ba0779d8025682311f",
"assets/assets/images/sporting.png": "0726430de53d461a252afc47407a6523",
"assets/assets/images/starinvest_icon.png": "05d5f9e3d3faed033abde292180bcadb",
"assets/assets/images/starinvest_logo.png": "124ab56d17f03cb8390863ec6f4b6fda",
"assets/assets/images/starinvest_splash.png": "00a87d17d12427110bfcc73a102deb3f",
"assets/assets/images/sterling.png": "f19dc6cbb42d2d63c26116dbd0fe4968",
"assets/assets/images/szoboszlai.png": "599c4d754d924b0a1925f322b44f166c",
"assets/assets/images/tonali.png": "0c9e641f0d198d29b1241959c4c633b8",
"assets/assets/images/tottenham.png": "61451d98912d06f258189343797a1715",
"assets/assets/images/trent.png": "488fda008e90ec4055b37afd92c744d2",
"assets/assets/images/valverde.png": "f663040fa49e87f76955f5c1664fb66f",
"assets/assets/images/vinicius.png": "3f2b1d9d1f968d4af20839ad9c23e886",
"assets/assets/images/wirtz.png": "9970427cb28d6f354820942cc1d97b62",
"assets/FontManifest.json": "972be1440adfa564326dc74287baed72",
"assets/fonts/MaterialIcons-Regular.otf": "c261cd2ddeeeea6f458caac512cdbc2f",
"assets/NOTICES": "c421c03aeb571358d75594d24aea821a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "f99e18f2188af3651a8186557793445d",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "dce4b1255166e701cafe57e9ac6e80e5",
"icons/Icon-192.png": "62bc085f145fef6e043689ea10881096",
"icons/Icon-512.png": "d383a1a1a2e3e87e2a7dc4776da93db6",
"icons/Icon-maskable-192.png": "62bc085f145fef6e043689ea10881096",
"icons/Icon-maskable-512.png": "d383a1a1a2e3e87e2a7dc4776da93db6",
"index.html": "3923e102e6db9aea9073198494838e8a",
"/": "3923e102e6db9aea9073198494838e8a",
"main.dart.js": "ee128299a8925170b968d574f7ac9196",
"manifest.json": "5b9156485f49e354d46c14dabcf95522",
"version.json": "edcf671a2a1c1803ed60687f8a24507e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
