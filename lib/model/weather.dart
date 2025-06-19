class Weather {
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class MainWeather {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double pressure;
  final int humidity;
  final int? seaLevel;
  final int? grndLevel;

  MainWeather({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp: (json['temp'] as num).toDouble() - 273.15,
      feelsLike: (json['feels_like'] as num).toDouble() - 273.15,
      tempMin: (json['temp_min'] as num).toDouble() - 273.15,
      tempMax: (json['temp_max'] as num).toDouble() - 273.15,
      pressure: (json['pressure'] as num).toDouble(),
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }
}

class WeatherWind {
  final double speed;
  final int deg;
  final double gust;

  WeatherWind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory WeatherWind.fromJson(Map<String, dynamic> json) {
    return WeatherWind(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'],
      gust: (json['gust'] as num).toDouble(),
    );
  }
}

class WeatherSys {
  final String country;
  final int sunrise;
  final int sunset;

  WeatherSys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherSys.fromJson(Map<String, dynamic> json) {
    return WeatherSys(
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class WeatherCoord {
  final double lon;
  final double lat;

  WeatherCoord({
    required this.lon,
    required this.lat,
  });

  factory WeatherCoord.fromJson(Map<String, dynamic> json) {
    return WeatherCoord(
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );
  }
}

class WeatherCloud {
    final int all;

  WeatherCloud({required this.all});

  factory WeatherCloud.fromJson(Map<String,dynamic> json) {
      return WeatherCloud(all: json["all"]);
  }
}



class WeatherResponse {
  final String cityName;
  final List<Weather> weatherList;
  final MainWeather mainWeather;
  final WeatherWind weatherWind;
  final WeatherSys weatherSys;
  final num visibility;
  final WeatherCoord weatherCoord;
  final WeatherCloud weatherCloud;

  WeatherResponse({
    required this.cityName,
    required this.weatherList,
    required this.mainWeather,
    required this.weatherWind,
    required this.weatherSys,
    required this.visibility,
    required this.weatherCoord,
    required this.weatherCloud,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      cityName: json['name'],
      weatherList: (json['weather'] as List)
          .map((item) => Weather.fromJson(item))
          .toList(),
      mainWeather: MainWeather.fromJson(json['main']),
      weatherWind: WeatherWind.fromJson(json['wind']),
      weatherSys: WeatherSys.fromJson(json['sys']),
      visibility: json["visibility"],
      weatherCoord: WeatherCoord.fromJson(json["coord"]),
      weatherCloud: WeatherCloud.fromJson(json["clouds"]),
    );
  }
}

