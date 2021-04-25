import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:petdiary/app/domain/entities/user_entity.dart';
import 'package:petdiary/app/presentation/presenters/getx_splash_presenter.dart';

import '../../mocks/fake_user_factory.dart';
import '../../mocks/load_current_user_spy.dart';

void main() {
  GetxSplashPresenter sut;
  LoadCurrentUserSpy loadCurrentUser;

  PostExpectation mockLoadCurrentAccountCall() => when(loadCurrentUser.load());

  void mockLoadCurrentAccount({UserEntity account}) =>
      mockLoadCurrentAccountCall().thenAnswer((_) async => account);

  void mockLoadCurrentAccountError() =>
      mockLoadCurrentAccountCall().thenThrow(Exception());

  setUp(() {
    loadCurrentUser = LoadCurrentUserSpy();
    sut = GetxSplashPresenter(loadCurrentUser: loadCurrentUser);
    mockLoadCurrentAccount(account: FakeUserFactory.makeEntity());
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentUser.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/home')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null token', () async {
    mockLoadCurrentAccount(account: UserEntity(token: null));

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });
}
