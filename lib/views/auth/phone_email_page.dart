import 'dart:async';

import 'package:app/models/user_model.dart';
import 'package:app/resources/colors.dart';
import 'package:app/resources/dimen.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/resources/widget_styles.dart';
import 'package:app/services/loader_service.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/utils/utils_constants.dart';
import 'package:app/views/main_views/home_view.dart';
import 'package:app/views/main_views/userinfo_register_view.dart';
import 'package:app/views/sub_views/email_subview.dart';
import 'package:app/views/sub_views/phone_subview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'confirm_view.dart';

class PhoneEmailPage extends StatefulWidget {
  PhoneEmailPage({this.fbApp});
  final FirebaseApp fbApp;

  @override
  _PhoneEmailPageState createState() => _PhoneEmailPageState();
}

class _PhoneEmailPageState extends State<PhoneEmailPage> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  DatabaseReference userRef;

  UserModel userModel = new UserModel();
  int frgIndex = 0;

  String txtCountryCode = '+1', txtPhoneNumber = '';
  String txtEmail = '', txtPassword = '';

  @override
  void initState() {
    super.initState();
    userRef = FirebaseDatabase.instance.reference().child(TB_USER);

    clearGlobalData();
  }

  @override
  Widget build(BuildContext context) {
    offsetXLg = MediaQuery.of(context).size.width * 0.1;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: statusGradient(context),
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity, height: double.infinity,
          decoration: mainGradient(),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: offsetXLg, top: 56.0, right: offsetXLg),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              onClickBack();
                            },
                            child: smallIcon(Icons.arrow_back_ios_rounded)
                        ),

                        Expanded(
                          child: Text(
                            signinStatus == appLocale.translate('signIn') ? appLocale.translate('signIn') : appLocale.translate('signUp'),
                            textAlign: TextAlign.center,
                            style: gilroyStyleBold().copyWith(fontSize: 24.0),
                          ),
                        ),

                        InkWell(
                            onTap: (){
                              onClickQuote();
                            },
                            child: SvgPicture.asset('assets/icons/ico_help.svg', width: 26, color: kWhiteColor,)
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 56.0),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                onPhone();
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      appLocale.translate('phone'),
                                      style: gilroyStyleRegular().copyWith(fontSize: 20.0, color: kWhiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8.0),
                                      height: 2.0,
                                      color: frgIndex == 0 ? kWhiteColor : kWhiteDarkColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                onEmail();
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      appLocale.translate('email'),
                                      style: gilroyStyleRegular().copyWith(fontSize: 20.0, color: kWhiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8.0),
                                      height: 2.0,
                                      color: frgIndex == 0 ? kWhiteDarkColor : kWhiteColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if(frgIndex == 0)
                      PhoneEntryView(txtCountryCode, txtPhoneNumber, (cCode, pNumber){
                        onChangedphoneNumber(cCode, pNumber);
                      }, (){
                        onClickSendCode();
                      },
                    ),

                    if(frgIndex == 1)
                      EmailEntryView(txtEmail, txtPassword, (_txtEmail, _txtPassword){
                        onChangedEmail(_txtEmail, _txtPassword);
                      }, (){
                        emailEntryCallback();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  clearGlobalData(){
    phoneNumber = '';
    phoneCountryCode = '+1';
    phoneNumber_otp_hint = '';

    emailStr = '';
    passwordStr = '';

    currentUser.phoneNumber = '';
    currentUser.emailAddress = '';
  }

  void onClickBack() {
    Navigator.of(context).pop();
  }

  void onPhone() {
    needToCreateAuth = false;
    clearGlobalData();

    frgIndex = 0;
    setState(() {});
  }

  void onEmail() {
    needToCreateAuth = true;
    clearGlobalData();

    frgIndex = 1;
    setState(() {});
  }

  onChangedEmail(_txtEmail, _txtPassword){
    txtEmail = _txtEmail;
    txtPassword = _txtPassword;
  }

  emailEntryCallback() {
    needToCreateAuth = true;
    if(txtEmail == ''){
      showToast(appLocale.translate('enterEmail'));
    }else if(signinStatus == appLocale.translate('signIn') && txtPassword == ''){
      showToast(appLocale.translate('enterEmail'));
    }else{

      if(signinStatus == appLocale.translate('signIn')){
        _signInWithEmailAndPassword();
      }else{
        emailStr = txtEmail;
        passwordStr = '';
        NavigationService().navigateToScreen(context, UserInfoRegister(fbApp: widget.fbApp, registerIndex: REG_PASSWORD,), );
      }
    }
  }

  onChangedphoneNumber(cCode, pNumber){
    txtCountryCode = cCode;
    txtPhoneNumber = pNumber;
  }

  onClickSendCode() {
    if(txtPhoneNumber == ''){
      showToast(appLocale.translate('enterPhoneNumber'));
    }else{
      phoneCountryCode = txtCountryCode;
      phoneNumber = txtPhoneNumber;
      phoneNumber_otp_hint = txtCountryCode + ' ' + txtPhoneNumber;
      NavigationService().navigateToScreen(context, ConfirmPage(fbApp: widget.fbApp,), );
    }
  }

  Future<void> fetchUserModel() async {
    Timer.run(() {
      LoaderService().showLoading(context);
    });

    await userRef.child(currentUser.userId).once().then((DataSnapshot snapshot) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      if(snapshot.value != null){
        currentUser = UserModel.fromJson(snapshot.value);
        NavigationService().navigateToScreen(context, HomePage(fbApp: widget.fbApp,), replace: true);
      }
      else{
        showToast(appLocale.translate('loginFailed'));
      }
    }).catchError((error) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);
      showToast(appLocale.translate('databaseError'));
    });
  }

  void _signInWithEmailAndPassword() async {
    Timer.run(() {
      LoaderService().showLoading(context);
    });

    try {
      final firebaseUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: txtEmail, password: txtPassword);

      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      if(firebaseUser != null){
        currentUser.userId = firebaseUser.user.uid;
        fetchUserModel();
      }else{
        showToast(appLocale.translate('loginFailed'));
      }

    } on FirebaseAuthException catch (e) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      if (e.code == 'user-not-found') {
        showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast('Wrong password provided for that user.');
      }
    }
  }
}
