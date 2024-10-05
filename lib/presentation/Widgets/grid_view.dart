import 'package:flutter/material.dart';
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
      "zipCode": userInfo.address.zipcode,
      "city": userInfo.address.city,
      "suite": userInfo.address.suite,
      "street": userInfo.address.street,
      "companyName": userInfo.companyName ?? ""
    };

    List<String> key = info.entries.map((user) => user.key).toList();

    return Row(
      children: [
        const Spacer(),
        ColumnText(
          textList: key,
        ),
        const Spacer(),
        const SemicolonList(length: 7),
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
    Map<String, String> info = {
      "name": "氏名",
      "username": "ニックネーム",
      "email": "Eメール",
      "phone": "電話番号",
      "zipCode": "郵便番号",
      "city": "都道府県",
      "suite": "県庁所在地",
      "street": "市区町村",
      "companyName": "会社名",
    };

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
                ),
              ],
            ),
          ),
        }
      ],
    );
  }
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
