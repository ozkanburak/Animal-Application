import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hayvan_uyg/pages/MainPage.dart';

import 'package:hayvan_uyg/pages/myReports.dart';
import 'package:hayvan_uyg/pages/settings.dart';
import 'package:hayvan_uyg/pages/wrapper.dart';
import 'package:hayvan_uyg/services/auth.dart';
import 'package:hayvan_uyg/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hayvan_uyg/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      StreamProvider<User?>.value(initialData: null, value: AuthService().user),
      StreamProvider<QuerySnapshot?>.value(
        value: DatabaseService().reports,
        initialData: null,
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  InterstitialAd? interstitialAd;
  bool isLoaded = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
            this.interstitialAd = ad;
          });
          print("Ad Loaded");
        },
        onAdFailedToLoad: (error) {
          print("Intetstitial Failed to load");
        },
      ),
    );
  }

  final logedIn = false;
  int _currentIndex = 1;
  static List<Widget> bottomPages = <Widget>[
    Wrapper(widgetToShow: MyReports()),
    const MainPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      interstitialAd!.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue[400],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
              size: 30,
            ),
            label: "Gönderilerim",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), label: "Anasayfa"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 30), label: "Ayarlar"),
        ],
      ),
    );
  }
}
