import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_api/features/login/presentation/widgets/modal_login.dart';
import 'package:up_api/features/welcome/bloc/welcome_cubit.dart';
import 'package:up_api/features/welcome/bloc/welcome_state.dart';
import 'package:up_api/utils/service/service_locator.dart';
import 'package:up_api/utils/show_modal_handler.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    upapiSessionManager.keyWelcome = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      upapiSessionManager.animation = null;
      showModalHandler(context, const ModalLogin(), 0.35);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: upapiSessionManager.keyWelcome,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/signup_background.png'), fit: BoxFit.cover),
        ),
        child: Hero(
          tag: 'logo_iniziale',
          child: SafeArea(
            child: BlocBuilder<WelcomeCubit, WelcomeState>(
              builder: (context, state) {
                return SizedBox(
                    height: MediaQuery.sizeOf(context).height * context.read<WelcomeCubit>().state.heightPercentage,
                    child: Image.asset('assets/images/up_api_logo.png'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
