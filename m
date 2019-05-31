Return-Path: <SRS0=N7Ha=T7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C10C28CC3
	for <linux-security-module@archiver.kernel.org>; Fri, 31 May 2019 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B71248E4
	for <linux-security-module@archiver.kernel.org>; Fri, 31 May 2019 14:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIf7q2os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEaODj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 May 2019 10:03:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36351 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfEaODi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 May 2019 10:03:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so8012616lfc.3;
        Fri, 31 May 2019 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PRisEFiAzs0UBk9yhEwg6SHyV1hVyDK73ysonpeTsxE=;
        b=hIf7q2osecUnb+VDqvVy0e1Jvx4wqFrUOCxrsclnLXX26wlAjy0a7gcb4i3ujUZeIh
         eCPRF+cbxXIW7hFZiS4rOxueKTS4Fl+cbX2izE7xMlvOCYJ7e/2NxhsOGEbVKYvXXc7k
         jTf3c3C0VRpjxi1h3YWFg9FLtdJxR7h415ic28KHczvFqNu7sTqNOeK73jH8aytM3dKK
         mjGVush5Be69cYQUiZL5xzH0syBPLej9Y9iehk9ItAVygat6bzzyEgi7mdjbo7SAODvj
         iMEPDj//lbT4Imd1mV7+NJ36sWa806wxGx55yA4CwOU6uc0QZlPfHBGfUbhSQGOKQVls
         T9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PRisEFiAzs0UBk9yhEwg6SHyV1hVyDK73ysonpeTsxE=;
        b=kL4ynptWYGP+CTQmrM+wztyOmybZE4/Ss8EwzcCKppV93mnGrr73Aqcr1asxHp1aG1
         4j7URXtC7MOVGUhJKe3PKlJ/yi2IzDo/0H4mmDAMugLr7CYSlVmbPZ4rDf6TLAgXvz7d
         bofPszqqteL50wfv6cdH0xdeMrNnVLYkftWIYxx72REkS7QKrHbe9HaO9R2ownqB2Vs3
         G/q5zRaQAWK626fo77xMr0vi5/EqW28nuj6JvxUPM/NYMHqQanB8nyD8pqiTdopUggNN
         wfjiVfj0bOU281EILb9uSfh5s1US+3798Gq50WKm8KRwtUIjnwMawPkSjiEnWEdXmdwk
         y6hg==
X-Gm-Message-State: APjAAAWvTM4DhrlM0tXokokecr/GrLpXOYs2yR9AsGCj9YV5QyUOW68R
        T/RpG1vgammZ7v+eTzHWzhckf4bzbkg=
X-Google-Smtp-Source: APXvYqyz6dRCdp0U6mfFInrNeB7yoKVKeuEGCJ0ME7oUjv3Ey2VX8RExx84uDZyXTO29uiuZwpYvgg==
X-Received: by 2002:a19:6b04:: with SMTP id d4mr5579063lfa.57.1559311416504;
        Fri, 31 May 2019 07:03:36 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-c1d2e5-213.dhcp.inet.fi. [193.210.229.213])
        by smtp.gmail.com with ESMTPSA id d15sm670412lfq.76.2019.05.31.07.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:03:35 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     sds@tycho.nsa.gov, zohar@linux.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH 1/2] LSM: switch to blocking policy update notifiers
Date:   Fri, 31 May 2019 17:02:36 +0300
Message-Id: <20190531140237.9199-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Atomic policy updaters are not very useful as they cannot
usually perform the policy updates on their own. Since it
seems that there is no strict need for the atomicity,
switch to the blocking variant.

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
---
 security/security.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index 23cbb1a295a3..c5e69ce81521 100644
--- a/security/security.c
+++ b/security/security.c
@@ -39,7 +39,7 @@
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
-static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+static BLOCKING_NOTIFIER_HEAD(lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
@@ -432,19 +432,19 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
-	return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
+	return blocking_notifier_call_chain(&lsm_notifier_chain, event, data);
 }
 EXPORT_SYMBOL(call_lsm_notifier);
 
 int register_lsm_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&lsm_notifier_chain, nb);
+	return blocking_notifier_chain_register(&lsm_notifier_chain, nb);
 }
 EXPORT_SYMBOL(register_lsm_notifier);
 
 int unregister_lsm_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&lsm_notifier_chain, nb);
+	return blocking_notifier_chain_unregister(&lsm_notifier_chain, nb);
 }
 EXPORT_SYMBOL(unregister_lsm_notifier);
 
-- 
2.17.1

