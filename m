From: dh.herrmann@gmail.com (David Herrmann)
Date: Mon, 23 Apr 2018 15:30:15 +0200
Subject: [PATCH 3/3] selinux: provide unix_stream_socketpair callback
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
Message-ID: <20180423133015.5455-4-dh.herrmann@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Make sure to implement the new unix_stream_socketpair callback so the
SO_PEERSEC call on socketpair(2)s will return correct information.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 security/selinux/hooks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a19167..828881d9a41d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4905,6 +4905,18 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 	return 0;
 }
 
+static int selinux_socket_unix_stream_socketpair(struct sock *socka,
+						 struct sock *sockb)
+{
+	struct sk_security_struct *sksec_a = socka->sk_security;
+	struct sk_security_struct *sksec_b = sockb->sk_security;
+
+	sksec_a->peer_sid = sksec_b->sid;
+	sksec_b->peer_sid = sksec_a->sid;
+
+	return 0;
+}
+
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
@@ -6995,6 +7007,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 
 	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
+	LSM_HOOK_INIT(unix_stream_socketpair,
+			selinux_socket_unix_stream_socketpair),
 	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
 
 	LSM_HOOK_INIT(socket_create, selinux_socket_create),
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
