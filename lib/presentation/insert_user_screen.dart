import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_sample/presentation/Widgets/grid_view.dart';

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
              child: OutlinedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('送信'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
