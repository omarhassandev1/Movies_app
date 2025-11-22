import 'package:dio/dio.dart';
import 'package:movies_app/features/main_layer/profile/data/profile_api_services.dart';
import 'package:movies_app/features/main_layer/profile/data/profile_repo.dart';
import '../../features/auth/data/auth_api_service.dart';
import '../../features/auth/data/auth_repo.dart';
import '../../features/main_layer/profile/profile_features/favorites/data/fav_api_services.dart';
import '../../features/main_layer/profile/profile_features/favorites/data/fav_repo.dart';
import '../consts/api_consts.dart';

class ServiceLocator {
  //Auth
  static final routeApi = Dio(
    BaseOptions(
      baseUrl: RouteApiConsts.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  static final authService = AuthApiService(routeApi);
  static final authRepo = AuthRepo(authService);

  //Profile
  static final profileService = ProfileApiServices(dio: routeApi);
  static final profileRepo = ProfileRepo(apiServices: profileService);

  //Favorite
  static final favServices = FavApiServices(dio: routeApi);
  static final favRepo = FavRepo(apiServices: favServices);


}