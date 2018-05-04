From: dh.herrmann@gmail.com (David Herrmann)
Date: Fri,  4 May 2018 16:28:22 +0200
Subject: [PATCH v2 4/4] smack: provide socketpair callback
In-Reply-To: <20180504142822.15233-1-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
Message-ID: <20180504142822.15233-5-dh.herrmann@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Tom Gundersen <teg@jklm.no>

Make sure to implement the new socketpair callback so the SO_PEERSEC
call on socketpair(2)s will return correct information.

Signed-off-by: Tom Gundersen <teg@jklm.no>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 security/smack/smack_lsm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0b414836bebd..dcb976f98df2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2842,6 +2842,27 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	return smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
 }
 
+/**
+ * smack_socket_socketpair - create socket pair
+ * @socka: one socket
+ * @sockb: another socket
+ *
+ * Cross reference the peer labels for SO_PEERSEC
+ *
+ * Returns 0 on success, and error code otherwise
+ */
+static int smack_socket_socketpair(struct socket *socka,
+		                   struct socket *sockb)
+{
+	struct socket_smack *asp = socka->sk->sk_security;
+	struct socket_smack *bsp = sockb->sk->sk_security;
+
+	asp->smk_packet = bsp->smk_out;
+	bsp->smk_packet = asp->smk_out;
+
+	return 0;
+}
+
 #ifdef SMACK_IPV6_PORT_LABELING
 /**
  * smack_socket_bind - record port binding information.
@@ -4724,6 +4745,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(unix_may_send, smack_unix_may_send),
 
 	LSM_HOOK_INIT(socket_post_create, smack_socket_post_create),
+	LSM_HOOK_INIT(socket_socketpair, smack_socket_socketpair),
 #ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(socket_bind, smack_socket_bind),
 #endif
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
