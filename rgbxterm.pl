#!/usr/bin/perl
use strict;
use Term::ExtendedColor;
use Term::ExtendedColor::Xresources;
use Getopt::Long;


our($opt_tty, $opt_html);

@ARGV or $opt_tty++;
GetOptions(
  term  => \$opt_tty,
  html  => \$opt_html,
);

output();

sub output {
  my $c = get_xterm_colors( [0 .. 255] );

  my $end = int(256/16);

  if($opt_html) {
    open(my $fh, '>', "$0.html") or die("Cant open $0.html for writing: $!");
    select($fh);
    print << "EOF";
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <title>Xterm colors</title>
  <meta http-equiv="content-type"
    content="text/html;charset=utf-8" />
</head>

<body>
<h1>
<p style="background: #121212">
EOF
  }

  print "<body bgcolor=\"#121212\">";
  for my $index(sort{$a <=> $b} (keys(%{ $c }))) {
    if($opt_html) {
      printf("<font color=\"#ff1b00\"><h4>xterm index </h4><h1>%s</h1><h4> have RGB values %s",
        "<font color=\"#"
          . $c->{$index}->{rgb}
          . "\">$index</font>",
          "<font color=\"#"
          . $c->{$index}->{rgb}
          . "\">"
          . $c->{$index}->{rgb}
          . "</font>",

          $c->{$index}->{rgb},
        );
      print "<br><strong>----<br></strong>";
      }
    else {
      print fg('bold', sprintf("%3d ", $index)),
        fg($index, $c->{$index}->{rgb}), "\n";
    }
  }
  print "</h1></p></hody></html>\n" if $opt_html;
}
