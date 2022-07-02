import 'package:core/core/model/city.dart';
import 'package:dartz/dartz.dart';

abstract class ICityRepository {
  Future<Either<Exception,List<MalaysianCity>>> getCityList({bool shouldRefresh = false});
  
  Future<List<MalaysianCity>> getSelectedCityList();
  Future<Either<Exception,List<MalaysianCity>>> removeSelectedCity(MalaysianCity city);

  Future<Either<Exception,List<MalaysianCity>>> addSelectedCity(MalaysianCity city);

}