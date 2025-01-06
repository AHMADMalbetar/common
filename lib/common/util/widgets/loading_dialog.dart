import 'package:common/common/extensions/font_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Loading{
  static  BuildContext? _context;

  static show(BuildContext context)async{
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Loading._context=context;
        return  AlertDialog(
            backgroundColor: context.onPrimaryColor,
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: context.primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  context.locale == const Locale('ar') ? 'يتم التحميل...' : 'Loading...',
                  style: const TextStyle(
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
        );
      },
    );
  }

  static close(){
    if(Loading._context !=null) {
      if(_context!.mounted) {
        Navigator.of(Loading._context!).pop();
      }
    }
  }




  static Widget bottomLoading(bool value, context){
    return value? Container(
      alignment: Alignment.center,
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: context.primaryColor,
        ),
      ),
    ) : const SizedBox(height: 5,width: 5,);
  }

}