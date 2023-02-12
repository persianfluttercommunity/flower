library flower;

import 'package:flower/flower_interface.dart';

export 'core/flower_core.dart';
export 'state_manager/flower_state_manager.dart';
export 'navigation/flower_navigation.dart';
export 'overlays/flower_overlays.dart';
export 'storage/flower_storage.dart';
export 'utils/flower_utils.dart';
export 'ui/flower_ui.dart';

class _FlowerImpl extends FlowerInterface {}

/// Flower is a UI Framework for Flutter.
// ignore: non_constant_identifier_names
final Flower = _FlowerImpl();
