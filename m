Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0D0C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 00:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17ED20829
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 00:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KxG2Ghxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHLAmC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:42:02 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:37475
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgHLAmC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 20:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597192920; bh=o+ZFxA76qUlH3AaFEm2WoDY+1UN23Wn9FIszIid/J24=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KxG2GhxwZjX0FbCd9yIlUsUSXkdDJPQgQJ1Zg0mVt4JYXzI8n8vNFB/O2bQrq4+LeqNRtttnQCEHOF0ICNjw0IlJT6QhnvjnS17GAmUb2ZluammaDt+zz76fyDyOxrtTv/w2JdpTfruXG9tA0ol4pZ7Qrdzppht62QqDmyQgVyEA9xe7nVDxkgFJrjPMKTErJfA/55Po6zmggshIwOoI8KTbjQBNjyascKdoiAHK2+LkSQGnnIjIuHrgQffkssck3q9pAYzdSukzdd20UDd8bQQpiCPCg6UFht4XcG+pVAiLYKyPJdPeLdXDwNvthsjehuA1fd+Z5oh1z2yckIc0bQ==
X-YMail-OSG: Ek1pyuwVM1ksIFQVVYhtQM__F3leEWjOoJXS320uA2a3NXQO7RG8lQ8eP9nmfXJ
 _N.QqayWSIxcGqzRKbPp5S8a1A5FHAOJCTF_Z9E9EsEBfnipE6abS.t5ZzOerrXtUmwZapebKlle
 EQvWZ5r5T00c9Qf0g5oK7PpsrIY1ce9wsQzgyTZ8NIyw9usBjy.lCRqWFbtG7WcxXlC6mg424iyL
 RtaIETXEYEsEo8RMuq4xUPUmeDaGisx98qH4Wbk2TkXR_Xfb9nAuNYi9VNDcAvcBJWXxIvjhJkSK
 fBopDd5mldtEXAItRZDdCDjrq.sl.tUBWpN16neeLkoneGiF39lDbl9wjlynLNCiy6v3LhGwJ_BM
 rOCm2Tm4UgNLWCFE6EbgYbxBLYpe1kiie4iK7vBpVUhkRStBF.8QgBQoa.o1ULP98UdV7U2sOGlB
 8_kCpApiG7YTx65is_mm29FDpN5hpLKqPSbmhJhVjJEJYczNjpVV1YiLugIT0cjUN.VtJ.ur0f2D
 GbHEUteFb6EntxMm.vj58R5ehrjBQyyGyPlILwb60hvIWsARFqJBBXzilCNnglNWzgwnfP7ri3RF
 BtxI.z99pKpTR6SuSAVjf11VRwRnRiTTLkeK7VcYAADOTMDlVMHV2xf2KavKTAjDnpYVZOchTQUG
 7lkdoXjYl1bAyL83pSkR.oPEX_6tevqEeRJMGpoiXJKQkqwF0CKu6q97Q9vJpxytT3z.bcebCqWy
 CuQo5BGOkEg1z_AwfLFiM2od.uE4IC4_VXGGw4s8YZD82t4ZiiXPnu8O3LV6k5Na8dzCHp6omtEU
 esmrTnJWYGo9VhK7M8Wv3Vl5d0EDSfBcBHtKaUiA.n3aNRu55M2ymOUHe0qW5RUQG4mQlhhWmOK7
 _LOQhFd2qVhyQHc9b0ymidYKASDzo1U0jDgLEAQRu_veTMb0d1_8TN5OJK8DwF03w7IdgFDngzgR
 1Fkxdjjxr9c6r7GZdOLjk3.X.moIETUzWVfAAqUn06auNBdjR15dNsyRokII0g0AJywC6I54sMeE
 Nrq6knPlqv45Q8xMygamzKt1q4EYt3NxEDGX5nVaRTjN2RharpGqR66O_d0I_U1dvkJoWlNGB8Dm
 4_2_f9fB18hZpSuzpDTetjO02BDYPw.jQfpwqYgQWXGRxYHiRHU4La_47FA0IljEsx38.eJzXtKy
 pnRz6sa67VMVOBcf8zXUqsRrUeU36jOWxyO3CkVJQsqwAM5m7PYZx8JbtaetQdu.W5w2c587RvxA
 8GYqnvGyXH9kJSVKJ_a3sXsfM69w8N4NIQ1LCDYLydkkmeG_LIzkNYLYJ4k27FU4JNX1QOcMAAs4
 1iJYZ0y4VYmUVlKVNInuuiP9nXNmIABJr9jzvaQWdcPg.KTMPXzNILtz4Zb4ykFHIoPGLM0Gl5AB
 xmN2GLjG1E2Gta1UXPGq7BUx5lf7qcVcjKUvkUemd3DVFdvVsowWmP_qFbdO676vGFUwAFSiKJPn
 1pfDPV_HfvxCx
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Aug 2020 00:42:00 +0000
Received: by smtp430.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 561f26abd72245e567015e7da50cf5b3;
          Wed, 12 Aug 2020 00:41:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     SMACK-discuss@lists.01.org, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com, casey@schaufler-ca.com
