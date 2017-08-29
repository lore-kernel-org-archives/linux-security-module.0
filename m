From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 29 Aug 2017 14:01:33 -0700
Subject: [PATCH 07/11] LSM: Shared secids by token
In-Reply-To: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
References: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
Message-ID: <b8e2485a-bb77-10d2-2262-1e2a8c90d6c0@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH 07/11] LSM: Shared secids by token

Introduces a mechanism for mapping a set of security
module secids to and from a "token". The module interfaces
are changed to generally hide the mechanism from both the
security modules and the callers of the security hooks.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h        |  54 ++++++++-
 security/Makefile                |   1 +
 security/security.c              | 248 ++++++++++++++++++++++++++++++++++-----
 security/selinux/hooks.c         |  31 +++--
 security/selinux/include/xfrm.h  |   2 +-
 security/selinux/xfrm.c          |   6 +-
 security/smack/smack.h           |   1 +
 security/smack/smack_lsm.c       |  19 ++-
 security/smack/smack_netfilter.c |  17 ++-
 security/stacking.c              | 165 ++++++++++++++++++++++++++
 10 files changed, 497 insertions(+), 47 deletions(-)
 create mode 100644 security/stacking.c

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index dfe4dab1ff8d..75d95854f2ed 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1627,7 +1627,7 @@ union security_list_options {
 	void (*secmark_refcount_inc)(void);
 	void (*secmark_refcount_dec)(void);
 	void (*req_classify_flow)(const struct request_sock *req,
-					struct flowi *fl);
+					u32 *fl_secid);
 	int (*tun_dev_alloc_security)(void **security);
 	void (*tun_dev_free_security)(void *security);
 	int (*tun_dev_create)(void);
@@ -1663,7 +1663,7 @@ union security_list_options {
 					u8 dir);
 	int (*xfrm_state_pol_flow_match)(struct xfrm_state *x,
 						struct xfrm_policy *xp,
-						const struct flowi *fl);
+						u32 fl_secid);
 	int (*xfrm_decode_session)(struct sk_buff *skb, u32 *secid, int ckall);
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
@@ -1916,9 +1916,59 @@ struct security_hook_list {
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
+extern u32 lsm_token_to_module_secid(const u32 token, int lsm);
+extern void lsm_secids_init(struct lsm_secids *secids);
+#else /* CONFIG_SECURITY_STACKING */
+struct lsm_secids {
+	u32	secid;
+};
+
+static inline u32 lsm_secids_to_token(const struct lsm_secids *secids)
+{
+	return secids->secid;
+}
+
+static inline void lsm_token_to_secids(const u32 token,
+				       struct lsm_secids *secids)
+{
+	secids->secid = token;
+}
+
+static inline u32 lsm_token_to_module_secid(const u32 token, int lsm)
+{
+	return token;
+}
+
+static inline void lsm_secids_init(struct lsm_secids *secids)
+{
+	secids->secid = 0;
+}
+#endif /* CONFIG_SECURITY_STACKING */
+
+/*
  * Security blob size or offset data.
  */
 struct lsm_blob_sizes {
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
index 6b979aa769ad..9d402d954cef 100644
--- a/security/security.c
+++ b/security/security.c
@@ -199,6 +199,11 @@ bool __init security_module_enable(const char *lsm, const bool stacked)
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
@@ -211,9 +216,14 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
@@ -1218,7 +1228,15 @@ EXPORT_SYMBOL(security_inode_listsecurity);
 
 void security_inode_getsecid(struct inode *inode, u32 *secid)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.inode_getsecid, list)
+		hp->hook.inode_getsecid(inode, &secids.secid[hp->lsm_index]);
+
+	*secid = lsm_secids_to_token(&secids);
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
@@ -1406,7 +1424,18 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_token_to_secids(secid, &secids);
+
+	list_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		rc = hp->hook.kernel_act_as(new, secids.secid[hp->lsm_index]);
+		if (rc)
+			break;
+	}
+	return rc;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
@@ -1465,8 +1494,15 @@ int security_task_getsid(struct task_struct *p)
 
 void security_task_getsecid(struct task_struct *p, u32 *secid)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid, p, secid);
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.task_getsecid, list)
+		hp->hook.task_getsecid(p, &secids.secid[hp->lsm_index]);
+
+	*secid = lsm_secids_to_token(&secids);
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
@@ -1515,7 +1551,19 @@ int security_task_movememory(struct task_struct *p)
 int security_task_kill(struct task_struct *p, struct siginfo *info,
 			int sig, u32 secid)
 {
-	return call_int_hook(task_kill, 0, p, info, sig, secid);
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
 }
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
@@ -1548,8 +1596,15 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list)
+		hp->hook.ipc_getsecid(ipcp, &secids.secid[hp->lsm_index]);
+
+	*secid = lsm_secids_to_token(&secids);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
@@ -1840,15 +1895,42 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
-				seclen);
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = -EOPNOTSUPP;
+
+	lsm_token_to_secids(secid, &secids);
+
+	/*
+	 * CBS - Return the first result regardless.
+	 */
+	list_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		rc = hp->hook.secid_to_secctx(secids.secid[hp->lsm_index],
+						secdata, seclen);
+		if (rc != -EOPNOTSUPP)
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
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
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
@@ -1977,10 +2059,26 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
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
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
@@ -2008,13 +2106,30 @@ EXPORT_SYMBOL(security_sk_clone);
 
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
-	call_void_hook(sk_getsecid, sk, &fl->flowi_secid);
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.sk_getsecid, list)
+		hp->hook.sk_getsecid(sk, &secids.secid[hp->lsm_index]);
+
+	fl->flowi_secid = lsm_secids_to_token(&secids);
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
-void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
+void security_req_classify_flow(const struct request_sock *req,
+				struct flowi *fl)
 {
-	call_void_hook(req_classify_flow, req, fl);
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+
+	list_for_each_entry(hp, &security_hook_heads.req_classify_flow, list)
+		hp->hook.req_classify_flow(req, &secids.secid[hp->lsm_index]);
+
+	fl->flowi_secid = lsm_secids_to_token(&secids);
 }
 EXPORT_SYMBOL(security_req_classify_flow);
 
