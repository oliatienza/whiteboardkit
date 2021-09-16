import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'toolbox_options.dart';
import 'whiteboard_draw.dart';

typedef void SizeChanged(Size size);

abstract class WhiteboardController {
  final streamController = StreamController<WhiteboardDraw?>.broadcast();
  final sizeChangedController = StreamController<Size>.broadcast();

  WhiteboardDraw? _draw;

  final bool readonly;
  final bool toolbox;
  final ToolboxOptions toolboxOptions;

  WhiteboardController({
    required this.readonly,
    this.toolbox = false,
    this.toolboxOptions = const ToolboxOptions(),
  });

  void initializeSize(double width, double height) {
    if (_draw!.getScaledSize(width, height) == this._draw!.getSize()) return;
    _draw!.scale(width, height);
    streamController.add(_draw!.copyWith());
  }

  WhiteboardDraw? getDraw() => _draw;

  Stream<WhiteboardDraw?> onChange() {
    return streamController.stream;
  }

  Stream<Size> onSizeChange() {
    return sizeChangedController.stream;
  }

  close() {
    streamController.close();
    sizeChangedController.close();
  }

  onPanUpdate(Offset position) {}

  onPanEnd() {}

  WhiteboardDraw? get draw => _draw;
  set draw(WhiteboardDraw? whiteboardDraw) {
    _draw = whiteboardDraw;
    streamController.add(_draw!.copyWith());
  }
}

class PlayControls {
  Stream<WhiteboardDraw>? onComplete() {}

  play() async {}

  skip() {}
}
