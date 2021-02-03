// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.associated.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PaymentAssociatedController on PaymentAssociatedControllerBase, Store {
  final _$isHideButtonAtom =
      Atom(name: 'PaymentAssociatedControllerBase.isHideButton');

  @override
  bool get isHideButton {
    _$isHideButtonAtom.reportRead();
    return super.isHideButton;
  }

  @override
  set isHideButton(bool value) {
    _$isHideButtonAtom.reportWrite(value, super.isHideButton, () {
      super.isHideButton = value;
    });
  }

  final _$paymentsAtom = Atom(name: 'PaymentAssociatedControllerBase.payments');

  @override
  ObservableList<dynamic> get payments {
    _$paymentsAtom.reportRead();
    return super.payments;
  }

  @override
  set payments(ObservableList<dynamic> value) {
    _$paymentsAtom.reportWrite(value, super.payments, () {
      super.payments = value;
    });
  }

  final _$paymentAtom = Atom(name: 'PaymentAssociatedControllerBase.payment');

  @override
  Payment get payment {
    _$paymentAtom.reportRead();
    return super.payment;
  }

  @override
  set payment(Payment value) {
    _$paymentAtom.reportWrite(value, super.payment, () {
      super.payment = value;
    });
  }

  final _$_paymentRepoAtom =
      Atom(name: 'PaymentAssociatedControllerBase._paymentRepo');

  @override
  PaymentRepo get _paymentRepo {
    _$_paymentRepoAtom.reportRead();
    return super._paymentRepo;
  }

  @override
  set _paymentRepo(PaymentRepo value) {
    _$_paymentRepoAtom.reportWrite(value, super._paymentRepo, () {
      super._paymentRepo = value;
    });
  }

  final _$errorMsgAtom = Atom(name: 'PaymentAssociatedControllerBase.errorMsg');

  @override
  String get errorMsg {
    _$errorMsgAtom.reportRead();
    return super.errorMsg;
  }

  @override
  set errorMsg(String value) {
    _$errorMsgAtom.reportWrite(value, super.errorMsg, () {
      super.errorMsg = value;
    });
  }

  final _$futureAtom = Atom(name: 'PaymentAssociatedControllerBase.future');

  @override
  Future<List<Payment>> get future {
    _$futureAtom.reportRead();
    return super.future;
  }

  @override
  set future(Future<List<Payment>> value) {
    _$futureAtom.reportWrite(value, super.future, () {
      super.future = value;
    });
  }

  final _$PaymentAssociatedControllerBaseActionController =
      ActionController(name: 'PaymentAssociatedControllerBase');

  @override
  bool hideButton() {
    final _$actionInfo = _$PaymentAssociatedControllerBaseActionController
        .startAction(name: 'PaymentAssociatedControllerBase.hideButton');
    try {
      return super.hideButton();
    } finally {
      _$PaymentAssociatedControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> findOne(int id) {
    final _$actionInfo = _$PaymentAssociatedControllerBaseActionController
        .startAction(name: 'PaymentAssociatedControllerBase.findOne');
    try {
      return super.findOne(id);
    } finally {
      _$PaymentAssociatedControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isHideButton: ${isHideButton},
payments: ${payments},
payment: ${payment},
errorMsg: ${errorMsg},
future: ${future}
    ''';
  }
}
