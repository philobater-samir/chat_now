import 'package:flutter/material.dart';

void showLoading(BuildContext context , String message){
  showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 12,
              ),
              Text(message)
            ],
          ),     );
      }));

}

void hideLoading(BuildContext context){
  Navigator.pop(context);
}

void showMessage(String message,BuildContext context, String poAcButtonText,Function? poAcButton ){
  showDialog(
      context: context,
      builder: ((context)
  {
    return AlertDialog(
        content:
        Text(message),
      actions: [
        TextButton(onPressed: (){
          poAcButton!(context);
        }
        , child: Text(poAcButtonText,textAlign: TextAlign.center,))

      ],

    );
  }));

}