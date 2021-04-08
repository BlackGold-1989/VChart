import 'dart:ui';

import 'package:app/resources/colors.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/views/main_views/search_view.dart';
import 'package:app/views/main_views/view_my_profile.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  HomePage({this.fbApp});
  final FirebaseApp fbApp;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  String imagePath;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity, height: double.infinity,
        color: kWhiteColor,
        child: Stack(
          children: [
            if(cameraController != null && cameraController.value.isInitialized)
            AspectRatio(
              aspectRatio: cameraController.value.aspectRatio,
              child: CameraPreview(cameraController),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Container(
                  //   width: double.infinity, height: double.infinity,
                  //   child: Image.asset('assets/images/ic_main_back.png', fit: BoxFit.fill,),
                  // ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      width: double.infinity, height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.brown.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120, color: Colors.black.withOpacity(0.2),
                      child: Column(
                        children: [
                          SizedBox(height: 26,),
                          Row(
                            children: [
                              Spacer(),
                              Text('It\'s CashTime!', style: gilroyStyleBold().copyWith(color: kWhiteColor, fontSize: 26),),
                              SizedBox(width: 12,),
                              Image.asset('assets/images/ic_hand.png', width: 26,),
                              Spacer(),
                            ],
                          ),
                          SizedBox(height: 18,),
                          Text('You have no recent video calls or requests.', style: gilroyStyleBold().copyWith(color: kWhiteColor, fontSize: 14),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                SizedBox(height: 64,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: Row(
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 18),
                          width: 48, height: 48,
                          child: Center(child: Image.asset('assets/images/ic_account.png', width: 26, color: kWhiteColor,)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                              color: Colors.black.withOpacity(0.3)
                          ),
                        ),
                        onTap: gotoProfile,
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 18),
                        width: 96, height: 40,
                        child: Center(child: Text('\$134.75', style: gilroyStyleMedium().copyWith(color: kWhiteColor, fontSize: 16),)),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.black.withOpacity(0.3)
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  child: InkWell(
                    child: Center(
                      child: Container(
                        width: 220, height: 60,
                        child: Row(
                          children: [
                            Spacer(),
                            Image.asset('assets/images/ic_logo_empty.png', width: 36,),
                            SizedBox(width: 12,),
                            Text('Request', style: gilroyStyleBold().copyWith(fontSize: 24, color: kWhiteColor),),
                            Spacer(),
                          ],
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [kMainColor, kMainMediumColor, kMainColor_light],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1.0, 2.0),
                              blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    ),
                    onTap: (){
                      gotoSearch();
                    },
                  ),
                ),
                SizedBox(height: 32,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void initData() {
    loadCamera();
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController = CameraController(cameraDescription, ResolutionPreset.high);
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        print('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      showToast(e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void gotoSearch() {
    NavigationService().navigateToScreen(context, SearchPage(fbApp: widget.fbApp, returnCallback: (){
          initData();
        },
      ),
    );
  }

  void gotoProfile() {
    NavigationService().navigateToScreen(context, ViewMyProfile(returnCallback: (){
          initData();
        },
      ),
    );
  }

  void loadCamera() {
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 1;
        });
        _initCameraController(cameras[selectedCameraIndex]).then((void v) {});
      }else{
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }
}
