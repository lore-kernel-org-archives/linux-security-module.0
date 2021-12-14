Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FF9C433FE
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Dec 2021 09:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhLNJpg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Dec 2021 04:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhLNJpf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Dec 2021 04:45:35 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29BFC06173F
        for <linux-security-module@vger.kernel.org>; Tue, 14 Dec 2021 01:45:34 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso16424397edc.10
        for <linux-security-module@vger.kernel.org>; Tue, 14 Dec 2021 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JYcreOWass/O0g4mIovOVIM4ETtWOpNnbMMQBbEG/c4=;
        b=UoV8HI1VlFYbMX06h37FjeMBodXU6/GnOXYoMAYgUJCD41WC9P+YcJ3n8ha93s/NyA
         Qiqq97Woi/wL8lgyfvLdv9sfzQptBuB2xzD7FEMG40riXGqs31l+11n0jdmgF3Ia3qP6
         ZNr1tnv1Uz7xJImbuAVMUFajvQnoXf9beM1Q1iNiZ1EitGS/aI2dnpQQJdyt6EsxpuX0
         oavORWiSvW25qFGGdmjqEmenIlJK5cka2nSevvOVJCyQo8o+T50ZHMVF10zC8yPpi4xv
         JLPoJF5QbzkRbqA2OM/whXvB8GvgQ2vpRtWCRHlns+H47TUrHeXE3AlFX1SsUseo/0Co
         /LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JYcreOWass/O0g4mIovOVIM4ETtWOpNnbMMQBbEG/c4=;
        b=3B8960i81U3XZGSY/wnRhcyhlaAOr23ZhRJjOsdOaXcaT8gOdRDJqYZrNBTRaack5s
         I+R+hMEMtin9IOcyX76arO5b2MrocaJpEY2G66i+Wy0Y8k4mNpV9GPUPCYpt5QnOK8Zb
         hX8ClzbS1IgCrdK/ecYUjSKxvWD96hXzW40K9fO/mvEpTLOHxIU4KsHmUM2l6R9DkWkX
         1XfUNhYAikEpRWREgVzVjUFvEbp6zUyoeGM9WAQ2siamAE2p4MIdC/sww0w0mN2hWHQr
         jGsa5BUWgQpiuZyDHKoEnjFWUjOB7gfnLz5Qn61zGniZKL5DDrlg56oyenlh0P90sEwg
         OpQQ==
X-Gm-Message-State: AOAM531uWfDRmYF/i05XHrW07xPO4pzNj5hNZQtVh+YOwBndvzhj9qdc
        iHCvUN84DVLPWc2r+3SVL2uTzoUIDgXB
X-Google-Smtp-Source: ABdhPJytufiypJLVS8/CJwhj8n4nqNs9eAWemEDWVEVktfvGo4rnmFlZLe7SCPuEgjCprlrhDpZKLYhxyOVM
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:2dbe:8a64:49c3:7849])
 (user=dvyukov job=sendgmr) by 2002:a17:907:a40b:: with SMTP id
 sg11mr4601636ejc.534.1639475133427; Tue, 14 Dec 2021 01:45:33 -0800 (PST)
Date:   Tue, 14 Dec 2021 10:45:26 +0100
Message-Id: <20211214094526.2442154-1-dvyukov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] tomoyo: Check exceeded quota early in tomoyo_domain_quota_is_ok().
From:   Dmitry Vyukov <dvyukov@google.com>
To:     takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp,
        jmorris@namei.org, serge@hallyn.com
Cc:     nogikh@google.com, Dmitry Vyukov <dvyukov@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If tomoyo is used in a testing/fuzzing environment in learning mode,
for lots of domains the quota will be exceeded and stay exceeded
for prolonged periods of time. In such cases it's pointless (and slow)
to walk the whole acl list again and again just to rediscover that
the quota is exceeded. We already have the TOMOYO_DIF_QUOTA_WARNED flag
that notes the overflow condition. Check it early to avoid the slowdown.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 security/tomoyo/util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 1da2e3722b126..af8cd2af3466d 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -1051,6 +1051,8 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 		return false;
 	if (!domain)
 		return true;
+	if (READ_ONCE(domain->flags[TOMOYO_DIF_QUOTA_WARNED]))
+		return false;
 	list_for_each_entry_rcu(ptr, &domain->acl_info_list, list,
 				srcu_read_lock_held(&tomoyo_ss)) {
 		u16 perm;
@@ -1096,14 +1098,12 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 	if (count < tomoyo_profile(domain->ns, domain->profile)->
 	    pref[TOMOYO_PREF_MAX_LEARNING_ENTRY])
 		return true;
-	if (!domain->flags[TOMOYO_DIF_QUOTA_WARNED]) {
-		domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true;
-		/* r->granted = false; */
-		tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
+	WRITE_ONCE(domain->flags[TOMOYO_DIF_QUOTA_WARNED], true);
+	/* r->granted = false; */
+	tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
 #ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
-		pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
-			domain->domainname->name);
+	pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
+		domain->domainname->name);
 #endif
-	}
 	return false;
 }

base-commit: 5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
-- 
2.34.1.173.g76aa8bc2d0-goog

