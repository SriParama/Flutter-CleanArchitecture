import 'package:fpdart/src/either.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecInvestModel.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/gsecModel/gsecorderdetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/novoModel/dashboard_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/data/novo_data_source/novo_remote_data_sources.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class NovoRepositoryImpl implements NovoRepository {
  final NovoRemoteDataSource remoteDataSource;
  NovoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> getClientId() async {
    try {
      return await remoteDataSource.getClientId();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in NovoRepositoryImpl while fetching client ID: $e');
      throw Exception('Failed to fetch client ID');
    }
  }

  @override
  Future<String> getClientName() async {
    try {
      return await remoteDataSource.getClientName();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in NovoRepositoryImpl while fetching client ID: $e');
      throw Exception('Failed to fetch client ID');
    }
  }

  @override
  Future<DashboardModel> getDashBoardDetails() async {
    try {
      return await remoteDataSource.getDashBoardDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print('Error in NovoRepositoryImpl while fetching dashboard details: $e');
      throw Exception('Failed to fetch dashboard details');
    }
  }

  @override
  Future<SGBinvestDetailsModel> getSGBinvestDetails() async {
    try {
      return await remoteDataSource.getSGBinsvestDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print(
      // 'Error in NovoRepositoryImpl while fetching SGB Master details: $e');
      throw Exception('Failed to fetch  SGB Invest details');
    }
  }

  @override
  Future<dynamic> getAccountBalanceDetails() async {
    try {
      return await remoteDataSource.getAccountBalanceDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print(
      // 'Error in NovoRepositoryImpl while fetching SGB Master details: $e');
      throw Exception('Failed to fetch  SGB Invest details');
    }
  }

  @override
  Future<SGBorderDetialsModel> getSGBorderDetails() async {
    try {
      return await remoteDataSource.getSGBorderDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print(
      // 'Error in NovoRepositoryImpl while fetching SGB Master details: $e');
      throw Exception('Failed to fetch  SGB Order details');
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> postSGBplaceOrder(
      SGBplaceOrderEntity postSgbBidDetails) async {
    try {
      var res = await remoteDataSource.postSGBplaceOrder(postSgbBidDetails);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteSGBplaceOrder(
      SGBplaceOrderEntity postSgbBidDetails) async {
    try {
      var res = await remoteDataSource.deleteSGBplaceOrder(postSgbBidDetails);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteGsecplaceOrder(
      GsecplaceOrderEntity postSgbBidDetails) async {
    try {
      var res = await remoteDataSource.deleteGsecplaceOrder(postSgbBidDetails);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<GsecInvestDetailsModel> getGsecinvestDetails() async {
    try {
      return await remoteDataSource.getGsecinvestDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print(
      // 'Error in NovoRepositoryImpl while fetching SGB Master details: $e');
      throw Exception('Failed to fetch  Gsec Invest details');
    }
  }

  @override
  Future<GsecOrderDetailsModel> getGsecorderDetails() async {
    try {
      return await remoteDataSource.getGsecorderDetails();
    } catch (e) {
      // Handle or log the error as necessary
      //print(
      // 'Error in NovoRepositoryImpl while fetching SGB Master details: $e');
      throw Exception('Failed to fetch  Gsec Order details');
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> postGsecplaceOrder(
      GsecplaceOrderEntity postSgbBidDetails) async {
    try {
      var res = await remoteDataSource.postGsecplaceOrder(postSgbBidDetails);

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
