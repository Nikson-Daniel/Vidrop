import 'package:flutter/material.dart';
import 'package:video_downloader/FBVid.dart';
import 'package:video_downloader/INSTVid.dart';
import 'package:video_downloader/YTVid.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:direct_link/direct_link.dart';
import 'package:video_downloader/videoPlayWidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class fbVid extends StatefulWidget {
  const fbVid({Key? key, required this.url, required this.dwnldUr})
      : super(key: key);
  final String? url;
  final String dwnldUr;

  @override
  _fbVidState createState() => _fbVidState();
}

class _fbVidState extends State<fbVid> {
  late String fin;
  static const PrrimaryColor = Color(0xFF6b4079);

  @override
  void initState() {
    super.initState();
    myBanner.load();
    setState(() {
      fin = widget.dwnldUr;
    });
  }

  void _launchURL(String _finUrl) async {
    if (await canLaunch(_finUrl)) {
      launch(_finUrl, forceSafariVC: true);
    } else {
      throw 'Coud not download';
    }
  }

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-9797272882939142/6867339254',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  Widget build(BuildContext context) {
    String finalUrl = widget.url.toString();
    String html = '''
           <iframe width="200" height='200'
            src="https://www.facebook.com/v2.3/plugins/video.php? 
            allowfullscreen=false&autoplay=true&href=$finalUrl" </iframe>
     ''';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      child: new SingleChildScrollView(
                        child: HtmlWidget(
                          html,
                          webView: true,
                        ),
                      ),
                    ),
                  ),
                  Column(
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
                ],
              ),
            ),
          ),
          floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.download),
              backgroundColor: PrrimaryColor,
              onPressed: () {
                if (fin == null) {
                  print("Hi");
                } else {
                  _launchURL(fin);
                }
              })),
    );
  }
}
