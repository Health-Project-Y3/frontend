import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/providers/user_provider.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/views/login_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:thurula/views/menu_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String>(
        future: _getInitialRoute(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white, // Set the background color to match your app's theme
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Customize the color of the indicator
                ),
              ),
            );
          }
          else if (snapshot.hasError) {
            // Handle error
            return Text('Error: ${snapshot.error}');
          } else {
            final initialRoute = snapshot.data;
            if (initialRoute == "LoginView") {
              return const LoginView();
            } else {
              return const MenuView();
            }
          }
        },
      ),
    );
  }

  Future<String> _getInitialRoute(BuildContext context) async {
    final id = await LocalService.getCurrentUserId();
    if (id == "") {
      return "LoginView";
    }
    final user = await UserService.getUser(id);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (user != null) {
      userProvider.setUser(user);
    }
    if (user == null) {
      return "LoginView";
    } else {
      return "MenuView";
    }
  }
}