Subject: [PATCH 2/3] Smack: Set socket labels only once
Date:   Tue, 11 Aug 2020 17:39:42 -0700
Message-Id: <20200812003943.3036-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200812003943.3036-1-casey@schaufler-ca.com>
References: <20200812003943.3036-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Refactor the IP send checks so that the netlabel value
is set only when necessary, not on every send. Some functions
get renamed as the changes made the old name misleading.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h     |  18 ++--
 security/smack/smack_lsm.c | 169 ++++++++++++++++++++-----------------
 2 files changed, 98 insertions(+), 89 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index e9e817d09785..c5d745a3ada8 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -100,7 +100,12 @@ struct socket_smack {
 	struct smack_known	*smk_out;	/* outbound label */
 	struct smack_known	*smk_in;	/* inbound label */
 	struct smack_known	*smk_packet;	/* TCP peer label */
+	int			smk_state;	/* netlabel socket states */
 };
+#define	SMK_NETLBL_UNSET	0
+#define	SMK_NETLBL_UNLABELED	1
+#define	SMK_NETLBL_LABELED	2
+#define	SMK_NETLBL_REQSKB	3
 
 /*
  * Inode smack data
@@ -196,19 +201,6 @@ enum {
 #define SMACK_DELETE_OPTION	"-DELETE"
 #define SMACK_CIPSO_OPTION 	"-CIPSO"
 
-/*
- * How communications on this socket are treated.
- * Usually it's determined by the underlying netlabel code
- * but there are certain cases, including single label hosts
- * and potentially single label interfaces for which the
- * treatment can not be known in advance.
- *
- * The possibility of additional labeling schemes being
- * introduced in the future exists as well.
- */
-#define SMACK_UNLABELED_SOCKET	0
-#define SMACK_CIPSO_SOCKET	1
-
 /*
  * CIPSO defaults.
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3402ac4aa28e..7a79ddb39e94 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2383,38 +2383,31 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
 }
 
 /**
- * smack_netlabel - Set the secattr on a socket
+ * smack_netlbl_add - Set the secattr on a socket
  * @sk: the socket
- * @labeled: socket label scheme
  *
- * Convert the outbound smack value (smk_out) to a
- * secattr and attach it to the socket.
+ * Attach the outbound smack value (smk_out) to the socket.
  *
  * Returns 0 on success or an error code
  */
