import 'dart:convert';

import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/features/genderize/data/models/genderize_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GenderizeLocalDataSource {
  Future<GenderizeModel?> getPrediction();

  Future<bool> cacheGender(GenderizeModel genderToCache);
}

const cacheGenderize = 'CACHE_GENDERIZE';

class GenderizeLocalDataSourceImpl implements GenderizeLocalDataSource {
  final SharedPreferences sharedPreferences;

  GenderizeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<GenderizeModel?> getPrediction() async {
    final jsonString = sharedPreferences.getString(cacheGenderize);
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      final data = GenderizeModel.fromJson(jsonData);
      return data;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheGender(GenderizeModel genderToCache) {
    return sharedPreferences.setString(
        cacheGenderize, json.encode(genderToCache.toJson()));
  }
}
