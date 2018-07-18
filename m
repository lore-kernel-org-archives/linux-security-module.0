From: p.sawicki2@partner.samsung.com (Piotr Sawicki)
Date: Wed, 18 Jul 2018 11:49:00 +0200
Subject: [PATCH v1 RFC] Smack: Inform peer that IPv6 traffic has been blocked
References: <CGME20180718094902eucas1p1e909c23f062782cd8b25ef8e7f4f47cb@eucas1p1.samsung.com>
Message-ID: <20180718094902eucas1p1e909c23f062782cd8b25ef8e7f4f47cb~CbZykHodt1208512085eucas1p1o@eucas1p1.samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In this patch we're sending an ICMPv6 message to a peer to
immediately inform it that making a connection is not possible.
In case of TCP connections, without this change, the peer
will be waiting until a connection timeout is exceeded.
---
  security/smack/smack_lsm.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c2282ac..cee8335 100644
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
@@ -4010,6 +4011,8 @@ static int smack_socket_sock_rcv_skb(struct sock 
*sk, struct sk_buff *skb)
  #ifdef SMACK_IPV6_PORT_LABELING
  		rc = smk_ipv6_port_check(sk, &sadd, SMK_RECEIVING);
  #endif /* SMACK_IPV6_PORT_LABELING */
+		if (rc != 0)
+			icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADM_PROHIBITED, 0);
  		break;
  #endif /* CONFIG_IPV6 */
  	}
-- 
2.7.4
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
