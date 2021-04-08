import 'dart:async';
import 'dart:io';

import 'package:app/cstmuis/button_ui.dart';
import 'package:app/models/user_model.dart';
import 'package:app/resources/colors.dart';
import 'package:app/resources/dimen.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/resources/widget_styles.dart';
import 'package:app/services/loader_service.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/utils/utils_constants.dart';
import 'package:app/views/auth/phone_email_page.dart';
import 'package:app/views/auth/signup_page.dart';
import 'package:app/views/main_views/home_view.dart';
import 'package:app/views/main_views/userinfo_register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  SignInPage({this.fbApp});
  final FirebaseApp fbApp;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  DatabaseReference userRef;

  UserModel userModel = new UserModel();

  bool supportsAppleSignIn = false;

  checkAppleSignAbalable() async {
    // if(Platform.isIOS) {
    //   supportsAppleSignIn = await AppleSignIn.isAvailable();
    // }
  }

  @override
  void initState() {
    signinStatus = appLocale.translate('signIn');
    userRef = FirebaseDatabase.instance.reference().child(TB_USER);

    checkAppleSignAbalable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    offsetXLg = MediaQuery.of(context).size.width * 0.06;
    return Scaffold(
      appBar: statusGradient(context),
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: mainGradient(),
        child: Padding(
          padding: EdgeInsets.only(
              left: offsetXLg, top: 64.0, right: offsetXLg),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0, left: 24.0),
                      height: 72,
                      child: SvgPicture.asset('assets/icons/ico_group_logo.svg',
                        fit: BoxFit.fitHeight, color: kWhiteColor,),
                    ),
                  ),

                  InkWell(
                      onTap: () {
                        mAuth.signOut();
                        onClickQuote();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/ico_help.svg', width: 26,
                        color: kWhiteColor,)
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 28.0,),
                child: Column(
                  children: [
                    Text(
                      appLocale.translate('loginToCashTime'),
                      style: gilroyStyleBold().copyWith(fontSize: 22.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Text(
                        appLocale.translate('payPerSecondVideoChat'),
                        style: gilroyStyleBold().copyWith(fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 280,
                margin: EdgeInsets.only(top: 28.0),
                height: 44.0,
                child: CustomButton(
                  isSvg: true,
                  assetPath: 'assets/icons/ico_user.svg',
                  title: appLocale.translate('usePhoneEmail'),
                  txtStyle: gilroyStyleBold().copyWith(
                      fontSize: 14.0, color: kTextMainColor),
                  onTap: () {
                    continueWithPhoneEmail();
                  },
                ),
              ),

              Container(
                width: 280,
                margin: EdgeInsets.only(top: 16.0),
                height: 44.0,
                child: CustomButton(
                  isSvg: true,
                  assetPath: 'assets/icons/ico_apple.svg',
                  title: appLocale.translate('continueWithApple'),
                  iconColor: kBlackColor,
                  txtStyle: gilroyStyleBold().copyWith(
                      fontSize: 14.0, color: kTextMainColor),
                  onTap: () {
                    _signInWithApple(context);
                  },
                ),
              ),

              Container(
                width: 280,
                margin: EdgeInsets.only(top: 16.0),
                height: 44.0,
                child: CustomButton(
                  isSvg: false,
                  assetPath: 'assets/images/ico_google.png',
                  title: appLocale.translate('continueWithGoogle'),
                  setIconColor: false,
                  txtStyle: gilroyStyleBold().copyWith(
                      fontSize: 14.0, color: kTextMainColor),
                  onTap: () {
                    signInWithGoogle();
                  },
                ),
              ),

              Spacer(),

              Container(
                width: 280,
                margin: EdgeInsets.only(bottom: 18.0),
                child: InkWell(
                  onTap: () {
                    gotoSignUp();
                  },
                  child: Row(
                    children: [
                      Text(
                        appLocale.translate('dontHaveAccount'),
                        style: gilroyStyleRegular().copyWith(fontSize: 14.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.0),
                        child: Text(
                          appLocale.translate('signUp'),
                          style: gilroyStyleRegular().copyWith(fontSize: 15.0,
                              color: kBlueColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void continueWithPhoneEmail() {
    NavigationService().navigateToScreen(context, PhoneEmailPage(fbApp: widget.fbApp,),);
  }

  Future<void> _signInWithApple(BuildContext context) async {
    needToCreateAuth = false;

    // try {
    //   final AuthorizationResult result = await AppleSignIn.performRequests([
    //     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    //   ]);
    //
    //   if(result.status == AuthorizationStatus.authorized){
    //     try {
    //       final AppleIdCredential appleIdCredential = result.credential;
    //
    //       OAuthProvider oAuthProvider = new OAuthProvider("apple.com");
    //       final AuthCredential credential = oAuthProvider.credential(
    //         idToken:
    //         String.fromCharCodes(appleIdCredential.identityToken),
    //         accessToken:
    //         String.fromCharCodes(appleIdCredential.authorizationCode),
    //       );
    //
    //       final UserCredential _res = await mAuth.signInWithCredential(credential);
    //       final User user = _res.user;
    //       if (user != null) {
    //         userModel.userId = user.uid;
    //         userModel.emailAddress = user.email;
    //         fetchUserModel();
    //       }else{
    //         showToast("error");
    //       }
    //
    //     } catch (e) {
    //       showToast("error");
    //     }
    //   }else{
    //     showToast("error");
    //   }
    // } catch (error) {}
  }

  void gotoSignUp() {
    NavigationService().navigateToScreen(context, SignUpPage(fbApp: widget.fbApp,),);
  }

  Future<void> signInWithGoogle() async {
    needToCreateAuth = false;
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await mAuth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User curUser = mAuth.currentUser;
      assert(user.uid == curUser.uid);

      userModel.userId = curUser.uid;
      userModel.emailAddress = curUser.email;
      emailStr = curUser.email;
      fetchUserModel();
    }
  }

  Future<void> fetchUserModel() async {
    Timer.run(() {
      LoaderService().showLoading(context);
    });

    await userRef.child(userModel.userId).once().then((DataSnapshot snapshot) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      if(snapshot.value != null){
        currentUser = UserModel.fromJson(snapshot.value);
        NavigationService().navigateToScreen(context, HomePage(fbApp: widget.fbApp,), replace: true);
      }
      else{
        NavigationService().navigateToScreen(context, UserInfoRegister(fbApp: widget.fbApp, registerIndex: REG_NAME,), );
      }
    }).catchError((error) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);
      showToast(appLocale.translate('databaseError'));
    });
  }
}
