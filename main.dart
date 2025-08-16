import 'dart:html';
import "dart:convert";
import "dart:math";

var globaali = 0;
var vastattu = false;

main() async{
  var data = '{"kysymykset": [{"teksti": "Mikä on Suomen väkiluku?", "vaihtoehdot": [{"teksti": "5,6 Miljoonaa", "oikein": true}, {"teksti": "7.1 Miljoonaa", "oikein": false}, {"teksti": "4.2 Miljoonaa", "oikein": false}]}, {"teksti": "Mikä on Ruotsin pääkaupunki?", "vaihtoehdot": [{"teksti": "Göteborg", "oikein": false}, {"teksti": "Linköping", "oikein": false}, {"teksti": "Tukholma", "oikein": true}, {"teksti": "Malmö", "oikein": false}]}, {"teksti": "Mikä on Suomen suurin järvi?", "vaihtoehdot": [{"teksti": "Päijänne", "oikein": false}, {"teksti": "Inarijärvi", "oikein": false}, {"teksti": "Saimaa", "oikein": true}]}, {"teksti": "Mikä on asukasluvultaan suurin Yhdysvaltain osavaltio?", "vaihtoehdot": [{"teksti": "Florida", "oikein": false}, {"teksti": "New York", "oikein": false}, {"teksti": "California", "oikein": true}, {"teksti": "Texas", "oikein": false}]}, {"teksti": "Minkä valtion lippu?", "vaihtoehdot": [{"teksti": "Ruotsi", "oikein": false}, {"teksti": "Tanska", "oikein": false}, {"teksti": "Suomi", "oikein": false}, {"teksti": "Norja", "oikein": true}]}]}';
  var osoite = "kysymykset.json";
  //var sisalto = await HttpRequest.getString(osoite);
  var sanakirja = jsonDecode(data);
  var kysymykset = sanakirja["kysymykset"];
  var kysymys_maara = kysymykset.length;
  
  var indeksi = 0;
  querySelector("#seuraava")?.onClick?.listen((e) {
    if (indeksi >= kysymykset.length) {
      querySelector("#nappi")?.children?.clear();
      querySelector("#vastaukset")?.children?.clear();
      var ranking = "";
      var lisateksti = "";
      
      /*
      var rnd = Random().nextDouble();
      ImageElement kuva = ImageElement();
      kuva.src = 'https://cataas.com/cat?type=small&t=$rnd';
      querySelector("#vastaukset")?.children?.add(kuva); */
      
      if (globaali < 0.25 * kysymys_maara) {
        ranking = "Noviisi";
      } else if (globaali < 0.5 * kysymys_maara) {
        ranking = "Osaaja";
      } else if (globaali < 0.75 * kysymys_maara) {
        ranking = "Ammattilainen";
      } else if (globaali < kysymys_maara) {
        ranking = "Ekspertti";
      } else if (globaali == kysymys_maara) {
        ranking = "Mestari";
        lisateksti = "Kaikki oikein!";
      }
      
      ImageElement kuva = ImageElement();
      kuva.src = "kuvat/ranking/$ranking.png";
      kuva.width = 400;
      querySelector("#vastaukset")?.children?.add(kuva);
      
      querySelector("#kysymys")?.text = "Pääsit Loppuun! Oikeita vastauksia: $globaali/$kysymys_maara $lisateksti Olet maantiedon $ranking.";
    } else {
      asetaKysymys(kysymykset[indeksi]);
    }
    indeksi++;
    querySelector("#seuraava")?.text = "Seuraava kysymys $indeksi/$kysymys_maara";
  });
}

asetaKysymys(kysymys) {
  querySelector("#kysymys")?.text = kysymys["teksti"];
  
  querySelector("#vastaukset")?.children?.clear();
  vastattu = false;
  for (var i = 0; i < kysymys["vaihtoehdot"].length; i++) {
    lisaaVastausvaihtoehto(kysymys["vaihtoehdot"][i]);
  }
  if (kysymys["kuva"] != "") {
	ImageElement kuva = ImageElement();
	var kuvanimi = kysymys["kuva"];
	kuva.src = "kuvat/kysymys_kuvat/$kuvanimi";
	querySelector("#vastaukset")?.children?.add(kuva);
  }
}

lisaaVastausvaihtoehto(vaihtoehto) {
  var elementti = Element.div();
  elementti.className = "vaihtoehto";
  elementti.text = vaihtoehto["teksti"];
  
  elementti.onClick.listen((e) {
    if (!vastattu) {
      if (vaihtoehto["oikein"]) {
      elementti.text = "Oikein!";
      elementti.className = "oikein";
      globaali++;
    } else {
      elementti.text = "Väärin!";
      elementti.className = "vaarin";
    }
    vastattu = true;
    }
  });
  
  querySelector("#vastaukset")?.children?.add(elementti);
}
