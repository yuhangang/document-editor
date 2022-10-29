import 'package:documenteditor/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:documenteditor/app/path/app_path.dart' as app_path;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SessionBloc>(context).add(InitSession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) {
        if (state is SessionError) {
          showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.white,
              builder: (context) {
                return const AlertDialog(
                  contentPadding: EdgeInsets.all(16),
                  content:
                      Text("Something wrong happens, please try again later"),
                );
              }).then((_) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          });
        } else {
          GoRouter.of(context).go(app_path.documentList);
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
