// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_menu_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainMenuStore on _MainMenuStore, Store {
  late final _$greetingAtom =
      Atom(name: '_MainMenuStore.greeting', context: context);

  @override
  String get greeting {
    _$greetingAtom.reportRead();
    return super.greeting;
  }

  @override
  set greeting(String value) {
    _$greetingAtom.reportWrite(value, super.greeting, () {
      super.greeting = value;
    });
  }

  late final _$futureHelloWorldAtom =
      Atom(name: '_MainMenuStore.futureHelloWorld', context: context);

  @override
  ObservableFuture<dynamic> get futureHelloWorld {
    _$futureHelloWorldAtom.reportRead();
    return super.futureHelloWorld;
  }

  @override
  set futureHelloWorld(ObservableFuture<dynamic> value) {
    _$futureHelloWorldAtom.reportWrite(value, super.futureHelloWorld, () {
      super.futureHelloWorld = value;
    });
  }

  late final _$_MainMenuStoreActionController =
      ActionController(name: '_MainMenuStore', context: context);

  @override
  Future<dynamic> getHelloWorld(BuildContext context) {
    final _$actionInfo = _$_MainMenuStoreActionController.startAction(
        name: '_MainMenuStore.getHelloWorld');
    try {
      return super.getHelloWorld(context);
    } finally {
      _$_MainMenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
greeting: ${greeting},
futureHelloWorld: ${futureHelloWorld}
    ''';
  }
}
