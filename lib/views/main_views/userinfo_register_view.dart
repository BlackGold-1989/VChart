import 'dart:async';

import 'package:app/cstmuis/button_ui.dart';
import 'package:app/models/user_model.dart';
import 'package:app/resources/colors.dart';
import 'package:app/resources/dimen.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/resources/widget_styles.dart';
import 'package:app/services/loader_service.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/utils/util_time.dart';
import 'package:app/utils/utils_constants.dart';
import 'package:app/views/main_views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UserInfoRegister extends StatefulWidget {
  UserInfoRegister({this.fbApp, this.registerIndex});
  final FirebaseApp fbApp;
  int registerIndex;

  @override
  _UserInfoRegisterState createState() => _UserInfoRegisterState();
}

class _UserInfoRegisterState extends State<UserInfoRegister> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  DatabaseReference userRef;

  UserModel userModel = new UserModel();
  String title = '', txtPassword = '', hintText = '', bottomTitle = '';
  bool visiblePassword = false;
  DateTime selectedDate = DateTime.now();

  TextEditingController txtInput = TextEditingController();
  int startIndex;

  @override
  void initState() {
    super.initState();
    userRef = FirebaseDatabase.instance.reference().child(TB_USER);
    userModel = currentUser.copyWith();
    startIndex = widget.registerIndex;

    if(widget.registerIndex == REG_PASSWORD){
      title = appLocale.translate('createPassword');
      bottomTitle = '';
      visiblePassword = false;
    }
    else if(widget.registerIndex == REG_NAME){
      title = appLocale.translate('myNameIs');
      bottomTitle = 'This is how it will appear in CashTime';
      visiblePassword = true;
    }
    else{
      title = appLocale.translate('myBirthdayIs');
      bottomTitle = 'Your age is private and will not be visible';
      visiblePassword = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    offsetXLg = MediaQuery.of(context).size.width * 0.06;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: statusGradient(context),
          resizeToAvoidBottomInset: true,
          body: Container(
            width: double.infinity, height: double.infinity,
            decoration: mainGradient(),
            child: Padding(
              padding: EdgeInsets.only(left: offsetXLg, top: 20.0, right: offsetXLg),
              child: SingleChildScrollView(
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
                        Spacer(),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 48),
                          child: Text(title, textAlign: TextAlign.start, style: gilroyStyleMedium().copyWith(fontSize: 22.0),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),

                    InkWell(
                      onTap: (){
                        if(widget.registerIndex == REG_BIRTHDAY){
                          showCalendarDlg(context);
                        }
                      },
                      child: Stack(
                        children: [
                          if(widget.registerIndex == REG_BIRTHDAY) Container(
                            margin: EdgeInsets.only(top: 8),
                            width: double.infinity, height: 44,
                            decoration: BoxDecoration(
                              border: Border.all(color: kWhiteColor, width: 1.7),
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              color: Colors.transparent
                            ),
                          ),
                          Container(
                            height: 36, width: double.infinity,
                            margin: EdgeInsets.only(top: 16),
                            child: Center(
                              child: TextField(
                                textAlign: widget.registerIndex == REG_PASSWORD ? TextAlign.start : TextAlign.center,
                                controller: txtInput,
                                style: gilroyStyleRegular().copyWith(color: kWhiteColor, fontSize: 18.0),
                                keyboardType: TextInputType.text,
                                cursorColor: kWhiteColor,
                                autofocus: true,
                                obscureText: !visiblePassword,
                                enabled: widget.registerIndex == REG_BIRTHDAY ? false : true,
                                decoration: InputDecoration(
                                  hintText: widget.registerIndex == REG_BIRTHDAY ? 'Month/Day/Year' : '',
                                  hintStyle: gilroyStyleMedium().copyWith(color: kWhiteColor, fontSize: 18),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if(widget.registerIndex != REG_BIRTHDAY)Container(
                      margin: EdgeInsets.only(top: 2, ),
                      height: 2,
                      color: kWhiteColor,
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 12),
                      alignment: Alignment.centerLeft,
                      child: Text(bottomTitle, style: gilroyStyleMedium().copyWith(color: kWhiteColor, fontSize: 13),),
                    ),

                    if(widget.registerIndex == REG_PASSWORD)
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: InkWell(
                              onTap: (){
                                visiblePassword = !visiblePassword;
                                setState((){});
                              },
                                child: Icon(visiblePassword == true ? Icons.visibility :Icons.visibility_off, color: kWhiteColor,)
                            )
                          ),
                        ],
                      ),

                    Container(
                      margin: EdgeInsets.only(top: 56.0),
                      height: 44.0,
                      child: CustomButton(
                        enableLeading: false,
                        title: appLocale.translate('continue'),
                        setIconColor: false,
                        buttonColor: kWhiteColor,
                        txtStyle: gilroyStyleBold().copyWith(fontSize: 14.0, color: kTextMainColor),
                        onTap: (){
                          onClickContinue();
                        },
                      ),
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

  setTitle() {
    if(widget.registerIndex == REG_PASSWORD){
      title = appLocale.translate('createPassword');
      bottomTitle = '';
    }
    else if(widget.registerIndex == REG_NAME){
      title = appLocale.translate('myNameIs');
      bottomTitle = 'This is how it will appear in CashTIme';
      visiblePassword = true;
    }
    else{
      title = appLocale.translate('myBirthdayIs');
      bottomTitle = 'Your age is private and will not be visible';
      visiblePassword = true;
    }
  }

  Future<bool> onClickBack() {
    if(startIndex >= widget.registerIndex){
      Navigator.of(context).pop();
    }else{
      if(widget.registerIndex == REG_PASSWORD){
        Navigator.of(context).pop();
      }else if(widget.registerIndex == REG_NAME){
        txtInput.text = '';
        widget.registerIndex = REG_PASSWORD;
        setTitle();
        setState((){});
      }else{
        txtInput.text = '';
        widget.registerIndex = REG_NAME;
        setTitle();
        setState((){});
      }
    }
  }

  Future<void> fetchUserModel(String userId) async {
    Timer.run(() {
      LoaderService().showLoading(context);
    });

    await userRef.child(userId).once().then((DataSnapshot snapshot) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      if(snapshot.value != null){
        showToast('isExistUser');
      }
      else{
        txtPassword = txtInput.text;
        txtInput.text = '';
        widget.registerIndex = REG_NAME;
        setTitle();
        setState((){});
      }
    }).catchError((error) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);
      showToast('databaseError');
    });
  }

  void _signInWithEmailAndPassword() async {
    Timer.run(() {
      LoaderService().showLoading(context);
    });

    try {
      final firebaseUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailStr, password: txtInput.text);

      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      if(firebaseUser != null){
        showToast('isExistUser');
      }else{
        txtInput.text = '';
        widget.registerIndex = REG_NAME;
        setTitle();
        setState((){});setState((){});
        }

    } on FirebaseAuthException catch (e) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      txtInput.text = '';
      widget.registerIndex = REG_NAME;
      setTitle();
      setState((){});
    }
  }

  void onClickContinue() {
    if(widget.registerIndex == REG_PASSWORD){
      if(txtInput.text != ''){
        txtPassword = txtInput.text;
        hintText = '';
        _signInWithEmailAndPassword();
      }
    }else if(widget.registerIndex == REG_NAME){
      if(txtInput.text != ''){
        userModel.name = txtInput.text;
        txtInput.text = '';
        hintText = 'Month/Day/Year';
        widget.registerIndex = REG_BIRTHDAY;
        setTitle();
        setState((){});
      }
    }else{
      if(txtInput.text != ''){
        userModel.birthDay = txtInput.text;
        userModel.emailAddress = emailStr;
        userModel.phoneNumber = phoneCountryCode + phoneNumber;
        if(!needToCreateAuth){
          registerUserToDB();
        }else{
          registerUserWithEmailAndPassword();
        }
      }
    }
  }

  void registerUserWithEmailAndPassword() async {
    Timer.run(() {
      LoaderService().showLoading(context);
    });

    try {
      final firebaseUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailStr, password: txtPassword);

      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      if(firebaseUser != null){
        userModel.userId = firebaseUser.user.uid;
        registerUserToDB();
      }else {
        showToast(appLocale.translate('registerFailed'));
      }

    } on FirebaseAuthException catch (e) {
      if(LoaderService().checkLoading())

      if (e.code == 'user-not-found') {
        showToast(appLocale.translate('registerFailed'));
      } else if (e.code == 'wrong-password') {
        showToast(appLocale.translate('registerFailed'));
      }else if (e.code == 'email-already-in-use'){
        showToast(appLocale.translate('emailAlreadyInUse'));
      }
    }
  }

  void registerUserToDB() {
    Timer.run(() {
      LoaderService().showLoading(context);
    });

    userRef.child(userModel.userId).set(userModel.toJson()).then((val) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      currentUser = userModel.copyWith();
      NavigationService().navigateToScreen(context, HomePage(fbApp: widget.fbApp,), replace: true);
    }).catchError((error) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);

      showToast(appLocale.translate('databaseError'));
    });
  }

  Future<bool> _onWillPop() async {
    if(startIndex >= widget.registerIndex){
      return true;
    }else{
      if(widget.registerIndex == REG_PASSWORD){
        return true;
      }else if(widget.registerIndex == REG_NAME){
        widget.registerIndex = REG_PASSWORD;
        hintText = '';
        setTitle();
        setState((){return false;});
      }else{
        widget.registerIndex = REG_NAME;
        hintText = '';
        setTitle();
        setState((){return false;});
      }
    }
  }

  void showCalendarDlg(BuildContext context) async{
    final DateTime picked = await showDatePicker(context: context, initialDate: selectedDate,
      firstDate: DateTime(1900), lastDate: DateTime(2050), );

    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
        txtInput.text = TimeUtil.getBirthdayFormatted(selectedDate);
      });
    }
  }
}
