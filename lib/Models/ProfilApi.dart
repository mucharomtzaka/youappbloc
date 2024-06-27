// ignore_for_file: file_names

class ProfilApi {
  ProfilApi({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;
  
  ProfilApi.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.email,
    required this.username,
    required this.interests,
  });
  late final String email;
  late final String username;
  late final List<dynamic> interests;
  
  Data.fromJson(Map<String, dynamic> json){
    email = json['email'];
    username = json['username'];
    interests = List.castFrom<dynamic, dynamic>(json['interests']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['username'] = username;
    _data['interests'] = interests;
    return _data;
  }
}