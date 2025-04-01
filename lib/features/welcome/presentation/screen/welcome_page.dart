import 'package:flutter/material.dart';
import 'package:up_api/features/login/presentation/widgets/modal_login.dart';
import 'package:up_api/features/register/presentation/widgets/modal_register.dart';
import 'package:up_api/utils/show_modal_handler.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override

  @override
  void initState() {
   /// WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalHandler(context, const ModalRegister());
   /// });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/signup_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Hero(
          tag: 'logo_iniziale',
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.15,
              child: Image.asset('assets/images/up_api_logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
