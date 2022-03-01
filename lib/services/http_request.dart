import 'dart:convert';
import 'dart:io';

import 'package:event/model/client.dart';
import 'package:event/model/verify_request.dart';
import 'package:event/model/version.dart';
import 'package:event/services/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';

const baseUrl = 'https://www.festrec.com/api';

// staging
// const baseUrlPortal='https://tenant.krowdz-staging.xylo.co.id/api';

// local
const baseUrlPortal = 'http://192.168.0.8:3000/api';
// const baseUrlPortal = 'http://10.0.2.2:3000/api';

// old api
// const baseUrlPortal='https://x-event-portal.xylo.co.id/api';
//const client_url='https://x-event-client.xylo.co.id';

class API {
  static Future<String?> getClientUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('API URL: ' + pref_api_url));
    return prefs.getString(pref_api_url);
  }

  Future getVersion() async {
    var url = Uri.parse(baseUrlPortal + "/version");
    print(baseUrlPortal);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //Version version=jsonDecode(response.body);
      return response.body;
    } else {
      print("Error in URL");
    }
  }

  Future doVerify(String code) async {
    var url = Uri.parse(baseUrlPortal + "/verify");
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
    var client_url = await (getClientUrl() as Future<String>);
    print(client_url);
    var url = Uri.parse(client_url + '/login');
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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);
    //print(client_url);
    var url = Uri.parse(client_url + '/visitors/scan-qrcode');
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    var body = '{ "code": "' + code + '"}';

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

  static Future<String> inputCode(code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);
    //print(client_url);
    var url = Uri.parse(client_url + '/visitors/input-code');
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    var body = '{ "code": "' + code + '"}';

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

  static Future<String> forgotPassword(email) async {
    var url = Uri.parse(baseUrl + '/password/email');
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
    var url = Uri.parse(baseUrl + '/register');
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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);
    // print(page);
    page = "" + page.replaceAll(client_url + '/visitors' + '?page=', '');
    // print(page);
    //var page2='1';
    var order_by = keyword_by;

    if (keyword_by == 'online' ||
        keyword_by == 'offline' ||
        keyword_by.contains('activity')) {
      order_by = '';
    } else if (keyword_by == 'code') {
      order_by = 'alphanumeric_code';
    }

    var url = Uri.parse(client_url +
        '/visitors' +
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
        order_by);
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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/visitors/register');
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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/activities/' + activityID + '/register');
    var headers = {
      // "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };

    json['visitor_id'] = visitorID;
    print(json);

    var request = http.MultipartRequest('POST', url);
    request.fields['a'] = 'a';
    // TODO: handle file inputs

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
      var json, var activityID, var historyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(
        client_url + '/activities/' + activityID + '/history/' + historyId);
    var headers = {
      // "Content-Type": "application/json",
      "Accept": "application/json",
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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/visitors/fields');
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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/activities/' + id + '/fields');
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

  static Future<String?> RegisterVisitor() async {
    return null;
  }

  static Future<String> VisitorDetail(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/visitors/' + id);
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

  static Future<String> DashboardSummary({DateTime? date}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var registered_at = date != null
        ? '?registered_at=' + DateFormat('yyyy-MM-dd').format(date)
        : '';

    var url = Uri.parse(client_url + '/dashboard/summary' + registered_at);

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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/dashboard/activity');
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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/dashboard/prize');
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
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url +
        '/merchandises' +
        '?keyword=' +
        keyword +
        '&activity=' +
        activity);
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    try {
      print(url);
      response = await http.get(url, headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  //Visitor Detail
  static Future<String> ActivityList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/activities');
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

  static Future<String> GeneralNotificationList({String page = '1'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/notifications/general?page=' + page);
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    // print(url);

    try {
      response = await http.get(url, headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> GeneralNotificationDetail(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/notifications/general/' + id);
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    // print(url);

    try {
      response = await http.get(url, headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> AnnouncementList({String page = '1'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url =
        Uri.parse(client_url + '/notifications/announcements?page=' + page);
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

  static Future<String> AnnouncementDetail(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/notifications/announcements/' + id);
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    http.Response response;

    // print(url);

    try {
      response = await http.get(url, headers: headers);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> UnreadNotificationsCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/notifications/unread-count');
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

  static Future<String> ReplyGeneralNotification(int id, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(
        client_url + '/notifications/general/' + id.toString() + '/reply');
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };
    var body = '{ "message": "' + message + '"}';

    http.Response response;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (_) {
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response.body;
  }

  static Future<String> GetUsersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/users');
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

  static Future CreateGeneralNotification(var body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString(pref_access_token)!;
    var client_url = await (getClientUrl() as Future<String>);

    var url = Uri.parse(client_url + '/notifications');
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ' + access_token,
    };

    http.Response response;

    try {
      response = await http.post(url, headers: headers, body: jsonEncode(body));
    } catch (e) {
      print(e);
      return {"status": "error", "message": "Failed to connect to server"}
          .toString();
    }

    return response;
  }
}
