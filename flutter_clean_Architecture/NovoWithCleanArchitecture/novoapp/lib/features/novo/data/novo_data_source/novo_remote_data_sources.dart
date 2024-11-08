import 'models/dashboard_model.dart';

abstract class NovoRemoteDataSource {
  Future<DashboardModel> getDashBoardDetails();
  Future<String> getClientId();
}
