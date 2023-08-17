'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-2048.gif": "9b45a138a409e0fd5166b110392d1224",
"index.html": "0ab601b29fc4b33a2f049842895982f4",
"/": "0ab601b29fc4b33a2f049842895982f4",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"manifest.json": "bf6c1147a9a6c8f92ddedea61f650cd4",
"favicon.png": "8d930dec302198f2d131c5e6fe8c5d75",
"assets/fonts/MaterialIcons-Regular.otf": "a2e5df6c47b635ffaf4e0bc91a208fe5",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "3153559ffbf2fdccea8f46e31314f34b",
"assets/assets/images/car/car1.png": "31cce1d071931f77bd3c422132c9beb4",
"assets/assets/images/car/car0.png": "f80232bb63df5e00d7cf42726c4d06c9",
"assets/assets/images/car/car2.png": "6b9a29acb12c6d48916cbfb946014d1b",
"assets/assets/images/cover/begin.png": "0b33007607e58f065dc10de82aa8d82f",
"assets/assets/images/cover/start.png": "3c8071c05f4e19876761dc9f9b3cf76e",
"assets/assets/images/cover/game_over.png": "717cd585ccbdcbc40cdf52b2adcd3c2b",
"assets/assets/images/cover/favicon.gif": "9b45a138a409e0fd5166b110392d1224",
"assets/assets/images/cover/background.png": "1695cec624246333bd58c512e748bf67",
"assets/assets/images/cover/instruction.png": "0ed4e417f8c01b9720b772d6ff7270c9",
"assets/assets/images/bird/bird1.png": "5e9499ca2cbb22199322744155803f66",
"assets/assets/images/bird/bird2.png": "970200ee019827f6f75f027e6e608e8f",
"assets/assets/images/bird/bird0.png": "557fbdc0b810aa8be142341603834b72",
"assets/assets/images/bird/bird3.png": "557fbdc0b810aa8be142341603834b72",
"assets/assets/images/person/person_v2-1.png": "f65359d9a96d0ddee019f73f5931a5a1",
"assets/assets/images/person/person_v2-3.png": "b120132eea9b6b9652cfeb8252b53e06",
"assets/assets/images/person/person_v2-2.png": "6d920b56f65dba91fc336e9fc3badf65",
"assets/assets/images/person/person_v2-0.png": "6d920b56f65dba91fc336e9fc3badf65",
"assets/assets/images/player/player0.png": "1231d6d45d79b08778722a03434314a9",
"assets/assets/images/player/player1.png": "cb058d11b4cea083387dd9db5fa1b8d6",
"assets/assets/images/player/be_crashed.png": "041336867baff6ac59f12b3a16e325b9",
"assets/assets/images/player/player2.png": "14272fda21bf893248f77369c8175eb7",
"assets/assets/images/bus/bus0.png": "9bc91baf8086a05530690ea84c82be52",
"assets/assets/images/bus/bus2.png": "3d1d27266ed68cd49cab9738f3919879",
"assets/assets/images/bus/bus4.png": "1e1f9f5086021a5bdeb94b131b82b975",
"assets/assets/images/bus/bus5.png": "bf583bc41fb746cbf3d4d0d6f17a60eb",
"assets/assets/images/bus/bus3.png": "5f65b3a9709f1c1464c5a7b2b2b1c630",
"assets/assets/images/bus/bus1.png": "c65b8cc62e33c232b1ba8b6a593e2380",
"assets/assets/images/road/road3.png": "d52be59b41a450e11c85dc648da32233",
"assets/assets/images/road/road0.png": "3a52e9a81fc2acbd4879208231b34ce3",
"assets/assets/images/road/road1.png": "f0e2cf4e84e3884eeb3c6501bf890040",
"assets/assets/images/road/road2.png": "3306458eb1ee27e9be6924ea805e488d",
"assets/assets/fonts/iansui.ttf": "2929d08daf249f0d32eca95baffaba20",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/AssetManifest.json": "24a15b7159c54d4622ab49c06d5b964e",
"assets/NOTICES": "eaf84d8e91da6b0dee4b7bdaad9d55b0",
"assets/FontManifest.json": "178dfcce10cd45738e21e40e1673bf06",
"version.json": "7897962182c528f7f59cda67f926c9c8",
"main.dart.js": "aab99e579c25b7925d656dadf4b58751",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
