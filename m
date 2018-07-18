From: p.sawicki2@partner.samsung.com (Piotr Sawicki)
Date: Wed, 18 Jul 2018 12:39:09 +0200
Subject: [PATCH v2 RFC] mack: Check UDP-Lite and DCCP protocols during IPv6
	handling
References: <CGME20180718103912eucas1p1bdceed080e229f29e37c1aadb10cebc1@eucas1p1.samsung.com>
Message-ID: <20180718103912eucas1p1bdceed080e229f29e37c1aadb10cebc1~CcFlYShn11831418314eucas1p1f@eucas1p1.samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The smack_socket_sock_rcv_skb() function is checking smack labels
only for UDP and TCP frames carried in IPv6 packets. From now on,
it is able also to handle UDP-Lite and DCCP protocols.

Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>
---
  security/smack/smack_lsm.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8b6cd5a..c2282ac 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3896,6 +3896,7 @@ static int smk_skb_to_addr_ipv6(struct sk_buff 
*skb, struct sockaddr_in6 *sip)
  			sip->sin6_port = th->source;
  		break;
  	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
  		uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
  		if (uh != NULL)
  			sip->sin6_port = uh->source;
@@ -3986,7 +3987,8 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
  #if IS_ENABLED(CONFIG_IPV6)
  	case PF_INET6:
  		proto = smk_skb_to_addr_ipv6(skb, &sadd);
-		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
+		if (proto != IPPROTO_UDP && proto != IPPROTO_UDPLITE &&
+		    proto != IPPROTO_TCP && proto != IPPROTO_DCCP)
  			break;
  #ifdef SMACK_IPV6_SECMARK_LABELING
  		if (skb && skb->secmark != 0)
-- 
2.7.4
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
