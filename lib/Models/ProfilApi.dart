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
    required this.name,
    required this.birthday,
    required this.horoscope,
    required this.height,
    required this.weight,
    required this.interests,
  });
  late final String email;
  late final String username;
  late final String name;
  late final String birthday;
  late final String horoscope;
  late final int height;
  late final int weight;
  late final List<String> interests;
  
  Data.fromJson(Map<String, dynamic> json){
    email = json['email'];
    username = json['username'];
    name = json['name'];
    birthday = json['birthday'];
    horoscope = json['horoscope'];
    height = json['height'];
    weight = json['weight'];
    interests = List.castFrom<dynamic, String>(json['interests']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['username'] = username;
    _data['name'] = name;
    _data['birthday'] = birthday;
    _data['horoscope'] = horoscope;
    _data['height'] = height;
    _data['weight'] = weight;
    _data['interests'] = interests;
    return _data;
  }
}