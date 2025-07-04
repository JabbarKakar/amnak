import 'package:amnak/core/feature/data/repositories/repository_imp.dart';
import 'package:amnak/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

class MockLocalDataSource extends Mock implements LocalDataSource {}

void main() {
  late RepoImp repoImp;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repoImp = RepoImp(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  test('Should get data from remote data source and return it', () async {
    // Arrange
    const endPoint = 'example_endpoint';
    final inputData = {'key': 'value'};
    final serverResponse = ServerResponse(data: {'data': 'example_data'});
    when(() => mockRemoteDataSource.get(endPoint, inputData))
        .thenAnswer((_) async => Right(serverResponse));

    // Act
    final result = await repoImp.get(endPoint, data: inputData);

    // Assert
    result.fold((l) {}, (r) => expect(r, equals(serverResponse.data)));
  });

  test(
      'Should return EmptyCacheFailure when trying to get cached data that does not exist',
      () async {
    // Arrange
    const endPoint = 'example_endpoint';
    final data = {'key': 'value'};
    const cacheName = 'example_cash_name';
    const failure = OfflineFailure(message: 'offline');
    when(() => mockRemoteDataSource.get(endPoint, data))
        .thenAnswer((_) async => const Left(failure));
    when(() => mockLocalDataSource.containsKey(cacheName))
        .thenAnswer((_) => Future.value(false));

    // Act
    final result =
        await repoImp.get(endPoint, data: data, cacheName: cacheName);

    // Assert
    result.fold(
      (l) => expect(l, equals(const EmptyCacheFailure(message: 'no_data'))),
      (r) {},
    );
  });
}
