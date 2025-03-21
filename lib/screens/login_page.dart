import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:up_api/classes/up_api_spacing.dart';
import '../classes/up_api_padding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true, // Permette al contenuto di andare oltre la metà dello schermo
        barrierColor: Colors.transparent,
        enableDrag: false,
        transitionAnimationController: AnimationController(
          duration: const Duration(seconds: 1),
          vsync: Navigator.of(context),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Evita che la tastiera copra il contenuto
            ),
            child: Container(
              alignment: Alignment.center,
              height: ((MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.vertical) * 0.65),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();

                          Future.delayed(const Duration(milliseconds: 1010), () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => Text('testo'),
                            );
                          });

                        },
                        child: Text("Forgot password?"),
                      ),
                      Text(
                        AppLocalizations.of(context)?.login_page_title ?? "login_page_title",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Padding(
                        padding: UpApiPadding.formPadding,
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)?.email_label ?? "email_label",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              UpApiSpacing.spacingLabelField,
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              UpApiSpacing.spacingFormFields,
                              Text(
                                AppLocalizations.of(context)?.password_label ?? "password_label",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              UpApiSpacing.spacingLabelField,
                              TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              UpApiSpacing.spacingFormFields,
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    print("ho cliccato");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Data')),
                                    );
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)?.login_page_submit_button ?? "login_page_submit_button",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });

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
