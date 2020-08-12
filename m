Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1D6C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 00:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853F62080C
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 00:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LPtpvz4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHLAkx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:40:53 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:42260
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgHLAkw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 20:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597192851; bh=YVxWMdLuA2xgtHptEacAN9lE2YsL7dT4ZjUthAr8UsA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LPtpvz4KcvSqB6FBZwlIAZsC5BjMu7DNJVn8hxLT09CStAZpBczZZW4yA7WFp+7+A6tQheY07PUS9SwJKXIdF1ib77zVj5M7T+MtvehthTDAlnLNKx0sEKiMs3ZG64sVUqqK5N+Bh33cO7vOaoHou/Dxvoqf7za0LQxZ0/pypyOkzen5QLRrgOCI75mViKKo5bxn8EXPoRK3socewVYNSuAVTQx1PdiaL48sywnGWEYFLERwmtwPoyEc5FHfc6oxcicEvfNpx2XF+vyGxaoeXEb2EP7AYzYU4vIIBapTy3XZxq7D5C1eJRRZw4i4Tub6T3Bts+0awV9wsRP7JGc01g==
X-YMail-OSG: EBCaBg0VM1lJSH22c6yWoGSzLOoXtZn5ILC_4Avxjr8tFQg68SP67EFiIwJ8X_I
 ZbT5AZ0NCNh0.BYBvfMAE6qon3OvSo1l9Z3jMLFFdKYmGcty8094TPvgglROTrntrN8yvlvjl5xy
 2qCK_kfEaogynPLrH5vCv5.FqixD8LrI.sZavCIdeiMvUHXwVgkqvUQHcaE4ZfD.TX7YaI6JiF0Q
 tkCYPJ.USBygLZvttkm2Jhdlti868XmE7scbOt27LqOS9qBuyqy3MuTU1vSyEqpSkONIH_qI7NaL
 Aje4WlOQVCKmnFmlT_cK5fdVEM3bCYMe.Clx3ZCqfKeTeixSBreUAg1AORicKSDnWhE6TB.QkbGa
 U9z5GIzQqVCDtyssy95UIGjyVDBaV7XYLzP5m9LnJKOrCB8pxy7u3UwYUOryZwJzC0jJvlqQRnQ3
 K2Q4Jqs7HK7d1mCEZZUF.RXsKIviJN5vjwoFcEBwx2a1rv.5Wi0QWCF2jvdrrsZFX_rB2bnTifdL
 Mwm60Oj9hM0iLPp9QSPXlKnlTTl0L51_Ingid3IM47nvKbUz1PMbr1Vr6ikLYZVAxHB1SSOgWWBk
 JYrI.7aCpgjNs4G2NKuWr75g0V1sS4ZYHC6.T5wQaN46PyJ92IkMQuv9cn6m65G_65eN8Yda7gye
 6SvXet3SU_jBdNMmx3PUJ3JzEgITVDGp_uq2ZjeQ4A1XZGmPozDxZGJfHiKxmrO6oOwU95SG6Loc
 gRfCEmJfAeE.7R0k4Kx4dOlMF0srHXa5bRnH_spv8Msuy4JXPy5Yf6PfUErTq8iHD3KQWkDU8sId
 zMc7jkA_FNQ4wpyjfP6BQb9Zi5bsy07wCV__5hMH.plnE6o53emtOxO.chIxBGhlckZTKAn8Gc0C
 Bv8AwFlxv3KTrGkMdBkeAyALy1UoUzR0VglQXlIyXmh_MkQRg47_EDyTGJSxAMye6dMMn8BUkk49
 IdUz0W2fDC.c0o4ST0x9f.cQ5tq.RWWYcmkxRvjAaGLFqLmM9OwNCy0oHupSeROWQlh62y4TOFKc
 yAazeiZXLTTgFM2BrX3pZakDDoddWjLPebrn0YMb5MFVIaG4vhhNua8RqoXCbAPwKBRQh5vc0aAk
 lBJ.1RhDeLoLbb6pOl.7ZOtVxmTpUKKbd2Zsohnhf3j_m1tIvEhkDW5SWhDNUiM21WopoH3Kr1Y5
 ouEyaKCKxXrqcVyoADl.DRwe0.eDv9QzUgg3vaeZkbMrF46F.8Hduquq9fLYQS1fr62n9c68ZHVd
 4fBJ7BfchSCUGtxcv_nLjpjp4pRD9MCIuD_VQShwb0KE0nuGr02xs1LiaXVjU0Rey6.gM4RViWUD
 StadVKs6.fI5H.emxoDRczm04EmK3NDKuCs25Zr4QWHAeNqyNkmMv9pvNnKAFhMtMg0ToL82UDVA
 T6oUP17IdnXMgygtWnbI72ieLlq.uSeM.jhho5D9Xblb5se378LQvjyvwSc3n7aZ7QCNhhp.IvXe
 bUwW7tH8u
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Aug 2020 00:40:51 +0000
Received: by smtp403.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 650ff3ab81c518068402849df9a4632a;
          Wed, 12 Aug 2020 00:40:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     SMACK-discuss@lists.01.org, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com, casey@schaufler-ca.com
