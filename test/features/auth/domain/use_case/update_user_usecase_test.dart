import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';
import 'package:thrift_store/features/auth/domain/use_case/update_user_usecase.dart';

// 1️⃣ Mock the repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UpdateUserUsecase updateUserUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    updateUserUsecase = UpdateUserUsecase(mockAuthRepository);
  });

  group('UpdateUserUsecase', () {
    const tName = 'John Doe';
    const tAge = 28;
    const tEmail = 'john@example.com';
    const tPhone = '9876543210';

    const tParams = UpdateUserParams(
      name: tName,
      age: tAge,
      email: tEmail,
      phone: tPhone,
    );

    test('should return void when update is successful', () async {
      // Arrange
      when(() => mockAuthRepository.updateUser(
            tName,
            tEmail,
            tAge,
            tPhone,
          )).thenAnswer((_) async => const Right(null));

      // Act
      final result = await updateUserUsecase(tParams);

      // Assert
      expect(result, const Right(null));
      verify(() => mockAuthRepository.updateUser(
            tName,
            tEmail,
            tAge,
            tPhone,
          )).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure when update fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Update failed');
      when(() => mockAuthRepository.updateUser(
            tName,
            tEmail,
            tAge,
            tPhone,
          )).thenAnswer((_) async => Left(failure));

      // Act
      final result = await updateUserUsecase(tParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.updateUser(
            tName,
            tEmail,
            tAge,
            tPhone,
          )).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
