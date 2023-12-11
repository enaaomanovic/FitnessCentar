
import 'package:fitness_mobile/models/odgovoriNaKomentare.dart';
import 'package:fitness_mobile/providers/base_provider.dart';


class ReplyToCommentProvider extends BaseProvider<OdgovoriNaKomentare> {
  ReplyToCommentProvider():super("OdgovoriNaKomentare");

  @override
  OdgovoriNaKomentare fromJson(data) {
    // TODO: implement fromJson
    return OdgovoriNaKomentare.fromJson(data);
  }
  
}