import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_api/features/home/bloc/home_cubit.dart';
import 'package:up_api/features/home/bloc/home_state.dart';
import 'package:up_api/style/up_api_padding.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/widgets/card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Transform.translate(
            offset: const Offset(-5
                , 0,),
            child: Icon(
              Icons.menu,
              size: 40,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Image(image: AssetImage('assets/images/up_api_logo_white.png')),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(10), child: SizedBox()),
      ),
     body: SafeArea(
       child: Padding(
         padding: UpApiPadding.basicPadding,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Dashboard',
               style: Theme.of(context).textTheme.headlineLarge,
             ),
             UpApiSpacing.extraLarge,
           ],
         ),
       ),
     ),
    );
  }
}
