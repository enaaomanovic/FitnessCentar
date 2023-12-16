

import 'package:fitness_mobile/models/pregledaneNovosti.dart';

import 'package:fitness_mobile/providers/base_provider.dart';

class SeenNewsProvider extends BaseProvider<PregledaneNovosti> {
  SeenNewsProvider():super("PregledaneNovosti");

  @override
  PregledaneNovosti fromJson(data) {
    // TODO: implement fromJson
    return PregledaneNovosti.fromJson(data);
  }
  
}