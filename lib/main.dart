import 'package:flutter/material.dart';
import 'package:gdsc/provider/Product.dart';
import 'package:provider/provider.dart';
import 'Home_Screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Product>(create: (context) => Product()),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
