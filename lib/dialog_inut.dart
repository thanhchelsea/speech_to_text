import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_code/speech_controller.dart';

class DialogInput extends StatefulWidget {
  const DialogInput({Key? key}) : super(key: key);

  @override
  _DialogInputState createState() => _DialogInputState();
}

class _DialogInputState extends State<DialogInput> {
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    editingController.text =(Get.find<SpeechController>().pu.value);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black38,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Hero(
            tag: "pik_K_puuu",
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType
                          .multiline, // user keyboard will have a button to move cursor to next line
                      controller: editingController,
                      decoration: InputDecoration(
                        hintText: "Type document...",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(

                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    if(editingController.text.isNotEmpty){
                      Get.find<SpeechController>().setTextOrigin(editingController.text.trim());
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff55E6C1),
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


