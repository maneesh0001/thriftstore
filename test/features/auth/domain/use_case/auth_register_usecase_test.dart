import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thrift_store/core/error/failure.dart';
import 'package:thrift_store/features/auth/domain/entity/user_entity.dart';
import 'package:thrift_store/features/auth/domain/repository/auth_repository.dart';
import 'package:thrift_store/features/auth/domain/use_case/auth_register_usecase.dart';

// Mock the IAuthRepository using mocktail
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  // Declare the variables needed for the tests
  late AuthRegisterUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  // setUp is called before each test runs
  setUp(() {
    // Instantiate the mock repository and the use case for each test
    mockAuthRepository = MockAuthRepository();
    usecase = AuthRegisterUsecase(authRepository: mockAuthRepository);
    // Register a fallback value for UserEntity for the verify call
    registerFallbackValue(const UserEntity(
      email: '',
      name: '',
      password: '',
      role: '',
    ));
  });

  // Group tests for AuthRegisterParams to ensure full coverage
  group('AuthRegisterParams', () {
    test('should correctly handle props for Equatable', () {
      // Assert
      expect(
        const AuthRegisterParams(
          email: 'a',
          name: 'b',
          password: 'c',
          role: 'd',
        ).props,
        ['a', 'b', 'c', 'd'],
      );
    });

    test('should correctly create an initial instance', () {
      // Act
      const params = AuthRegisterParams.initial(
        email: 'a',
        name: 'b',
        password: 'c',
        role: 'd',
      );
      // Assert
      expect(params.email, 'a');
      expect(params.name, 'b');
      expect(params.password, 'c');
      expect(params.role, 'd');
    });
  });

  // Group tests for the AuthRegisterUsecase
  group('AuthRegisterUsecase', () {
    // Define test parameters
    const tName = 'Test User';
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tRegisterParams = AuthRegisterParams(
      name: tName,
      email: tEmail,
      password: tPassword,
    );
    final tUserEntity = UserEntity(
      email: tRegisterParams.email,
      name: tRegisterParams.name,
      password: tRegisterParams.password,
      role: 'user', // Default role as per usecase logic
    );
    final tApiFailure = ApiFailure(message: 'Email already in use');

    test(
      'should call createAccount on the repository with default role',
      () async {
        // Arrange
        when(() => mockAuthRepository.createAccount(any()))
            .thenAnswer((_) async => const Right(null));

        // Act
        final result = await usecase(tRegisterParams);

        // Assert
        expect(result, const Right(null));
        verify(() => mockAuthRepository.createAccount(tUserEntity)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    test(
      'should call createAccount with the provided role when it is not null',
      () async {
        // Arrange
        const tRole = 'admin';
        const tRegisterParamsWithRole = AuthRegisterParams(
          name: tName,
          email: tEmail,
          password: tPassword,
          role: tRole,
        );
        final tUserEntityWithRole = UserEntity(
          email: tRegisterParamsWithRole.email,
          name: tRegisterParamsWithRole.name,
          password: tRegisterParamsWithRole.password,
          role: tRole,
        );
        when(() => mockAuthRepository.createAccount(any()))
            .thenAnswer((_) async => const Right(null));

        // Act
        final result = await usecase(tRegisterParamsWithRole);

        // Assert
        expect(result, const Right(null));
        verify(() => mockAuthRepository.createAccount(tUserEntityWithRole))
            .called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    test(
      'should return a Failure from the repository when registration fails',
      () async {
        // Arrange
        when(() => mockAuthRepository.createAccount(any()))
            .thenAnswer((_) async => Left(tApiFailure));

        // Act
        final result = await usecase(tRegisterParams);

        // Assert
        expect(result, Left(tApiFailure));
        verify(() => mockAuthRepository.createAccount(tUserEntity)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}

// NOTE: The following classes are assumed to be defined elsewhere in your project.
// They are included here for the test to be self-contained and understandable.

// Your abstract repository interface
// abstract class IAuthRepository {
//   Future<Either<Failure, void>> createAccount(UserEntity user);
// }

// Your entity class
// class UserEntity extends Equatable {
// ...
// }

// Your params class
// class AuthRegisterParams extends Equatable {
// ...
// }

// Your Failure classes
// abstract class Failure extends Equatable {
// ...
// }

// class ApiFailure extends Failure {
// ...
// }
