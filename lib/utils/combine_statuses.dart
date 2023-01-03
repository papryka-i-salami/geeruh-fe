import 'package:mobx/mobx.dart';

FutureStatus combineStatuses(List<FutureStatus> futureStatuses) {
  if (futureStatuses.any((status) => status == FutureStatus.pending)) {
    return FutureStatus.pending;
  }

  if (futureStatuses.any((status) => status == FutureStatus.rejected)) {
    return FutureStatus.rejected;
  }

  return FutureStatus.fulfilled;
}
