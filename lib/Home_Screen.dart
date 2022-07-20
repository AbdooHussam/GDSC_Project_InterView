import 'package:flutter/material.dart';
import 'package:gdsc/provider/Product.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSpinner = false;

  Future<void> prepareData() async {
    var mvcProvider = Provider.of<Product>(context, listen: false);
    (mvcProvider.photo.isEmpty) ? await mvcProvider.getPhoto() : null;
  }

  @override
  void initState() {
    super.initState();
    prepareData();
  }

  @override
  Widget build(BuildContext context) {
    var get = Provider.of<Product>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: (get.photo.isEmpty)
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    itemCount: get.photo.length,
                    itemBuilder: (context, index) {
                      return PhotoCard(
                        img: get.photo[index].img,
                        name: get.photo[index].name,
                      );
                    },
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio:
                          MediaQuery.of(context).size.height * 0.001,
                    )),
          ),
        ),
      ),
    );
  }
}
