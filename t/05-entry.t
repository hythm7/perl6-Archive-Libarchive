#!/usr/bin/env perl6

use Test;
use lib 'lib';
use Archive::Libarchive;
use Archive::Libarchive::Constants;

my Archive::Libarchive::Entry $e1 .= new: operation => LibarchiveWrite;
is $e1.entry.defined, True, 'Create entry';
lives-ok { $e1.pathname('test.tar.gz') }, 'Set entry pathname';
$e1.free;
is $e1.entry.defined, False, 'Free entry';
my Archive::Libarchive::Entry $e2 .= new;
throws-like
  { $e2.pathname('test.tar.gz') },
  X::Libarchive,
  message => /'Read-only entry'/,
  'Set pathname on read-only entry fails';

done-testing;