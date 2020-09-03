import 'package:http/http.dart' as http;

class Github {
  final String userName;
  final String url = 'https://api.github.com/';
  static String client_id = '68db445067740a3044fa';
  static String client_secret = '90e9da8b0207bf3abdade5bde4f25d4cb96bb2cb'; 

  final String query  = "?client_id=${client_id}&client_secret=${client_secret}";

  Github(this.userName);

  Future<http.Response> fetchUser(){
    return http.get(url + 'users/' + userName + query);
  }   

  Future<http.Response> fetchFollowing() {
    return http.get(url + 'users/' + userName + '/following' + query);
  }
}