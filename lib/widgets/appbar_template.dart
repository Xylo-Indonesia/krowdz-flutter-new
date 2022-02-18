import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:event/services/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> menuList = <String>["Account", "Logout"];

class AppBarTemplate extends StatelessWidget{
  final BuildContext? context;
  final Widget? body;
  final bool isTransparent;
  final bool isLoading;
  final scaffoldKey;
  final fab;

  const AppBarTemplate({Key? key, this.context, this.body, this.isTransparent = false, this.scaffoldKey, this.fab, this.isLoading = false}) : super(key: key);

  void menuSelected(String choice) {
    switch (choice) {
      case "Account":
        //prevent route stacking bug
        Navigator.of(context!).pushNamedAndRemoveUntil(
          profilePageRoute,
            (route) => route.isCurrent && route.settings.name == profilePageRoute
            ? false
            : true);
        break;
      case "Logout":
        //destroy token
        SharedPreferences.getInstance().then((prefs) {
          //API.userLogout(prefs.getString('token'));
          prefs.setString("token", null);
        });
        Navigator.pushReplacementNamed(context!, loginPageRoute);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        extendBodyBehindAppBar: isTransparent,
        key: scaffoldKey,
        floatingActionButton: fab,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Image(
            image: AssetImage('assets/logo.png'),
          ),
          backgroundColor: isTransparent ? Colors.transparent : Theme.of(context).primaryColorDark,
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(Icons.account_circle),
              onSelected: menuSelected,
              itemBuilder: (BuildContext context) {
                return menuList.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice, style: TextStyle(fontWeight: FontWeight.w600),),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: body,
      ),
    );
  }
}