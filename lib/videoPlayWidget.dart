import 'dart:async';

import 'package:flutter/services.dart';
import 'package:video_downloader/FBVid.dart';
import 'package:video_downloader/INSTVid.dart';
import 'package:video_downloader/YTVid.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:direct_link/direct_link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  static const PrrimaryColor = Color(0xFF6b4079);
  late String _url;
  String dwnldUrl = "";
  String _faceBook = "https://fb.watch/";
  String _fbAlter = "https://www.facebook.com/";
  String _youtube = "https://youtu.be/";
  String _youtubeAlter = "https://youtube.com/shorts";
  String _instagram = "https://www.instagram.com/";
  String _youtubeShorts = "https://youtube.com/shorts/";
  String termsAndConditions =
      'https://nhdevelopersofficial.blogspot.com/2022/03/terms-and-conditions.html';
  String privacyPolicy =
      'https://nhdevelopersofficial.blogspot.com/2022/03/privacy-policy.html';

  String aboutUs =
      "https://nhdevelopersofficial.blogspot.com/2022/03/about-us.html";
  late InterstitialAd _interstitialAd;

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-9797272882939142/5689988953',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    _initAdYT();
    _initAdFB();
    _initAdInst();
    //SystemChannels.textInput.invokeMethod('TextInput.hide');
    myBanner.load();
  }

  dem(String dwnd) async {
    String url = dwnd.toString();
    var check = await DirectLink.check(url); // add your url

    for (var element in check!) {
      setState(() {
        dwnldUrl = element.link;
      });
    }
  }

  void _initAdYT() {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-9797272882939142/1615012574', // replace with your Admob Interstitial ad Unit ID
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

  void showAdYT() {
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("ad onAdshowedFullscreen");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ytvid(
                  url: _url,
                )));
        // ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ytvid(
                  url: _url,
                )));
        // ad.dispose();
        //call reload of the ads
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );

    _interstitialAd.show();
    _interstitialAd == null;
  }

  void _initAdInst() {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-9797272882939142/4049604228', // replace with your Admob Interstitial ad Unit ID
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

  void showAdInst() {
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("ad onAdshowedFullscreen");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => instVid(
                  url: _url,
                  dwnldUr: dwnldUrl,
                )));
        // ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => instVid(
                  url: _url,
                  dwnldUr: dwnldUrl,
                )));
        // ad.dispose();
        //call reload of the ads
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );

    _interstitialAd.show();
    _interstitialAd == null;
  }

  void _initAdFB() {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-9797272882939142/7223450525', // replace with your Admob Interstitial ad Unit ID
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

  void showAdFB() {
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("ad onAdshowedFullscreen");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => fbVid(
                url: _url,
                dwnldUr: dwnldUrl,
              ),
            ));
        // ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => fbVid(
                url: _url,
                dwnldUr: dwnldUrl,
              ),
            ));
        // ad.dispose();
        //call reload of the ads
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );

    _interstitialAd.show();
    _interstitialAd == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/finbg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Paste your URL here",
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: new BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      validator: (value) {
                        setState(() {
                          _url = value.toString().trim();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(PrrimaryColor)),
                      child: Text("Enter"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (_url.startsWith(_faceBook)) {
                            dem(_url);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => fbVid(
                                      url: _url,
                                      dwnldUr: dwnldUrl,
                                    )));
                            showAdFB();
                          } else if (_url.startsWith(_fbAlter)) {
                            dem(_url);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => fbVid(
                                      url: _url,
                                      dwnldUr: dwnldUrl,
                                    )));
                            showAdFB();
                          } else if (_url.startsWith(_instagram)) {
                            dem(_url);

                            if (dwnldUrl.startsWith("https://")) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => instVid(
                                        url: _url,
                                        dwnldUr: dwnldUrl,
                                      )));
                              showAdInst();
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Loader()));
                            }
                          } else if (_url.startsWith(_youtube)) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ytvid(
                                      url: _url,
                                    )));
                            showAdYT();
                          } else if (_url.startsWith(_youtubeAlter)) {
                            getVideoID(_url);
                          } else if (_url.isEmpty) {
                            //youTubeVideo();
                            return;
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
        ),
      ),
      drawer: GestureDetector(
        child: Drawer(
          child: SafeArea(
              right: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: PrrimaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage("assets/final.jpg")),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Center(
                              child: Text(
                                "Vidrop",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    onTap: () {
                      _launchURL(aboutUs);
                    },
                    title: Text("About us"),
                  ),
                  ListTile(
                    leading: Icon(Icons.rule),
                    onTap: () {
                      _launchURL(termsAndConditions);
                    },
                    title: Text("Terms and conditions"),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip),
                    onTap: () {
                      _launchURL(privacyPolicy);
                    },
                    title: Text("Privacy policy"),
                  ),
                  ListTile(
                    leading: Icon(Icons.note),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Licence()));
                    },
                    title: Text("Open source library"),
                  ),
                ],
              )),
        ),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            title: Text(
              "Vidrop",
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: PrrimaryColor,
            // ...
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getVideoID(String url) {
    List user = url.split('shorts/');
    String dem1 = user[1];
    List user1 = dem1.split('?');
    String finId = user1[0];
    String finUrl = "https://youtu.be/" + finId + "?";

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ytvid(
              url: finUrl,
            )));
    return url;
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $_url';
  }
}

class Licence extends StatefulWidget {
  const Licence({Key? key}) : super(key: key);

  @override
  State<Licence> createState() => _LicenceState();
}

class _LicenceState extends State<Licence> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LicensePage(
        applicationName: "Vidrop",
        applicationIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/final.jpg",
            width: 50,
            height: 50,
          ),
        ),
        applicationVersion: '0.0.1',
      ),
    );
  }
}

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please click Enter again"),
      ));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Color(0xFF6b4079),
              valueColor: AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 8,
            ),
          ],
        ),
      ),
    );
  }
}
