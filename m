From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 27 Oct 2017 14:45:25 -0700
Subject: [PATCH 7/9] LSM: Shared secids
In-Reply-To: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
References: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
Message-ID: <2ca9a0d8-998c-10f9-cfef-9f67bb80aa26@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH 7/9] LSM: Shared secids

Introduces a mechanism for mapping a set of security
module secids to and from a "token". The module interfaces
are changed to generally hide the mechanism from both the
security modules and the callers of the security hooks.

The implementation of the lsm_token functions is functional
but not production ready. At the least, it needs locking and
lifetime management which it lacks. The versions here do
work with Ubuntu 17.04 and Fedora 27 in workstation
configurations.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h        |  43 +++++-
 include/net/request_sock.h       |   2 +
 security/Makefile                |   1 +
 security/security.c              | 292 ++++++++++++++++++++++++++++++++++++++-
 security/selinux/hooks.c         |  31 ++++-
 security/selinux/include/xfrm.h  |   2 +-
 security/selinux/xfrm.c          |   6 +-
 security/smack/smack.h           |  11 ++
 security/smack/smack_lsm.c       |  14 +-
 security/smack/smack_netfilter.c |   6 +-
 security/stacking.c              | 188 +++++++++++++++++++++++++
 11 files changed, 570 insertions(+), 26 deletions(-)
 create mode 100644 security/stacking.c

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 84643a3ae378..d49d4f3544cf 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1624,7 +1624,7 @@ union security_list_options {
 	void (*secmark_refcount_inc)(void);
 	void (*secmark_refcount_dec)(void);
 	void (*req_classify_flow)(const struct request_sock *req,
-					struct flowi *fl);
+					u32 *fl_secid);
 	int (*tun_dev_alloc_security)(void **security);
 	void (*tun_dev_free_security)(void *security);
 	int (*tun_dev_create)(void);
@@ -1660,7 +1660,7 @@ union security_list_options {
 					u8 dir);
 	int (*xfrm_state_pol_flow_match)(struct xfrm_state *x,
 						struct xfrm_policy *xp,
-						const struct flowi *fl);
+						u32 fl_secid);
 	int (*xfrm_decode_session)(struct sk_buff *skb, u32 *secid, int ckall);
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
@@ -1912,9 +1912,48 @@ struct security_hook_list {
 	struct list_head		*head;
 	union security_list_options	hook;
 	char				*lsm;
+	int				lsm_index;
 } __randomize_layout;
 
 /*
+ * The maximum number of major security modules.
+ * Used to avoid excessive memory management while
+ * mapping global and module specific secids.
+ *
+ * Currently SELinux, Smack, AppArmor, TOMOYO
+ * Oh, but Casey needs to come up with the right way
+ * to identify a "major" module, so use the total number
+ * of modules (including minor) for now.
+ * Minor: Capability, Yama, LoadPin
+ */
+#define	LSM_MAX_MAJOR	8
+
+#ifdef CONFIG_SECURITY_STACKING
+struct lsm_secids {
+	u32	secid[LSM_MAX_MAJOR];
+};
+
+extern u32 lsm_secids_to_token(const struct lsm_secids *secids);
+extern void lsm_token_to_secids(const u32 token, struct lsm_secids *secids);
+extern u32 lsm_token_get_secid(const u32 token, int lsm);
+extern u32 lsm_token_set_secid(const u32 token, u32 lsecid, int lsm);
+extern u32 lsm_token_to_module_secid(const u32 token, int lsm);
+extern void lsm_secids_init(struct lsm_secids *secids);
+#else /* CONFIG_SECURITY_STACKING */
+
+static inline u32 lsm_token_get_secid(const u32 token, int lsm)
+{
+	return token;
+}
+
+static inline u32 lsm_token_set_secid(const u32 token, u32 lsecid, int lsm)
+{
+	return lsecid;
+}
+
+#endif /* CONFIG_SECURITY_STACKING */
+
+/*
  * Security blob size or offset data.
  */
 struct lsm_blob_sizes {
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 23e22054aa60..07c0e919c4e7 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -102,6 +102,8 @@ reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
 	sk_tx_queue_clear(req_to_sk(req));
 	req->saved_syn = NULL;
 	refcount_set(&req->rsk_refcnt, 0);
+	req->secid = 0;
+	req->peer_secid = 0;
 
 	return req;
 }