-static int smack_netlabel(struct sock *sk, int labeled)
+static int smack_netlbl_add(struct sock *sk)
 {
-	struct smack_known *skp;
 	struct socket_smack *ssp = sk->sk_security;
-	int rc = 0;
+	struct smack_known *skp = ssp->smk_out;
+	int rc;
 
-	/*
-	 * Usually the netlabel code will handle changing the
-	 * packet labeling based on the label.
-	 * The case of a single label host is different, because
-	 * a single label host should never get a labeled packet
-	 * even though the label is usually associated with a packet
-	 * label.
-	 */
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
-	if (ssp->smk_out == smack_net_ambient ||
-	    labeled == SMACK_UNLABELED_SOCKET)
-		netlbl_sock_delattr(sk);
-	else {
-		skp = ssp->smk_out;
-		rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+	switch (rc) {
+	case 0:
+		ssp->smk_state = SMK_NETLBL_LABELED;
+		break;
+	case -EDESTADDRREQ:
+		ssp->smk_state = SMK_NETLBL_REQSKB;
+		rc = 0;
+		break;
 	}
 
 	bh_unlock_sock(sk);
@@ -2424,7 +2417,31 @@ static int smack_netlabel(struct sock *sk, int labeled)
 }
 
 /**
- * smack_netlbel_send - Set the secattr on a socket and perform access checks
+ * smack_netlbl_delete - Remove the secattr from a socket
+ * @sk: the socket
+ *
+ * Remove the outbound smack value from a socket
+ */
+static void smack_netlbl_delete(struct sock *sk)
+{
+	struct socket_smack *ssp = sk->sk_security;
+
+	/*
+	 * Take the label off the socket if one is set.
+	 */
+	if (ssp->smk_state != SMK_NETLBL_LABELED)
+		return;
+
+	local_bh_disable();
+	bh_lock_sock_nested(sk);
+	netlbl_sock_delattr(sk);
+	bh_unlock_sock(sk);
+	local_bh_enable();
+	ssp->smk_state = SMK_NETLBL_UNLABELED;
+}
+
+/**
+ * smk_ipv4_check - Perform IPv4 host access checks
  * @sk: the socket
  * @sap: the destination address
  *
@@ -2434,11 +2451,10 @@ static int smack_netlabel(struct sock *sk, int labeled)
  * Returns 0 on success or an error code.
  *
  */
-static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
+static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 {
 	struct smack_known *skp;
-	int rc;
-	int sk_lbl;
+	int rc = 0;
 	struct smack_known *hkp;
 	struct socket_smack *ssp = sk->sk_security;
 	struct smk_audit_info ad;
@@ -2454,19 +2470,18 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
 		ad.a.u.net->dport = sap->sin_port;
 		ad.a.u.net->v4info.daddr = sap->sin_addr.s_addr;
 #endif
-		sk_lbl = SMACK_UNLABELED_SOCKET;
 		skp = ssp->smk_out;
 		rc = smk_access(skp, hkp, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv4 host check", skp, hkp, MAY_WRITE, rc);
-	} else {
-		sk_lbl = SMACK_CIPSO_SOCKET;
-		rc = 0;
+		/*
+		 * Clear the socket netlabel if it's set.
+		 */
+		if (!rc)
+			smack_netlbl_delete(sk);
 	}
 	rcu_read_unlock();
-	if (rc != 0)
-		return rc;
 
-	return smack_netlabel(sk, sk_lbl);
+	return rc;
 }
 
 /**
@@ -2703,7 +2718,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	else if (strcmp(name, XATTR_SMACK_IPOUT) == 0) {
 		ssp->smk_out = skp;
 		if (sock->sk->sk_family == PF_INET) {
-			rc = smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
+			rc = smack_netlbl_add(sock->sk);
 			if (rc != 0)
 				printk(KERN_WARNING
 					"Smack: \"%s\" netlbl error %d.\n",
@@ -2754,7 +2769,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	/*
 	 * Set the outbound netlbl.
 	 */
-	return smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
+	return smack_netlbl_add(sock->sk);
 }
 
 /**
@@ -2845,7 +2860,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 	}
 	if (sap->sa_family != AF_INET || addrlen < sizeof(struct sockaddr_in))
 		return 0;
-	rc = smack_netlabel_send(sock->sk, (struct sockaddr_in *)sap);
+	rc = smk_ipv4_check(sock->sk, (struct sockaddr_in *)sap);
 	return rc;
 }
 
@@ -3663,7 +3678,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (msg->msg_namelen < sizeof(struct sockaddr_in) ||
 		    sip->sin_family != AF_INET)
 			return -EINVAL;
-		rc = smack_netlabel_send(sock->sk, sip);
+		rc = smk_ipv4_check(sock->sk, sip);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
@@ -3824,6 +3839,33 @@ static struct smack_known *smack_from_skb(struct sk_buff *skb)
 	return smack_from_secid(skb->secmark);
 }
 
+/**
+ * smack_from_netlbl - Smack data from the IP options in an skb
+ * @sk: socket data came in on
+ * @family: address family
+ * @skb: packet
+ *
+ * Returns smack_known of the IP options or NULL if that won't work.
+ */
+static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
+					     struct sk_buff *skb)
+{
+	struct netlbl_lsm_secattr secattr;
+	struct socket_smack *ssp = NULL;
+	struct smack_known *skp = NULL;
+
+	netlbl_secattr_init(&secattr);
+
+	if (sk)
+		ssp = sk->sk_security;
+	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0)
+		skp = smack_from_secattr(&secattr, ssp);
+
+	netlbl_secattr_destroy(&secattr);
+
+	return skp;
+}
+
 /**
  * smack_socket_sock_rcv_skb - Smack packet delivery access check
  * @sk: socket
@@ -3833,7 +3875,6 @@ static struct smack_known *smack_from_skb(struct sk_buff *skb)
  */
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct netlbl_lsm_secattr secattr;
 	struct socket_smack *ssp = sk->sk_security;
 	struct smack_known *skp = NULL;
 	int rc = 0;
