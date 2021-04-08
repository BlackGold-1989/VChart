import 'dart:ui';

import 'package:app/models/user_model.dart';
import 'package:app/resources/colors.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/utils/utils_constants.dart';
import 'package:app/views/main_views/view_others_profile.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  SearchPage({this.fbApp, this.returnCallback});
  final FirebaseApp fbApp;
  Function returnCallback;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  TextEditingController txtSearch = new TextEditingController();

  List<UserModel> users = [];
  List<UserModel> searchedUsers = [];

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          width: double.infinity, height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.brown.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    SizedBox(height: 56,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(
                        children: [
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text('Cancel', style: gilroyStyleMedium().copyWith(color: Color(0xff93d793), fontSize: 18),),
                            ),
                            onTap: (){
                              onClickCancel();
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Request CashTime', style: gilroyStyleMedium().copyWith(color: kWhiteColor.withOpacity(0.9), fontSize: 19),)
                            ),
                          ),
                          SizedBox(width: 68,),
                        ],
                      ),
                    ),
                    Divider(
                      color: kWhiteColor, height: 0.7,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 16,),
                        Text('To:', style: gilroyStyleMedium().copyWith(color: Colors.white.withOpacity(0.75), fontSize: 18),),
                        SizedBox(width: 8,),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.start,
                            controller: txtSearch,
                            style: gilroyStyleRegular().copyWith(color: kWhiteColor, fontSize: 16),
                            keyboardType: TextInputType.text,
                            cursorColor: Color(0xff93d793),
                            autofocus: true,
                            onChanged: (val){
                              refresh(val);
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 6),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 12,),
                      ],
                    ),
                    Divider(
                      color: kWhiteColor, height: 0.7,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 4),
                        itemBuilder: (context,index){
                          return UserModelCellUI(searchedUsers.elementAt(index), (){
                              onClickUserCell(index);
                            }
                          );
                        },
                        itemCount: searchedUsers.length,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initData() {
    users.clear();
    for(int i=0; i < 20; i++){
      UserModel userModel = new UserModel();
      userModel.imgUrl = avatarImgs[i];
      userModel.name = names[i];
      userModel.detectId = detectIds[i];
      userModel.backImage = backImages[i];
      users.add(userModel);
    }

    searchedUsers.clear();
    refresh('');

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

  refresh(String filterStr){
    searchedUsers.clear();
    if(filterStr == ''){
      searchedUsers.addAll(users);
    }else{
      for(int i=0; i< users.length; i++){
        UserModel user = new UserModel();
        user = users.elementAt(i).copyWith();
        if(user.name.toLowerCase().contains(filterStr.toLowerCase())){
          searchedUsers.add(user);
        }
      }
    }
    setState((){});
  }

  void onClickCancel() {
    Navigator.of(context).pop();
  }

  void onClickUserCell(int index) {
    NavigationService().navigateToScreen(context, ViewOtherProfile(userModel: searchedUsers.elementAt(index),), );
  }

  Future<bool> _onWillPop() {
    Navigator.of(context).pop();
    widget.returnCallback();
  }
}