diff --git a/security/Makefile b/security/Makefile
index f2d71cdb8e19..05e6d525b5a1 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
+obj-$(CONFIG_SECURITY_STACKING)		+= stacking.o
 
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
diff --git a/security/security.c b/security/security.c
index a306a5447d43..0269971b3b05 100644
--- a/security/security.c
+++ b/security/security.c
@@ -213,6 +213,11 @@ bool __init security_module_enable(const char *lsm, const bool stacked)
 #endif
 }
 
+/*
+ * Keep the order of major modules for mapping secids.
+ */
+static int lsm_next_major;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
@@ -225,9 +230,14 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm)
 {
 	int i;
+	int lsm_index = lsm_next_major++;
 
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	pr_info("LSM: Security module %s gets index %d\n", lsm, lsm_index);
+#endif
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
+		hooks[i].lsm_index = lsm_index;
 		list_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
@@ -1217,7 +1227,19 @@ EXPORT_SYMBOL(security_inode_listsecurity);
 
 void security_inode_getsecid(struct inode *inode, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.inode_getsecid, list)
+		hp->hook.inode_getsecid(inode, &secids.secid[hp->lsm_index]);
+
+	*secid = lsm_secids_to_token(&secids);
+#else
 	call_void_hook(inode_getsecid, inode, secid);
+#endif
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
@@ -1415,7 +1437,28 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_token_to_secids(secid, &secids);
+
+	list_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		/*
+		 * Not all of the security modules may have gotten
+		 * a secid when this token was created, so ignore 0.
+		 */
+		if (secids.secid[hp->lsm_index] == 0)
+			continue;
+		rc = hp->hook.kernel_act_as(new, secids.secid[hp->lsm_index]);
+		if (rc)
+			break;
+	}
+	return rc;
+#else
 	return call_int_hook(kernel_act_as, 0, new, secid);
+#endif
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
@@ -1474,8 +1517,20 @@ int security_task_getsid(struct task_struct *p)
 
 void security_task_getsecid(struct task_struct *p, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.task_getsecid, list)
+		hp->hook.task_getsecid(p, &secids.secid[hp->lsm_index]);
+
+	*secid = lsm_secids_to_token(&secids);
+#else
 	*secid = 0;
 	call_void_hook(task_getsecid, p, secid);
+#endif
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
@@ -1524,7 +1579,23 @@ int security_task_movememory(struct task_struct *p)
 int security_task_kill(struct task_struct *p, struct siginfo *info,
 			int sig, u32 secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_token_to_secids(secid, &secids);
+
+	list_for_each_entry(hp, &security_hook_heads.task_kill, list) {
+		rc = hp->hook.task_kill(p, info, sig,
+					secids.secid[hp->lsm_index]);
+		if (rc)
+			break;
+	}
+	return rc;
+#else
 	return call_int_hook(task_kill, 0, p, info, sig, secid);
+#endif
 }
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
@@ -1557,8 +1628,20 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list)
+		hp->hook.ipc_getsecid(ipcp, &secids.secid[hp->lsm_index]);
+
+	*secid = lsm_secids_to_token(&secids);
+#else
 	*secid = 0;
 	call_void_hook(ipc_getsecid, ipcp, secid);
+#endif
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
@@ -1731,15 +1814,52 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = -EOPNOTSUPP;
+
+	lsm_token_to_secids(secid, &secids);
+
+	/*
+	 * Return the first result regardless.
+	 */
+	list_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		rc = hp->hook.secid_to_secctx(secids.secid[hp->lsm_index],
+						secdata, seclen);
+		if (rc != -EOPNOTSUPP)
+			break;
+	}
+	return rc;
+#else
 	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
 				seclen);
+#endif
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		rc = hp->hook.secctx_to_secid(secdata, seclen,
+						&secids.secid[hp->lsm_index]);
+		if (rc)
+			break;
+	}
+
+	*secid = lsm_secids_to_token(&secids);
+	return rc;
+#else
 	*secid = 0;
 	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+#endif
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
@@ -1868,10 +1988,31 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = -ENOPROTOOPT;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+									list) {
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
+						&secids.secid[hp->lsm_index]);
+		if (rc)
+			break;
+	}
+
+	if (!rc)
+		*secid = lsm_secids_to_token(&secids);
+	return rc;
+#else
 	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
 			     skb, secid);
