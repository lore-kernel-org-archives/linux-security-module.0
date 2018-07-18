From: p.sawicki2@partner.samsung.com (Piotr Sawicki)
Date: Wed, 18 Jul 2018 12:39:27 +0200
Subject: [PATCH v2 RFC] Smack: Inform peer that IPv6 traffic has been blocked
References: <CGME20180718103931eucas1p2123762ecf523ccdcd0caf9e62803ce62@eucas1p2.samsung.com>
Message-ID: <20180718103931eucas1p2123762ecf523ccdcd0caf9e62803ce62~CcF2zNG0N3142931429eucas1p2q@eucas1p2.samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In this patch we're sending an ICMPv6 message to a peer to
immediately inform it that making a connection is not possible.
In case of TCP connections, without this change, the peer
will be waiting until a connection timeout is exceeded.

Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>
---
  security/smack/smack_lsm.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c2282ac..efa81bc 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -28,6 +28,7 @@
  #include <linux/tcp.h>
  #include <linux/udp.h>
  #include <linux/dccp.h>
+#include <linux/icmpv6.h>
  #include <linux/slab.h>
  #include <linux/mutex.h>
  #include <linux/pipe_fs_i.h>
@@ -4010,6 +4011,9 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
  #ifdef SMACK_IPV6_PORT_LABELING
  		rc = smk_ipv6_port_check(sk, &sadd, SMK_RECEIVING);
  #endif /* SMACK_IPV6_PORT_LABELING */
+		if (rc != 0)
+			icmpv6_send(skb, ICMPV6_DEST_UNREACH,
+					ICMPV6_ADM_PROHIBITED, 0);
  		break;
  #endif /* CONFIG_IPV6 */
  	}
-- 
2.7.4
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
