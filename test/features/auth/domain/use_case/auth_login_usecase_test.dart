import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/entity/login_response_entity.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_login_usecase.dart';

// 1️⃣ Create a Mock Repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late AuthLoginUsecase authLoginUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authLoginUsecase = AuthLoginUsecase(authRepository: mockAuthRepository);
  });

  // 2️⃣ Register fallback values for mocktail
  setUpAll(() {
    registerFallbackValue(const LoginParams(email: '', password: ''));
  });

  group('AuthLoginUsecase', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tLoginParams = LoginParams(email: tEmail, password: tPassword);

    final tLoginResponse = LoginResponse(
      token: 'sample_token',
      userId: 'user123',
    user: UserEntity(
        id: 'user123',
        email: tEmail,
        name: 'Test User',
        role: 'user', password: '',
      ),
    );

    test('should return LoginResponse when repository login is successful', () async {
      // Arrange
      when(() => mockAuthRepository.loginToAccount(tEmail, tPassword))
          .thenAnswer((_) async => Right(tLoginResponse));

      // Act
      final result = await authLoginUsecase(tLoginParams);

      // Assert
      expect(result, Right(tLoginResponse));
      verify(() => mockAuthRepository.loginToAccount(tEmail, tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return Failure when repository login fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Invalid credentials');
      when(() => mockAuthRepository.loginToAccount(tEmail, tPassword))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await authLoginUsecase(tLoginParams);

      // Assert
      expect(result, Left(failure));
      verify(() => mockAuthRepository.loginToAccount(tEmail, tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
