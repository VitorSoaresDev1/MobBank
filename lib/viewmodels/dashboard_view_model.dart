import 'package:mobbank/locator.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/store/card_list_length.dart';

import 'base_model.dart';

class DashboardViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future createCard({CardListLength listLength}) async {
    setBusy(true);
    listLength.setCountAndSaveCard().whenComplete(() => _navigationService
        .replaceWith(DashBoardRoute, arguments: [listLength.user]));
  }
}
