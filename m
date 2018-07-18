From: p.sawicki2@partner.samsung.com (Piotr Sawicki)
Date: Wed, 18 Jul 2018 09:01:46 +0200
Subject: [PATCH v2 RFC] Smack: Fix handling of IPv4 traffic received by
	PF_INET6 sockets
References: <CGME20180718070149eucas1p1786f17e073ca72ae39a62bd4e82aa778@eucas1p1.samsung.com>
Message-ID: <20180718070149eucas1p1786f17e073ca72ae39a62bd4e82aa778~CZHyDgs-U0818808188eucas1p1c@eucas1p1.samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

A socket which has sk_family set to PF_INET6 is able to receive not
only IPv6 but also IPv4 traffic (IPv4-mapped IPv6 addresses).

Prior to this patch, the smk_skb_to_addr_ipv6() could have been
called for socket buffers containing IPv4 packets, in result such
traffic was allowed.

Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>
---
  security/smack/smack_lsm.c | 14 +++++++++-----
  1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 19de675..8b6cd5a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3924,15 +3924,19 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
  	struct smack_known *skp = NULL;
  	int rc = 0;
  	struct smk_audit_info ad;
+	u16 family = sk->sk_family;
  #ifdef CONFIG_AUDIT
  	struct lsm_network_audit net;
  #endif
  #if IS_ENABLED(CONFIG_IPV6)
  	struct sockaddr_in6 sadd;
  	int proto;
+
+	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
+		family = PF_INET;
  #endif /* CONFIG_IPV6 */

-	switch (sk->sk_family) {
+	switch (family) {
  	case PF_INET:
  #ifdef CONFIG_SECURITY_SMACK_NETFILTER
  		/*
@@ -3950,7 +3954,7 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
  		 */
  		netlbl_secattr_init(&secattr);

-		rc = netlbl_skbuff_getattr(skb, sk->sk_family, &secattr);
+		rc = netlbl_skbuff_getattr(skb, family, &secattr);
  		if (rc == 0)
  			skp = smack_from_secattr(&secattr, ssp);
  		else
@@ -3963,7 +3967,7 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
  #endif
  #ifdef CONFIG_AUDIT
  		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-		ad.a.u.net->family = sk->sk_family;
+		ad.a.u.net->family = family;
  		ad.a.u.net->netif = skb->skb_iif;
  		ipv4_skb_to_auditdata(skb, &ad.a, NULL);
  #endif
@@ -3977,7 +3981,7 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
  		rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
  					MAY_WRITE, rc);
  		if (rc != 0)
-			netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
+			netlbl_skbuff_err(skb, family, rc, 0);
  		break;
  #if IS_ENABLED(CONFIG_IPV6)
  	case PF_INET6:
@@ -3993,7 +3997,7 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
  			skp = smack_net_ambient;
  #ifdef CONFIG_AUDIT
  		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-		ad.a.u.net->family = sk->sk_family;
+		ad.a.u.net->family = family;
  		ad.a.u.net->netif = skb->skb_iif;
  		ipv6_skb_to_auditdata(skb, &ad.a, NULL);
  #endif /* CONFIG_AUDIT */
-- 
2.7.4
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
