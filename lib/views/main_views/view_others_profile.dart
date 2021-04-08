import 'dart:ui';

import 'package:align_positioned/align_positioned.dart';
import 'package:app/cstmuis/button_ui.dart';
import 'package:app/models/user_model.dart';
import 'package:app/resources/colors.dart';
import 'package:app/resources/dimen.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/resources/widget_styles.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/views/auth/phone_email_page.dart';
import 'package:app/views/auth/signin_page.dart';
import 'package:app/views/auth/signup_page.dart';
import 'package:app/views/main_views/search_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ViewOtherProfile extends StatefulWidget {
  ViewOtherProfile({this.userModel});
  final UserModel userModel;

  @override
  _ViewOtherProfileState createState() => _ViewOtherProfileState();
}

class _ViewOtherProfileState extends State<ViewOtherProfile> {
  Image imgTop, imgCenter, imgBottom, imgThumb;
  double rotateAngle = 3.14;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height - 232;
    imgTop = Image.network(widget.userModel.backImage, width: double.infinity, height: h, fit: BoxFit.cover, alignment: Alignment.topLeft,);
    imgCenter = Image.network(widget.userModel.backImage, width: double.infinity, height: h, fit: BoxFit.cover, );
    imgBottom = Image.network(widget.userModel.backImage, width: double.infinity, height: h, fit: BoxFit.cover, alignment: Alignment.bottomLeft, );
    imgThumb = Image.asset('assets/images/ic_back_1.png', width: double.infinity, height: h, fit: BoxFit.cover, );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity, height: double.infinity,
        color: kWhiteColor,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity, height: double.infinity,
                    child: Image.asset('assets/images/ic_main_back.png', fit: BoxFit.fill,),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: double.infinity, height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.brown.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ClipRRect(
                      child: Stack(
                        children: <Widget>[
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationX(rotateAngle),
                            child: imgTop,
                          ),
                          Positioned(
                            top: 0,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff1b0701).withOpacity(0.7),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 48),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 16,),
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios, color: kWhiteColor, size: 28,),
                                  onPressed: onClickBack
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6),
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.userModel.name.length > 16 ? widget.userModel.name.substring(0, 15) : widget.userModel.name,
                                          style: gilroyStyleBold().copyWith(color: kWhiteColor, fontSize: 20),
                                        ),
                                        SizedBox(height: 4,),
                                        Text(
                                          widget.userModel.detectId.length > 16 ? widget.userModel.detectId.substring(0, 15) : widget.userModel.detectId,
                                          style: gilroyStyleBold().copyWith(color: Color(0xff93d793), fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(Icons.more_vert, size: 30, color: kWhiteColor,),
                                SizedBox(width: 16,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: imgCenter
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 112,
                    child: ClipRRect(
                      child: Stack(
                        children: <Widget>[
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationX(rotateAngle),
                            child: imgBottom,
                          ),
                          Positioned(
                            top: 0,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff1b0701).withOpacity(0.65),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 112,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Spacer(),
                                    Text('\$5.50', style: gilroyStyleBold().copyWith(color: kWhiteColor, fontSize: 26),),
                                    Text(' per seconds', style: gilroyStyleRegular().copyWith(color: kWhiteColor, fontSize: 20),),
                                    Spacer(),
                                  ],
                                ),
                                Container(
                                  width: 220, height: 48,
                                  margin: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Image.asset('assets/images/ic_logo_empty.png', color: Color(0xff060f06), width: 32,),
                                      SizedBox(width: 12,),
                                      Text('Request', style: gilroyStyleBold().copyWith(color: Color(0xff060f06), fontSize: 23),),
                                      Spacer(),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickBack() {
    Navigator.of(context).pop();
  }

  void initData() {

  }
}
