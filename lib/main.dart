import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/product_event.dart';
import 'blocs/product_bloc.dart';
import 'services/api_service.dart';
import 'screens/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final darkModeEnabled = preferences.getBool("darkMode") ?? false;

  runApp(AppEntry(isDarkMode: darkModeEnabled));
}

class AppEntry extends StatefulWidget {
  final bool isDarkMode;

  const AppEntry({required this.isDarkMode, Key? key}) : super(key: key);

  @override
  _AppEntryState createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  late bool darkModeActive;

  @override
  void initState() {
    super.initState();
    darkModeActive = widget.isDarkMode;
  }

  Future<void> switchTheme() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      darkModeActive = !darkModeActive;
    });
    preferences.setBool("darkMode", darkModeActive);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(apiService: ApiService())..add(LoadProducts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Shop',
        theme: ThemeData(
          brightness: darkModeActive ? Brightness.dark : Brightness.light,
          primarySwatch: Colors.blue,
        ),
        home: HomeView(onThemeToggle: switchTheme),
      ),
    );
  }
}
