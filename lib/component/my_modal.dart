library my_modal_component;

import 'package:angular/angular.dart';
import 'package:angular_ui/angular_ui.dart';
import 'dart:async';

@Component(
    selector: 'my-modal',
    templateUrl: 'packages/modal_update/component/my_modal.html',
    useShadowDom: false,
    exportExpressions: const ["tmp", "ok"]
)
class MyModalComponent implements ScopeAware  {

  @NgOneWay('colors')
  List<String> colors = ['red', 'white', 'blue', 'green', 'black'];

  String selected;
  String tmp;

  Modal modal;
  ModalInstance modalInstance;
  Scope scope;

  @NgTwoWay('colorOptions')
  NgForm colorOptions;

  @NgTwoWay('color')
  String color;

  @NgTwoWay('quantity')
  int quantity;

  @NgTwoWay('favorite')
  bool favorite;

  MyModalComponent(this.modal) {
    print('Creating MyModalComponent');
  }

  void openUrl(templateUrl) {

    String backdrop = "static";
    modalInstance = modal.open(new ModalOptions(templateUrl:templateUrl, backdrop:backdrop), scope);

    modalInstance.opened
      ..then((v) {
      print('Opened');
    }, onError: (e) {
      print('Open error is $e');
    });

    // Override close to add you own functionality
    modalInstance.close = (result) {
      selected = result;
      print('Closed with selection $selected');
      modal.hide();
    };

    // Override dismiss to add you own functionality
    modalInstance.dismiss = (String reason) {
      print('Dismissed with $reason');
      modal.hide();
    };
  }

  void ok() {
    print('ok');
    modalInstance.close("$quantity - $color - favorite:$favorite");
  }
}
