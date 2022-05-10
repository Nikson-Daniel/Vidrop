import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ytvid extends StatefulWidget {
  const ytvid({
    Key? key,
    this.url,
  }) : super(key: key);
  final String? url;

  @override
  _ytvidState createState() => _ytvidState();
}

class _ytvidState extends State<ytvid> {
  static const PrrimaryColor = Color(0xFF6b4079);
  late InterstitialAd _interstitialAd;

  String? _extractedLink = 'Loading...';

  var uuid = Uuid();
  late String? youTube_link;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    myBanner.load();

    setState(() {
      isLoading = true;
    });
    extractYoutubeLink();
    setState(() {
      youTube_link = widget.url;
    });
  }

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-9797272882939142/9739693418',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  void _initAd() {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-3940256099942544/1033173712', // replace with your Admob Interstitial ad Unit ID
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        setState(() {
          _interstitialAd = ad;
        });
      }, onAdFailedToLoad: (LoadAdError error) {
        print('InterstitialAd failed to load: $error');
      }),
    );
  }

  void showAd() {
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("ad onAdshowedFullscreen");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print("ad Disposed");
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        print('$ad OnAdFailed $aderror');
        ad.dispose();
        //call reload of the ads
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );

    _interstitialAd.show();
    _interstitialAd == null;
  }

  void onAdLoaded() {}

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> extractYoutubeLink() async {
    String? link;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      link = await (FlutterYoutubeDownloader.extractYoutubeLink(
          youTube_link!, 18));
    } on PlatformException {
      link = 'Failed to Extract YouTube Video Link.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _extractedLink = link;
    });
  }

  Future<void> downloadVideo(String youtube_lnk, String title) async {
    final result = await FlutterYoutubeDownloader.downloadVideo(
        youTube_link!, '$title', 18);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    String videoId =
        YoutubePlayer.convertUrlToId(widget.url.toString()).toString();
    String finalUrl = widget.url.toString();
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/finbg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                      progressColors: ProgressBarColors(
                        playedColor: PrrimaryColor,
                        handleColor: PrrimaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 50.0,
                          width: 320.0,
                          child: AdWidget(
                            ad: myBanner,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.download),
              backgroundColor: PrrimaryColor,
              onPressed: () async {
                var status = await Permission.storage.status;
                if (status.isGranted) {
                  // We didn't ask for permission yet or the permission has been denied before but not permanently.
                  downloadVideo(youTube_link.toString(), uuid.v1() + ".");
                } else {
                  Permission.storage.request();
                }

// You can can also directly ask the permission about its status.
              })),
    );
  }

  buildLoading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        });
  }
}
