import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test_code/dialog_input.dart';

class SpeechController extends GetxController {
  RxList<String> textResult = <String>[].obs;
  RxList<String> textOrigin = <String>[].obs;
  RxString pu = "".obs;
  late SpeechToText speechToText;
  RxBool isListening = false.obs;
  bool _listenLoop = false;
  bool newSpeech=false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    setTextOrigin("Cộng hoà xã hội chủ nghĩa Việt Nam!");
    super.onReady();
  }

  Future startSpeech({bool start = false,bool forced = false}) async {
    print("bat dau noi nha m");
    if (start) textResult.clear();
    if (forced) {
        _listenLoop = !_listenLoop;
    }
    if (!_listenLoop) return;
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
      newSpeech = true;
      speechToText = SpeechToText();
      await speechToText.initialize(
        onStatus: (status) async {
          if ('done' == status) {
            startSpeech();
          }
        },
        onError: (v) async {
          print("error nha :" + v.errorMsg);
          // speechToText.listen(onResult: _onSpeechResult);
        },
      );
      isListening.value = true;
      await speechToText.listen(onResult: _onSpeechResult);
    }
  }

  Future stopListening() async {
    isListening.value = false;
    _listenLoop=false;
    print("stop ghi am");
    await speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    print(stringsToList(result.recognizedWords).toString());
    if(stringsToList(result.recognizedWords).isNotEmpty) {
      if (textResult.isEmpty) {
        textResult.add(stringsToList(result.recognizedWords)[0]);
      } else {
        if (newSpeech == false) {
          print("speech cux nha");
          // print(
          //   stringsToList(result.recognizedWords).sublist(
          //     textResult.length,
          //     stringsToList(result.recognizedWords).length,
          //   ),
          // );
          textResult.addAll(
            stringsToList(result.recognizedWords).sublist(
              textResult.length,
              stringsToList(result.recognizedWords).length,
            ),
          );
        } else {
          print("speech moi nha: ${result.recognizedWords}");
          textResult.addAll(stringsToList(result.recognizedWords));
        }
        newSpeech = false;
      }
    } else  newSpeech = false;
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
