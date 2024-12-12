part of 'utils.dart';

class _ExtendUpgrade extends _Upgrade {
  _ExtendUpgrade._();

  @override
  Future<UpgradeModel> checkUpgrade() async {
    return UpgradeModel();
  }
}
