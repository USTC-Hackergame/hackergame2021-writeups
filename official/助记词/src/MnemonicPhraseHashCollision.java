import java.util.*;
import java.util.stream.IntStream;

public class MnemonicPhraseHashCollision
{
    public static final String[] MNEMONIC_ARRAY = ("ability access account action active activity addition address " +
            "advantage advertising advice affect alternative amount analysis animal answer anything apartment " +
            "appearance application area army article association attempt attention audience author average back " +
            "balance ball bank base basis beautiful beginning being benefit beyond bird birth black blood board " +
            "boat body book boss bottom boyfriend brain break broad brown brush budget building business button " +
            "call camera capital card care career case cash category cause cell challenge chance change charge " +
            "check chemistry chicken child choice cigarette city class classic click coast cold combination " +
            "comfortable commercial common community company competition complex computer concept concern condition " +
            "contact context control cook cost country county couple course cover craft creative credit culture " +
            "current customer cycle damage dance data date deal dealer death debate decision deep definition demand " +
            "department depth design desire development difference direction discipline discount discussion disease " +
            "disk display distance drive driver earth economics economy education effect effective effort energy " +
            "environment equipment estate event exam example exchange excuse exercise exit experience expression " +
            "face fact fail failure fall familiar family feature feel feeling field figure file film final finding " +
            "finish fire fish fishing flight flow focus following food foot force form foundation frame freedom " +
            "friend front function future gain game garden general gift give glad goal good government grandmother " +
            "great green ground group growth guard guide half hand handle head health heart heat heavy hello help " +
            "high history hold home hope house housing human idea image impact importance income increase " +
            "independent individual industry inflation influence information inside instance insurance interest " +
            "internet investment issue item junior keep kind knowledge lack lake language lead leading leave length " +
            "lesson level library life lift light line link list listen literature living local location long look " +
            "love machine magazine main major make management many market marketing marriage material math matter " +
            "maybe meaning meat media medicine medium meet member message metal method middle might mind minute " +
            "model moment money month mood morning most mouse move movie music name nation national natural nature " +
            "necessary negative network news newspaper night normal north note nothing notice number object " +
            "objective offer office officer official opinion opportunity order original other outside oven page " +
            "paint painting pair paper part particular past payment people performance period person personal " +
            "perspective phase philosophy phone photo physical physics pick picture piece place plan plant plastic " +
            "play player point policy politics population position positive possible post potential power practice " +
            "present president press pressure price primary private problem process produce product profit program " +
            "property public purchase purpose quality question radio rain range rate reach read reading reality " +
            "reason recipe record reference register regular release remove rent report research reserve rest " +
            "result return review rich ride rise risk road rock role room rule safe safety salt save savings scale " +
            "scene school science screen search second secret section security self sell sense series serve service " +
            "shape share shoot shopping shot show side sign simple single site situation size skill society " +
            "software soil sound soup source space special specific speed spend sport spot spread spring square " +
            "staff stage stand standard star start state statement stay step stick still stock stop store story " +
            "strategy stress structure student studio study style subject success sugar summer support system table " +
            "talk target task taste teach teacher teaching technology television tell temperature term test text " +
            "thanks theme theory thing thought time title today tonight tool topic touch tough track trade training " +
            "travel trouble truth turn type unique unit university user valuable value variety video view visit " +
            "visual voice wait walk wall watch water wealth weather week western while white whole will wind wing " +
            "woman wood word work working world worry worth writing year young").split(" ");

    public static void main(String[] args)
    {
        var hashes = calculateHashes();
        var texts = List.of(
                getMnemonicsAsJson(hashes.get(9).get(10)),
                getMnemonicsAsJson(hashes.get(9).get(9)),
                getMnemonicsAsJson(hashes.get(9).get(8)),
                getMnemonicsAsJson(hashes.get(9).get(7)),
                getMnemonicsAsJson(hashes.get(9).get(6)),
                getMnemonicsAsJson(hashes.get(9).get(5)),
                getMnemonicsAsJson(hashes.get(9).get(4)),
                getMnemonicsAsJson(hashes.get(9).get(3)),
                getMnemonicsAsJson(hashes.get(9).get(2)),
                getMnemonicsAsJson(hashes.get(9).get(1)),
                getMnemonicsAsJson(hashes.get(9).get(0)),
                getMnemonicsAsJson(hashes.get(8).get(4)),
                getMnemonicsAsJson(hashes.get(8).get(3)),
                getMnemonicsAsJson(hashes.get(8).get(2)),
                getMnemonicsAsJson(hashes.get(8).get(1)),
                getMnemonicsAsJson(hashes.get(8).get(0)),
                getMnemonicsAsJson(hashes.get(7).get(2)),
                getMnemonicsAsJson(hashes.get(7).get(1)),
                getMnemonicsAsJson(hashes.get(7).get(0)),
                getMnemonicsAsJson(hashes.get(6).get(2)),
                getMnemonicsAsJson(hashes.get(6).get(1)),
                getMnemonicsAsJson(hashes.get(6).get(0)),
                getMnemonicsAsJson(hashes.get(5).get(1)),
                getMnemonicsAsJson(hashes.get(5).get(0)),
                getMnemonicsAsJson(hashes.get(4).get(1)),
                getMnemonicsAsJson(hashes.get(4).get(0)),
                getMnemonicsAsJson(hashes.get(3).get(1)),
                getMnemonicsAsJson(hashes.get(3).get(0)),
                getMnemonicsAsJson(hashes.get(2).get(1)),
                getMnemonicsAsJson(hashes.get(2).get(0)),
                getMnemonicsAsJson(hashes.get(1).get(1)),
                getMnemonicsAsJson(hashes.get(1).get(0)));
        var json = "[ " + String.join(", ", texts) + " ]";
        System.out.println(json);
    }

    public static String getMnemonicsAsJson(String[] words)
    {
        return '"' + words[0] + ' ' + words[1] + ' ' + words[2] + ' ' + words[3] + '"';
    }

    public static List<? extends List<String[]>> calculateHashes()
    {
        var step = 0;
        var multipliers = getPowersOf31(12);
        var hashes = IntStream.range(0, 10).mapToObj(e -> new ArrayList<String[]>()).toList();
        for (var w : MNEMONIC_ARRAY)
        {
            for (var x : MNEMONIC_ARRAY)
            {
                for (var y : MNEMONIC_ARRAY)
                {
                    for (var z : MNEMONIC_ARRAY)
                    {
                        var hash = w.hashCode() * 31;
                        hash = (hash + ' ') * multipliers[x.length()] + x.hashCode() * 31;
                        hash = (hash + ' ') * multipliers[y.length()] + y.hashCode() * 31;
                        hash = (hash + ' ') * multipliers[z.length()] + z.hashCode() * 31;
                        if (hash > 0 && hash < 10)
                        {
                            hashes.get(hash).add(new String[]{w, x, y, z});
                        }
                    }
                }
            }
            System.out.printf("(%d / %d)\n", ++step, MNEMONIC_ARRAY.length);
        }
        return hashes;
    }

    public static int[] getPowersOf31(int length)
    {
        var multiplier = 1;
        var result = new int[length];
        for (var i = 0; i < length; ++i)
        {
            multiplier *= 31;
            result[i] = multiplier;
        }
        return result;
    }
}
