Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B904D0A0D;
	Wed, 30 Sep 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776511; cv=none; b=Dqo0cgLRNWgEN6Rc+7BqdAxLMGdNEwEX77ce/XyixRzjdXC7vwgzF71/j7TiM5KHaEsRRTf1zXvrIUjz3luesXCzp765/+Un7luM3tY0fByaY76Mw3BqYZW1S/YQvebYuYyqaXZNcfsaxUoFhEqd15gcTj6A/FLrjnDM1mLX20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776511; c=relaxed/simple;
	bh=8Daqr49GTkOdyPVcu3YfH7zRwQ2q2SKCN6OFsi9VlEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKD67sR+h0Kv6gXHoLwo1zQjs/JqzY2ds3mfXhfFlthzO0rCIE9le6wUYz4lBIkFo6NjiOItgT/42FhLdUcJi7dixAs4ex0mOuNKBvow697WBVkQX1ERAtA0xPLqLAkxG4cs9meY5kAs2ALJCz6PQjybK3z2mWGQ3St+mbOy/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E431321E26;
	Wed, 30 Sep 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F32413ABC;
	Wed, 30 Sep 2026 13:54:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJXpHGIUvWqUTwAAD6G6ig:T16
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 13:54:50 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Willem de Bruijn <willemb@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Florian Westphal <fw@strlen.de>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Joel Granados <joel.granados@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/16 net-next v3] netlabel: cipso: introduce CONFIG_CIPSO to decouple IPv4 dependency
Date: Wed, 30 Sep 2026 15:52:58 +0200
Message-ID: <20260930135334.4739-16-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260930135334.4739-1-fmancera@suse.de>
References: <20260930135334.4739-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: E431321E26
X-Spam-Flag: NO
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Currently, the Commercial IP Security Option (CIPSO) is unconditionally
tied to CONFIG_NETLABEL. Because CIPSO is inherently an IPv4 protocol
feature, this creates a transitive dependency where subsystems relying on
NetLabel (such as Smack) are forced to depend on CONFIG_IPV4, even if
the user only wants to utilize IPv6/CALIPSO.

This patch introduces a new CONFIG_CIPSO boolean that is automatically
enabled only when both NETLABEL and IPV4 are selected. It abstracts the
CIPSO-specific Makefile targets, sysctls, and kernel APIs behind this
new config.

By safely stubbing out the CIPSO netlabel_kapi functions to return
-ENOSYS when disabled, this allows NetLabel and Smack to be successfully
built and used on IPv6-only kernels.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/net/cipso_ipv4.h         | 18 +++++++++++-------
 net/Kconfig                      |  3 ---
 net/ipv4/Makefile                |  2 +-
 net/ipv4/sysctl_net_ipv4.c       |  4 ++--
 net/netlabel/Kconfig             |  4 ++++
 net/netlabel/Makefile            |  2 +-
 net/netlabel/netlabel_cipso_v4.h |  7 +++++++
 net/netlabel/netlabel_kapi.c     |  3 +++
 security/smack/Kconfig           |  1 -
 9 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/net/cipso_ipv4.h b/include/net/cipso_ipv4.h
index d6780d7903f4..6f50a0a6951b 100644
--- a/include/net/cipso_ipv4.h
+++ b/include/net/cipso_ipv4.h
@@ -100,7 +100,7 @@ struct cipso_v4_std_map_tbl {
  * Sysctl Variables
  */
 
-#ifdef CONFIG_NETLABEL
+#ifdef CONFIG_CIPSO
 extern int cipso_v4_cache_enabled;
 extern int cipso_v4_cache_bucketsize;
 extern int cipso_v4_rbm_optfmt;
@@ -111,7 +111,7 @@ extern int cipso_v4_rbm_strictvalid;
  * DOI List Functions
  */
 
-#ifdef CONFIG_NETLABEL
+#ifdef CONFIG_CIPSO
 int cipso_v4_doi_add(struct cipso_v4_doi *doi_def,
 		     struct netlbl_audit *audit_info);
 void cipso_v4_doi_free(struct cipso_v4_doi *doi_def);
@@ -144,19 +144,23 @@ static inline struct cipso_v4_doi *cipso_v4_doi_getdef(u32 doi)
 	return NULL;
 }
 
+static inline void cipso_v4_doi_putdef(struct cipso_v4_doi *doi_def)
+{
+}
+
 static inline int cipso_v4_doi_walk(u32 *skip_cnt,
 		     int (*callback) (struct cipso_v4_doi *doi_def, void *arg),
 		     void *cb_arg)
 {
 	return 0;
 }
-#endif /* CONFIG_NETLABEL */
+#endif /* CONFIG_CIPSO */
 
 /*
  * Label Mapping Cache Functions
  */
 
-#ifdef CONFIG_NETLABEL
+#ifdef CONFIG_CIPSO
 void cipso_v4_cache_invalidate(void);
 int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 		       const struct netlbl_lsm_secattr *secattr);
@@ -171,13 +175,13 @@ static inline int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 {
 	return 0;
 }
