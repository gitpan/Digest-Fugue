use strict;
use warnings;
use Test::More tests => 68;
use Digest::Fugue qw(fugue_512 fugue_512_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::Fugue->new(512)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            fugue_512_hex($data), $digest,
            "fugue_512_hex: $len bits of $msg"
        );
        ok(
            fugue_512($data) eq pack('H*', $digest),
            "fugue_512: $len bits of $msg"
        );
    }

    my $md = Digest::Fugue->new(512)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

__DATA__
00|3124F0CBB5A1C2FB3CE747ADA63ED2AB3BCD74795CEF2B0E805D5319FCC360B4617B6A7EB631D66F6D106ED0724B56FA8C1110F9B8DF1C6898E7CA3C2DFCCF79
00|F8499BAFAC2D562817D1B9DDA8DFCAC7DCB13BB533B9C34CC026F3F7AF808366C9C129FEC525FF9859AE39B7F1B49523E9BAC2DD8AFEFFC8F62C931127E43FE8
C0|584468A827A1FC47C4F32C5C591D15B4739929A276C4FE927251A155EFA64948D09C4B15B68FF06E40C9861D3C536A7BCCD2DCC51509B1EE1E20E619961A5F0C
C0|615E911FAC702F5BAA83AD0F885C11C28D6718B7840361B81AD5BC41CCDBD7E9EA1904D278E5A00136A2139A4F94FEA94FE9A6B8161DAB957FA7443EE3D19E46
80|D46719E3C558BF47AF31182A431262CBB31CC6F630474DBE472292029FF5533EEE2669AF041E28C9234369781E105F975D49E34069B959B7C00798E1DCDA2A5A
48|7043E22B4E514E2BEB6A7A980AF1593B3B811D96B3EA0874A0E3EBDA92CA4FCCF0A69745793E5FFF9A5212EDAB9F87EEC8C4921C70EC42B295258437DE7FF410
50|61E5A7032228B3A4BE934F091C7044F496AA78EFA042EE2D458DF7A2DAE8358F40B664263B9D65010996F5B9E9E63E3F8E40C32EDE5E22893B5002ACB0EEC451
98|921560B7F68360B231875D6E838F072E419E2E5312DE0D39F8F4EF5FFF612C7B6ACAC2E0C8097FBD6691CB9CC8DCA599F44399201CB794373E75D5E2C0A9CC9C
CC|2EF4115479B060FC64A4D6F6913A39E326AFC81DEB4E39D71C573DF5ED132200E7C784BAB1804930CAD16847F16CBDA59A865BBD928EBC17D33689FEF233C10B
9800|951CC56EA6D7B15C80E7D93274AD69744A1EF7C5621C181478C09B3A9577DEF313838572896FB9E62CB610D3E482845B768DEE28E741ED18B96DB9286D3916B4
9D40|320C97A71C5A79457829003678D88693D095484FD55C22F876DDDBF8A3273C97299BF99A6B31FCB261B1C91F4302F37F0B7D59508478000727CAB10DCAD74380
AA80|B15DA184D830A76546DADDD38F68E4C8DE7AEEDA9E7FDE1B0E46FF13AA5AA73BED2930A22FBA977A03FDF4B33D77C0B320657C93CE776CC20486EDA7959242A6
9830|4E70F4F8C61EBAE38FB821BBC34E679A18914ACEFBA66C3590211D0C3673975567FBD7B7251688B63D0161D10F4EA2BC68A3F04FDC28E6A69960D00DF28434EC
5030|9EF9D5432AEBD7CF17BE55F75F7A22FD2E3BB1672A1C8CA2060163AB6C8DE6E067B980087EC6C40C09CE35FF1F97BB00E0341A32F167C5E6FE18122DD3091462
4D24|20F5DFF5D46C2099AC3D30C99C067B3EA837C1CFF230273580B00DC09C7A0460E30447A99ADB44DA12372AA226C67BF52F45533B74688F751B1F491FDCEF3273
CBDE|58C9920266A1F0ED52B9F9E65783C1884B68B9CA794B26708FF2F5CEB2C3E33263F9C7301E9BF94AA990B8B39364286D5675BA9099F7726430AD6F40D9DE2785
41FB|F42D0817EF7FE50AFEC87CDD1B934D16BFB575DF4FEDA7E65D09B592B0318920D9B1D1F89BDFF9AA4C6AB5F058D692AB0D5D431E860F6AC6BE70F47AB124ABD8
4FF400|84DA518423C3E0D7283C7A446F34939F33E6E686547A7D6BC4C6893023C981B73CB2B91E5FEABED8CB0C4C415413964699A8B305D92C100526E9AD5018FCEEB7
FD0440|90BE918CFABD6F479BC574DC175084B9B098D774EDDB8FFE8D4153399963FCE97D019267F3CC9FE7583864A566528C90F6B46427103F49A4C223E654FF71C904
424D00|8279D8B5C919D5F870681BED1E4E2E3E9395DECD80D238896E290B0EC0A77FF9DB1C032E19085E264B9EF3AB5A80E3C66FA0BCD56980370F32445D2612114BFC
3FDEE0|EECBA8D3B37A5F9FDC1705EAC3A0906F9896A3D4AADBD74397B52A2286EEA65AE5B0168D42D0AFC19EAA3BB122AA7DEA5D46CDE919B3D82C498B73811EEF3FE1
335768|B86ACFCCA5D963C75D9C7F6C5FA28B8D30BFCA00D12BE4CAB744F0C0D8D44A619C32FFD5911CA0AF1C9517E8226C19277640FF0F22005EFE8F8B05AE05BAF5E2
051E7C|5559CF945E5E6FD5AECC6156C655E81C2FE19BC7DD6B6893584D811E0BDAEADF791A70A333C591C90E86CC32699BA75A0041FB433E69016C5427B25ED7ACA6BD
717F8C|5003FB803A5D6CE3ED0F306F34EA9BFFE8A71F4B0815E6CE706A758968CBFB9F242F88BA2A8FF13DB404AA29BF61DF336C803F8862F9247D75109BC81774AB9D
1F877C|DEEA1A90BF692F13974943E0CEEB551CF94903BDE784278FB52A2B61750D093AB4EB662EDB36FFC3C184CE753621173928E5FA58F7DF7449D8888A56F238D936
EB35CF80|478DAEE4EA34E8FE698E705359AAD05CEFC73AA6B52B65941E0854DA299FAF393267F2E2DA24514B4C2AED8D27F4DE7C0762B023DB6B5AAF07B0F74EB1D20676
B406C480|E83EB5DD12E8450361344C187DFF3ACB36EB5441754069E8322569B052C1F7959CC6C2C5F543DD7CB38428C954DFB769ED66A2BD17838E124902B764B51BC108
CEE88040|E76E1EBAB7CB0704044A79EF9A61BFFCFDD7DC5CAC68BAEAD9CA08E16B87990CA6DD0C7A8CD04F30154E122F7E0C99BAF0458045EA6A68C8A89E6F233DB8ACE0
C584DB70|62A1A7D50824BCF7A82D1D23A6A62A5FA0E4ACC0DA99A314CFCA3DE9E7F2D288F38C9E84CF450DB9B1967741BE90785521541834C86B4B97EBB093733B39D742
53587BC8|C7C72422F7C90860ED1DF3823C0A2810C950865FFF33EAD86139A3CA1EC9A0C88AA949A51A123520E219363270E1F1D6AB269C83E1CBF204C9D1C65C32EA2EE0
69A305B0|DCF7DC2A179DA707099977A433CE81D01C5A382B1B311276D4DDA05880D779D7D0AC375D444551879E5401309EC8B88108B10F6C32907A1CB33B3C3CFA5DCFDA
C9375ECE|F051A9B3D97C241BA0E2557E1FAA06686A3ECA60808FE070D3B80DC3B86C058CE0307B5F12E8C2FB52A9D305BFAE504FC0F08B71CD00A5DE8ACE9AB7233AA289
C1ECFDFC|016A26BED81A1AF68DC64E4089878B89C660AC5FAA61FCF9F4EDA88B5FD62E4786B66E295B94992887E0BB95BF802C4C35AADA89D5C2F77ECC4D6FC7546114B6
8D73E8A280|EF614A3F1983CCCDB73EFF9716B300CDDABCC735582EBE0B3F1ABF05FCB0BB1079871930872606E252C6BCA076E6005A5BCD5C59B0E1E8DFE0FB2158E3100448
06F2522080|CACA1649892F57DC8457D0541F2F81D6C99B4D554CEF92E771D2B0996E9637884504740EDB50070E5744D256076981FCE9401C4E33767913401C5EBCFFCD8FD2
3EF6C36F20|07A6309AE3181BDEED1BCB8787B8E67277A03B1E302E6749726EC0F5091E80F9F5B1D4E562E4586A273E107A2FAA5E4CC0163235964C421425C69EBFEF3D8A91
0127A1D340|CCD11D4C7014797EDCC62D9CD897989034F9385B39AA6EFD62CA6F41CDE4E07BC095CED01705C2644EFB7558963FAD1DC08ED4F6E513E35131AD0805944109A2
6A6AB6C210|F19D5E1A1C9131579C1025616FB51690777C0D7752AD36D0E643FED649D15A2E5DC71B91CC2FF923C2F070528132E00E43EEB437258CC3806B98D353467BF44E
AF3175E160|CF22BA0555B29D7B550EAC9A3262EB95D98F48136BBB97F6BAFDE9E425E49D4D1BA1631329B9090BD8B859FFC0FEE0048A2B615C1DA7BF31FF6EF4A868C9522F
B66609ED86|6D5863BF1CADF51BA5EF7C1F4BDB520B1D5BA059D36030C6DE6B8073A0EDA7265E56C30F5F18FF1D94F8D118611C394836277E82922D070757D6366BB04D146A
21F134AC57|DFED15E291C38285AB66277BD772726F63C07080111571932006C3AB7B448414CC13402D3AD25EB75021826FE8FBDA01C390DB1FB26F282C831E9E72D0D54391
3DC2AADFFC80|D9BA951A2BDE972730033BCAC63BD7A38993455AFD21565F330984D9E9C0DC8AB74EF65D814EBF62EAE7F867770482928BFDB7E6110FF0D711DE8C4A7FD5BEBF
9202736D2240|DF5C12F02F20DF95C4B73939D91B977906BB366D85B416F1CC8DD40B70EA384AEC005A479C62EDFB4F7C0635F756BD1D9DE32A5C7E6A7D158AC782537F6600EA
F219BD629820|AB329DAAC453859327A4D3D679CE6F9D697C9DCFA71152AEBBEFAC15A66C457137D9B55B8D5CC60A65C80333DAFECEBF770876DCF7677468F7FA719A960B1596
F3511EE2C4B0|95907BC639E0B910F1A16D837EF9F2FB77A5F5C51150245EE29D564CF3F9128FEE47B818B23E41B7DC783A63549CB4C971C124E5CE6A690D85CBDEACE9EE0CBD
3ECAB6BF7720|74B9DBF7D521D2A69BCB3EE71A784BF74980E9581E597C0A9BD3CE981F42ECB4C29EA441687CF6C856F34AB2F4C9F6EADDEB2FA64F8EB9F9B86B385EAE40AB9A
CD62F688F498|1E92CA31A42CDCAB6347257D55CFB28F5F345B4A0DE5179C883A3D01A12727A188D1183F550E54C5CFF25CE41188034E2A66F28253DBEB0A7B304BB84553E8D4
C2CBAA33A9F8|81B94C65B61358376157AB31B389EC53F1FC70F7E6BD05A9CEB79DCFB9D992F5BEB2F21F79C5E674AAD95CEC4A09864E994514996C19959AA515B7401B373370
C6F50BB74E29|172DD6328695A30E9DBD7D6F805B43836F1003C242BE47D95D83A4F0A7BBC6D7B0E84697002FB7707FDEAA305C60ADB56A6A9B25B227A3FE16CD6602742F5125
79F1B4CCC62A00|F09B2E0E5308CFE964EFA1D3511D70F54984B531292D15843926F17EDD46ACCE4C41AB53B3A6FF9193E1D9AEECF84836FF944777826F31FA27DFF50EA7F38C22
