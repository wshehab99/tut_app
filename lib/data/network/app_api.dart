import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/data/response/response.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseURL)
abstract class AppServicesClient {
  factory AppServicesClient(
    Dio dio, {
    String baseUrl,
  }) = _AppServicesClient;
  @POST("/api/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
  @POST("/api/forget_password")
  Future<ForgetPasswordResponse> forgetPassword(
    @Field("email") String email,
  );
  @POST("/api/register")
  Future<AuthenticationResponse> register(
    @Field("username") String username,
    @Field("email") String email,
    @Field("password") String password,
    @Field("phone_number") String phoneNumber,
    @Field("profilePicture") String profilePicture,
  );
  @GET("/api/home")
  Future<HomeResponse> getHome();
  @GET("/api/store_details")
  Future<StoreDetailsResponse> getStoreDetails();
}
