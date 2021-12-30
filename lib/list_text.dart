import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListText extends StatelessWidget {
  List<String> textsOrigin;
  List<String> textsSpeech;
  int lengthSpeech;

  ListText({
    required this.textsOrigin,
    required this.textsSpeech,
    required this.lengthSpeech,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16.w),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: List.generate(
                textsOrigin.length,
                (index) {
                  Color colorText = Colors.black;
                  if (textsSpeech.length <= index) {
                    colorText = Colors.black;
                  } else {
                    if (checkSameWord(textsOrigin[index], textsSpeech[index],
                        index: index)) {
                      colorText = Color(0xff1B9CFC);
                    } else
                      colorText = Color(0xffFC427B);
                  }
                  if(index == lengthSpeech&& index!=0){
                    colorText = Color(0xffD6A2E8);
                  }

                  return WidgetSpan(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        textsOrigin[index],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: colorText,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkSameWord(String w1, String w2, {required int index}) {
    String t1 = w1.replaceAll(RegExp(r"[^\s\w]"), "");
    String t2 = w2.replaceAll(RegExp(r"[^\s\w]"), "");
    bool check = false;
    check = t1.toLowerCase() == t2.toLowerCase();
    if (!check) {
      List<String> tFake = [];
      if (index == 0)
        tFake = textsSpeech.sublist(0, 1);
      else {
        if (index == textsSpeech.length - 2) {
          tFake = textsSpeech.sublist(index, index + 1);
        } else
          tFake = textsSpeech.sublist(index - 1, index + 1);
      }

      return tFake.contains(w1);
    }
    return check;
  }
}