Subject: [PATCH 1/3] Smack: Consolidate uses of secmark into a function
Date:   Tue, 11 Aug 2020 17:39:41 -0700
Message-Id: <20200812003943.3036-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200812003943.3036-1-casey@schaufler-ca.com>
References: <20200812003943.3036-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a function smack_from_skb() that returns the Smack label
identified by a network secmark. Replace the explicit uses of
the secmark with this function.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 61 +++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8ffbf951b7ed..3402ac4aa28e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3810,6 +3810,20 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 }
 #endif /* CONFIG_IPV6 */
 
+/**
+ * smack_from_skb - Smack data from the secmark in an skb
+ * @skb: packet
+ *
+ * Returns smack_known of the secmark or NULL if that won't work.
+ */
+static struct smack_known *smack_from_skb(struct sk_buff *skb)
+{
+	if (skb == NULL || skb->secmark == 0)
+		return NULL;
+
+	return smack_from_secid(skb->secmark);
+}
+
 /**
  * smack_socket_sock_rcv_skb - Smack packet delivery access check
  * @sk: socket
@@ -3838,17 +3852,14 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	switch (family) {
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		/*
 		 * If there is a secmark use it rather than the CIPSO label.
 		 * If there is no secmark fall back to CIPSO.
 		 * The secmark is assumed to reflect policy better.
 		 */
-		if (skb && skb->secmark != 0) {
-			skp = smack_from_secid(skb->secmark);
+		skp = smack_from_skb(skb);
+		if (skp)
 			goto access_check;
-		}
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -3862,9 +3873,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 		netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
+
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = family;
@@ -3890,16 +3900,14 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		    proto != IPPROTO_TCP && proto != IPPROTO_DCCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		if (skb && skb->secmark != 0)
-			skp = smack_from_secid(skb->secmark);
-		else if (smk_ipv6_localhost(&sadd))
-			break;
-		else
+		skp = smack_from_skb(skb);
+		if (skp == NULL) {
+			if (smk_ipv6_localhost(&sadd))
+				break;
 			skp = smack_ipv6host_label(&sadd);
-		if (skp == NULL)
-			skp = smack_net_ambient;
-		if (skb == NULL)
-			break;
+			if (skp == NULL)
+				skp = smack_net_ambient;
+		}
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = family;
@@ -3995,11 +4003,11 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		s = skb->secmark;
-		if (s != 0)
+		skp = smack_from_skb(skb);
+		if (skp) {
+			s = skp->smk_secid;
 			break;
-#endif
+		}
 		/*
 		 * Translate what netlabel gave us.
 		 */
@@ -4015,7 +4023,9 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		s = skb->secmark;
+		skp = smack_from_skb(skb);
+		if (skp)
+			s = skp->smk_secid;
 #endif
 		break;
 	}
@@ -4087,17 +4097,14 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	}
 #endif /* CONFIG_IPV6 */
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 	/*
 	 * If there is a secmark use it rather than the CIPSO label.
 	 * If there is no secmark fall back to CIPSO.
 	 * The secmark is assumed to reflect policy better.
 	 */
-	if (skb && skb->secmark != 0) {
-		skp = smack_from_secid(skb->secmark);
+	skp = smack_from_skb(skb);
+	if (skp)
 		goto access_check;
-	}
-#endif /* CONFIG_SECURITY_SMACK_NETFILTER */
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
@@ -4107,9 +4114,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		skp = &smack_known_huh;
 	netlbl_secattr_destroy(&secattr);
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
 access_check:
-#endif
 
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-- 
2.19.1