@@ -2045,7 +2160,20 @@ void security_inet_conn_established(struct sock *sk,
 
 int security_secmark_relabel_packet(u32 secid)
 {
-	return call_int_hook(secmark_relabel_packet, 0, secid);
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
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
@@ -2163,7 +2291,20 @@ EXPORT_SYMBOL(security_xfrm_state_alloc);
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
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
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
@@ -2179,7 +2320,19 @@ void security_xfrm_state_free(struct xfrm_state *x)
 
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
-	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
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
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
@@ -2187,6 +2340,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       const struct flowi *fl)
 {
 	struct security_hook_list *hp;
+	struct lsm_secids secids;
 	int rc = 1;
 
 	/*
@@ -2198,9 +2352,12 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
+	lsm_token_to_secids(fl->flowi_secid, &secids);
+
 	list_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
-		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
+									list) {
+		rc = hp->hook.xfrm_state_pol_flow_match(x, xp,
+				secids.secid[hp->lsm_index]);
 		break;
 	}
 	return rc;
@@ -2208,15 +2365,41 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
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
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
-	int rc = call_int_hook(xfrm_decode_session, 0, skb, &fl->flowi_secid,
-				0);
+	struct security_hook_list *hp;
+	struct lsm_secids secids;
+	int rc = 0;
+
+	lsm_secids_init(&secids);
 
+	list_for_each_entry(hp, &security_hook_heads.xfrm_decode_session,
+									list) {
+		rc = hp->hook.xfrm_decode_session(skb,
+					&secids.secid[hp->lsm_index], 0);
+		if (rc)
+			break;
+	}
 	BUG_ON(rc);
+	fl->flowi_secid = lsm_secids_to_token(&secids);
 }
 EXPORT_SYMBOL(security_skb_classify_flow);
 
@@ -2275,7 +2458,18 @@ void security_audit_rule_free(void *lsmrule)
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 			      struct audit_context *actx)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
-				actx);
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
 }
 #endif /* CONFIG_AUDIT */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 84d533335924..389f09ebd374 100644
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
 
@@ -4610,6 +4613,11 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 			    SECCLASS_NODE, NODE__RECVFROM, ad);
 }
 
+static u32 selinux_secmark_to_secid(u32 token)
+{
+	return lsm_token_to_module_secid(token, selinux_secids_index);
+}
+
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
@@ -4629,7 +4637,9 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		err = avc_has_perm(sk_sid,
+				   selinux_secmark_to_secid(skb->secmark),
+				   SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -4703,7 +4713,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		err = avc_has_perm(sk_sid,
+				   selinux_secmark_to_secid(skb->secmark),
+				   SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -4902,9 +4914,9 @@ static void selinux_secmark_refcount_dec(void)
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
-				      struct flowi *fl)
+				      u32 *fl_secid)
 {
-	fl->flowi_secid = req->secid;
+	*fl_secid = req->secid;
 }
 
 static int selinux_tun_dev_alloc_security(void **security)
