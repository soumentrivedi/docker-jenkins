#!/bin/bash
set -e
source /build/buildconfig
set -x

# CPAN search is unreliable
# https://metacpan.org/about/faq
# However to edit the hosts file we need to do this dirty hack.
# It will be fixed by Docker in a soon to arrive fix (30/6/2014)
cp /etc/hosts /tmp/hosts
echo -e "\
\n#Added DJL to get around search.cpan.org being down.
46.43.35.68 search.cpan.org\n\
46.43.35.68 cpansearch.perl.org\n\
" >> /tmp/hosts

mkdir -p -- /lib-override && cp /lib/x86_64-linux-gnu/libnss_files.so.2 /lib-override
perl -pi -e 's:/etc/hosts:/tmp/hosts:g' /lib-override/libnss_files.so.2
export LD_LIBRARY_PATH="/lib-override"
export PERL_CPANM_OPT="--mirror http://cpan.mirrors.uk2.net/"