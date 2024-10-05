import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_sample/domain/model/user.dart';
import 'package:riverpod_sample/presentation/Widgets/grid_view.dart';
import 'package:riverpod_sample/presentation/insert_user_view_model.dart';

class InsertUserScreen extends ConsumerStatefulWidget {
  const InsertUserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => InsertUserScreenState();
}

class InsertUserScreenState extends ConsumerState<ConsumerStatefulWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController zipCodeController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController suiteController = TextEditingController();
    TextEditingController streetController = TextEditingController();
    TextEditingController compNameController = TextEditingController();

    List<TextEditingController> textControllerList = [
      nameController,
      userNameController,
      emailController,
      phoneController,
      zipCodeController,
      cityController,
      suiteController,
      streetController,
      compNameController,
    ];

    void clearTextField() {
      nameController.text = "";
      userNameController.text = "";
      emailController.text = "";
      phoneController.text = "";
      zipCodeController.text = "";
      cityController.text = "";
      suiteController.text = "";
      streetController.text = "";
      compNameController.text = "";
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green,
        title: const Text(
          "Register User",
          style: TextStyle(color: Colors.white),
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
                    ref.read(insertUserViewModelProvider.notifier).insertUserData(
                          name: nameController.text,
                          username: userNameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          address: Address(
                            street: streetController.text,
                            suite: suiteController.text,
                            city: cityController.text,
                            zipcode: zipCodeController.text,
                          ),
                          companyName: compNameController.text,
                        );
                    clearTextField();
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
