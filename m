From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 27 Oct 2017 14:45:32 -0700
Subject: [PATCH 9/9] LSM: Full security module stacking
In-Reply-To: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
References: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
Message-ID: <6a6b3895-5aae-1ef8-d515-2974e0b7d636@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH 9/9] LSM: Full security module stacking

Allow any combination of existing security modules,
including those using secids and security marked networking.

The interfaces used by filesystems to maintain security
attributes:
	security_inode_setsecctx
	security_inode_getsecctx
	security_inode_notifysecctx
have been trained to keep a full set of attributes
using the "lsm1='data1',lsm2='data2'" format.

A sockopt interface has been added to identify which
security module should be invoked when secids are
translated to secctx and back. If none is specified the
first module will be used. This eliminates the ambiguity
of what data will be seen in user-space at the cost of
requiring user-space code to be explicit about what it
wants to see.

Issues remain with the use of netlabel, as SELinux and
Smack use the interfaces differently.

Audit has not been fully tested, and may not always
be providing the correct security module information.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/include/uapi/asm/socket.h    |   2 +
 arch/frv/include/uapi/asm/socket.h      |   2 +
 arch/ia64/include/uapi/asm/socket.h     |   2 +
 arch/m32r/include/uapi/asm/socket.h     |   2 +
 arch/mips/include/uapi/asm/socket.h     |   2 +
 arch/mn10300/include/uapi/asm/socket.h  |   2 +
 arch/parisc/include/uapi/asm/socket.h   |   2 +
 arch/s390/include/uapi/asm/socket.h     |   2 +
 arch/sparc/include/uapi/asm/socket.h    |   2 +
 arch/xtensa/include/uapi/asm/socket.h   |   2 +
 fs/xattr.c                              |   2 +-
 include/linux/security.h                |  35 ++-
 include/net/scm.h                       |   3 +-
 include/uapi/asm-generic/socket.h       |   2 +
 kernel/audit.c                          |  16 +-
 kernel/auditsc.c                        |   4 +-
 kernel/cred.c                           |   2 +-
 net/core/sock.c                         |   4 +
 net/ipv4/ip_sockglue.c                  |   8 +-
 net/netfilter/nf_conntrack_netlink.c    |   9 +-
 net/netfilter/nf_conntrack_standalone.c |   2 +-
 net/netfilter/nfnetlink_queue.c         |   3 +-
 net/netfilter/xt_SECMARK.c              |   2 +-
 net/netlabel/netlabel_unlabeled.c       |  12 +-
 net/netlabel/netlabel_user.c            |   2 +-
 security/Kconfig                        |  52 +----
 security/security.c                     | 378 ++++++++++++++++++++++++++++----
 security/selinux/hooks.c                |   4 +
 security/smack/smack_lsm.c              |  18 +-
 29 files changed, 456 insertions(+), 122 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index c6133a045352..3089e9a35a2b 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -111,4 +111,6 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/frv/include/uapi/asm/socket.h b/arch/frv/include/uapi/asm/socket.h
index 9abf02d6855a..77c671cd0b81 100644
--- a/arch/frv/include/uapi/asm/socket.h
+++ b/arch/frv/include/uapi/asm/socket.h
@@ -104,5 +104,7 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif /* _ASM_SOCKET_H */
 
diff --git a/arch/ia64/include/uapi/asm/socket.h b/arch/ia64/include/uapi/asm/socket.h
index 002eb85a6941..6c0ebb0ff56e 100644
--- a/arch/ia64/include/uapi/asm/socket.h
+++ b/arch/ia64/include/uapi/asm/socket.h
@@ -113,4 +113,6 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif /* _ASM_IA64_SOCKET_H */
diff --git a/arch/m32r/include/uapi/asm/socket.h b/arch/m32r/include/uapi/asm/socket.h
index e268e51a38d1..58e36a070ea2 100644
--- a/arch/m32r/include/uapi/asm/socket.h
+++ b/arch/m32r/include/uapi/asm/socket.h
@@ -104,4 +104,6 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif /* _ASM_M32R_SOCKET_H */
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 6c755bc07975..d2c700015a8b 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -122,4 +122,6 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/mn10300/include/uapi/asm/socket.h b/arch/mn10300/include/uapi/asm/socket.h
index ac82a3f26dbf..4906db01d5db 100644
--- a/arch/mn10300/include/uapi/asm/socket.h
+++ b/arch/mn10300/include/uapi/asm/socket.h
@@ -104,4 +104,6 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif /* _ASM_SOCKET_H */
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 3b2bf7ae703b..54ba5e44ab89 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -103,4 +103,6 @@
 
 #define SO_ZEROCOPY		0x4035
 