+#endif
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
@@ -1899,13 +2040,38 @@ EXPORT_SYMBOL(security_sk_clone);
 
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.sk_getsecid, list)
+		hp->hook.sk_getsecid(sk, &secids.secid[hp->lsm_index]);
+
+	fl->flowi_secid = lsm_secids_to_token(&secids);
+#else
 	call_void_hook(sk_getsecid, sk, &fl->flowi_secid);
+#endif
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
-void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
+void security_req_classify_flow(const struct request_sock *req,
+				struct flowi *fl)
 {
-	call_void_hook(req_classify_flow, req, fl);
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.req_classify_flow, list)
+		hp->hook.req_classify_flow(req, &secids.secid[hp->lsm_index]);
+
+	fl->flowi_secid = lsm_secids_to_token(&secids);
+#else
+	call_void_hook(req_classify_flow, req, &fl->flowi_secid);
+#endif
 }
 EXPORT_SYMBOL(security_req_classify_flow);
 
@@ -1936,7 +2102,24 @@ void security_inet_conn_established(struct sock *sk,
 
 int security_secmark_relabel_packet(u32 secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_token_to_secids(secid, &secids);
+
+	list_for_each_entry(hp, &security_hook_heads.secmark_relabel_packet,
+									list) {
+		rc = hp->hook.secmark_relabel_packet(
+						secids.secid[hp->lsm_index]);
+		if (rc)
+			break;
+	}
+	return rc;
+#else
 	return call_int_hook(secmark_relabel_packet, 0, secid);
+#endif
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
@@ -2054,7 +2237,24 @@ EXPORT_SYMBOL(security_xfrm_state_alloc);
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_token_to_secids(secid, &secids);
+
+	list_for_each_entry(hp, &security_hook_heads.xfrm_state_alloc_acquire,
+									list) {
+		rc = hp->hook.xfrm_state_alloc_acquire(x, polsec,
+						secids.secid[hp->lsm_index]);
+		if (rc)
+			break;
+	}
+	return rc;
+#else
 	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
+#endif
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
@@ -2070,7 +2270,23 @@ void security_xfrm_state_free(struct xfrm_state *x)
 
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_token_to_secids(fl_secid, &secids);
+
+	list_for_each_entry(hp, &security_hook_heads.xfrm_policy_lookup, list) {
+		rc = hp->hook.xfrm_policy_lookup(ctx,
+					secids.secid[hp->lsm_index], dir);
+		if (rc)
+			break;
+	}
+	return rc;
+#else
 	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
+#endif
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
@@ -2078,6 +2294,9 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       const struct flowi *fl)
 {
 	struct security_hook_list *hp;
+#ifdef CONFIG_SECURITY_STACKING
+	struct lsm_secids secids;
+#endif
 	int rc = 1;
 
 	/*
@@ -2089,9 +2308,18 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
+#ifdef CONFIG_SECURITY_STACKING
+	lsm_token_to_secids(fl->flowi_secid, &secids);
+#endif
+
 	list_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
-		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
+									list) {
+#ifdef CONFIG_SECURITY_STACKING
+		rc = hp->hook.xfrm_state_pol_flow_match(x, xp,
+				secids.secid[hp->lsm_index]);
+#else
+		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl->flowi_secid);
+#endif
 		break;
 	}
 	return rc;
@@ -2099,15 +2327,51 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.xfrm_decode_session,
+									list) {
+		rc = hp->hook.xfrm_decode_session(skb,
+					&secids.secid[hp->lsm_index], 1);
+		if (rc)
+			break;
+	}
+	if (!rc)
+		*secid = lsm_secids_to_token(&secids);
+	return rc;
+#else
 	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
+#endif
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.xfrm_decode_session,
+									list) {
+		rc = hp->hook.xfrm_decode_session(skb,
+					&secids.secid[hp->lsm_index], 0);
+		if (rc)
+			break;
+	}
+	BUG_ON(rc);
+	fl->flowi_secid = lsm_secids_to_token(&secids);
+#else
 	int rc = call_int_hook(xfrm_decode_session, 0, skb, &fl->flowi_secid,
 				0);
-
 	BUG_ON(rc);
+#endif
 }
 EXPORT_SYMBOL(security_skb_classify_flow);
 
@@ -2166,7 +2430,23 @@ void security_audit_rule_free(void *lsmrule)
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 			      struct audit_context *actx)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_token_to_secids(secid, &secids);
+
+	list_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		rc = hp->hook.audit_rule_match(secids.secid[hp->lsm_index],
+						field, op, lsmrule, actx);
+		if (rc)
+			break;
+	}
+	return rc;
+#else
 	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
 				actx);
+#endif
 }
 #endif /* CONFIG_AUDIT */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a3466517c55c..e6d6ab671493 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -100,6 +100,9 @@
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
+/* Index into lsm_secids */
+static int selinux_secids_index;
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing;
 
@@ -4617,6 +4620,11 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 			    SECCLASS_NODE, NODE__RECVFROM, ad);
 }
 
