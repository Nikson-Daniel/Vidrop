import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:direct_link/direct_link.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class instVid extends StatefulWidget {
  const instVid({Key? key, required this.url, required this.dwnldUr})
      : super(key: key);
  final String url;
  final String dwnldUr;
  @override
  _instVidState createState() => _instVidState();
}

class _instVidState extends State<instVid> with SingleTickerProviderStateMixin {
  late WebViewController _controller;

  static const PrrimaryColor = Color(0xFF6b4079);
  late String displayUrl;
  late String fin;

  @override
  void initState() {
    super.initState();
    myBanner.load();
    setState(() {
      fin = widget.dwnldUr;
    });
  }

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-9797272882939142/4432747607',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  void _launchURL(String _finUrl) async {
    if (await canLaunch(_finUrl)) {
      launch(_finUrl, forceSafariVC: true);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 50.0,
                    width: 320.0,
                    child: AdWidget(
                      ad: myBanner,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 600,
                    child: WebView(
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController web) {
                        _controller = web;
                      },
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: new FloatingActionButton(
                elevation: 0.0,
                child: new Icon(Icons.download),
                backgroundColor: PrrimaryColor,
                onPressed: () {
                  if (fin == null) {
                  } else {
                    _launchURL(fin);
                  }
                })),
      ),
    );
  }
}
