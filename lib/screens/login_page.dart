import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/classes/up_api_spacing.dart';
import 'package:up_api/screens/modals/modal_login.dart';
import '../classes/up_api_padding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../helper/helper_show_modal.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalHandler(
            context,
            ModalLogin()
        );
      },
    );

    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/signup_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Hero(
            tag: 'logo_iniziale',
            child: SafeArea(
              child: SizedBox(
                  height: (MediaQuery.sizeOf(context).height * 0.35),
                  child: Image.asset('assets/images/up_api_logo.png'),
              ),
            ),
        ),


      ),
    );
  }
}