+#define SO_LSMSEC		0x4036
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/s390/include/uapi/asm/socket.h b/arch/s390/include/uapi/asm/socket.h
index a56916c83565..48b4e0b835df 100644
--- a/arch/s390/include/uapi/asm/socket.h
+++ b/arch/s390/include/uapi/asm/socket.h
@@ -110,4 +110,6 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif /* _ASM_SOCKET_H */
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index b2f5c50d0947..d97aa57a5987 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -100,6 +100,8 @@
 
 #define SO_ZEROCOPY		0x003e
 
+#define SO_LSMSEC		0x003f
+
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		0x5001
 #define SO_SECURITY_ENCRYPTION_TRANSPORT	0x5002
diff --git a/arch/xtensa/include/uapi/asm/socket.h b/arch/xtensa/include/uapi/asm/socket.h
index 220059999e74..6f3f257d6fdd 100644
--- a/arch/xtensa/include/uapi/asm/socket.h
+++ b/arch/xtensa/include/uapi/asm/socket.h
@@ -115,4 +115,6 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif	/* _XTENSA_SOCKET_H */
diff --git a/fs/xattr.c b/fs/xattr.c
index 4424f7fecf14..61cd28ba25f3 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -250,7 +250,7 @@ xattr_getsecurity(struct inode *inode, const char *name, void *value,
 	}
 	memcpy(value, buffer, len);
 out:
-	security_release_secctx(buffer, len);
+	kfree(buffer);
 out_noalloc:
 	return len;
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 3a70b23a7dcc..8e06d9614736 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -410,8 +410,10 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secid_to_secctx(const char *lsm, u32 secid, char **secdata,
+			     u32 *seclen);
+int security_secctx_to_secid(const char *lsm, const char *secdata, u32 seclen,
+			     u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1185,14 +1187,14 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(const char *lsm, u32 secid,
+					   char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int security_secctx_to_secid(const char *secdata,
-					   u32 seclen,
-					   u32 *secid)
+static inline int security_secctx_to_secid(const char *lsm, const char *secdata,
+					   u32 seclen, u32 *secid)
 {
 	return -EOPNOTSUPP;
 }
@@ -1241,6 +1243,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
+int security_socket_passed_lsm(struct socket *sock, char __user *optval,
+				      unsigned int optlen);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
@@ -1263,6 +1267,7 @@ int security_tun_dev_create(void);
 int security_tun_dev_attach_queue(void *security);
 int security_tun_dev_attach(struct sock *sk, void *security);
 int security_tun_dev_open(void *security);
+char *security_socket_lsm(const struct sock *sk);
 
 #else	/* CONFIG_SECURITY_NETWORK */
 static inline int security_unix_stream_connect(struct sock *sock,
@@ -1362,12 +1367,21 @@ static inline int security_sock_rcv_skb(struct sock *sk,
 	return 0;
 }
 
-static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-						    int __user *optlen, unsigned len)
+static inline int security_socket_getpeersec_stream(struct socket *sock,
+						    char __user *optval,
+						    int __user *optlen,
+						    unsigned len)
 {
 	return -ENOPROTOOPT;
 }
 
+static inline int security_socket_passed_lsm(struct socket *sock,
+					     char __user *optval,
+					     unsigned int optlen)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
 	return -ENOPROTOOPT;
@@ -1455,6 +1469,11 @@ static inline int security_tun_dev_open(void *security)
 {
 	return 0;
 }
+
+static inline char *security_socket_lsm(const struct sock *sk)
+{
+	return NULL;
+}
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
diff --git a/include/net/scm.h b/include/net/scm.h
index 142ea9e7a6d0..4783ba64773b 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -95,7 +95,8 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
+		err = security_secid_to_secctx(security_socket_lsm(sock->sk),
+						scm->secid, &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index e47c9e436221..c5ed101d0be1 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -106,4 +106,6 @@
 
 #define SO_ZEROCOPY		60
 
+#define SO_LSMSEC		61
+
 #endif /* __ASM_GENERIC_SOCKET_H */
diff --git a/kernel/audit.c b/kernel/audit.c
index be1c28fd4d57..e4a016ce9580 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1374,7 +1374,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
 		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+			err = security_secid_to_secctx(NULL, audit_sig_sid, &ctx, &len);
 			if (err)
 				return err;
 		}
@@ -2107,7 +2107,7 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (n->osid != 0) {
 		char *ctx = NULL;
 		u32 len;
-		if (security_secid_to_secctx(
+		if (security_secid_to_secctx(NULL,
 			n->osid, &ctx, &len)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
@@ -2153,7 +2153,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!sid)
 		return 0;
 
-	error = security_secid_to_secctx(sid, &ctx, &len);
+	error = security_secid_to_secctx(NULL, sid, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
@@ -2339,21 +2339,25 @@ void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
 
 #ifdef CONFIG_SECURITY
 /**
- * audit_log_secctx - Converts and logs SELinux context
+ * audit_log_secctx - Converts and logs security context
  * @ab: audit_buffer
  * @secid: security number
  *
  * This is a helper function that calls security_secid_to_secctx to convert
- * secid to secctx and then adds the (converted) SELinux context to the audit
+ * secid to secctx and then adds the (converted) security context to the audit
  * log by calling audit_log_format, thus also preventing leak of internal secid
  * to userspace. If secid cannot be converted audit_panic is called.
+ *
+ * Note: There is not sufficient information in the input to
+ * determine which security module the caller is interested in
+ * in the multiple security module case.
  */
 void audit_log_secctx(struct audit_buffer *ab, u32 secid)
 {
 	u32 len;
 	char *secctx;
 
-	if (security_secid_to_secctx(secid, &secctx, &len)) {
+	if (security_secid_to_secctx(NULL, secid, &secctx, &len)) {
 		audit_panic("Cannot convert secid to context");
 	} else {
 		audit_log_format(ab, " obj=%s", secctx);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ecc23e25c9eb..6427e1956345 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -984,7 +984,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+		if (security_secid_to_secctx(NULL, sid, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1200,7 +1200,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 		if (osid) {
 			char *ctx = NULL;
 			u32 len;
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
+			if (security_secid_to_secctx(NULL, osid, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
diff --git a/kernel/cred.c b/kernel/cred.c
index fa2061ee4955..f6b067259b6d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -671,7 +671,7 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	u32 secid;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
+	ret = security_secctx_to_secid(NULL, secctx, strlen(secctx), &secid);
 	if (ret < 0)
 		return ret;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 9b7b6bbb2a23..f585833fe52d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -849,6 +849,10 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 			clear_bit(SOCK_PASSCRED, &sock->flags);
 		break;
 
+	case SO_LSMSEC:
+		ret = security_socket_passed_lsm(sock, optval, optlen);
+		break;
+
 	case SO_TIMESTAMP:
 	case SO_TIMESTAMPNS:
 		if (valbool)  {
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a599aa83fdad..b8d6c519592f 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -125,7 +125,8 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 	put_cmsg(msg, SOL_IP, IP_CHECKSUM, sizeof(__wsum), &csum);
 }
 
-static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
+static void ip_cmsg_recv_security(const struct sock *sk, struct msghdr *msg,
+				  struct sk_buff *skb)
 {
 	char *secdata;
 	u32 seclen, secid;
@@ -135,7 +136,8 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(secid, &secdata, &seclen);
+	err = security_secid_to_secctx(security_socket_lsm(sk),
+					secid, &secdata, &seclen);
 	if (err)
 		return;
 
@@ -213,7 +215,7 @@ void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 	}
 
 	if (flags & IP_CMSG_PASSSEC) {
-		ip_cmsg_recv_security(msg, skb);
+		ip_cmsg_recv_security(sk, msg, skb);
 
 		flags &= ~IP_CMSG_PASSSEC;
 		if (!flags)
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index de4053d84364..c758f4b1f9c3 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -316,7 +316,12 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	int len, ret;
 	char *secctx;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	if (skb && skb->sk)
+		ret = security_secid_to_secctx(security_socket_lsm(skb->sk),
+					ct->secmark, &secctx, &len);
+	else
+		ret = security_secid_to_secctx(NULL, ct->secmark, &secctx,
+						&len);
 	if (ret)
 		return 0;
 
@@ -564,7 +569,7 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 #ifdef CONFIG_NF_CONNTRACK_SECMARK
 	int len, ret;
 
-	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
+	ret = security_secid_to_secctx(NULL, ct->secmark, NULL, &len);
 	if (ret)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 5a101caa3e12..b1760cb790ee 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -182,7 +182,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	u32 len;
 	char *secctx;
 
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	ret = security_secid_to_secctx(NULL, ct->secmark, &secctx, &len);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index c9796629858f..8687a11dd0d7 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -292,7 +292,8 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark)
-		security_secid_to_secctx(skb->secmark, secdata, &seclen);
+		security_secid_to_secctx(security_socket_lsm(skb->sk),
+						skb->secmark, secdata, &seclen);
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
 #endif
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 9faf5e050b79..d2e1bf037111 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -56,7 +56,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
-	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
+	err = security_secctx_to_secid(NULL, info->secctx, strlen(info->secctx),
 				       &info->secid);
 	if (err) {
 		if (err == -EINVAL)
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 22dc1b9d6362..93a526d028c1 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -451,7 +451,7 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(secid,
+		if (security_secid_to_secctx(NULL, secid,
 					     &secctx,
 					     &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
@@ -508,7 +508,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 		if (dev != NULL)
 			dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(NULL, entry->secid,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -569,7 +569,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 		if (dev != NULL)
 			dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(entry->secid,
+		    security_secid_to_secctx(NULL, entry->secid,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -915,7 +915,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
-	ret_val = security_secctx_to_secid(
+	ret_val = security_secctx_to_secid(NULL,
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  &secid);
@@ -964,7 +964,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
-	ret_val = security_secctx_to_secid(
+	ret_val = security_secctx_to_secid(NULL,
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  &secid);
@@ -1141,7 +1141,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		secid = addr6->secid;
 	}
 
-	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
+	ret_val = security_secid_to_secctx(NULL, secid, &secctx, &secctx_len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 58495f44c62a..45c9b3a192fd 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -113,7 +113,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
+	    security_secid_to_secctx(NULL, audit_info->secid,
 				     &secctx,
 				     &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
diff --git a/security/Kconfig b/security/Kconfig
index a14d50b45b6c..d09eb11ae608 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -292,60 +292,30 @@ endmenu
 menu "Security Module Stack"
 	visible if SECURITY_STACKING
 
-choice
-	prompt "Stacked 'extreme' security module"
-	default SECURITY_SELINUX_STACKED if SECURITY_SELINUX
-	default SECURITY_SMACK_STACKED if SECURITY_SMACK
-	default SECURITY_APPARMOR_STACKED if SECURITY_APPARMOR
-
-	help
-	  Enable an extreme security module. These modules cannot
-	  be used at the same time.
-
-	config SECURITY_SELINUX_STACKED
-		bool "SELinux" if SECURITY_SELINUX=y
+config SECURITY_SELINUX_STACKED
+	bool "SELinux" if SECURITY_SELINUX=y
 	help
 	  This option instructs the system to use the SELinux checks.
-	  At this time the Smack security module is incompatible with this
-	  module.
-	  At this time the AppArmor security module is incompatible with this
-	  module.
 
-	config SECURITY_SMACK_STACKED
-		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
+config SECURITY_SMACK_STACKED
+	bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
 	help
 	  This option instructs the system to use the Smack checks.
-	  At this time the SELinux security module is incompatible with this
-	  module.
-	  At this time the AppArmor security module is incompatible with this
-	  module.
 
-	config SECURITY_APPARMOR_STACKED
-		bool "AppArmor" if SECURITY_APPARMOR=y
+config SECURITY_APPARMOR_STACKED
+	bool "AppArmor" if SECURITY_APPARMOR=y
 	help
 	  This option instructs the system to use the AppArmor checks.
-	  At this time the SELinux security module is incompatible with this
-	  module.
-	  At this time the Smack security module is incompatible with this
-	  module.
-
-	config SECURITY_NOTHING_STACKED
-		bool "Use no 'extreme' security module"
-	help
-	  Use none of the SELinux, Smack or AppArmor security module.
-
-endchoice
 
 config SECURITY_TOMOYO_STACKED
-	bool "TOMOYO support is enabled by default"
-	depends on SECURITY_TOMOYO && SECURITY_STACKING
-	default n
+	bool "TOMOYO" if SECURITY_TOMOYO=y
 	help
 	  This option instructs the system to use the TOMOYO checks.
-	  If not selected the module will not be invoked.
-	  Stacked security modules may interact in unexpected ways.
 
-	  If you are unsure how to answer this question, answer N.
+config SECURITY_NOTHING_STACKED
+	bool "Use no 'extreme' security module"
+	help
+	  Use none of the SELinux, Smack or AppArmor security modules.
 
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 7a004006e761..fbf64b5a9848 100644
--- a/security/security.c
+++ b/security/security.c
@@ -31,7 +31,12 @@
 #include <net/flow.h>
 #include <net/sock.h>
 
-#define MAX_LSM_EVM_XATTR	2
+/*
+ * This should depend on the number of security modules
+ * that use extended attributes. At this writing it is
+ * at least EVM, SELinux and Smack.
+ */
+#define MAX_LSM_EVM_XATTR	8
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
@@ -171,7 +176,7 @@ static int lsm_append(char *new, char **result)
 
 /**
  * security_module_enable - Load given security module on boot ?
- * @module: the name of the module
+ * @lsm: the name of the module
  * @stacked: indicates that the module wants to be stacked
  *
  * Each LSM must pass this method before registering its own operations
@@ -333,7 +338,14 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	lsm_set_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_size(&needed->lbs_key, &blob_sizes.lbs_key);
 	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	/*
+	 * The socket blob gets the name of the security module
+	 * passed in SO_PEERSEC as well as the module data.
+	 */
+	if (needed->lbs_sock && blob_sizes.lbs_sock == 0)
+		blob_sizes.lbs_sock = SECURITY_NAME_MAX + 2;
 	lsm_set_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
+
 	lsm_set_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 	/*
@@ -507,10 +519,6 @@ int lsm_msg_msg_alloc(struct msg_msg *mp)
  */
 int lsm_sock_alloc(struct sock *sock, gfp_t priority)
 {
-#ifdef CONFIG_SECURITY_LSM_DEBUG
-	if (sock->sk_security)
-		pr_info("%s: Inbound sock blob is not NULL.\n", __func__);
-#endif
 	if (blob_sizes.lbs_sock == 0)
 		return 0;
 
@@ -520,6 +528,16 @@ int lsm_sock_alloc(struct sock *sock, gfp_t priority)
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_NETWORK
+char *security_socket_lsm(const struct sock *sk)
+{
+	if (sk)
+		return sk->sk_security;
+	return NULL;
+}
+EXPORT_SYMBOL(security_socket_lsm);
+#endif
+
 /**
  * lsm_superblock_alloc - allocate a composite superblock blob
  * @sb: the superblock that needs a blob
@@ -773,7 +791,7 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 {
 	int nobody = 0;
 
-#ifdef SECURITY_EXTREME_STACKING
+#ifdef CONFIG_SECURITY_STACKING
 	if (opts->selinux.num_mnt_opts != 0 || opts->smack.num_mnt_opts != 0)
 		nobody = -EOPNOTSUPP;
 #else
@@ -859,9 +877,10 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
-	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
+	struct security_hook_list *hp;
+	struct xattr xattrs[MAX_LSM_EVM_XATTR + 1];
+	int rc = -EOPNOTSUPP;
+	int attrn = 0;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -869,24 +888,41 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!initxattrs)
 		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
 				     dir, qstr, NULL, NULL, NULL);
-	memset(new_xattrs, 0, sizeof(new_xattrs));
-	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
-	if (ret)
+
+	memset(xattrs, 0, sizeof(xattrs));
+
+	list_for_each_entry(hp, &security_hook_heads.inode_init_security,
+									list) {
+		rc = hp->hook.inode_init_security(inode, dir, qstr,
+						  &xattrs[attrn].name,
+						  &xattrs[attrn].value,
+						  &xattrs[attrn].value_len);
+		/*
+		 * If the module doesn't support this, reuse the entry.
+		 * If it's a real error, bail out of the loop.
+		 */
+		if (rc == -EOPNOTSUPP)
+			rc = 0;
+		else if (rc)
+			break;
+		else
+			attrn++;
+	}
+	if (rc)
 		goto out;
 
-	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
-	if (ret)
+	/*
+	 * Should EVM loop on these?
+	 * Do the first one until it's sorted out.
+	 */
+	rc = evm_inode_init_security(inode, &xattrs[0], &xattrs[attrn]);
+	if (rc)
 		goto out;
-	ret = initxattrs(inode, new_xattrs, fs_data);
+	rc = initxattrs(inode, xattrs, fs_data);
 out:
-	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
-		kfree(xattr->value);
-	return (ret == -EOPNOTSUPP) ? 0 : ret;
+	for (; attrn >= 0; attrn--)
+		kfree(xattrs[attrn].value);
+	return (rc == -EOPNOTSUPP) ? 0 : rc;
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
@@ -1114,18 +1150,22 @@ int security_inode_getattr(const struct path *path)
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	struct security_hook_list *hp;
+	int ret = -ENOSYS;
+	int trc;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_setxattr, 1, dentry, name, value, size,
-				flags);
 
-	if (ret == 1)
+	list_for_each_entry(hp, &security_hook_heads.inode_setxattr, list) {
+		trc = hp->hook.inode_setxattr(dentry, name, value, size, flags);
+		if (trc != -ENOSYS) {
+			ret = trc;
+			break;
+		}
+	}
+
+	if (ret == -ENOSYS)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
 	if (ret)
 		return ret;
@@ -1790,7 +1830,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	list_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -1803,7 +1843,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	list_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
@@ -1821,25 +1861,25 @@ int security_ismaclabel(const char *name)
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+int security_secid_to_secctx(const char *lsm, u32 secid, char **secdata,
+			     u32 *seclen)
 {
 #ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
-	int rc = -EOPNOTSUPP;
+	int rc;
 
 	lsm_token_to_secids(secid, &secids);
 
-	/*
-	 * Return the first result regardless.
-	 */
 	list_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
+			continue;
 		rc = hp->hook.secid_to_secctx(secids.secid[hp->lsm_index],
 						secdata, seclen);
 		if (rc != -EOPNOTSUPP)
-			break;
+			return rc;
 	}
-	return rc;
+	return -EOPNOTSUPP;
 #else
 	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
 				seclen);
@@ -1847,7 +1887,8 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *lsm, const char *secdata, u32 seclen,
+			     u32 *secid)
 {
 #ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
@@ -1857,6 +1898,8 @@ int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 	lsm_secids_init(&secids);
 
 	list_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
+			continue;
 		rc = hp->hook.secctx_to_secid(secdata, seclen,
 						&secids.secid[hp->lsm_index]);
 		if (rc)
@@ -1874,7 +1917,11 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	kfree(secdata);
+#else
 	call_void_hook(release_secctx, secdata, seclen);
+#endif
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -1884,21 +1931,223 @@ void security_inode_invalidate_secctx(struct inode *inode)
 }
 EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
+#ifdef CONFIG_SECURITY_STACKING
+struct lsm_value {
+	char *lsm;
+	char *data;
+};
+
+/**
+ * lsm_parse_context - break a compound "context" into module data
+ * @cxt: the initial data, which will be modified
+ * @vlist: an array to receive the results
+ *
+ * Returns the number of entries, or -EINVAL if the cxt is unworkable.
+ */
+static int lsm_parse_context(char *cxt, struct lsm_value *vlist)
+{
+	char *lsm;
+	char *data;
+	char *cp;
+	int i;
+
+	lsm = cxt;
+	for (i = 0; i < LSM_MAX_MAJOR; i++) {
+		data = strstr(lsm, "='");
+		if (!data)
+			break;
+		*data = '\0';
+		data += 2;
+		cp = strchr(data, '\'');
+		if (!cp)
+			return -EINVAL;
+		*cp++ = '\0';
+		vlist[i].lsm = lsm;
+		vlist[i].data = data;
+		if (*cp == '\0') {
+			i++;
+			break;
+		}
+		if (*cp == ',')
+			cp++;
+		else
+			return -EINVAL;
+		lsm = cp;
+	}
+	return i;
+}
+#endif /* CONFIG_SECURITY_STACKING */
+
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_value *lsm_value;
+	char *temp;
+	int count;
+	int rc = 0;
+
+	if (!ctx || !ctxlen)
+		return -EACCES;
+
+	lsm_value = kzalloc(sizeof(*lsm_value) * LSM_MAX_MAJOR, GFP_KERNEL);
+	if (!lsm_value)
+		return -ENOMEM;
+
+	temp = kmemdup(ctx, ctxlen + 1, GFP_KERNEL);
+	if (!temp) {
+		rc = -ENOMEM;
+		goto free_out;
+	}
+	temp[ctxlen] = '\0';
+
+	count = lsm_parse_context(temp, lsm_value);
+	if (count <= 0) {
+		rc = -EINVAL;
+		goto free_out;
+	}
+
+	for (count--; count >= 0; count--) {
+		list_for_each_entry(hp,
+				    &security_hook_heads.inode_notifysecctx,
+									list) {
+			if (!strcmp(hp->lsm, lsm_value[count].lsm)) {
+				rc = hp->hook.inode_notifysecctx(inode,
+						lsm_value[count].data,
+						strlen(lsm_value[count].data));
+				break;
+			}
+		}
+		if (rc)
+			break;
+	}
+
+free_out:
+	kfree(lsm_value);
+	kfree(temp);
+	return rc;
+#else
 	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+#endif
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
+/**
+ * security_inode_setsecctx - set the LSM security attribute(s) on an inode
+ * @dentry: the directory entry containing the inode
+ * @ctx: the security attributes, in text form
+ * @ctxlen: the length of the attributes
+ *
+ * This should only be called by filesystems for the purpose
+ * of setting attributes in an LSM agnositic way. The @ctx
+ * value should never be externally supplied.
+ *
+ * Returns 0 on success and LSM defined errors.
+ */
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_value *lsm_value;
+	char *temp;
+	int count;
+	int rc = 0;
+
+	lsm_value = kzalloc(sizeof(*lsm_value) * LSM_MAX_MAJOR, GFP_KERNEL);
+	if (!lsm_value)
+		return -ENOMEM;
+
+	temp = kmemdup(ctx, ctxlen + 1, GFP_KERNEL);
+	if (!temp) {
+		rc = -ENOMEM;
+		goto free_out;
+	}
+	temp[ctxlen] = '\0';
+
+	count = lsm_parse_context(temp, lsm_value);
+	if (count <= 0) {
+		rc = -EINVAL;
+		goto free_out;
+	}
+
+	for (count--; count >= 0; count--) {
+		list_for_each_entry(hp, &security_hook_heads.inode_setsecctx,
+									list) {
+			if (!strcmp(hp->lsm, lsm_value[count].lsm)) {
+				rc = hp->hook.inode_setsecctx(dentry,
+						lsm_value[count].data,
+						strlen(lsm_value[count].data));
+				break;
+			}
+		}
+		if (rc)
+			break;
+	}
+
+free_out:
+	kfree(lsm_value);
+	kfree(temp);
+	return rc;
+#else
 	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+#endif
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
+/**
+ * security_inode_getsecctx - get the LSM security attribute(s) of an inode
+ * @inode: the inode
+ * @ctx: the fetched security attributes, in text form
+ * @ctxlen: the length of the fetched attributes
+ *
+ * This should only be called by filesystems for the purpose
+ * of getting attributes in an LSM agnositic way. The @ctx
+ * value should never be externally exposed.
+ *
+ * Returns 0 on success and LSM defined errors.
+ */
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char *value = NULL;
+	void *vp;
+	char *cp;
+	u32 tlen;
+	int trc;
+	int rc = -EOPNOTSUPP;
+
+	list_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		trc = hp->hook.inode_getsecctx(inode, &vp, &tlen);
+		if (trc < 0) {
+			kfree(value);
+			return trc;
+		}
+		rc = trc;
+		if (value == NULL) {
+			value = kasprintf(GFP_KERNEL, "%s='%s'", hp->lsm,
+						(char *)vp);
+			kfree(vp);
+			if (value == NULL)
+				return -ENOMEM;
+		} else {
+			cp = kasprintf(GFP_KERNEL, "%s,%s='%s'", value,
+					hp->lsm, (char *)vp);
+			kfree(vp);
+			kfree(value);
+			if (cp == NULL)
+				return -ENOMEM;
+			value = cp;
+		}
+	}
+	if (!rc) {
+		*ctxlen = strlen(value);
+		*ctx = value;
+	}
+	return rc;
+#else
 	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+#endif
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
@@ -1993,8 +2242,39 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char *lsm = security_socket_lsm(sock->sk);
+	int rc;
+
+	list_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+									list) {
+		if (lsm && lsm[0] && strcmp(lsm, hp->lsm))
+			continue;
+		rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
+							len);
+		if (rc != -ENOPROTOOPT)
+			return rc;
+	}
+	return -ENOPROTOOPT;
+#else
 	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
 				optval, optlen, len);
+#endif
+}
+
+int security_socket_passed_lsm(struct socket *sock, char __user *optval,
+				unsigned int optlen)
+{
+	char *lsm = security_socket_lsm(sock->sk);
+	long reallen;
+
+	if (optlen > SECURITY_NAME_MAX)
+		return -EINVAL;
+
+	reallen = strncpy_from_user(lsm, optval, optlen);
+	lsm[reallen] = '\0';
+	return 0;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
@@ -2003,16 +2283,24 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 #ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
+	char *lsm = NULL;
 	int rc = -ENOPROTOOPT;
+	int trc;
+
+	if (skb && skb->sk)
+		lsm = security_socket_lsm(skb->sk);
+	else if (sock && sock->sk)
+		lsm = security_socket_lsm(sock->sk);
 
 	lsm_secids_init(&secids);
 
 	list_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
 									list) {
-		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
+		trc = hp->hook.socket_getpeersec_dgram(sock, skb,
 						&secids.secid[hp->lsm_index]);
-		if (rc)
-			break;
+		if ((!lsm || !lsm[0] || !strcmp(lsm, hp->lsm)) &&
+		    trc != -ENOPROTOOPT)
+			rc = trc;
 	}
 
 	if (!rc)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 395fbfa7bfac..544fa3041592 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5928,10 +5928,12 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 	return security_context_to_sid(secdata, seclen, secid, GFP_KERNEL);
 }
 
+#ifndef CONFIG_SECURITY_STACKING
 static void selinux_release_secctx(char *secdata, u32 seclen)
 {
 	kfree(secdata);
 }
+#endif
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
@@ -6230,7 +6232,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
+#ifndef CONFIG_SECURITY_STACKING
 	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
+#endif
 	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9fb9148cf4b5..d53ff04c49e1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1421,7 +1421,10 @@ static int smack_inode_getsecurity(struct inode *inode,
 	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
 		isp = smk_of_inode(inode);
 		ilen = strlen(isp->smk_known);
-		*buffer = isp->smk_known;
+		if (alloc)
+			*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
+		else
+			*buffer = isp->smk_known;
 		return ilen;
 	}
 
@@ -1447,7 +1450,10 @@ static int smack_inode_getsecurity(struct inode *inode,
 
 	ilen = strlen(isp->smk_known);
 	if (rc == 0) {
-		*buffer = isp->smk_known;
+		if (alloc)
+			*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
+		else
+			*buffer = isp->smk_known;
 		rc = ilen;
 	}
 
@@ -4361,8 +4367,16 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	struct smack_known *skp = smack_from_secid(secid);
 
+#ifdef CONFIG_SECURITY_STACKING
+	if (secdata) {
+		*secdata = kstrdup(skp->smk_known, GFP_KERNEL);
+		if (*secdata == NULL)
+			return -ENOMEM;
+	}
+#else
 	if (secdata)
 		*secdata = skp->smk_known;
+#endif
 	*seclen = strlen(skp->smk_known);
 	return 0;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
