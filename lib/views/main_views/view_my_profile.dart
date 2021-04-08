import 'dart:io';
import 'dart:ui';

import 'package:app/resources/colors.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/services/common_service.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/views/auth/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class ViewMyProfile extends StatefulWidget {
  ViewMyProfile({this.returnCallback});
  Function returnCallback;

  @override
  _ViewMyProfileState createState() => _ViewMyProfileState();
}

class _ViewMyProfileState extends State<ViewMyProfile> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height - 160;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: kWhiteColor,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: double.infinity, height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.brown.withOpacity(0.6),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 96, color: Colors.black.withOpacity(0.2),
                      child: Column(
                        children: [
                          SizedBox(height: 40,),
                          Row(
                            children: [
                              SizedBox(width: 12,),
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios, color: kWhiteColor, size: 26),
                                onPressed: () {
                                  _onWillPop();
                                },
                              ),
                              Spacer(),
                              Text('Profile', style: gilroyStyleBold().copyWith(color: kWhiteColor, fontSize: 26),),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.logout, color: kWhiteColor, size: 26),
                                onPressed: () {
                                  signOut(context);
                                },
                              ),
                              SizedBox(width: 12,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: profileImgPath == '' ?
                        Center(
                          child: Text('Please take profile photo.', style: gilroyStyleBold().copyWith(color: kWhiteColor, fontSize: 20),)
                        ) :
                        Container(
                            child: Image.file(File(profileImgPath), fit: BoxFit.cover, width: double.infinity, height: h,),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 64, color: Colors.black.withOpacity(0.2),
                      child: InkWell(
                        child: Center(
                          child: Container(
                            width: 48, height: 48,
                            child: Center(
                                child: Icon(Icons.add_a_photo, color: Colors.redAccent, size: 28,)
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                        onTap: (){
                          showImagePickerDialog();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickBack() {
    Navigator.of(context).pop();
  }

  void initData() {

  }

  void signOut(_context) {
    showAlertDialog(context, 'Sign Out', 'Do you want to sign out?', (){
        mAuth.signOut();
        NavigationService().navigateToScreen(_context, SignInPage(), replace: true);
      }, (){}
    );
  }

  Future<bool> _onWillPop() {
    Navigator.of(context).pop();
    widget.returnCallback();
  }

  void showImagePickerDialog() {
    CommonService().showBottomDialog(
      context: context,
      height: 160,
      title: 'Choose Image',
      bodyWidget: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              getImage(ImageSource.gallery);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.image, size: 24, color: Colors.black45,),
                Text('From Gallery', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                Container(width: 24,),
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              getImage(ImageSource.camera);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.camera_alt, size: 24, color: Colors.black45,),
                Text('From Camera', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                Container(width: 24,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getImage(ImageSource soure) async {
    final pickedFile = await picker.getImage(source: soure);
    setState(() {
      if (pickedFile != null) {
        profileImgPath = pickedFile.path;
      }
    });
  }
}
