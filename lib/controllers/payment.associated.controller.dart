import 'dart:async';
import 'package:hcslzapp/models/payment.dart';
import 'package:hcslzapp/repositories/payment.repo.dart';
import 'package:mobx/mobx.dart';

part 'payment.associated.controller.g.dart';

class PaymentAssociatedController = PaymentAssociatedControllerBase with _$PaymentAssociatedController;

abstract class PaymentAssociatedControllerBase with Store {
  @observable
  bool isHideButton = true;

  @observable
  ObservableList payments = [].asObservable();

  @observable
  Payment payment;

  @observable
  PaymentRepo _paymentRepo = PaymentRepo();

  @observable
  String errorMsg;

  @observable
  Future<List<Payment>> future;

  get init {
    payments.clear();
  }

  @action
  bool hideButton() => isHideButton = !isHideButton;

  @action
  Future findOne(int id) =>
      ObservableFuture(_paymentRepo.findByAssociatedIdToList(id).then((value) => value))
          .catchError((e) {
        this.errorMsg = "${e.message}";
      }, test: (e) => e is Exception);

  Future<List<Payment>> getFuture(int _paymentId) =>
      future = findOne(_paymentId);
}