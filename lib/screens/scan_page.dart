import 'dart:async';

import 'package:event/services/consts.dart';
import 'package:event/stores/scan_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_dialog.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/scan_reader.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);
  final ScanStore store = ScanStore();
  @override
  _ScanPageState createState() {
    return _ScanPageState();
  }
}

class _ScanPageState extends State<ScanPage> {
  GlobalKey<ScanReaderState> qrKey = GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _manualInputKey = new GlobalKey<FormState>();
  final manualInputController = TextEditingController();
  final _focusNode = FocusNode();
  bool isLoading = true;
  List<String> scanResult;

  @override
  void initState() {
    super.initState();
    // stopScanning();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        stopScanning();
      }
    });
  }

  Widget qrLoadingOverlay() {
    return Positioned.fill(
        child: Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }

  void stopScanning() {
    qrKey.currentState.stopScan();
  }

  void startScanning() {
    qrKey.currentState.startScan();
  }

  @override
  Widget build(BuildContext context) {
    //ScanStore store=ScanStore();
    //store.scanCode('123123');
    return BlackTheme(
      darkMode: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        var scanBoxRatio = constraints.maxWidth / constraints.maxHeight;
                        print('Scan Box:' + scanBoxRatio.toString());
                        return ScanReader(
                          key: qrKey,
                          onScan: onScan,
                          scanBoxRatio: .7 * scanBoxRatio,
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                          radius: 2.5, colors: [darkerBackground, Color(0xFF101010)], center: Alignment.topCenter),
                    ),
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 37),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Observer(
                                  builder: (_) => CustomInput(
                                        darkMode: true,
                                        label: "Or Manual Code",
                                        child: TextFormField(
                                          focusNode: _focusNode,
                                          onChanged: (value) {
                                            widget.store.code = value;
                                            if (value.length == 6) {
                                              widget.store.scanCode().then((result) => processScan(result));
                                            }
                                          },
                                        ),
                                      )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Container(
                                height: 1,
                                color: darkBackground,
                              ),
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                  child: Text("Add Visitor",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                  padding: EdgeInsets.all(18),
                                  color: redColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  onPressed: () async {
                                    stopScanning();
                                    await Navigator.pushNamed(context, visitorNewPage);
                                    //stopScanning();
                                    startScanning();
                                  },
                                )),
                          ],
                        )),
                  )
                ],
              ),
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: CustomHeader(
                  darkMode: true,
                  onBack: () => Navigator.of(context).pop(),
                  title: 'Scan Code',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onScan(String data) {
    stopScanning();
    widget.store.code = data;
    widget.store.scanCode().then((result) => processScan(result));
  }

  Future processScan(var result) {
    if (result.status == true) {
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: result.data.name + " is successfully added to Visitor List",
            text: "View Profile",
            text2: "Back",
            buttonColor2: Colors.white,
            buttonColor1: redColor,
            textColor2: redColor,
            textColor1: Colors.white,
            function: () async {
              //print(data);
              stopScanning();
              await Navigator.of(context).pushNamed(visitorDetailPage, arguments: widget.store.json_response['data']);
              //stopScanning();
              startScanning();
              //Timer(Duration(milliseconds: 1000), () => startScanning());
            },
            function2: () {
              Timer(Duration(milliseconds: 100), () => startScanning());
            },
          );
        },
      );
    } else {
      if ("Visitor not Found!" == result.message ||
          "Visitor is not Verified" == result.message ||
          "Visitor is Expired" == result.message) {
        var message = "Visitor with code " + widget.store.code + "" + result.message.replaceAll("Visitor", "");
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: message,
              text: "Add Visitor",
              text2: "Back",
              buttonColor1: Colors.white,
              buttonColor2: redColor,
              textColor1: redColor,
              textColor2: Colors.white,
              function: () async {
                //print(data);
                stopScanning();
                await Navigator.pushNamed(context, visitorNewPage);
                //stopScanning();
                startScanning();
                //Timer(Duration(milliseconds: 1000), () => startScanning());
              },
              function2: () {
                Timer(Duration(milliseconds: 100), () => startScanning());
              },
            );
          },
        );
      } else if ("Visitor is not Verified" == result.message) {
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: widget.store.code + " - Verified visitor?",
              text: "Yes",
              text2: "Back",
              buttonColor1: Colors.white,
              buttonColor2: redColor,
              textColor1: redColor,
              textColor2: Colors.white,
              function: () {
                //print(data);
                Timer(Duration(milliseconds: 100), () => startScanning());
              },
              function2: () {
                Timer(Duration(milliseconds: 100), () => startScanning());
              },
            );
          },
        );
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
