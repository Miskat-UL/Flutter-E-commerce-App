import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/features/home/home_screen.dart';
import 'package:amazon_clone/providers/user_providers.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constans/global_variables.dart';
import 'features/auth/screens/auth_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: GlobalVariables.secondaryColor,
            )),
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const HomeScreen()
          : const AuthScreen(),
    );
  }
}

// class MyName extends StatelessWidget {
//   const MyName({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextButton(
//         onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (_) => AuthScreen()));
//         },
//         child: Text('Auth Screen'),
//       ),
//     );
//   }
// }
