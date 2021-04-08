import 'dart:async';
import 'dart:io';
import 'package:app/models/user_model.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/resources/widget_styles.dart';
import 'package:app/services/loader_service.dart';
import 'package:app/services/localization_service.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/utils/utils_constants.dart';
import 'package:app/views/auth/signin_page.dart';
import 'package:app/views/main_views/home_view.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp fbApp = await Firebase.initializeApp (
    name: appName,
    options: Platform.isIOS || Platform.isMacOS ?
    FirebaseOptions(
      appId: '1:783907092206:ios:ff7cace8ea0caddb5aa5ff',
      apiKey: 'AIzaSyBQiaLeIKMjQfNFwsBxIYOcP7O9VNrotAc',
      projectId: 'cashtime-app',
      messagingSenderId: '783907092206',
      databaseURL: 'https://cashtime-app.firebaseio.com/',
    ) :
    FirebaseOptions(
      appId: '1:783907092206:android:65eed41baf646d615aa5ff',
      apiKey: 'AIzaSyBQiaLeIKMjQfNFwsBxIYOcP7O9VNrotAc',
      projectId: 'cashtime-app',
      messagingSenderId: '783907092206',
      databaseURL: 'https://cashtime-app.firebaseio.com/',
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(MyApp(fbApp: fbApp,));
}

class MyApp extends StatelessWidget {
  MyApp({this.fbApp});
  final FirebaseApp fbApp;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
      ],
      title: appName,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var langItem in supportedLocales) {
          if (langItem.languageCode == locale.languageCode) {
            appLocale = AppLocalizations(langItem);
            appLocale.load();
            return langItem;
          }
        }
        appLocale = AppLocalizations(supportedLocales.first);
        appLocale.load();
        return supportedLocales.first;
      },
      home: SplashScreen(fbApp: fbApp, ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.fbApp}) : super(key: key);
  final FirebaseApp fbApp;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  DatabaseReference userRef;

  Timer timer;

  void callSignInScreenScreen() {

    timer = Timer(const Duration(seconds: 2), () {
      NavigationService().navigateToScreen(context, SignInPage(), replace: true);
    }
    );
  }

  void callHomeScreenScreen() {

    timer = Timer(const Duration(seconds: 2), () {
        NavigationService().navigateToScreen(context, HomePage(), replace: true);
      }
    );
  }

  Future<void> fetchUserModel() async {
    Timer.run(() {
      LoaderService().showLoading(context);
    });

    await userRef.child(currentUser.userId).once().then((DataSnapshot snapshot) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      if(snapshot.value != null){
        showToast(appLocale.translate('logInSuccessed'));
        currentUser = UserModel.fromJson(snapshot.value);
        callHomeScreenScreen();
      } else{
        callSignInScreenScreen();
      }
    }).catchError((onError){
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      callSignInScreenScreen();
    });
  }

  @override
  void initState() {
    super.initState();

    currentUser = new UserModel();
    userRef = FirebaseDatabase.instance.reference().child(TB_USER);

    if (mAuth.currentUser != null) {
      currentUser.userId = mAuth.currentUser.uid;
      fetchUserModel();
    }else{
      callSignInScreenScreen();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: statusGradient(context),
        body: Container(
          decoration: mainGradient(),
          child: Column(
            children: [
              Expanded(flex: 1, child: Container(),),
              Container(
                child: Text(appName, style: gilroyStyleBold().copyWith(fontSize: 28,)),
              ),
              Expanded(flex: 1, child: Container(),),
            ],
          ),
        )
    );
  }
}
