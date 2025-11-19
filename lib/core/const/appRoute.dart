import 'package:go_router/go_router.dart';
import 'package:solar_calculator_app/view/screen/Area_input.dart';
import 'package:solar_calculator_app/view/screen/ConsumptionResult.dart';
import 'package:solar_calculator_app/view/screen/ConsumptionInput.dart';
import 'package:solar_calculator_app/view/screen/home_page.dart';
import 'package:solar_calculator_app/view/screen/AreaResult.dart';

class AppRoute {
  static const String home = '/home';
  static const String consumptionInput = '/consumptionInput';
  static const String consumptionResult = '/consumptionResult';
  static const String Areainput = '/Areainput';
  static const String Arearesult = '/Arearesult';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => HomePage()),
      GoRoute(
        path: consumptionInput,
        builder: (context, state) => ConsumptionInput(),
      ),
      GoRoute(
        path: consumptionResult,
        builder: (context, state) => ConsumptionResult(),
      ),
      GoRoute(path: Areainput, builder: (context, state) => AreaInput()),
      GoRoute(path: Arearesult, builder: (context, state) => AreaResult()),
    ],
  );
}
