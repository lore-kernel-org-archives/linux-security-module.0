Return-Path: <SRS0=sGvM=2B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55DBC43603
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Dec 2019 11:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A9D21556
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Dec 2019 11:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GJ0da8m2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5UkeyQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfLKLoS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:44:18 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37669 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727365AbfLKLoR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Dec 2019 06:44:17 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 415A0221E5;
        Wed, 11 Dec 2019 06:44:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Dec 2019 06:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=q9GfmJu0/uXcjjwNdVXT87y9tv
        f2NAepvRlS76KjFRs=; b=GJ0da8m2WH87Ht44h966jrtP0Zmt91nq++iEcenp+s
        781GGmpBI6qjrNcUfAigwkw5Yss5e9d4+AnuTV0z8u++p5hA6KJvGUvrXIQ/LssM
        6mtYyzPcuRb4CMNMQv3woiTsDkci6wmdXP50iVas7tQPDOVBAo3va5uAw4av3ALX
        Nzi1Bnh1Z0UWeNdFm+Lc6yz8aMNOnhiWwpH3nn54l5B5T6zovpVhmq4letl8NyuQ
        fKcFx8P7ProWrdX/m/4PEOJR9HOWhtpKXYgBdBMfOambgxtj228HvOJZc/AQBD3a
        p4T/BZLjJJaJMAtsLoi9OvnS5XEbRMV3d4HbN1LMY6aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=q9GfmJu0/uXcjjwNd
        VXT87y9tvf2NAepvRlS76KjFRs=; b=L5UkeyQ5D+dpUGbymL26aPvBSWJIQIF2o
        GNxOZoiAxw5RxlZ6J1aOp1ihqpG3Osm4U3asRYAZndARsZu4MRVBXa3DhYicc5qO
        7MdXZuIee6t8POfobaYfwrkfgBqTD3985pUBsUa3NSUlVbOISuC9siLSlfNJX66I
        FBWQdKKAvOkQ8eiwDNetil+i1yWwsxH9eD6w92dXbo0eoMqB4k/T5TTQgO6bxxY5
        mHcobLNV1bgQFDhQnVy6UzfkwO9cuWEPVEPHEJs2malUAjxbYcwOb62kYLlQT0NO
        FZtDrpwrJiqrunlo9LyW7/7vRhXf4/ofWe4K0EdsikJFfwVqm6rIA==
X-ME-Sender: <xms:j9bwXeRmRE-gQqcGF_KBnC8tTx-ygmqU8OiHYNDHOKlMag_EXZHqIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelhedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucffohhmrghinhepihhssh
    huvgdrshgvtghurhhithihnecukfhppeejjedrudekfedrudejjedrudduieenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:j9bwXeBZgNNsjAlQQb9OESx0AUrzRPZ-bBbGl-vGX-Fa8V7vRlo6TA>
    <xmx:j9bwXRQgDhYnM99cgeutqzUYqQrKWOFUjLuWb5nq7DStHoQHxF5skQ>
    <xmx:j9bwXQTA5EntrFSSxWKCLBf2Df3RFrgRVYvRwWDOkLOY99kPpOCV4w>
    <xmx:kNbwXVUIvN8TJz_QE2UpzLAYUxJnHZvAnPAK91oZgxkyUsfVfLQ0bA>
Received: from vm-mail (x4db7b174.dyn.telefonica.de [77.183.177.116])
        by mail.messagingengine.com (Postfix) with ESMTPA id F094D8005B;
        Wed, 11 Dec 2019 06:44:13 -0500 (EST)
Received: from localhost (<unknown> [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 123db24a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Dec 2019 11:44:10 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-security-module@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] apparmor: fix bind mounts aborting with -ENOMEM
Date:   Wed, 11 Dec 2019 12:44:08 +0100
Message-Id: <c70b386ac87254dcd3e23ae5ab168e44b1567e28.1576064594.git.ps@pks.im>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With commit df323337e507 (apparmor: Use a memory pool instead per-CPU
caches, 2019-05-03), AppArmor code was converted to use memory pools. In
that conversion, a bug snuck into the code that polices bind mounts that
causes all bind mounts to fail with -ENOMEM, as we erroneously error out
if `aa_get_buffer` returns a pointer instead of erroring out when it
does _not_ return a valid pointer.

Fix the issue by correctly checking for valid pointers returned by
`aa_get_buffer` to fix bind mounts with AppArmor.

Fixes: df323337e507 (apparmor: Use a memory pool instead per-CPU caches)
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I've fixed the issue on top of v5.5-rc1, where I in fact found
the issue.

 security/apparmor/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 4ed6688f9d40..e0828ee7a345 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -442,7 +442,7 @@ int aa_bind_mount(struct aa_label *label, const struct path *path,
 	buffer = aa_get_buffer(false);
 	old_buffer = aa_get_buffer(false);
 	error = -ENOMEM;
-	if (!buffer || old_buffer)
+	if (!buffer || !old_buffer)
 		goto out;
 
 	error = fn_for_each_confined(label, profile,
-- 
2.24.1

