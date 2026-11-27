Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800040;
	b=3IFDX2w5vQzMFwaZVXrSdBaRbnDnwMyw0tIZXyeEJUKyGz+l6wmKNzR5Vux93q7dzIMX
	 2VKQWJ7httQlFIM0qht9cpf+DXiss6LJau/xkSbvC1ioqEv6gr9mKcWEfmFlhe8ba1701
	 Jp8JE/N2V+EhAKrOfYPd2V/qQqQb8porD+YUiA0xGecu2MMTZ8MytUEMWrYlhHprBRzus
	 ojyd7fsI52bgxIwbJ8TXqVUKdKEp/y60X4hzU12kGlEMVkDOHedKa9hfo2ma8nTSMp1mB
	 EiIutnmGQF2QQXr4d/YhJXAYEiDAo7O/WpkLsP0qITlP+tOcYz0dgovzBFL9u+w/tMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800040;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=Sl//dY663VEVseMCe8XQEfagB17ZRGQNkvBMCSx691s=;
	b=t+Fb4h+QQALUcGO2HirQux8496dkKvSr7Fm4mDx26gZZsLCluDTBNVaqYkTXA2ueoxya
	 txZw1mMlen7W2JL03RIxdpaGOZDLfGIKWEWXsb4gyub1l37l0aaoBx3gSx6ebTbNvNbdy
	 UawkKpcHfXnl+byAKwQUDUX8fiGY+e6sicGq68LWLp8IUFRtg6z9JU77232oqRXzWzVuZ
	 FLJAcvPvbSQcsgy3Wy0NG1+b4u1RTvnaEFpQPh5JFNFAIuUqFZR/aghC2pqshwbNHMC+8
	 wyapg1RiUGlLmRXLu/C761uUaqvBgS0bCUIYDZWbDODizNCnjAnfrgy/ohQuYf5Womw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D1606A327;
	Fri, 27 Nov 2026 17:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD6D1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25B72229B3;
	Fri, 27 Nov 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C762813432;
	Fri, 27 Nov 2026 17:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Yb1MH67CWuMAwAAD6G6ig:T16
	(envelope-from <fmancera@suse.de>); Fri, 27 Nov 2026 17:20:36 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Paul Moore <paul@paul-moore.com>,
	Willem de Bruijn <willemb@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Lukas Prause <lukas.prause@ikt.uni-hannover.de>,
	Florian Westphal <fw@strlen.de>,
	Amery Hung <ameryhung@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Tim Fuechsel <t.fuechsel@gmx.de>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net-next v4 15/16] netlabel: cipso: introduce CONFIG_CIPSO to decouple IPv4 dependency
Date: Fri, 27 Nov 2026 18:18:00 +0100
Message-ID: <20261127171824.27362-16-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261127171824.27362-1-fmancera@suse.de>
References: <20261127171824.27362-1-fmancera@suse.de>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 25B72229B3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

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
 net/netlabel/netlabel_mgmt.c     |  3 ++-
 security/smack/Kconfig           |  1 -
 10 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/net/cipso_ipv4.h b/include/net/cipso_ipv4.h
index b41672221797..8b972d2d35f1 100644
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
@@ -304,6 +308,6 @@ static inline int cipso_v4_validate(const struct sk_buff *skb,
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
index 003ad176d6ee..3b6bf940c0b6 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_TCP_CONG_YEAH) += tcp_yeah.o
 obj-$(CONFIG_TCP_CONG_ILLINOIS) += tcp_illinois.o
 obj-$(CONFIG_NET_SOCK_MSG) += tcp_bpf.o
 obj-$(CONFIG_BPF_SYSCALL) += udp_bpf.o
-obj-$(CONFIG_NETLABEL) += cipso_ipv4.o
+obj-$(CONFIG_CIPSO) += cipso_ipv4.o
 
 obj-$(CONFIG_XFRM) += xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
 		      xfrm4_output.o xfrm4_protocol.o
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 8ab5afd2f862..290d23995c8a 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -574,7 +574,7 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
-#ifdef CONFIG_NETLABEL
+#ifdef CONFIG_CIPSO
 	{
 		.procname	= "cipso_cache_enable",
 		.data		= &cipso_v4_cache_enabled,
@@ -603,7 +603,7 @@ static struct ctl_table ipv4_table[] = {
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
index c0eddb6afef3..cb0eedb457af 100644
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
diff --git a/net/netlabel/netlabel_mgmt.c b/net/netlabel/netlabel_mgmt.c
index 3e89c3b3a1a4..efadfe31667b 100644
--- a/net/netlabel/netlabel_mgmt.c
+++ b/net/netlabel/netlabel_mgmt.c
@@ -689,7 +689,8 @@ static int netlbl_mgmt_protocols(struct sk_buff *skb,
 		protos_sent++;
 	}
 	if (protos_sent == 1) {
-		if (netlbl_mgmt_protocols_cb(skb,
+		if (IS_ENABLED(CONFIG_CIPSO) &&
+		    netlbl_mgmt_protocols_cb(skb,
 					     cb,
 					     NETLBL_NLTYPE_CIPSOV4) < 0)
 			goto protocols_return;
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
2.56.1

