From: dh.herrmann@gmail.com (David Herrmann)
Date: Fri,  4 May 2018 16:28:21 +0200
Subject: [PATCH v2 3/4] selinux: provide socketpair callback
In-Reply-To: <20180504142822.15233-1-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
Message-ID: <20180504142822.15233-4-dh.herrmann@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Make sure to implement the new socketpair callback so the SO_PEERSEC
call on socketpair(2)s will return correct information.

Acked-by: Serge Hallyn <serge@hallyn.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Tom Gundersen <teg@jklm.no>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 security/selinux/hooks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a19167..02ebd1585eaf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4569,6 +4569,18 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	return err;
 }
 
+static int selinux_socket_socketpair(struct socket *socka,
+				     struct socket *sockb)
+{
+	struct sk_security_struct *sksec_a = socka->sk->sk_security;
+	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
+
+	sksec_a->peer_sid = sksec_b->sid;
+	sksec_b->peer_sid = sksec_a->sid;
+
+	return 0;
+}
+
 /* Range of port numbers used to automatically bind.
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
@@ -6999,6 +7011,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(socket_create, selinux_socket_create),
 	LSM_HOOK_INIT(socket_post_create, selinux_socket_post_create),
+	LSM_HOOK_INIT(socket_socketpair, selinux_socket_socketpair),
 	LSM_HOOK_INIT(socket_bind, selinux_socket_bind),
 	LSM_HOOK_INIT(socket_connect, selinux_socket_connect),
 	LSM_HOOK_INIT(socket_listen, selinux_socket_listen),
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
