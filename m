Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCFC4332F
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Feb 2022 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiBLR7m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 12 Feb 2022 12:59:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiBLR7j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 12 Feb 2022 12:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A1AA2E0A6
        for <linux-security-module@vger.kernel.org>; Sat, 12 Feb 2022 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644688774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5RblU/muR32surpJb7XXaw9mmDJULWUJNTXUxoEyEQ=;
        b=c+a6GnYQ4XInT3V5ME8+qRbz22icZrlMVkQ16Ycp7+p2/k5HhLO25izmM946HKPUUrVXeZ
        9H6U1/+CD0JKLS0Aleaaot0PK+D3tnWu+9xz+bhdtHH93W2qR3cs1KFYxcmG4ael8sS7lj
        geT4wXNXT0F3fDXFS3ilJ9Sxutgaif8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-zKG5pkivMHGjn-CgBsYwuQ-1; Sat, 12 Feb 2022 12:59:29 -0500
X-MC-Unique: zKG5pkivMHGjn-CgBsYwuQ-1
Received: by mail-ed1-f70.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso7342215edk.13
        for <linux-security-module@vger.kernel.org>; Sat, 12 Feb 2022 09:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5RblU/muR32surpJb7XXaw9mmDJULWUJNTXUxoEyEQ=;
        b=ZdQSTv/V0HQ5HJp0tTg24wuMrN5rTJOP1Wz461aaQjsRFyZq1wiSEEJVjjrG7m8maS
         xhfbBKFW8dRxWtjzMZxYyDGppx2K1ugFA943AFsep377MUMFpZROtFEz86d3g/gruFqZ
         fYkWp8z9+LzO6eUAy4P/yC9ySRvp76CubLMP84r1Uy9e6RCzuqPH/NLXdm1XY7r1PIby
         3IeYhFWK1TTHBYJvdp2UBAD2d/5QVZBLbywuzNMcqEcTozbxFHKDSoNoIlUrqUwlGBfE
         qdMWOV3/XDgu4aZfTY2QrtqcgGD2kSU/YvKNGvrdGPKhEd6b66VTy6+vuE0V/tqdqZkv
         WUyw==
X-Gm-Message-State: AOAM533a0dinEeqIiiHBM7ZCygCPhHviL/mIKTRC7Ez081OzINHtm1ut
        sp7O7YU+XVqzzwm23A1mYu4IqCkShEDlubI+cGVYT8r0XEv/Va7TP5OGPfmCi8TBlbg0+KHvp7p
        FlVoxedKM5yeILaiQKZGDmvTja/OAZtJunM1X
X-Received: by 2002:a17:906:72c2:: with SMTP id m2mr5408231ejl.185.1644688767793;
        Sat, 12 Feb 2022 09:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw57ju00rK6w8JCy1wMU6yq5Btl/VLmazdQ5/+qt78JXBu42hrVcdWMZg3J3gwh0E78L3tBpA==
X-Received: by 2002:a17:906:72c2:: with SMTP id m2mr5408220ejl.185.1644688767482;
        Sat, 12 Feb 2022 09:59:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id d10sm437409ejo.207.2022.02.12.09.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 09:59:27 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prashanth Prahlad <pprahlad@redhat.com>
Subject: [PATCH net v3 2/2] security: implement sctp_assoc_established hook in selinux
Date:   Sat, 12 Feb 2022 18:59:22 +0100
Message-Id: <20220212175922.665442-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220212175922.665442-1-omosnace@redhat.com>
References: <20220212175922.665442-1-omosnace@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Do this by extracting the peer labeling per-association logic from
selinux_sctp_assoc_request() into a new helper
selinux_sctp_process_new_assoc() and use this helper in both
selinux_sctp_assoc_request() and selinux_sctp_assoc_established(). This
ensures that the peer labeling behavior as documented in
Documentation/security/SCTP.rst is applied both on the client and server
side:
"""
An SCTP socket will only have one peer label assigned to it. This will be
assigned during the establishment of the first association. Any further
associations on this socket will have their packet peer label compared to
the sockets peer label, and only if they are different will the
``association`` permission be validated. This is validated by checking the
socket peer sid against the received packets peer sid to determine whether
the association should be allowed or denied.
"""

At the same time, it also ensures that the peer label of the association
is set to the correct value, such that if it is peeled off into a new
socket, the socket's peer label  will then be set to the association's
peer label, same as it already works on the server side.

While selinux_inet_conn_established() (which we are replacing by
selinux_sctp_assoc_established() for SCTP) only deals with assigning a
peer label to the connection (socket), in case of SCTP we need to also
copy the (local) socket label to the association, so that
selinux_sctp_sk_clone() can then pick it up for the new socket in case
of SCTP peeloff.

Careful readers will notice that the selinux_sctp_process_new_assoc()
helper also includes the "IPv4 packet received over an IPv6 socket"
check, even though it hadn't been in selinux_sctp_assoc_request()
before. While such check is not necessary in
selinux_inet_conn_request() (because struct request_sock's family field
is already set according to the skb's family), here it is needed, as we
don't have request_sock and we take the initial family from the socket.
In selinux_sctp_assoc_established() it is similarly needed as well (and
also selinux_inet_conn_established() already has it).

Fixes: 72e89f50084c ("security: Add support for SCTP security hooks")
Reported-by: Prashanth Prahlad <pprahlad@redhat.com>
Based-on-patch-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 90 +++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 24 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ab32303e6618..dafabb4dcc64 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5238,37 +5238,38 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 	sksec->sclass = isec->sclass;
 }
 
