#! /usr/bin/perl
=pod
Copyright © 2013-2014 Julien Arlandis
    @author : Julien Arlandis <julien.arlandis_at_gmail.com>
    @Licence : http://www.gnu.org/licenses/agpl-3.0.txt

This file is part of PhpNemoServer.

    PhpNemoServer is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    PhpNemoServer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with PhpNemoServer.  If not, see <http://www.gnu.org/licenses/>.
=cut

use strict; 
use warnings; 
use LWP::UserAgent; 
use JSON;

my $DOMAIN = 'testfeed.nemoweb.net';
my $USER_AGENT	= "N2JConnector/0.1";
my ($query, $res);

sub execJNTP {
	my $req = HTTP::Request->new(POST => "http://".$_[0]."/jntp/");
	$req->header('content-type' => 'application/json');
	$req->content($_[1]);
	my $response = LWP::UserAgent->new( agent => $USER_AGENT)->request($req)->content;
	print $response."\n";
	return decode_json($response);
}

sub getArticle {
	open (my $art, '<', 'article.txt') or die "unable to open file";
	my $article = '';
	while (<$art>) { $article .= $_; } close $art;
	return $article;
}

$query = <<"EOF";
[
    "diffuse",
    {
        "Propose": [
            {
                "Data": {
                    "DataType": "NetNews",
                    "DataID": "xxxxxdfghdfgfdsgds"
                }
            }
        ],
        "From": "$DOMAIN"
    }
]
EOF

$res = execJNTP("devnews.nemoweb.net", $query);

if($res->{'code'} eq "200") {

	$query = <<"EOF";
	[
	    "diffuse",
	    {
		"Data":
		    {
	               "DataType": "NetNews",
	               "DataID": "xxxxxdfghdfgfdsgds",
	               "Body": ""
		    },
		"From": "$DOMAIN"
	    }
	]
EOF
	$query = decode_json($query);
	$query->[1]{'Data'}{'Body'} = getArticle();
	$query = encode_json($query);
	$res = execJNTP("devnews.nemoweb.net", $query);
}

