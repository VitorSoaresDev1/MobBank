// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_list_length.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardListLength on _CardListLength, Store {
  final _$countAtom = Atom(name: '_CardListLength.count');

  @override
  int get count {
    _$countAtom.context.enforceReadPolicy(_$countAtom);
    _$countAtom.reportObserved();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.context.conditionallyRunInAction(() {
      super.count = value;
      _$countAtom.reportChanged();
    }, _$countAtom, name: '${_$countAtom.name}_set');
  }

  final _$userAtom = Atom(name: '_CardListLength.user');

  @override
  Usuario get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(Usuario value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$setCountAndSaveCardAsyncAction = AsyncAction('setCountAndSaveCard');

  @override
  Future<void> setCountAndSaveCard() {
    return _$setCountAndSaveCardAsyncAction
        .run(() => super.setCountAndSaveCard());
  }

  final _$setCountAsyncAction = AsyncAction('setCount');

  @override
  Future<void> setCount(dynamic userid) {
    return _$setCountAsyncAction.run(() => super.setCount(userid));
  }

  @override
  String toString() {
    final string = 'count: ${count.toString()},user: ${user.toString()}';
    return '{$string}';
  }
}
