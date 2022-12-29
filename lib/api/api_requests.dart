import 'package:chopper/chopper.dart';
import 'package:geeruh/api/api_classes.dart';

part 'api_requests.chopper.dart';

@ChopperApi()
abstract class ApiRequests extends ChopperService {
  static ApiRequests create([ChopperClient? client]) => _$ApiRequests(client);

  @Get(path: "/issues")
  Future<Response<List<IssueRes>>> getIssues();

  @Put(path: "/issues/{issueId}")
  Future<Response<IssueRes>> updateIssue(
      @Path("issueId") String issueId, @Body() PutIssueReq issueReq);

// -------------------------------------------

  @Post(path: "/login")
  Future<Response> login(@Body() LoginReq loginBody);

  @Get(path: "/logout")
  Future<Response> logout();

// -------------------------------------------

  @Post(path: "/users")
  Future<Response<RegisterRes>> register(@Body() RegisterReq registerBody);
}
