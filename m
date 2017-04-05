From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 5 Apr 2017 14:54:11 -0700
Subject: [PATCH RFC 09/11] netlabel agreement checking
In-Reply-To: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
Message-ID: <21a11f67-bd72-d4eb-81bf-bd0e2b61b3d7@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH RFC 09/11] netlabel agreement checking

If multiple security modules are using netlabel
to pass security attributes they must agree on the
labeling for each packet. Because a module may
decide on the labeling based on a number of factors
the check needs to be done at send time.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 include/linux/lsm_hooks.h    |  5 +++-
 include/net/netlabel.h       |  8 +++++++
 net/netlabel/netlabel_kapi.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 security/security.c          | 23 ++++++++++++++++++-
 security/selinux/hooks.c     |  7 +++++-
 security/smack/smack_lsm.c   |  4 +++-
 security/tomoyo/tomoyo.c     |  3 ++-
 7 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6b0ede2..d848a0a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,8 @@
 #include <linux/init.h>
 #include <linux/rculist.h>
 
+struct netlbl_lsm_secattr;
+
 /**
  * Security hooks for program execution operations.
  *
@@ -789,6 +791,7 @@
  *	@sock contains the socket structure.
  *	@msg contains the message to be transmitted.
  *	@size contains the size of message.
+ *	@attrs points to the network attributes on return.
  *	Return 0 if permission is granted.
  * @socket_recvmsg:
  *	Check permission before receiving a message from a socket.
@@ -1584,7 +1587,7 @@ union security_list_options {
 	int (*socket_listen)(struct socket *sock, int backlog);
 	int (*socket_accept)(struct socket *sock, struct socket *newsock);
 	int (*socket_sendmsg)(struct socket *sock, struct msghdr *msg,
-				int size);
+				int size, struct netlbl_lsm_secattr **attrs);
 	int (*socket_recvmsg)(struct socket *sock, struct msghdr *msg,
 				int size, int flags);
 	int (*socket_getsockname)(struct socket *sock);
diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 8cdd2d6..3cda2f3 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -472,6 +472,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 			  u32 offset,
 			  unsigned long bitmap,
 			  gfp_t flags);
+bool netlbl_secattr_equal(const struct netlbl_lsm_secattr *secattr_a,
+			  const struct netlbl_lsm_secattr *secattr_b);
 
 /* Bitmap functions
  */
@@ -623,6 +625,12 @@ static inline int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 {
 	return 0;
 }
+static inline bool netlbl_secattr_equal(
+				const struct netlbl_lsm_secattr *secattr_a,
+				const struct netlbl_lsm_secattr *secattr_b)
+{
+	return true;
+}
 static inline int netlbl_enabled(void)
 {
 	return 0;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index cb8a2c7..5692d92 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1461,6 +1461,60 @@ int netlbl_cache_add(const struct sk_buff *skb, u16 family,
 	return -ENOMSG;
 }
 
+/**
+ * netlbl_secattr_equal - Compare two lsm secattrs
+ * @secattr_a: one security attribute
+ * @secattr_b: the other security attribute
+ *
+ * Description:
+ * Compare two lsm security attribute structures. Returns true
+ * if they are the same, false otherwise.
+ *
+ */
+bool netlbl_secattr_equal(const struct netlbl_lsm_secattr *secattr_a,
+			  const struct netlbl_lsm_secattr *secattr_b)
+{
+	struct netlbl_lsm_catmap *iter_a;
+	struct netlbl_lsm_catmap *iter_b;
+
+	if (secattr_a == secattr_b)
+		return true;
+	if (!secattr_a || !secattr_b)
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_SECID) &&
+	    (secattr_b->flags & NETLBL_SECATTR_SECID))
+		return secattr_a->attr.secid.common ==
+			secattr_b->attr.secid.common;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_LVL) !=
+	    (secattr_b->flags & NETLBL_SECATTR_MLS_LVL))
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_LVL) &&
+	    secattr_a->attr.mls.lvl != secattr_b->attr.mls.lvl)
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_CAT) !=
+	    (secattr_b->flags & NETLBL_SECATTR_MLS_CAT))
+		return false;
+
+	iter_a = secattr_a->attr.mls.cat;
+	iter_b = secattr_b->attr.mls.cat;
+
+	while (iter_a && iter_b) {
+		if (iter_a->startbit != iter_b->startbit)
+			return false;
+		if (memcmp(iter_a->bitmap, iter_b->bitmap,
+					sizeof(iter_a->bitmap)))
+			return false;
+		iter_a = iter_a->next;
+		iter_b = iter_b->next;
+	}
+
+	return !iter_a && !iter_b;
+}
+
 /*
  * Protocol Engine Functions
  */
diff --git a/security/security.c b/security/security.c
index 35ccc81..5cf3214 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,6 +28,7 @@
 #include <linux/msg.h>
 #include <net/flow.h>
 #include <net/sock.h>
+#include <net/netlabel.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -2134,7 +2135,27 @@ int security_socket_accept(struct socket *sock, struct socket *newsock)
 
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
-	return call_int_hook(socket_sendmsg, 0, sock, msg, size);
+	struct security_hook_list *hp;
+	int rc;
+	struct netlbl_lsm_secattr *pattrs = NULL;
+	struct netlbl_lsm_secattr *attrs = NULL;
+
+	list_for_each_entry(hp, &security_hook_heads.socket_sendmsg, list) {
+		rc = hp->hook.socket_sendmsg(sock, msg, size, &attrs);
+		if (rc)
+			return rc;
+		/*
+		 * Only do the check if the current module reports
+		 * an attribute, and there is something to compare it to.
+		 */
+		if (attrs) {
+			if (!pattrs)
+				pattrs = attrs;
+			else if (!netlbl_secattr_equal(pattrs, attrs))
+				return -EACCES;
+		}
+	}
+	return 0;
 }
 
 int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d5c8868..6c493b8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4437,8 +4437,13 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 }
 
 static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
-				  int size)
+				  int size, struct netlbl_lsm_secattr **attrs)
 {
+#ifdef CONFIG_NETLABEL
+	struct sk_security_struct *sksec = selinux_sock(sock->sk);
+
+	*attrs = sksec->nlbl_secattr;
+#endif
 	return sock_has_perm(sock->sk, SOCKET__WRITE);
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0034365..7c8ffe4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3635,7 +3635,7 @@ static int smack_unix_may_send(struct socket *sock, struct socket *other)
  * For IPv6 this is a check against the label of the port.
  */
 static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
-				int size)
+				int size, struct netlbl_lsm_secattr **attrs)
 {
 	struct sockaddr_in *sip = (struct sockaddr_in *) msg->msg_name;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -3647,6 +3647,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 #endif
 	int rc = 0;
 
+	*attrs = NULL;
 	/*
 	 * Perfectly reasonable for this to be NULL
 	 */
@@ -3656,6 +3657,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	switch (sock->sk->sk_family) {
 	case AF_INET:
 		rc = smack_netlabel_send(sock->sk, sip);
+		*attrs = &ssp->smk_out->smk_netlabel;
 		break;
 	case AF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 27f1198..914eab3 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -499,11 +499,12 @@ static int tomoyo_socket_bind(struct socket *sock, struct sockaddr *addr,
  * @sock: Pointer to "struct socket".
  * @msg:  Pointer to "struct msghdr".
  * @size: Size of message.
+ * @attrs: unused
  *
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
-				 int size)
+				 int size, struct netlbl_lsm_secattr **attrs)
 {
 	return tomoyo_socket_sendmsg_permission(sock, msg, size);
 }
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
