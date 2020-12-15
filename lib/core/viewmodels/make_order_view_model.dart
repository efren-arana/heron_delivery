import 'package:heron_delivery/core/providers/base_model.dart';
import 'package:heron_delivery/core/services/navigation_service.dart';

import '../../locator.dart';

class MakeOrderViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();


  /// Metodo que realiza la navegacion a la pagina para verificar el telefono
  Future navigateToAuthPhoneView() async {
    await _navigationService.navigateTo('/auth_phone');
  }
}