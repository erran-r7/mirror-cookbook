depends           'git'
depends           'mercurial'
description       'Configures a node as a git/hg repository mirror'
maintainer        'Rapid7'
maintainer_email  'erran_carey@rapid7.com'
name              'mirror'
license           'All rights reserved'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
recipe            'mirror::default', 'Determines what mirror recipe should be ran'
version           '0.0.1'

depends 'git'
