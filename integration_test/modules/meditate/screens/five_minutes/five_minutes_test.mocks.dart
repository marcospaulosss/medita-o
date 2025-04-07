// This is a generated file; do not edit or check into version control.
import 'package:mockito/mockito.dart' as _i1;
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart' as _i2;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_contract.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAppRouter_0 extends _i1.SmartFake implements _i2.AppRouter {
  _FakeAppRouter_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRepository_1 extends _i1.SmartFake implements _i3.Repository {
  _FakeRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AppRouter].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppRouter extends _i1.Mock implements _i2.AppRouter {
  @override
  void goTo(_i4.PageRouteInfo<dynamic> route, {void Function(dynamic)? onClose}) =>
      super.noSuchMethod(
        Invocation.method(
          #goTo,
          [route],
          {#onClose: onClose},
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [Repository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRepository extends _i1.Mock implements _i3.Repository {
  @override
  void sendOpenScreenEvent() => super.noSuchMethod(
        Invocation.method(
          #sendOpenScreenEvent,
          [],
        ),
        returnValueForMissingStub: null,
      );
      
  @override
  Future<void> requestRegisterMeditateCompleted(int time) =>
      super.noSuchMethod(
        Invocation.method(
          #requestRegisterMeditateCompleted,
          [time],
        ),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      );
} 