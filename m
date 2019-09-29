Return-Path: <SRS0=T0qu=XY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6005C4CED1
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Sep 2019 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9777C21D7D
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Sep 2019 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778880;
	bh=k/CKsmCS30QHIytIpsZwjwBWQ5cbvop2pcjUtBpbhDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J1jzZvcuAdDDhSY29EQZpGXSPZ0JZ/xZIGAor5S7BNK2MXMlGtt3Z2rVAQ2OM+SNi
	 LcrhYRxbZbcbMtpgUfDH6LTNrD1hFXVdlxnQ+9X8TC8pVBj4l/9NC4FKMwdDuREPlf
	 3HmS2mssT12wXdu/rB80u+XyHDtY+0abd888y3ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfI2RlP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730144AbfI2Rdn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 29 Sep 2019 13:33:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A05D521D7F;
        Sun, 29 Sep 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778422;
        bh=k/CKsmCS30QHIytIpsZwjwBWQ5cbvop2pcjUtBpbhDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoLK1y4+y0R0UF/WrD+DGTZmOYljMosgI7noBBYckNdhdZEygzxSIK1vdA4MQFeiS
         MlnxtUIN/IbQ4TorC69Ptv08VfdW2b9I4Mw6hYvxElFvhaJmq2EgUHikvhYM1znkpS
         ZCNA02P4VYvfcn3NQ7EmbUuv9V+HHGzQDVtXI8Zw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 28/42] security: smack: Fix possible null-pointer dereferences in smack_socket_sock_rcv_skb()
Date:   Sun, 29 Sep 2019 13:32:27 -0400
Message-Id: <20190929173244.8918-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173244.8918-1-sashal@kernel.org>
References: <20190929173244.8918-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 3f4287e7d98a2954f20bf96c567fdffcd2b63eb9 ]

In smack_socket_sock_rcv_skb(), there is an if statement
on line 3920 to check whether skb is NULL:
    if (skb && skb->secmark != 0)

This check indicates skb can be NULL in some cases.

But on lines 3931 and 3932, skb is used:
    ad.a.u.net->netif = skb->skb_iif;
    ipv6_skb_to_auditdata(skb, &ad.a, NULL);

Thus, possible null-pointer dereferences may occur when skb is NULL.

To fix these possible bugs, an if statement is added to check skb.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4c5e5a438f8bd..5c9fc8ba6e572 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3925,6 +3925,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
 			skp = smack_net_ambient;
+		if (skb == NULL)
+			break;
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = family;
-- 
2.20.1

