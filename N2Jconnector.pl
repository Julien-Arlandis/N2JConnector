#! /usr/bin/perl

use strict; use warnings; use LWP::UserAgent; use JSON;

my $DOMAIN = 'test.domain';
my $USER_AGENT	= "N2JConnector/0.1";
my (@query, $res);

@query = ("diffuse", {(
		"Propose" => {(
			"DataType" => "NetNews",
			"DataID" => "xxxx"
			)},
		"From" => $DOMAIN
		)}
);

$res = execJNTP("devnews.nemoweb.net", \@query);

if($res->{'code'} eq "500") {
	@query = ("diffuse", {(
			"Data" => {(
				"DataType" => "NetNews",
				"DataID" => "hhhhh",
				"Body" => getArticle()
				)},
			"From" => $DOMAIN
			)}
	);
}

$res = execJNTP("devnews.nemoweb.net", \@query);
print $res->{'code'}."\n".$res->{'body'}."\n";


sub execJNTP {
	my $req = HTTP::Request->new(POST => "http://".$_[0]."/jntp/");
	$req->header('content-type' => 'application/json');
	$req->content(encode_json($_[1]));
	return decode_json(LWP::UserAgent->new( agent => $USER_AGENT)->request($req)->content);
}

sub getArticle {
	open (my $art, '<', 'article.txt') or die "unable to open file";
	my $article = '';
	while (<$art>) { $article .= $_; } close $art;
	return $article;
}

