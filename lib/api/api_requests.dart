import 'package:chopper/chopper.dart';
import 'package:geeruh/api/api_classes.dart';

part 'api_requests.chopper.dart';

@ChopperApi()
abstract class ApiRequests extends ChopperService {
  static ApiRequests create([ChopperClient? client]) => _$ApiRequests(client);

  // -------------------------------------------

  @Post(path: "/statuses/{statusCode}")
  Future<Response<StatusRes>> postStatus(
      @Path("statusCode") String statusCode, @Body() PostStatusReq statusReq);

  @Get(path: "/statuses")
  Future<Response<List<StatusRes>>> getStatuses();

  // -------------------------------------------

  @Get(path: "/issues")
  Future<Response<List<IssueRes>>> getIssues();

  @Put(path: "/issues/{issueId}")
  Future<Response<IssueRes>> updateIssue(
    @Path("issueId") String issueId,
    @Body() PutIssueReq issueReq,
  );

  @Post(path: "/issues")
  Future<Response<IssueRes>> postIssue(
    @Body() PutIssueReq issueReq,
    @Query("projectCode") String projectCode,
    @Query("statusCode") String statusCode,
  );

  @Put(path: "/issues/{issueId}/status")
  Future<Response<IssueRes>> updateIssueStatus(
      @Path("issueId") String issueId, @Body() ChangeIssueStatusReq statusCode);

  @Put(path: "/issues/{issueId}/assignee")
  Future<Response<IssueRes>> updateIssueAssignee(
    @Path("issueId") String issueId,
    @Body() UpdateIssueAssigneeReq statusCode,
  );

  @Post(path: "/issues/{issueId}/related-to/{relatedIssueId}")
  Future<Response<IssueRes>> makeIssueRelation(
    @Path("issueId") String issueId,
    @Path("relatedIssueId") String relatedIssueId,
  );

  @Delete(path: "/issues/{issueId}/related-to/{relatedIssueId}")
  Future<Response<IssueRes>> removeIssueRelation(
    @Path("issueId") String issueId,
    @Path("relatedIssueId") String relatedIssueId,
  );

  @Delete(path: "/issues/{issueId}")
  Future<Response> removeIssue(
    @Path("issueId") String issueId,
  );

  @Get(path: "/issues/{issueId}/history")
  Future<Response<List<IssueHistoryRes>>> getIssueHistory(
    @Path("issueId") String issueId,
  );

// -------------------------------------------

  @Get(path: "/projects")
  Future<Response<List<ProjectRes>>> getProjects();

  @Put(path: "/projects/{projectCode}")
  Future<Response<ProjectRes>> putProject(
    @Path("projectCode") String projectCode,
    @Body() PutProjectReq projectReq,
  );

  @Delete(path: "/projects/{projectCode}")
  Future<Response<void>> deleteProject(
    @Path("projectCode") String projectCode,
  );

  @Post(path: "/projects/{projectCode}")
  Future<Response<ProjectRes>> postProject(
    @Path("projectCode") String projectCode,
    @Body() PostProjectReq projectReq,
  );

// -------------------------------------------

  @Post(path: "/login")
  Future<Response> login(
    @Body() LoginReq loginBody,
  );

  @Get(path: "/logout")
  Future<Response> logout();

  @Get(path: "/session")
  Future<Response<UserRes>> getSession();

// -------------------------------------------

  @Post(path: "/users")
  Future<Response<RegisterRes>> register(
    @Body() RegisterReq registerBody,
  );

  @Get(path: "/users")
  Future<Response<List<UserRes>>> getUsers();

  // -------------------------------------------

  @Get(path: "/comments")
  Future<Response<List<CommentRes>>> getComments();

  @Post(path: "/comments")
  Future<Response<CommentRes>> postComment(
    @Body() PostCommentReq commentReq,
    @Query("issueId") String issueId,
  );

  @Delete(path: "/comments/{commentId}")
  Future<Response> deleteComment(
    @Path("commentId") String commentId,
  );
}