+static u32 selinux_token_to_secid(u32 token)
+{
+	return lsm_token_get_secid(token, selinux_secids_index);
+}
+
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
@@ -4636,7 +4644,9 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		err = avc_has_perm(sk_sid,
+				   selinux_token_to_secid(skb->secmark),
+				   SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -4710,7 +4720,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		err = avc_has_perm(sk_sid,
+				   selinux_token_to_secid(skb->secmark),
+				   SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -4909,9 +4921,9 @@ static void selinux_secmark_refcount_dec(void)
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
-				      struct flowi *fl)
+				      u32 *fl_secid)
 {
-	fl->flowi_secid = req->secid;
+	*fl_secid = req->secid;
 }
 
 static int selinux_tun_dev_alloc_security(void **security)
@@ -5073,7 +5085,8 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+		if (avc_has_perm(peer_sid,
+				 selinux_token_to_secid(skb->secmark),
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
@@ -5185,7 +5198,8 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->sid, skb->secmark,
+		if (avc_has_perm(sksec->sid,
+				 selinux_token_to_secid(skb->secmark),
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -5308,7 +5322,8 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+		if (avc_has_perm(peer_sid,
+				 selinux_token_to_secid(skb->secmark),
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -6328,6 +6343,8 @@ static __init int selinux_init(void)
 
 	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
 
+	selinux_secids_index = selinux_hooks[0].lsm_index;
+
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
 
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 36a7ce9e11ff..0235b0cfd0ce 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -25,7 +25,7 @@ int selinux_xfrm_state_delete(struct xfrm_state *x);
 int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
 int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				      struct xfrm_policy *xp,
-				      const struct flowi *fl);
+				      u32 fl_secid);
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 extern atomic_t selinux_xfrm_refcount;
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 789d07bd900f..d71e2c32b5da 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -174,7 +174,7 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
  */
 int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				      struct xfrm_policy *xp,
-				      const struct flowi *fl)
+				      u32 fl_secid)
 {
 	u32 state_sid;
 
@@ -196,13 +196,13 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 
 	state_sid = x->security->ctx_sid;
 
-	if (fl->flowi_secid != state_sid)
+	if (fl_secid != state_sid)
 		return 0;
 
 	/* We don't need a separate SA Vs. policy polmatch check since the SA
 	 * is now of the same label as the flow and a flow Vs. policy polmatch
 	 * check had already happened in selinux_xfrm_policy_lookup() above. */
-	return (avc_has_perm(fl->flowi_secid, state_sid,
+	return (avc_has_perm(fl_secid, state_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO,
 			    NULL) ? 0 : 1);
 }
diff --git a/security/smack/smack.h b/security/smack/smack.h
index e7611de071f1..b16846e3d1f1 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -328,6 +328,7 @@ void smk_destroy_label_list(struct list_head *list);
  * Shared data.
  */
 extern int smack_enabled;
+extern int smack_secids_index;
 extern int smack_cipso_direct;
 extern int smack_cipso_mapped;
 extern struct smack_known *smack_net_ambient;
@@ -432,6 +433,16 @@ static inline struct smack_known **smack_key(const struct key *key)
 }
 #endif /* CONFIG_KEYS */
 
+static inline u32 smack_token_to_secid(u32 token)
+{
+	return lsm_token_get_secid(token, smack_secids_index);
+}
+
+static inline u32 smack_to_token(u32 token, u32 secid)
+{
+	return lsm_token_set_secid(token, secid, smack_secids_index);
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e3f32f4d322a..9031f2dc8bfb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -57,6 +57,7 @@ static LIST_HEAD(smk_ipv6_port_list);
 #endif
 static struct kmem_cache *smack_inode_cache;
 int smack_enabled;
+int smack_secids_index;
 
 static const match_table_t smk_mount_tokens = {
 	{Opt_fsdefault, SMK_FSDEFAULT "%s"},
@@ -3789,7 +3790,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 * The secmark is assumed to reflect policy better.
 		 */
 		if (skb && skb->secmark != 0) {
-			skp = smack_from_secid(skb->secmark);
+			skp = smack_from_secid(smack_token_to_secid(
+							skb->secmark));
 			goto access_check;
 		}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
@@ -3834,7 +3836,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		if (skb && skb->secmark != 0)
-			skp = smack_from_secid(skb->secmark);
+			skp = smack_from_secid(smack_token_to_secid(
+							skb->secmark));
 		else
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
@@ -3932,7 +3935,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		s = skb->secmark;
+		s = smack_token_to_secid(skb->secmark);
 		if (s != 0)
 			break;
 #endif
@@ -3951,7 +3954,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		s = skb->secmark;
+		s = smack_token_to_secid(skb->secmark);
 #endif
 		break;
 	}
@@ -4030,7 +4033,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * The secmark is assumed to reflect policy better.
 	 */
 	if (skb && skb->secmark != 0) {
-		skp = smack_from_secid(skb->secmark);
+		skp = smack_from_secid(smack_token_to_secid(skb->secmark));
 		goto access_check;
 	}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
@@ -4618,6 +4621,7 @@ static __init int smack_init(void)
 	 * Register with LSM
 	 */
 	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	smack_secids_index = smack_hooks[0].lsm_index;
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 701a1cc1bdcc..ee2e16d0b1a3 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -34,7 +34,8 @@ static unsigned int smack_ipv6_output(void *priv,
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-		skb->secmark = skp->smk_secid;
+		skb->secmark = lsm_token_set_secid(skb->secmark,
+					skp->smk_secid, smack_secids_index);
 	}
 
 	return NF_ACCEPT;
@@ -52,7 +53,8 @@ static unsigned int smack_ipv4_output(void *priv,
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-		skb->secmark = skp->smk_secid;
+		skb->secmark = lsm_token_set_secid(skb->secmark,
+					skp->smk_secid, smack_secids_index);
 	}
 
 	return NF_ACCEPT;
diff --git a/security/stacking.c b/security/stacking.c
new file mode 100644
index 000000000000..f74b4f0512aa
--- /dev/null
+++ b/security/stacking.c
@@ -0,0 +1,188 @@
+/*
+ *  Maintain a mapping between the secid used in networking
+ *  and the set of secids used by the security modules.
+ *
+ *  Author:
+ *	Casey Schaufler <casey@schaufler-ca.com>
+ *
+ *  Copyright (C) 2017 Casey Schaufler <casey@schaufler-ca.com>
+ *  Copyright (C) 2017 Intel Corporation.
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2,
+ *      as published by the Free Software Foundation.
+ */
+
+#include <linux/lsm_hooks.h>
+
+struct token_entry {
+	int			used;	/* relative age of the entry */
+	u32			token;	/* token value */
+	struct lsm_secids	secids;	/* secids mapped to this token */
+};
+
+/*
+ * Add an entry to the table when asked for a mapping that
+ * isn't already present. If the table is full throw away the
+ * least recently used entry. If the entry is present undate
+ * when it was used.
+ */
+#define TOKEN_AGE_LIMIT (MAX_INT >> 2)
+#define TOKEN_LIMIT 0x20000000
+#define TOKEN_SET_SIZE 200
+#define TOKEN_BIT 0x80000000
+int token_used;
+u32 token_next;
+struct lsm_secids null_secids;
+struct token_entry token_set[TOKEN_SET_SIZE];
+
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+static void report_token(const char *msg, const struct token_entry *te)
+{
+	int i;
+
+	pr_info("LSM: %s token=%08x %u,%u,%u,%u,%u,%u,%u,%u\n", msg, te->token,
+		te->secids.secid[0], te->secids.secid[1], te->secids.secid[2],
+		te->secids.secid[3], te->secids.secid[4], te->secids.secid[5],
+		te->secids.secid[6], te->secids.secid[7]);
+	for (i = 0; i < LSM_MAX_MAJOR; i++)
+		if (te->secids.secid[i] & TOKEN_BIT)
+			pr_info("LSM: module %d provided a token.\n", i);
+}
+#else
+static inline void report_token(const char *msg, const struct token_entry *te)
+{
+}
+#endif
+
+static int next_used(void)
+{
+	if (token_next >= TOKEN_LIMIT) {
+		pr_info("LSM: Security token use overflow - safe reset\n");
+		token_used = 0;
+	}
+	return ++token_used;
+}
+
+static u32 next_token(void)
+{
+	if (token_next >= TOKEN_LIMIT) {
+		pr_info("LSM: Security token overflow - safe reset\n");
+		token_next = 0;
+	}
+	return ++token_next | TOKEN_BIT;
+}
+
+u32 lsm_secids_to_token(const struct lsm_secids *secids)
+{
+	int i;
+	int j;
+	int old;
+
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	for (i = 0; i < LSM_MAX_MAJOR; i++)
+		if (secids->secid[i] & TOKEN_BIT)
+			pr_info("LSM: %s secid[%d]=%08x has token bit\n",
+				__func__, i, secids->secid[i]);
+#endif
+
+	/*
+	 * If none of the secids are set whoever sent this here
+	 * was thinking "0".
+	 */
+	if (!memcmp(secids, &null_secids, sizeof(*secids)))
+		return 0;
+
+	for (i = 0; i < TOKEN_SET_SIZE; i++) {
+		if (token_set[i].token == 0)
+			break;
+		if (!memcmp(secids, &token_set[i].secids, sizeof(*secids))) {
+			token_set[i].used = next_used();
+			return token_set[i].token;
+		}
+	}
+	if (i == TOKEN_SET_SIZE) {
+		old = token_used;
+		for (j = 0; j < TOKEN_SET_SIZE; j++) {
+			if (token_set[j].used < old) {
+				old = token_set[j].used;
+				i = j;
+			}
+		}
+	}
+	token_set[i].secids = *secids;
+	token_set[i].token = next_token();
+	token_set[i].used = next_used();
+
+	report_token("new", &token_set[i]);
+
+	return token_set[i].token;
+}
+
+void lsm_token_to_secids(const u32 token, struct lsm_secids *secids)
+{
+	int i;
+	struct lsm_secids fudge;
+
+	if (token) {
+		if (!(token & TOKEN_BIT)) {
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+			pr_info("LSM: %s token=%08x has no token bit\n",
+				__func__, token);
+#endif
+			for (i = 0; i < LSM_MAX_MAJOR; i++)
+				fudge.secid[i] = token;
+			*secids = fudge;
+			return;
+		}
+		for (i = 0; i < TOKEN_SET_SIZE; i++) {
+			if (token_set[i].token == 0)
+				break;
+			if (token_set[i].token == token) {
+				*secids = token_set[i].secids;
+				token_set[i].used = next_used();
+				return;
+			}
+		}
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	pr_info("LSM: %s token=%u was not found\n", __func__, token);
+#endif
+	}
+	*secids = null_secids;
+}
+
+u32 lsm_token_get_secid(const u32 token, int lsm)
+{
+	struct lsm_secids secids;
+
+        lsm_token_to_secids(token, &secids);
+	return secids.secid[lsm];
+}
+
+u32 lsm_token_set_secid(const u32 token, u32 lsecid, int lsm)
+{
+	struct lsm_secids secids;
+
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	if (!(token & TOKEN_BIT)) {
+		if (token)
+			pr_info("LSM: %s token=%08x has no token bit\n",
+				__func__, token);
+#else
+	if (!token) {
+#endif
+		lsm_secids_init(&secids);
+	} else {
+		lsm_token_to_secids(token, &secids);
+		if (secids.secid[lsm] == lsecid)
+			return token;
+	}
+
+	secids.secid[lsm] = lsecid;
+	return lsm_secids_to_token(&secids);
+}
+
+void lsm_secids_init(struct lsm_secids *secids)
+{
+	*secids = null_secids;
+}
-- 
2.13.0


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
