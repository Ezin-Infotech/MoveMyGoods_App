import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/home/view%20model/home_provider.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (crete) => HomeProvider(),
  ),
  ChangeNotifierProvider(
    create: (crete) => AuthProvider(),
  ),
  ChangeNotifierProvider(
    create: (crete) => SettingsProvider(),
  ),
];
