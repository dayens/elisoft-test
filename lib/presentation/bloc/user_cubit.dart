import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_elisoft/model/user_model.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  void changeState(UserModel userModel) {
    emit(userModel);
  }
}
