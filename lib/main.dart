import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mmg/app/settings/view%20model/theme_notifier.dart';
import 'package:mmg/app/settings/view/widgets/theme.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/providers.dart';
import 'package:mmg/app/utils/routes/router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeNotifier>(builder: (context, them, _) {
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            Responsive().init(constraints, orientation);
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              themeMode: them.themeMode,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          });
        });
      }),
    );
  }
}