-#endif /* CONFIG_NETLABEL */
+#endif /* CONFIG_CIPSO */
 
 /*
  * Protocol Handling Functions
  */
 
-#ifdef CONFIG_NETLABEL
+#ifdef CONFIG_CIPSO
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway);
 int cipso_v4_getattr(const unsigned char *cipso,
 		     struct netlbl_lsm_secattr *secattr);
@@ -303,6 +307,6 @@ static inline int cipso_v4_validate(const struct sk_buff *skb,
 	return err_offset;
 
 }
-#endif /* CONFIG_NETLABEL */
+#endif /* CONFIG_CIPSO */
 
 #endif /* _CIPSO_IPV4_H */
diff --git a/net/Kconfig b/net/Kconfig
index ca86f20540dd..2ef4ea6ce056 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -136,10 +136,7 @@ if INET
 source "net/ipv4/Kconfig"
 source "net/ipv6/Kconfig"
 source "net/mptcp/Kconfig"
-
-if IPV4
 source "net/netlabel/Kconfig"
-endif # if IPV4
 
 endif # if INET
 
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 83c25f52eb58..871187937add 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_TCP_CONG_YEAH) += tcp_yeah.o
 obj-$(CONFIG_TCP_CONG_ILLINOIS) += tcp_illinois.o
 obj-$(CONFIG_NET_SOCK_MSG) += tcp_bpf.o
 obj-$(CONFIG_BPF_SYSCALL) += udp_bpf.o
-obj-$(CONFIG_NETLABEL) += cipso_ipv4.o
+obj-$(CONFIG_CIPSO) += cipso_ipv4.o
 
 obj-$(CONFIG_XFRM) += xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
 		      xfrm4_output.o xfrm4_protocol.o
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 6096e9e4d82d..89b0caf5a9f5 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -573,7 +573,7 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
-#ifdef CONFIG_NETLABEL
+#ifdef CONFIG_CIPSO
 	{
 		.procname	= "cipso_cache_enable",
 		.data		= &cipso_v4_cache_enabled,
@@ -602,7 +602,7 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#endif /* CONFIG_NETLABEL */
+#endif /* CONFIG_CIPSO */
 	{
 		.procname	= "tcp_available_ulp",
 		.maxlen		= TCP_ULP_BUF_MAX,
diff --git a/net/netlabel/Kconfig b/net/netlabel/Kconfig
index 4383ac29693e..bcc27196d5bd 100644
--- a/net/netlabel/Kconfig
+++ b/net/netlabel/Kconfig
@@ -17,3 +17,7 @@ config NETLABEL
 	   * https://github.com/netlabel/netlabel_tools
 
 	  If you are unsure, say N.
+
+config CIPSO
+	def_bool y
+	depends on NETLABEL && IPV4
diff --git a/net/netlabel/Makefile b/net/netlabel/Makefile
index 5a46381a64e7..8afc1bf00424 100644
--- a/net/netlabel/Makefile
+++ b/net/netlabel/Makefile
@@ -12,5 +12,5 @@ obj-y	+= netlabel_mgmt.o
 
 # protocol modules
 obj-y	+= netlabel_unlabeled.o
-obj-y	+= netlabel_cipso_v4.o
+obj-$(CONFIG_CIPSO) += netlabel_cipso_v4.o
 obj-$(subst m,y,$(CONFIG_IPV6)) += netlabel_calipso.o
diff --git a/net/netlabel/netlabel_cipso_v4.h b/net/netlabel/netlabel_cipso_v4.h
index 9518ab56ec98..fb718f86bcbd 100644
--- a/net/netlabel/netlabel_cipso_v4.h
+++ b/net/netlabel/netlabel_cipso_v4.h
@@ -147,6 +147,13 @@ enum {
 #define NLBL_CIPSOV4_A_MAX (__NLBL_CIPSOV4_A_MAX - 1)
 
 /* NetLabel protocol functions */
+#if IS_ENABLED(CONFIG_CIPSO)
 int netlbl_cipsov4_genl_init(void);
+#else
+static inline int netlbl_cipsov4_genl_init(void)
+{
+	return 0;
+}
+#endif
 
 #endif
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 3583fa63dd01..c088f599b53d 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -332,6 +332,9 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
 	struct netlbl_domaddr_map *addrmap = NULL;
 	struct netlbl_domaddr4_map *addrinfo = NULL;
 
+	if (!IS_ENABLED(CONFIG_CIPSO))
+		return -ENOSYS;
+
 	doi_def = cipso_v4_doi_getdef(doi);
 	if (doi_def == NULL)
 		return -ENOENT;
diff --git a/security/smack/Kconfig b/security/smack/Kconfig
index b4e6d0168bd1..5a8dfad469c3 100644
--- a/security/smack/Kconfig
+++ b/security/smack/Kconfig
@@ -3,7 +3,6 @@ config SECURITY_SMACK
 	bool "Simplified Mandatory Access Control Kernel Support"
 	depends on NET
 	depends on INET
-	depends on IPV4
 	depends on SECURITY
 	select NETLABEL
 	select SECURITY_NETWORK
-- 
2.55.0

