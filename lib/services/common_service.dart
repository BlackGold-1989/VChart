
import 'package:flutter/material.dart';
import 'package:app/views/top_dialog_view.dart';

class CommonService {

  void showBottomDialog({
    Key key,
    BuildContext context,
    String title,
    double height,
    Widget titleWidget,
    Widget bodyWidget,
    bool isFullDialog = false,
  })
  {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: isFullDialog,
      builder: (_) {
        return Container(
          height: height,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12))
          ),
          child: Column(
            children: [
              TopDialogView(),

              Container(
                margin: EdgeInsets.only(top: 16, bottom: 12),
                child: titleWidget == null ?
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),) :
                  titleWidget
              ),

              Divider(),

              bodyWidget
            ],
          ),
        );
      });
  }

  void showDialog({Key key}) {

  }
}