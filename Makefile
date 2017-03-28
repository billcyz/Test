

ERLC=$(shell which erlc)
ERLCFLAGS=-o
SRCDIR=src
##LOGDIR=/var/log/mysoftware
##LOGDIR=$(SRCDIR)/mysoftware
##CONFDIR=/etc/mysoftware
LOGDIR=./knk_log
CONFDIR=./knk_config
BEAMDIR=./ebin

all:
	@ mkdir -p $(BEAMDIR) ;
	@ $(ERLC) $(ERLCFLAGS) $(BEAMDIR) $(SRCDIR)/*.erl ;
	@ mkdir -p $(CONFDIR) ;
	@ mkdir -p $(LOGDIR) ;
	##@ cp conf/mysoftware.conf $(CONFDIR)/mysoftware.conf-example
	
clean:
	@ rm -rf $(BEAMDIR) ;
	@ rm -rf $(LOGDIR) ;
	@ rm -rf $(CONFDIR) ;
	@ rm -rf erl_crush.dump