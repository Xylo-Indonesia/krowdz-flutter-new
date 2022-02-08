import 'package:event/stores/form_login_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FormLoginStore store = FormLoginStore();
  final loginKey = new GlobalKey<FormState>();
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    store.setupValidations();
    store.getClient();
  }

  @override
  void dispose() {
    super.dispose();
    store.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var isFetching=false;

    return LoadingOverlay(
      isLoading: false,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
      child: BlackTheme(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image(image: AssetImage('assets/images/xylo.png')),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 32.0),
                                child: Observer(
                                  builder: (_) =>
                                      //    Text(store.url_logo)

                                      Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill, image: new NetworkImage(store.url_logo)))),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Form(
                              key: loginKey,
                              child: Column(
                                children: [
                                  CustomInput(
                                    darkMode: true,
                                    child: Observer(
                                      builder: (_) => TextFormField(
                                        onChanged: (value) => store.email = value,
                                        controller: usernameController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: 'Input Username',
                                            errorText: store.error.email == null ? ' ' : store.error.email,
                                            helperText: ' '),
                                      ),
                                    ),
                                    label: 'Username',
                                  ),
                                  CustomInput(
                                    darkMode: true,
                                    label: "Password",
                                    padding: EdgeInsets.only(top: 16),
                                    child: Observer(
                                      builder: (_) => TextFormField(
                                        onChanged: (value) => store.password = value,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: 'Input Password',
                                          errorText: store.error.password == null ? ' ' : store.error.password,
                                          helperText: '-',
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 60, bottom: 20),
                            child: SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      isLoading = !isLoading;
                                    });
                                    //await for animation purposes
                                    await store.validateAll(context);
                                    setState(() {
                                      isLoading = !isLoading;
                                    });
                                  },
                                  child: isLoading
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text("Please Wait",
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                                          ],
                                        )
                                      : Text("Log in",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                  padding: EdgeInsets.all(18),
                                  color: redColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
