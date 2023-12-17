import 'package:json_annotation/json_annotation.dart';

part 'odgovoriNaKomentare.g.dart';

@JsonSerializable()
class OdgovoriNaKomentare{
       int? id;
       int? komentarId;
       int? trenerId;
       String? tekst;
       DateTime? datumOdgovora;
    
  
         OdgovoriNaKomentare(this.id,this.komentarId,this.trenerId,this.tekst,this.datumOdgovora);

  factory OdgovoriNaKomentare.fromJson(Map<String, dynamic> json) =>
      _$OdgovoriNaKomentareFromJson(json);

  Map<String, dynamic> toJson() => _$OdgovoriNaKomentareToJson(this);
}

