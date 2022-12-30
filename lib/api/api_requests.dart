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

  @Get(path: "/projects")
  Future<Response<List<ProjectRes>>> getProjects();

  @Put(path: "/projects/{projectCode}")
  Future<Response<ProjectRes>> putProject(
      @Path("projectCode") String projectCode,
      @Body() PutProjectReq projectReq);

  @Post(path: "/projects/{projectCode}")
  Future<Response<ProjectRes>> postProject(
      @Path("projectCode") String projectCode,
      @Body() PostProjectReq projectReq);

// -------------------------------------------

  @Post(path: "/login")
  Future<Response> login(@Body() LoginReq loginBody);

  @Get(path: "/logout")
  Future<Response> logout();

// -------------------------------------------

  @Post(path: "/users")
  Future<Response<RegisterRes>> register(@Body() RegisterReq registerBody);
}
