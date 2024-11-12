import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle/bird.dart';
import 'package:ncu_biking/controllers/playing/obstacle/bus.dart';
import 'package:ncu_biking/controllers/playing/obstacle/car.dart';
import 'package:ncu_biking/controllers/playing/obstacle/person.dart';
import 'package:ncu_biking/controllers/playing/player.dart';
import 'package:ncu_biking/controllers/playing/roads.dart';
import 'package:ncu_biking/main.dart';

/// - Car, 固定位置
/// - Bus, 向前移動
/// - Person, 橫向移動
/// - Bird, 斜向後移動

class Playing extends Component with HasGameRef<NcuBikingGame> {
  final double _updateTime = 0.1;
  int stage = 0;

  /// 使 [stage] 增加所需要的總里程數
  final _stageTable = <double>[0.05, 0.2, 0.5, double.infinity];

  /// 每 0.1 秒有多少機率生成
  final _frequencyTable = <List<double>>[
    [0.05, -1, -1, -1],
    [0.06, 0.04, -1, -1],
    [0.06, 0.03, 0.05, -1],
    [0.05, 0.03, 0.06, 0.03],
  ];

  /// 各障礙物出現的冷卻時間
  final _coldDownTable = <double>[2, 3.5, 3, 4];

  /// 各障礙物出現的剩餘冷卻時間
  final _coldDown = <double>[0, 0, 0, 0];

  late Timer _generatingTimer;

  @override
  FutureOr<void> onLoad() async {
    addAll([Roads(), Player()]);
    _generatingTimer = Timer(
      _updateTime,
      onTick: () {
        if (_toGenerate(0)) {
          add(Car());
          _coldDownReset(0);
        }
        if (_toGenerate(1)) {
          add(Bus());
          _coldDownReset(1);
        }
        if (_toGenerate(2)) {
          add(Person());
          _coldDownReset(2);
        }
        if (_toGenerate(3)) {
          add(Bird());
          _coldDownReset(3);
        }
        for (int i = 0; i < _coldDown.length; i++) {
          _coldDown[i] -= _updateTime;
        }
      },
      repeat: true,
    );
    return super.onLoad();
  }

  @override
  void onMount() {
    gameRef.overlays.add("instruction");

    stage = 0;
    for (int i = 0; i < _coldDown.length; i++) {
      _coldDown[i] = 0;
    }
    // gameRef.isPlaying = true;
    gameRef.accumulatedTime = 0.0;
    gameRef.milage = 0.0;
    gameRef.crashed = null;
    gameRef.overlays.add("milage_hud");
    super.onMount();
  }

  @override
  void update(double dt) {
    if (gameRef.isPlaying) {
      _generatingTimer.update(dt);
      gameRef.accumulatedTime += dt;
      if (gameRef.milage / gameRef.milageCoefficient >= _stageTable[stage]) {
        stage++;
      }
    }
    super.update(dt);
  }

  bool _toGenerate(int index) {
    return Random().nextDouble() < _frequencyTable[stage][index] && _coldDown[index] <= 0;
  }

  void _coldDownReset(int index) {
    _coldDown[index] = _coldDownTable[index];
  }
}
