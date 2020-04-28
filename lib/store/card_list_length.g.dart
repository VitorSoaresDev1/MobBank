// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_list_length.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardListLength on _CardListLength, Store {
  Computed<int> _$rollingComputed;

  @override
  int get rolling =>
      (_$rollingComputed ??= Computed<int>(() => super.rolling)).value;

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

  final _$rollAtom = Atom(name: '_CardListLength.roll');

  @override
  int get roll {
    _$rollAtom.context.enforceReadPolicy(_$rollAtom);
    _$rollAtom.reportObserved();
    return super.roll;
  }

  @override
  set roll(int value) {
    _$rollAtom.context.conditionallyRunInAction(() {
      super.roll = value;
      _$rollAtom.reportChanged();
    }, _$rollAtom, name: '${_$rollAtom.name}_set');
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

  final _$setCountAsyncAction = AsyncAction('setCount');

  @override
  Future<void> setCount() {
    return _$setCountAsyncAction.run(() => super.setCount());
  }

  final _$_CardListLengthActionController =
      ActionController(name: '_CardListLength');

  @override
  void resetRoll() {
    final _$actionInfo = _$_CardListLengthActionController.startAction();
    try {
      return super.resetRoll();
    } finally {
      _$_CardListLengthActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'count: ${count.toString()},roll: ${roll.toString()},user: ${user.toString()},rolling: ${rolling.toString()}';
    return '{$string}';
  }
}
