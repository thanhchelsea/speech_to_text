import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_code/dialog_inut.dart';

class SpeechController extends GetxController {
  RxList<String> textResult = <String>[].obs;
  RxList<String> textOrigin = <String>[].obs;
  RxString pu = "".obs;
  late SpeechToText speechToText = SpeechToText();
  RxBool isListening = false.obs;
  RxBool isListening1 = false.obs;

  bool newC = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    setTextOrigin("Hello, Can you speak Tiếng việt, solo yasuo với tôi không?");
    await speechToText.initialize(
      // finalTimeout: Duration(milliseconds: 5000),
      onStatus: (status) async {
        if (status == "done" && isListening1.value) {
          print(status +" : "+ isListening1.value.toString());
          isListening1.value=false;
          await speechToText.stop();
          await startSpeech();
          return;
        }
      },
    );
    super.onReady();
  }

  Future startSpeech({bool start = false}) async {
    newC = true;
    if (start) textResult.clear();
    if (textOrigin.isEmpty) {
      Navigator.push(
        Get.context!,
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
          },
        ),
      );
    } else {
      // speechToText = SpeechToText();
      // await speechToText.initialize(
      //   // onStatus: (status)async {
      //   //   if (status == "done" && isListening.value) {
      //   //
      //   //     startSpeech();
      //   //    return ;
      //   //   }
      //   // },
      //
      //   onError: (errorNotification) {
      //     print(errorNotification.toString());
      //   },
      // );
      await speechToText.cancel();
      isListening.value = true;
      isListening1.value =true;
      await speechToText.listen(
        onResult: _onSpeechResult,
      );
    }
  }

  Future stopListening() async {
    isListening.value = false;
    isListening1.value=false;
    print("stop ghi am");
    await speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.recognizedWords.isNotEmpty) {
      if (textResult.isEmpty)
        textResult.add(stringsToList(result.recognizedWords)[0]);
      else if (newC==false) {
        print(
          stringsToList(result.recognizedWords).sublist(
            textResult.length,
            stringsToList(result.recognizedWords).length,
          ),
        );
        textResult.addAll(
          stringsToList(result.recognizedWords).sublist(
            textResult.length,
            stringsToList(result.recognizedWords).length,
          ),
        );
      } else {
        print("moi nha : ${result.recognizedWords}");
        textResult.addAll(stringsToList(result.recognizedWords));
      }
    }
    if (!result.finalResult) {
      print("van fale nhe");
      newC = false;
    }else print("true me nó r");
  }

  List<String> stringsToList(String s) {
    List<String> data = [];
    data = s.split(" ");
    return data;
  }

  void setTextOrigin(String text) {
    pu.value = text;
    textResult.clear();
    textOrigin.value = stringsToList(text);
  }
}
