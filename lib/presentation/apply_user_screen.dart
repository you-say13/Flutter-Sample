import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/presentation/Widgets/grid_view.dart';
import 'package:riverpod_sample/presentation/apply_user_view_model.dart';

class ApplyUserScreen extends ConsumerStatefulWidget {
  final User? userParam;
  final String title;
  const ApplyUserScreen({super.key, required this.title, this.userParam});

  @override
  ApplyUserScreenState createState() => ApplyUserScreenState();
}

class ApplyUserScreenState extends ConsumerState<ApplyUserScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController zipCodeController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController suiteController = TextEditingController();
    TextEditingController streetController = TextEditingController();
    TextEditingController compNameController = TextEditingController();
    TextEditingController birthDayController = TextEditingController();

    List<TextEditingController> textControllerList = [
      nameController,
      userNameController,
      ageController,
      emailController,
      phoneController,
      zipCodeController,
      cityController,
      suiteController,
      streetController,
      compNameController,
      birthDayController
    ];

    void settingTextField({User? user}) {
      nameController.text = user?.name ?? "";
      userNameController.text = user?.username ?? "";
      ageController.text = user?.age ?? "";
      emailController.text = user?.email ?? "";
      phoneController.text = user?.phone ?? "";
      zipCodeController.text = user?.address.zipcode ?? "";
      cityController.text = user?.address.city ?? "";
      suiteController.text = user?.address.suite ?? "";
      streetController.text = user?.address.street ?? "";
      compNameController.text = user?.companyName ?? "";
      birthDayController.text = user != null ? DateFormat('yyyy-MM-dd').format(user!.birthDay) : "";
    }

    settingTextField(user: widget.userParam);

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => context.pop('/'),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: InsertGridView(textControllerList: textControllerList),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (widget.userParam == null) {
                      ref.read(applyUserViewModelProvider.notifier).insertUserData(
                            name: nameController.text,
                            username: userNameController.text,
                            age: ageController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: Address(
                              street: streetController.text,
                              suite: suiteController.text,
                              city: cityController.text,
                              zipcode: zipCodeController.text,
                            ),
                            companyName: compNameController.text,
                            birthDay: DateTime.parse(birthDayController.text),
                          );
                    } else {
                      ref.read(applyUserViewModelProvider.notifier).updateUserData(
                            id: widget.userParam!.id,
                            name: nameController.text,
                            username: userNameController.text,
                            age: ageController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: Address(
                              street: streetController.text,
                              suite: suiteController.text,
                              city: cityController.text,
                              zipcode: zipCodeController.text,
                            ),
                            companyName: compNameController.text,
                            createdAt: widget.userParam!.createdAt,
                            birthDay: DateTime.parse(birthDayController.text),
                          );
                    }
                    settingTextField();
                    context.go("/");
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('送信'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
