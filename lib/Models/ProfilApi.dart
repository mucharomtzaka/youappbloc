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
    final datax = <String, dynamic>{};
    datax['message'] = message;
    datax['data'] = data.toJson();
    return datax;
  }
}

class Data {
  Data({
    required this.email,
    required this.username,
    required this.name,
    required this.birthday,
    required this.horoscope,
    required this.zodiac,
    required this.height,
    required this.weight,
    required this.interests,
  });
  late String email;
  late String username;
  late String name;
  late String birthday;
  late String horoscope;
  late String zodiac;
  late int height;
  late int weight;
  late final List<String> interests;
  
  Data.fromJson(Map<String, dynamic> json){
    email = json['email'];
    username = json['username'];
    name = json['name'];
    birthday = json['birthday'];
    horoscope = json['horoscope'];
    zodiac   = json['zodiac'];
    height = json['height'];
    weight = json['weight'];
    interests = List.castFrom<dynamic, String>(json['interests']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['name'] = name;
    data['birthday'] = birthday;
    data['horoscope'] = horoscope;
    data['height'] = height;
    data['zodiac'] = zodiac;
    data['weight'] = weight;
    data['interests'] = interests;
    return data;
  }
}