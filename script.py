import json

def main():
    sanakirja = {}
    sanakirja["kysymykset"] = []
    filename = "kysymyksia.txt"
    f = open(filename, "r")
    lines = f.read().split("\n")
    f.close()
    for i in range(0, len(lines)):
        elems = lines[i].split(";")
        kysymys_sanakirja = {}
        kysymys_sanakirja["teksti"] = elems[0]
        kysymys_sanakirja["vaihtoehdot"] = []
        kysymys_sanakirja["kuva"] = elems[len(elems)-1]
        oikea_vaihtoehto = int(elems[len(elems)-2])
        for j in range(1, len(elems)-2):
            if j == oikea_vaihtoehto:
                kysymys_sanakirja["vaihtoehdot"].append({"teksti" : elems[j], "oikein": True})
            else:
                kysymys_sanakirja["vaihtoehdot"].append({"teksti" : elems[j], "oikein": False})
                
        sanakirja["kysymykset"].append(kysymys_sanakirja)
    tiedosto = json.dumps(sanakirja, ensure_ascii=False)
    w = open("kysymykset.json", "w")
    w.write(tiedosto)
    w.close()

main()
