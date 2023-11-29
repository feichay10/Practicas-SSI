#
# Shorewall -- /etc/shorewall/snat
#
# For information about entries in this file, type "man shorewall-snat"
#
# See http://shorewall.net/manpages/shorewall-snat.html for more information
#
###########################################################################################################################################
#ACTION                 SOURCE                  DEST            PROTO   PORT    IPSEC   MARK    USER    SWITCHORIGDEST        PROBABILITY
MASQUERADE              192.168.10.0/24         ens3            all