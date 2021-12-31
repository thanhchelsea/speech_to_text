import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_code/dialog_input.dart';
import 'package:test_code/list_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mricro_component.dart';
import 'speech_controller.dart';

class SpeechToTextUI extends StatelessWidget {
  var speechController = Get.put(SpeechController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetX<SpeechController>(
          builder: (controller) {
            return Container(
              margin: EdgeInsets.all(16.w),
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: ListText(
                      textsSpeech: controller.textResult.value,
                      textsOrigin: controller.textOrigin.value,
                      lengthSpeech: controller.textResult.length,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: MicroComponent(
                      status: controller.isListening.value,
                      onPressed: () {
                       controller.startSpeech(start: true,forced: true);
                      },
                      onPressedEnd: () {
                        controller.stopListening();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showInput(context);
          },
          backgroundColor: Color(0xff58B19F),
          child:  Icon(Icons.edit),
        ),
      ),
    );
  }

   void showInput(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          barrierDismissible: false,
          pageBuilder: (BuildContext context, _, __) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: DialogInput(),
              // child: Container(),
            );
          }),
    );
  }
}
