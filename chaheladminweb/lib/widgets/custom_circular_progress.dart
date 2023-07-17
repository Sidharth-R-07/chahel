import 'package:flutter/material.dart';

void customCircularProgressIndicator(context, key) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SimpleDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            key: key,
            children: const <Widget>[
              Center(
                child: SizedBox(
                  height: 60,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Please Wait..."),
                      ]),
                ),
              ),
            ],
          ),
        );
      });
}