-/* Called whenever SCTP receives an INIT chunk. This happens when an incoming
- * connect(2), sctp_connectx(3) or sctp_sendmsg(3) (with no association
- * already present).
+/*
+ * Determines peer_secid for the asoc and updates socket's peer label
+ * if it's the first association on the socket.
  */
-static int selinux_sctp_assoc_request(struct sctp_association *asoc,
-				      struct sk_buff *skb)
+static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
+					  struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sock *sk = asoc->base.sk;
+	u16 family = sk->sk_family;
+	struct sk_security_struct *sksec = sk->sk_security;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
-	u8 peerlbl_active;
-	u32 peer_sid = SECINITSID_UNLABELED;
-	u32 conn_sid;
-	int err = 0;
+	int err;
 
-	if (!selinux_policycap_extsockclass())
-		return 0;
+	/* handle mapped IPv4 packets arriving via IPv6 sockets */
+	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
+		family = PF_INET;
 
-	peerlbl_active = selinux_peerlbl_enabled();
+	if (selinux_peerlbl_enabled()) {
+		asoc->peer_secid = SECSID_NULL;
 
-	if (peerlbl_active) {
 		/* This will return peer_sid = SECSID_NULL if there are
 		 * no peer labels, see security_net_peersid_resolve().
 		 */
-		err = selinux_skb_peerlbl_sid(skb, asoc->base.sk->sk_family,
-					      &peer_sid);
+		err = selinux_skb_peerlbl_sid(skb, family, &asoc->peer_secid);
 		if (err)
 			return err;
 
-		if (peer_sid == SECSID_NULL)
-			peer_sid = SECINITSID_UNLABELED;
+		if (asoc->peer_secid == SECSID_NULL)
+			asoc->peer_secid = SECINITSID_UNLABELED;
+	} else {
+		asoc->peer_secid = SECINITSID_UNLABELED;
 	}
 
 	if (sksec->sctp_assoc_state == SCTP_ASSOC_UNSET) {
@@ -5279,8 +5280,8 @@ static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 		 * then it is approved by policy and used as the primary
 		 * peer SID for getpeercon(3).
 		 */
-		sksec->peer_sid = peer_sid;
-	} else if  (sksec->peer_sid != peer_sid) {
+		sksec->peer_sid = asoc->peer_secid;
+	} else if (sksec->peer_sid != asoc->peer_secid) {
 		/* Other association peer SIDs are checked to enforce
 		 * consistency among the peer SIDs.
 		 */
@@ -5288,11 +5289,32 @@ static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 		ad.u.net = &net;
 		ad.u.net->sk = asoc->base.sk;
 		err = avc_has_perm(&selinux_state,
-				   sksec->peer_sid, peer_sid, sksec->sclass,
-				   SCTP_SOCKET__ASSOCIATION, &ad);
+				   sksec->peer_sid, asoc->peer_secid,
+				   sksec->sclass, SCTP_SOCKET__ASSOCIATION,
+				   &ad);
 		if (err)
 			return err;
 	}
+	return 0;
+}
+
+/* Called whenever SCTP receives an INIT or COOKIE ECHO chunk. This
+ * happens on an incoming connect(2), sctp_connectx(3) or
+ * sctp_sendmsg(3) (with no association already present).
+ */
+static int selinux_sctp_assoc_request(struct sctp_association *asoc,
+				      struct sk_buff *skb)
+{
+	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	u32 conn_sid;
+	int err;
+
+	if (!selinux_policycap_extsockclass())
+		return 0;
+
+	err = selinux_sctp_process_new_assoc(asoc, skb);
+	if (err)
+		return err;
 
 	/* Compute the MLS component for the connection and store
 	 * the information in asoc. This will be used by SCTP TCP type
@@ -5300,17 +5322,36 @@ static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 	 * socket to be generated. selinux_sctp_sk_clone() will then
 	 * plug this into the new socket.
 	 */
-	err = selinux_conn_sid(sksec->sid, peer_sid, &conn_sid);
+	err = selinux_conn_sid(sksec->sid, asoc->peer_secid, &conn_sid);
 	if (err)
 		return err;
 
 	asoc->secid = conn_sid;
-	asoc->peer_secid = peer_sid;
 
 	/* Set any NetLabel labels including CIPSO/CALIPSO options. */
 	return selinux_netlbl_sctp_assoc_request(asoc, skb);
 }
 
+/* Called when SCTP receives a COOKIE ACK chunk as the final
+ * response to an association request (initited by us).
+ */
+static int selinux_sctp_assoc_established(struct sctp_association *asoc,
+					  struct sk_buff *skb)
+{
+	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+
+	if (!selinux_policycap_extsockclass())
+		return 0;
+
+	/* Inherit secid from the parent socket - this will be picked up
+	 * by selinux_sctp_sk_clone() if the association gets peeled off
+	 * into a new socket.
+	 */
+	asoc->secid = sksec->sid;
+
+	return selinux_sctp_process_new_assoc(asoc, skb);
+}
+
 /* Check if sctp IPv4/IPv6 addresses are valid for binding or connecting
  * based on their @optname.
  */
@@ -7131,6 +7172,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sctp_assoc_request, selinux_sctp_assoc_request),
 	LSM_HOOK_INIT(sctp_sk_clone, selinux_sctp_sk_clone),
 	LSM_HOOK_INIT(sctp_bind_connect, selinux_sctp_bind_connect),
+	LSM_HOOK_INIT(sctp_assoc_established, selinux_sctp_assoc_established),
 	LSM_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
 	LSM_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
-- 
2.34.1

