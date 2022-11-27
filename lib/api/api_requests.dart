import 'package:chopper/chopper.dart';
import 'package:geeruh/api/api_classes.dart';

part 'api_requests.chopper.dart';

@ChopperApi()
abstract class ApiRequests extends ChopperService {
  static ApiRequests create([ChopperClient? client]) => _$ApiRequests(client);

  @Get(path: "/")
  Future<Response<String>> getHelloWorld();

  @Get(path: "/issues")
  Future<Response<List<IssueRes>>> getIssues();

// -------------------------------------------

  @Post(path: "/login")
  Future<Response> login(@Body() LoginReq loginBody);
}
