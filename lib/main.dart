import 'package:flutter/material.dart';
import 'package:state_management/helpers/routes/app_router.dart';

void main() {
  runApp(Main(
    appRouter: AppRouter(),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
