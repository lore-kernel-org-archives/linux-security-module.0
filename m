From: p.sawicki2@partner.samsung.com (Piotr Sawicki)
Date: Mon, 9 Jul 2018 14:37:27 +0200
Subject: [PATCH RFC] Smack: Fix handling of IPv4 traffic received by
	PF_INET6 sockets
References: <CGME20180709123728eucas1p2e80949d219441dced3b0ab58e73315ce@eucas1p2.samsung.com>
Message-ID: <20180709123728eucas1p2e80949d219441dced3b0ab58e73315ce~-s5SM65Kc0595005950eucas1p2U@eucas1p2.samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

A socket which has sk_family set to PF_INET6 is able to recevie not
only IPv6 but also IPv4 traffic (IPv4-mapped IPv6 addresses).

Prior to this patch, the smk_skb_to_addr_ipv6() could have been
called for socket buffers containing IPv4 packets, in result such
traffic was allowed.

Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>
---
  security/smack/smack_lsm.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 19de675..a6b4c2e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3924,15 +3924,20 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
      struct smack_known *skp = NULL;
      int rc = 0;
      struct smk_audit_info ad;
+    u16 family = sk->sk_family;
  #ifdef CONFIG_AUDIT
      struct lsm_network_audit net;
  #endif
  #if IS_ENABLED(CONFIG_IPV6)
      struct sockaddr_in6 sadd;
      int proto;
+
+    if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP)) {
+        family = PF_INET;
+    }
  #endif /* CONFIG_IPV6 */

-    switch (sk->sk_family) {
+    switch (family) {
      case PF_INET:
  #ifdef CONFIG_SECURITY_SMACK_NETFILTER
          /*
-- 
2.7.4
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
