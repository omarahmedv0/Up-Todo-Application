import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:up_todo_app/data/networking/network_info.dart';
import 'network_info_unit_test.mocks.dart';



@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(internetConnectionChecker: mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      //arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      //act
      final result = networkInfo.isConnected;
      //assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}