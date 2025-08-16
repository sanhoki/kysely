import 'dart:html';
import "dart:convert";

var globaali = 0;
var vastattu = false;

main() async{
  /*
  var vaihtoehdot = [];
  vaihtoehdot.add({"teksti" : "Norja", "oikein" : false});
  vaihtoehdot.add({"teksti" : "Suomi", "oikein" : true});
  vaihtoehdot.add({"teksti" : "Ruotsi", "oikein" : false});
  vaihtoehdot.add({"teksti" : "Viro", "oikein" : false});
  
  var vaihtoehdot2 = [];
  vaihtoehdot2.add({"teksti" : "Uranus", "oikein" : false});
  vaihtoehdot2.add({"teksti" : "Mars", "oikein" : false});
  vaihtoehdot2.add({"teksti" : "Pluto", "oikein" : true});
  
  var vaihtoehdot3 = [];
  vaihtoehdot3.add({"teksti" : "65 miljoonaa", "oikein" : false});
  vaihtoehdot3.add({"teksti" : "83 miljoonaa", "oikein" : true});
  vaihtoehdot3.add({"teksti" : "2.7 triljoonaa", "oikein" : false});
  
  var kysymys = {};
  kysymys["teksti"] = "Minkä maan pääkaupunki on Helsinki?";
  kysymys["vaihtoehdot"] = vaihtoehdot;
  
  var kysymys2 = {};
  kysymys2["teksti"] = "Mikki Hiiren koiran nimi?";
  kysymys2["vaihtoehdot"] = vaihtoehdot2;
  
  var kysymys3 = {};
  kysymys3["teksti"] = "Saksan väkiluku?";
  kysymys3["vaihtoehdot"] = vaihtoehdot3;
  
  var kysymykset = [kysymys, kysymys2, kysymys3];
  */
  var osoite = "kysymykset.json";
  var sisalto = await HttpRequest.getString(osoite);
  var sanakirja = jsonDecode(sisalto);
  var kysymykset = sanakirja["kysymykset"];
  var kysymys_maara = kysymykset.length;
  
  var indeksi = 0;
  querySelector("#seuraava")?.onClick?.listen((e) {
    if (indeksi >= kysymykset.length) {
      querySelector("#nappi")?.children?.clear();
      querySelector("#vastaukset")?.children?.clear();
      querySelector("#kysymys")?.text = "Pääsit Loppuun! Oikeita vastauksia: $globaali/$kysymys_maara";
    } else {
      asetaKysymys(kysymykset[indeksi]);
    }
    indeksi++;
  });
}

asetaKysymys(kysymys) {
  querySelector("#kysymys")?.text = kysymys["teksti"];
  
  querySelector("#vastaukset")?.children?.clear();
  vastattu = false;
  for (var i = 0; i < kysymys["vaihtoehdot"].length; i++) {
    lisaaVastausvaihtoehto(kysymys["vaihtoehdot"][i]);
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
