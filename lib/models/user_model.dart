

import 'package:app/resources/colors.dart';
import 'package:app/resources/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserModel {

  String userId;
  String name;
  String birthDay;
  String phoneNumber;
  String emailAddress;
  String imgUrl;
  String detectId;
  String backImage;

  UserModel({this.userId = '', this.name = '', this.birthDay = '', this.phoneNumber = '', this.emailAddress = '', this.imgUrl = '', this.detectId = '', this.backImage = ''});

  fromJson(Map<dynamic, dynamic> json){
    userId = json['userId'] as String;
    name = json['name'] as String;
    birthDay = json['birthDay'] as String;
    phoneNumber = json['phoneNumber'] as String;
    emailAddress = json['emailAddress'] as String;
    imgUrl = json['imgUrl'] as String;
    detectId = json['detectId'] as String;
    backImage = json['backImage'] as String;
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      userId : json['userId'] as String,
      name : json['name'] as String,
      birthDay : json['birthDay'] as String,
      phoneNumber : json['phoneNumber'] as String,
      emailAddress : json['emailAddress'] as String,
      imgUrl : json['imgUrl'] as String,
      detectId : json['detectId'] as String,
      backImage : json['backImage'] as String,
    );
  }

  toJson() {
    return {
      "userId": userId,
      "userName" : name,
      "birthDay": birthDay,
      "phoneNumber": phoneNumber,
      "emailAddress": emailAddress,
      "imgUrl": imgUrl,
      "detectId": detectId,
      "backImage": backImage,
    };
  }

  copyWith({String userId, String userName, String birthDay, String phoneNumber,String emailAddress, String imgUrl, String detectId, String backImage}) {
    return new UserModel(
      userId: userId?? this.userId,
      name: userName?? this.name,
      birthDay: birthDay?? this.birthDay,
      phoneNumber: phoneNumber?? this.phoneNumber,
      emailAddress: emailAddress?? this.emailAddress,
      imgUrl: imgUrl?? this.imgUrl,
      detectId: detectId?? this.detectId,
      backImage: backImage?? this.backImage,
    );
  }
}

class UserModelCellUI extends StatelessWidget {
  UserModelCellUI(this.userModel, this.clickCallback);
  UserModel userModel;
  Function clickCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12),
      child: Column(
        children: [
          InkWell(
            child: Row(
              children: [
                Image.network(userModel.imgUrl, width: 72,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        userModel.name,
                        textAlign: TextAlign.start,
                        style: gilroyStyleMedium().copyWith(color: kWhiteColor, fontSize: 20),
                      ),
                    ),
                    Container(
                      child: Text(
                        userModel.detectId,
                        textAlign: TextAlign.left,
                        style: gilroyStyleMedium().copyWith(color: Color(0xff93d793), fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: (){
              clickCallback();
            },
          ),
          Container(
              margin: EdgeInsets.only(left: 64),
              child: Divider(height: 0.7, color: kWhiteColor,)
          ),
        ],
      ),
    );
  }
}