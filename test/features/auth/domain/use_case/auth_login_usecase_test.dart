import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_login_usecase.dart';

// First, let's create a mock for the IAuthRepository using mocktail
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  // Declare the variables needed for the tests
  late AuthLoginUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  // setUp is called before each test runs
  setUp(() {
    // Instantiate the mock repository and the use case for each test
    mockAuthRepository = MockAuthRepository();
    usecase = AuthLoginUsecase(authRepository: mockAuthRepository);
  });

  // Group tests for LoginParams to ensure full coverage of the params class
  group('LoginParams', () {
    test('should correctly handle props for Equatable', () {
      // Assert
      expect(const LoginParams(email: 'a', password: 'b').props, ['a', 'b']);
    });

    test('should correctly create an initial instance', () {
      // Act
      const params = LoginParams.initial();
      // Assert
      expect(params.email, '');
      expect(params.password, '');
    });
  });

  // Group tests for the AuthLoginUsecase
  group('AuthLoginUsecase', () {
    // Define test parameters
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tLoginParams = LoginParams(email: tEmail, password: tPassword);
    const tAuthToken = 'sample_auth_token';
    final tApiFailure = ApiFailure(message: 'Invalid credentials');

    test(
      'should get auth token from the repository when login is successful',
      () async {
        // Arrange: Configure the mock repository to return a successful result.
        when(() => mockAuthRepository.loginToAccount(any(), any()))
            .thenAnswer((_) async => const Right(tAuthToken));

        // Act: Call the use case with the test parameters.
        final result = await usecase(tLoginParams);

        // Assert: Check if the result is what we expect.
        expect(result, const Right(tAuthToken));

        // Verify: Ensure that the loginToAccount method on the repository was called
        verify(() => mockAuthRepository.loginToAccount(tEmail, tPassword))
            .called(1);

        // VerifyNoMoreInteractions: Ensure no other methods were called on the mock repository.
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    test(
      'should return a Failure from the repository when login fails',
      () async {
        // Arrange: Configure the mock repository to return a failure.
        when(() => mockAuthRepository.loginToAccount(any(), any()))
            .thenAnswer((_) async => Left(tApiFailure));

        // Act: Call the use case.
        final result = await usecase(tLoginParams);

        // Assert: Check if the result is a Left containing the failure.
        expect(result, Left(tApiFailure));

        // Verify: Ensure the repository method was called with the correct parameters.
        verify(() => mockAuthRepository.loginToAccount(tEmail, tPassword))
            .called(1);

        // VerifyNoMoreInteractions: Ensure no other methods were called.
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}

// NOTE: The following classes are assumed to be defined elsewhere in your project.
// You would import these from their respective files.

// Your abstract repository interface
// abstract class IAuthRepository {
//   Future<Either<Failure, String>> loginToAccount(String email, String password);
// }

// Your use case implementation
// class AuthLoginUsecase implements UseCaseWithParams<String, LoginParams> {
//   final IAuthRepository _authRepository;
//   AuthLoginUsecase({required IAuthRepository authRepository})
//       : _authRepository = authRepository;
//   @override
//   Future<Either<Failure, String>> call(LoginParams params) async {
//     return await _authRepository.loginToAccount(
//       params.email,
//       params.password,
//     );
//   }
// }

// Your params class
// class LoginParams extends Equatable {
//   final String email;
//   final String password;
//   const LoginParams({required this.email, required this.password});
//   const LoginParams.initial() : email = '', password = '';
//   @override
//   List<Object?> get props => [email, password];
// }

// Your Failure classes
// abstract class Failure extends Equatable {
//   const Failure({required this.message});
//   final String message;
//   @override
//   List<Object> get props => [message];
// }

// class ApiFailure extends Failure {
//   const ApiFailure({required super.message});
// }
