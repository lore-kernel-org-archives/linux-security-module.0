Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284ADC4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Dec 2022 22:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLNWDX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLNWDV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 17:03:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A12A26B
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 14:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671055354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zZI+v6Iz9fu4P+tN9ii9dNN7/Dql4T2fwtA0wpvKfc=;
        b=MHYr16KPRrYh3zLm47EjxJGGVWW/nI5YJ/3FOOC/gx/4PerXFuuqkGOsesW+dh40I3RR3W
        m/T4wDbY6kUQWdRt8y3uOzq67Nb618ZL8MCuz3XwYBUsvnApYsqKJ13fu6Df1zMRVsTj0Y
        UjBrEwh5HNGfq4Bl2dM4q4B2N8Zwyvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-Lg97WhIKM2CucLxNJf-hRQ-1; Wed, 14 Dec 2022 17:02:31 -0500
X-MC-Unique: Lg97WhIKM2CucLxNJf-hRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BF93802C1C;
        Wed, 14 Dec 2022 22:02:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED0BF40C2064;
        Wed, 14 Dec 2022 22:02:29 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Subject: [PATCH 2/2] selinux: Implement mptcp_add_subflow hook
Date:   Wed, 14 Dec 2022 23:01:58 +0100
Message-Id: <d6f04d238c8a797899d6cb543a43f75e544221af.1671054577.git.pabeni@redhat.com>
In-Reply-To: <cover.1671054577.git.pabeni@redhat.com>
References: <cover.1671054577.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Newly added subflows should inherit the associated label
from the current process context, regarless of the sk_kern_sock
flag value.

This patch implements the above resetting the subflow sid, deleting
the existing subflow label, if any, and then re-creating a new one.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 security/selinux/hooks.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c5be76a9199..cbb4c711c502 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5476,6 +5476,35 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 	selinux_netlbl_sctp_sk_clone(sk, newsk);
 }
 
+static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct sk_security_struct *ssksec = ssk->sk_security;
+	u16 sclass;
+	u32 sid;
+	int err;
+
+	/* create the sid using the current cred, regardless of the ssk kern
+	 * flag
+	 */
+	sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
+					       ssk->sk_protocol);
+	err = socket_sockcreate_sid(tsec, sclass, &sid);
+	if (err)
+		return err;
+
+	ssksec->sid = sid;
+
+	/* replace the existing subflow label with the new one
+	 * inherited from the mptcp socket
+	 */
+	if (ssksec->nlbl_secattr != NULL) {
+		netlbl_secattr_free(ssksec->nlbl_secattr);
+		ssksec->nlbl_secattr = NULL;
+	}
+	return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
+}
+
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
@@ -7216,6 +7245,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sctp_sk_clone, selinux_sctp_sk_clone),
 	LSM_HOOK_INIT(sctp_bind_connect, selinux_sctp_bind_connect),
 	LSM_HOOK_INIT(sctp_assoc_established, selinux_sctp_assoc_established),
+	LSM_HOOK_INIT(mptcp_add_subflow, selinux_mptcp_add_subflow),
 	LSM_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
 	LSM_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
-- 
2.38.1

