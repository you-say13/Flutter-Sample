import 'package:flutter/material.dart' hide DateTimePicker;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/domain/service/validator.dart';

class DetailGridView extends StatelessWidget {
  const DetailGridView({super.key, required this.userInfo});
  final User userInfo;

  @override
  Widget build(context) {
    Map<String, String> info = {
      "username": userInfo.username ?? "",
      "phone": userInfo.phone,
      "age": userInfo.age,
      "zipCode": userInfo.address.zipcode,
      "city": userInfo.address.city,
      "suite": userInfo.address.suite,
      "street": userInfo.address.street,
      "companyName": userInfo.companyName ?? "",
      "birthDay": DateFormat("yyyy-MM-dd").format(userInfo.birthDay),
    };

    List<String> key = info.entries.map((user) => user.key).toList();

    return Row(
      children: [
        const Spacer(),
        ColumnText(
          textList: key,
        ),
        const Spacer(),
        const SemicolonList(length: 9),
        const Spacer(),
        ColumnText(
          textList: [...info.entries.map((user) => user.value)],
        ),
        const Spacer(),
      ],
    );
  }
}

class InsertGridView extends StatelessWidget {
  const InsertGridView({super.key, required this.textControllerList});
  final List<TextEditingController> textControllerList;

  @override
  Widget build(context) {
    final info = userGenerator();

    List<String> key = info.entries.map((user) => user.key).toList();
    List<String> hintValue = info.entries.map((user) => user.value).toList();

    return Column(
      children: [
        for (int i = 0; i < info.length; i++) ...{
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    key[i],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                TextFormField(
                  controller: textControllerList[i],
                  focusNode: key[i] == "birthDay" ? AlwaysDisabledFocusNode() : null,
                  decoration: InputDecoration(
                    //下記2行追加
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                    border: const OutlineInputBorder(),
                    hintText: hintValue[i],
                  ),
                  validator: (value) {
                    final str =
                        InputValidator().errorString(key: key[i], value: value, context: context);
                    debugPrint('validation result: $str');
                    return str;
                  },
                  onTap: () {
                    if (key[i] == "birthDay") {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now().add(
                          const Duration(days: -36500),
                        ),
                        maxTime: DateTime.now(),
                        onChanged: (date) {
                          print(date);
                        },
                        onConfirm: (date) {
                          print(date);
                        },
                        currentTime: textControllerList[i].text != ""
                            ? DateTime.parse(textControllerList[i].text)
                            : DateTime.now(),
                        locale: LocaleType.jp,
                      ).then(
                        (value) {
                          if (value != null) {
                            textControllerList[i].text = DateFormat('yyyy-MM-dd').format(value);
                          }
                        },
                      );
                    } else {
                      return;
                    }
                  },
                ),
              ],
            ),
          ),
        },
      ],
    );
  }
}

// class TextArea extends StatelessWidget{
//   TextArea({super.key, required this.focusNode, required this.controller, required this.keyValue, required this.validator,});
//
//   final FocusNode focusNode;
//   final TextEditingController controller;
//   final String keyValue;
//   String? Function(String) validator;
//
//   @override
//   Widget build(context){
//
//     bool datePickFlag = false;
//     TextInputType keyboardType;
//
//     if(keyValue == "birthDay"){
//       datePickFlag = true;
//     }
//
//     return TextFormField(
//       controller: controller,
//       focusNode: datePickFlag ? focusNode : null,
//       keyboardType: ,
//     );
//   }
//
// }

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class SemicolonList extends StatelessWidget {
  const SemicolonList({super.key, required this.length});
  final int length;

  @override
  Widget build(BuildContext context) {
    List<String> list = List.generate(length, (_) => ":");

    return Column(
      children: [
        ...list.map(
          (text) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(text),
          ),
        )
      ],
    );
  }
}

class ColumnText extends StatelessWidget {
  const ColumnText({super.key, required this.textList, this.bullet});

  final List<String> textList;
  final bool? bullet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...textList.map(
          (text) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Text(text),
            );
          },
        )
      ],
    );
  }
}
