// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    this.request,
    this.location,
    this.current,
  });

  Request? request;
  Location? location;
  Current? current;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        request: Request.fromJson(json["request"]),
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "request": request?.toJson(),
        "location": location?.toJson(),
        "current": current?.toJson(),
      };
}

class Current {
  Current({
    this.observationTime,
    this.temperature,
    this.weatherCode,
    this.weatherIcons,
    this.weatherDescriptions,
    this.windSpeed,
    this.windDegree,
    this.windDir,
    this.pressure,
    this.precip,
    this.humidity,
    this.cloudcover,
    this.feelslike,
    this.uvIndex,
    this.visibility,
    this.isDay,
  });

  String? observationTime;
  int? temperature;
  int? weatherCode;
  List<String>? weatherIcons;
  List<String>? weatherDescriptions;
  int? windSpeed;
  int? windDegree;
  String? windDir;
  int? pressure;
  int? precip;
  int? humidity;
  int? cloudcover;
  int? feelslike;
  int? uvIndex;
  int? visibility;
  String? isDay;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        observationTime: json["observation_time"],
        temperature: json["temperature"],
        weatherCode: json["weather_code"],
        weatherIcons: List<String>.from(json["weather_icons"].map((x) => x)),
        weatherDescriptions:
            List<String>.from(json["weather_descriptions"].map((x) => x)),
        windSpeed: json["wind_speed"],
        windDegree: json["wind_degree"],
        windDir: json["wind_dir"],
        pressure: json["pressure"],
        precip: json["precip"],
        humidity: json["humidity"],
        cloudcover: json["cloudcover"],
        feelslike: json["feelslike"],
        uvIndex: json["uv_index"],
        visibility: json["visibility"],
        isDay: json["is_day"],
      );

  Map<String, dynamic> toJson() => {
        "observation_time": observationTime,
        "temperature": temperature,
        "weather_code": weatherCode,
        "weather_icons": List<dynamic>.from(weatherIcons!.map((x) => x)),
        "weather_descriptions":
            List<dynamic>.from(weatherDescriptions!.map((x) => x)),
        "wind_speed": windSpeed,
        "wind_degree": windDegree,
        "wind_dir": windDir,
        "pressure": pressure,
        "precip": precip,
        "humidity": humidity,
        "cloudcover": cloudcover,
        "feelslike": feelslike,
        "uv_index": uvIndex,
        "visibility": visibility,
        "is_day": isDay,
      };
}

class Location {
  Location({
    this.name,
    this.country,
    this.region,
    this.lat,
    this.lon,
    this.timezoneId,
    this.localtime,
    this.localtimeEpoch,
    this.utcOffset,
  });

  String? name;
  String? country;
  String? region;
  String? lat;
  String? lon;
  String? timezoneId;
  String? localtime;
  int? localtimeEpoch;
  String? utcOffset;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        country: json["country"],
        region: json["region"],
        lat: json["lat"],
        lon: json["lon"],
        timezoneId: json["timezone_id"],
        localtime: json["localtime"],
        localtimeEpoch: json["localtime_epoch"],
        utcOffset: json["utc_offset"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "region": region,
        "lat": lat,
        "lon": lon,
        "timezone_id": timezoneId,
        "localtime": localtime,
        "localtime_epoch": localtimeEpoch,
        "utc_offset": utcOffset,
      };
}

class Request {
  Request({
    this.type,
    this.query,
    this.language,
    this.unit,
  });

  String? type;
  String? query;
  String? language;
  String? unit;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        type: json["type"],
        query: json["query"],
        language: json["language"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": query,
        "language": language,
        "unit": unit,
      };
}