@@ -3858,22 +3899,11 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 * The secmark is assumed to reflect policy better.
 		 */
 		skp = smack_from_skb(skb);
-		if (skp)
-			goto access_check;
-		/*
-		 * Translate what netlabel gave us.
-		 */
-		netlbl_secattr_init(&secattr);
-
-		rc = netlbl_skbuff_getattr(skb, family, &secattr);
-		if (rc == 0)
-			skp = smack_from_secattr(&secattr, ssp);
-		else
-			skp = smack_net_ambient;
-
-		netlbl_secattr_destroy(&secattr);
-
-access_check:
+		if (skp == NULL) {
+			skp = smack_from_netlbl(sk, family, skb);
+			if (skp == NULL)
+				skp = smack_net_ambient;
+		}
 
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
@@ -3979,12 +4009,11 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 					 struct sk_buff *skb, u32 *secid)
 
 {
-	struct netlbl_lsm_secattr secattr;
 	struct socket_smack *ssp = NULL;
 	struct smack_known *skp;
+	struct sock *sk = NULL;
 	int family = PF_UNSPEC;
 	u32 s = 0;	/* 0 is the invalid secid */
-	int rc;
 
 	if (skb != NULL) {
 		if (skb->protocol == htons(ETH_P_IP))
@@ -4011,15 +4040,11 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		/*
 		 * Translate what netlabel gave us.
 		 */
-		if (sock != NULL && sock->sk != NULL)
-			ssp = sock->sk->sk_security;
-		netlbl_secattr_init(&secattr);
-		rc = netlbl_skbuff_getattr(skb, family, &secattr);
-		if (rc == 0) {
-			skp = smack_from_secattr(&secattr, ssp);
+		if (sock != NULL)
+			sk = sock->sk;
+		skp = smack_from_netlbl(sk, family, skb);
+		if (skp != NULL)
 			s = skp->smk_secid;
-		}
-		netlbl_secattr_destroy(&secattr);
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
@@ -4073,7 +4098,6 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
 	struct socket_smack *ssp = sk->sk_security;
-	struct netlbl_lsm_secattr secattr;
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
 	struct smack_known *hskp;
@@ -4103,18 +4127,11 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * The secmark is assumed to reflect policy better.
 	 */
 	skp = smack_from_skb(skb);
-	if (skp)
-		goto access_check;
-
-	netlbl_secattr_init(&secattr);
-	rc = netlbl_skbuff_getattr(skb, family, &secattr);
-	if (rc == 0)
-		skp = smack_from_secattr(&secattr, ssp);
-	else
-		skp = &smack_known_huh;
-	netlbl_secattr_destroy(&secattr);
-
-access_check:
+	if (skp == NULL) {
+		skp = smack_from_netlbl(sk, family, skb);
+		if (skp == NULL)
+			skp = &smack_known_huh;
+	}
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-- 
2.19.1

