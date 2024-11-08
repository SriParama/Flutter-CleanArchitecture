import 'Apicall.dart';
import 'models/dashboard_model.dart';
import 'novo_remote_data_sources.dart';

class NovoRemoteDataSourceImpl implements NovoRemoteDataSource {
  @override
  Future<String> getClientId() async {
    return await getclientIdApi('tokenValidation');
  }

  @override
  Future<DashboardModel> getDashBoardDetails() async {
    return await getDashboardApi('dashboard');
  }
}
