import 'dart:convert';
import 'dart:io';

import 'package:event/model/client.dart';
import 'package:event/model/verify_request.dart';
import 'package:event/model/version.dart';
import 'package:event/services/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

const baseUrl = 'https://www.festrec.com/api';
// const baseUrlPortal = 'https://tenant.krowdz-staging.xylo.co.id/api';
const baseUrlPortal = 'https://x-event-portal.xylo.co.id/api';
const client_url = 'https://staging-event-client.xylo.co.id/api';

class API {
  static Future<String> getClientUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(pref_api_url));
    return prefs.getString(pref_api_url);
  }

  Future getVersion() async {
    var url = baseUrlPortal + "/versions";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //Version version=jsonDecode(response.body);
      return response.body;
    } else {
      print("Error in URL");
    }
  }

  Future doVerify(String code) async {
    var url = baseUrlPortal + "/verify";
    VerifyRequest request = VerifyRequest(code: code);

    final response = await http.post(url, body: request.toJson());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
      //print("Error: "+response.statusCode.toString()+" "+response.request.headers.toString()+" "+request.toJson().toString());
    }
  }

  static Future<String> loginPost(email, password) async {
    //    var box=Hive.box<Client>('client');
    //    var client=box.getAt(0);
    var client_url = await getClientUrl();
    print(client_url);
    var url = client_url + '/login';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    var body = '{ "email": "' + email + '", "password": "' + password + '"}';
    http.Response response;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      print(e.toString());
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> scanCode(code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();
    //print(client_url);
    var url = client_url + '/check/code/' + code;
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };

    http.Response response;

    try {
      response = await http.get(url, headers: headers);
    } catch (e) {
      print(e.toString());
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> forgotPassword(email) async {
    var url = baseUrl + '/password/email';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    var body = jsonEncode({"email": email});

    http.Response response = await http.post(url, headers: headers, body: body);
    return response.body;
  }

  static Future<String> registerPost(
      name, email, password, confirmPassword) async {
    var url = baseUrl + '/register';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    var body = '{"role_id": 2, "name": "' +
        name +
        '", "email": "' +
        email +
        '", "password": "' +
        password +
        '", "password_confirmation": "' +
        confirmPassword +
        '"}';
    print("register body: " + body);
    http.Response response = await http.post(url, headers: headers, body: body);
    print(response.body);
    return response.body;
  }

  static Future<String> VisitorList(
      {String keyword = '',
      String keyword_by = '',
      String page = '',
      String order_direction = 'asc'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();
    // print(page);
    page = "" + page.replaceAll(client_url + '/visitor/list' + '?page=', '');
    // print(page);
    //var page2='1';
    var url = client_url +
        '/visitor/list' +
        '?' +
        'keyword=' +
        keyword +
        '&' +
        'keyword_by=' +
        keyword_by +
        '&page=' +
        page +
        '&' +
        'order_direction=' +
        order_direction +
        '&order_by=' +
        keyword_by;
    print(url);
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      response = await http.get(url, headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<dynamic> doRegisterNewVisitor(var json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/visitor/register';
    var headers = {
      // "Content-Type": "application/json",
      // "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;
    try {
      response = await http.post(url, headers: headers, body: json);
      //print('Response:'+response.body.toString());
    } catch (e) {
      print(e.toString());
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<dynamic> doRegisterNewActivity(
      var json, var activityID, var visitorID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/activity/' + activityID + '/visitor/' + visitorID;
    var headers = {
      // "Content-Type": "application/json",
      // "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['a'] = 'a';
    //perlu bikin ini besok

    http.Response response;
    try {
      response = await http.post(url, headers: headers, body: json);
      //print('Response:'+response.body.toString());
    } catch (e) {
      print(e.toString());
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<dynamic> doEditActivity(
      var json, var activityID, var visitorID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url +
        '/activity/history/' +
        activityID +
        '/visitor/' +
        visitorID;
    var headers = {
      // "Content-Type": "application/json",
      // "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };

    http.Response response;
    try {
      response = await http.put(url, headers: headers, body: json);
      //print('Response:'+response.body.toString());
    } catch (e) {
      print(e.toString());
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> getRegisterEntity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/visitor/fields';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      response = await http.get(url, headers: headers);
      print('Response:' + response.body.toString());
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> getRegisterEntityById(var id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/activity/' + id + '/fields';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      response = await http.get(url, headers: headers);
      print('Response:' + response.body.toString());
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> RegisterVisitor() async {
    return null;
  }

  static Future<String> VisitorDetail(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/visitor/show/' + id;
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      response = await http.get(url, headers: headers);
      print('' + response.body.toString());
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> DashboardSummary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/dashboard/summary';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      response = await http.get(url, headers: headers);
      print('' + response.toString());
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> DashboardActivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/dashboard/activity';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      response = await http.get(url, headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> DashboardPrize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/dashboard/prize';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      response = await http.get(url, headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> RewardList(
      {String keyword = '', String activity = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/reward/list';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      print(url + '?keyword=' + keyword + '&activity=' + activity);
      response = await http.get(
          url + '?keyword=' + keyword + '&activity=' + activity,
          headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  //Visitor Detail
  static Future<String> ActivityList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token);
    var client_url = await getClientUrl();

    var url = client_url + '/activity/list';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      response = await http.get(url, headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }
}
