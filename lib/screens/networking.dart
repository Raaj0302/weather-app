import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper(this.ur);
  final String ur;
  Future getData() async {
    Uri url = Uri.parse(ur);
    Response res = await get(url);

    var decoded = jsonDecode(res.body);
    return decoded;
  }
}