@@ -5066,7 +5078,8 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+		if (avc_has_perm(peer_sid,
+				 selinux_secmark_to_secid(skb->secmark),
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
@@ -5178,7 +5191,8 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->sid, skb->secmark,
+		if (avc_has_perm(sksec->sid,
+				 selinux_secmark_to_secid(skb->secmark),
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -5301,7 +5315,8 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+		if (avc_has_perm(peer_sid,
+				 selinux_secmark_to_secid(skb->secmark),
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -6339,6 +6354,8 @@ static __init int selinux_init(void)
 
 	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
 
+	selinux_secids_index = selinux_hooks[0].lsm_index;
+
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
 
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index 1450f85b946d..475a328248b3 100644
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
index e7611de071f1..e9fd586e0ec1 100644
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
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1e9ab7bdaf55..51daf9b05f17 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -57,6 +57,7 @@ static LIST_HEAD(smk_ipv6_port_list);
 #endif
 static struct kmem_cache *smack_inode_cache;
 int smack_enabled;
+int smack_secids_index;
 
 static const match_table_t smk_mount_tokens = {
 	{Opt_fsdefault, SMK_FSDEFAULT "%s"},
@@ -3788,6 +3789,13 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 }
 #endif /* CONFIG_IPV6 */
 
+#ifdef CONFIG_SECURITY_SMACK_NETFILTER
+static u32 smk_of_secmark(u32 secmark)
+{
+	return lsm_token_to_module_secid(secmark, smack_secids_index);
+}
+#endif
+
 /**
  * smack_socket_sock_rcv_skb - Smack packet delivery access check
  * @sk: socket
@@ -3819,7 +3827,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 * The secmark is assumed to reflect policy better.
 		 */
 		if (skb && skb->secmark != 0) {
-			skp = smack_from_secid(skb->secmark);
+			skp = smack_from_secid(smk_of_secmark(skb->secmark));
 			goto access_check;
 		}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
@@ -3864,7 +3872,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		if (skb && skb->secmark != 0)
-			skp = smack_from_secid(skb->secmark);
+			skp = smack_from_secid(smk_of_secmark(skb->secmark));
 		else
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
@@ -3962,7 +3970,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		s = skb->secmark;
+		s = smk_of_secmark(skb->secmark);
 		if (s != 0)
 			break;
 #endif
@@ -3981,7 +3989,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		s = skb->secmark;
+		s = smk_of_secmark(skb->secmark);
 #endif
 		break;
 	}
@@ -4060,7 +4068,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * The secmark is assumed to reflect policy better.
 	 */
 	if (skb && skb->secmark != 0) {
-		skp = smack_from_secid(skb->secmark);
+		skp = smack_from_secid(smk_of_secmark(skb->secmark));
 		goto access_check;
 	}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
@@ -4650,6 +4658,7 @@ static __init int smack_init(void)
 	 * Register with LSM
 	 */
 	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	smack_secids_index = smack_hooks[0].lsm_index;
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index a5155295551f..510661ba6c16 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -23,6 +23,19 @@
 
 #if IS_ENABLED(CONFIG_IPV6)
 
+/*
+ * Reinvestigate this soon?
+ *
+ */
+static u32 smack_to_secmark(u32 secid)
+{
+	struct lsm_secids secids;
+
+	lsm_secids_init(&secids);
+	secids.secid[smack_secids_index] = secid;
+	return lsm_secids_to_token(&secids);
+}
+
 static unsigned int smack_ipv6_output(void *priv,
 					struct sk_buff *skb,
 					const struct nf_hook_state *state)
@@ -34,7 +47,7 @@ static unsigned int smack_ipv6_output(void *priv,
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-		skb->secmark = skp->smk_secid;
+		skb->secmark = smack_to_secmark(skp->smk_secid);
 	}
 
 	return NF_ACCEPT;
@@ -52,7 +65,7 @@ static unsigned int smack_ipv4_output(void *priv,
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-		skb->secmark = skp->smk_secid;
+		skb->secmark = smack_to_secmark(skp->smk_secid);
 	}
 
 	return NF_ACCEPT;
diff --git a/security/stacking.c b/security/stacking.c
new file mode 100644
index 000000000000..65276cd695de
--- /dev/null
+++ b/security/stacking.c
@@ -0,0 +1,165 @@
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
+u32 lsm_token_to_module_secid(const u32 token, int lsm)
+{
+	struct lsm_secids secids;
+
+        lsm_token_to_secids(token, &secids);
+	return secids.secid[lsm];
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
