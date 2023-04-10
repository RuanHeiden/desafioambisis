import 'package:desafioambisis/component/provider/filtro_date_provider.dart';
import 'package:desafioambisis/core/database/esg/esg_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'component/page/home_page.dart';
import 'core/database/esg/esgdb_store.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

///Iniciando getit
GetIt getIt = GetIt.instance;
void main() async {
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<Esgdb>(
    Esgdb(),
  );

  getIt.registerSingleton<EsgService>(
    EsgService(
      esgdb: getIt<Esgdb>(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('pt', 'BR')],
      title: 'Dashboard ESG',
      theme: ThemeData(
          primarySwatch: Colors.green,
          ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FiltroDateProvider()),
        ],
        child: HomePage(),
      ),
    );
  }
}

//  DateTime startTime = DateTime.parse('2020-04-06 00:00:00');
//       DateTime endTime = DateTime.parse('2023-04-07 00:00:00');
//       List<Esg> dateEsg = listEsg.where((element) {
//         return element.date.isAfter(startTime) && element.date.isBefore(endTime);
//       }).toList();
//       print(dateEsg.length);
