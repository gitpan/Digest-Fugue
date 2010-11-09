use strict;
use warnings;
use Test::More tests => 19;
use Digest::Fugue qw(fugue_224 fugue_224_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::Fugue->new(224)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            fugue_224_hex($data), $digest,
            "fugue_224_hex: $len bits of $msg"
        );
        ok(
            fugue_224($data) eq pack('H*', $digest),
            "fugue_224: $len bits of $msg"
        );
    }
    else {
        TODO:
        eval {
            local $TODO = 'add_bits is not yet implemented';
            my $md = Digest::Fugue->new(224)->add_bits($data, $len)
                ->hexdigest;
            is($md, $digest, "new/add_bits/hexdigest: $msg");
        };
    }
}
continue { $len++ }

__DATA__
00|E2CD30D51A913C4ED2388A141F90CAA4914DE43010849E7B8A7A9CCD
00|961467B3195C979C89989BAF45A239D0D785488D1B8E3DCFA5C5D72F
C0|2B9660F86C76FB36D7C92AE905E29414AEC93EBCBA6BF5B69D7F4264
C0|776EB691737AB7397EA21A34596AA83BF3FBB507B070C0D19A049576
80|A0E753969F989B240C470F549E8D71B74364F91A6114FD43D2DFFBB4
48|FE420B37B0815ABF1A7E48EFB797F18715118A84179182DAFD4BB50F
50|AF247981F6016E071DF400799BC6EB5FDE7C97B3A4BE7A957A9AF53A
98|4C4EBF2A551C7994712D2746F757F2A2B27D80DD7A990EC290895F07
CC|34602EA95B2B9936B9A04BA14B5DC463988DF90B1A46F90DD716B60F
9800|D9AFA27E40B5768152677766E6CD4D4BAD308BC293E6AFE8E3B18207
9D40|B408E647C41DDD91B7AEAA6992EA2F02834715E8D30F47A7D695830C
AA80|0A69AAB301ADF8F6D455F31334BF959EFD1B7085DDA65A4028909851
9830|6589E9A74480DA5964EBC7B133C876B61F8658B10A6A750961A22BAF
5030|2E02AF0F071473276B6594AFDAD773F64CDD979502FAD27F429E4913
4D24|6B9C234F6AB0C9303BEB99C437C1F9530EB6A526A133511EFDCD08FF
CBDE|85EE233971940F5C5F8D7A1491904B9BFCEBDE8AA58D6D5B5B6FF0D5
41FB|17042EF3C9203A838978356CC8DEBCB90B49A7A3F9862C4C96385E2B
4FF400|6389D064D29B3D20D9FF89CF5282524AA932563626696B4A314485B5
FD0440|68AC01B86B464CA84D280133895B5CAF7786671F16A2EFB1E0338DB5
424D00|BB943D3A771382F513D33C8EE9DE4251B2F6B9D36863A9E331081A4A
3FDEE0|A5B16DCCC65BD94AF2B11FC1644D6C612CC60A6C08D17E92B784B9DB
335768|3BFE9AFE23427A637CCBA5B983F8375E2C7E11D32C4DE810381ED921
051E7C|E7F8F8F2A8EA3FFAC7D733A3D244F12EF109CE172D0170B9C4B1BCA6
717F8C|A2AA33A4F792C1C0C34BC553197C5588776D1B049541E376782C3B39
1F877C|C4E858280A095030C40CDBE1FD0044632ED28F1B85FBDE9B48BC3EFD
EB35CF80|233D76724C92CE411E4DC94297A47CF917787E45EE832D3E4E234788
B406C480|92D9C49777984DA9F78FBE9B4390B5382A8E4AF8BEBFDA56EA7EAEFC
CEE88040|E41397F3C890C88D11BC42A6A187AD216E30EFF73239BAA2C246E41E
C584DB70|CC84B92CE51CD5270113D3F339B14AC6CBF0D1ED085F240F06FFDBC0
53587BC8|C7CBEF0DDB469A02856175D09230C5F9DF7B8E4FE9425C2012B0E7D6
69A305B0|AC9CBD76FC5A10D95088032637DE90EF4D269DA8AEA3B19692CEA1FA
C9375ECE|9434D10593A9C19C0E309486D5AD7B94835A9639FFA78940F3ED0AF5
C1ECFDFC|EDFDF5A0C8B1CE7C5B7818C670C302745CB61FD4468C04BF36644497
8D73E8A280|FFBE105F2FEE7A569577E11EC70D8B5FBE1EF6CB9C2EFAF53879356D
06F2522080|D8AC409967C740BD39EB69D9E030C0FB37FD84FB0F29456E33281A27
3EF6C36F20|5DC3B1D24AC95FFAE418C95D12B66ABA466C753638FF45C0B8D9DE33
0127A1D340|C1FF9F5BD133EEFB7E88B15F2EF348A8C11C7BAEA500D63F70E5E363
6A6AB6C210|502A8D6FDE4E78B2A129BC7757AA26FA31DCBFED975FB44745DFEA26
AF3175E160|67DB60C0647A99EDF43FEC01E8D244500C4DA1ECA3D41722F9761E35
B66609ED86|6844136D87E4B80E17FE3BFAF0C76CC38DBA0A65A659BA95BF6317C8
21F134AC57|B24848F32AC54150B4F616D12870039DB2FDF026B7240EDF1846FED1
3DC2AADFFC80|626890D86E822F4F0A258246E99FBFFA916E624D3ECC3A24C78F1FEF
9202736D2240|538FD264E82E637D5DAEF91C84B912152199BEDCFCEF32870F638953
F219BD629820|F06897A3B0DFAB31A48BC785AA4349038643591A625FAC8645897FF6
F3511EE2C4B0|86626181F221EB6BE4CA31B982A14BFEBB614D0AF207489DE3206367
3ECAB6BF7720|9FC57720A22B7D3BC83A511D049BDEB0A648D811C7D07BB2E40169EE
CD62F688F498|8FC225A577384FE06EC84DBD01171DB4D4525E9A2EA6ABBAC12C6536
C2CBAA33A9F8|F44765653D39BD9D46D464381152CF4385018E916A12720FF9CFBE7A
C6F50BB74E29|74B3EAF5370935CC997DF0FF6B196906F582A951B546A3D38710E3C5
79F1B4CCC62A00|B4768211ABD6F2F8DAC25ACD71E45BF9E543921C40169B604231D886
