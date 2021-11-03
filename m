Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C7BC433F5
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 07:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CB661166
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 07:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhKCHeO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Nov 2021 03:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKCHeM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Nov 2021 03:34:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D449C061714;
        Wed,  3 Nov 2021 00:31:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so723781pjb.4;
        Wed, 03 Nov 2021 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tlBDlVal1KG6zXw+Y+LdgDK2QBV75F/H10pKxwlc5xU=;
        b=DoIqXaUgabSui7mO3St0+U75IJrVAVBvEuOv9BPHzR5GA+gnJhKEad18SN3sloRfvN
         wVYA9SjbiIQEVyvtjMmAtTbN1m6hv6NJcGDgUPAuFRRBw9oqMKiDOLQhBlflWyeMZebV
         LARaZ6nXbZoXya7omSoodYZtZLSkzWPxeuOzeaJG2rWj5Y6ACiUHyrpLowb1UcziB0al
         U/zPJx/eBsXH5REwYnnZeJJrAHO5ZxMD46CyW1Ke1UVw9oFS5/tTu9aMuAcQlXp4339J
         hNNyPDolVuyurN6ggsRzoq7aLQH1db+UxQ6B3RqRnK9bZXbBjT+C4zb/GudNfedy37Og
         8yjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tlBDlVal1KG6zXw+Y+LdgDK2QBV75F/H10pKxwlc5xU=;
        b=qiN4irn0RFJJ0FwgJpEQi69LOsogOdF55neRUFth7m3pSJTmNiC/UlK5uC+T5EHOqK
         DY/pOWYFyR8BeCu+IjOk/a1o9Yd/iSFMgcgjcyLLT3zRcnSARCCpmcQVCxYldWtz/vGX
         X3DLYumwk8G6XuKq6Q//iFMMpQBmFYuYKJc14rxyWLlI5vZ9ewzAljDmn3TK1Q3a4jQW
         C3eWtIvdR2eJPtf/QBoy+XUI+iTClQ6tt9zA+/vqkDBQ84QiVj1ZYa8xubApwCYtuD1U
         k2McbsRs8B0Crbl7Del7EYmXo0PHsTfOdmk6hwXL5UkPOkxshekurmzHrWWcmIEdaMT7
         tnhA==
X-Gm-Message-State: AOAM532Hq8W982quCqOJIGUtDESD+NF1CIh2Ygd7CyVDixtp0tQU0Fku
        uUSMt8GhhSsMnAl9bCRek2Ccw7akgs70Ow==
X-Google-Smtp-Source: ABdhPJxDStkl0WN6KfNlIGGMahJI6wXL8tpPGOrcMt66IsojNI3Rz7HZ/LqKD3FiT6HtTdgFrowSFg==
X-Received: by 2002:a17:90a:8c0f:: with SMTP id a15mr12954457pjo.25.1635924696053;
        Wed, 03 Nov 2021 00:31:36 -0700 (PDT)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id c1sm1475326pfv.54.2021.11.03.00.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 00:31:35 -0700 (PDT)
Date:   Wed, 3 Nov 2021 07:31:31 +0000
From:   Austin Kim <austindh.kim@gmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] smack: clean up smack_enabled to be more readable
Message-ID: <20211103073131.GA15173@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The smack_enabled is only set to 0, 1. So changing type of smack_enabled 
as bool may make relevant routine be more readable.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 security/smack/smack.h           | 2 +-
 security/smack/smack_lsm.c       | 4 ++--
 security/smack/smack_netfilter.c | 2 +-
 security/smack/smackfs.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 99c3422596ab..dc1726f5953f 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -302,7 +302,7 @@ int smack_populate_secattr(struct smack_known *skp);
 /*
  * Shared data.
  */
-extern int smack_enabled __initdata;
+extern bool smack_enabled __initdata;
 extern int smack_cipso_direct;
 extern int smack_cipso_mapped;
 extern struct smack_known *smack_net_ambient;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index efd35b07c7f8..ba3b46bd2ceb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -56,7 +56,7 @@ static DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
 #endif
 struct kmem_cache *smack_rule_cache;
-int smack_enabled __initdata;
+bool smack_enabled __initdata;
 
 #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
 static struct {
@@ -4953,7 +4953,7 @@ static __init int smack_init(void)
 	 * Register with LSM
 	 */
 	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
-	smack_enabled = 1;
+	smack_enabled = true;
 
 	pr_info("Smack:  Initializing.\n");
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index b945c1d3a743..82092d9387a3 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -70,7 +70,7 @@ static struct pernet_operations smack_net_ops = {
 
 static int __init smack_nf_ip_init(void)
 {
-	if (smack_enabled == 0)
+	if (smack_enabled == false)
 		return 0;
 
 	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 658eab05599e..7649ad8cc335 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2993,7 +2993,7 @@ static int __init init_smk_fs(void)
 	int err;
 	int rc;
 
-	if (smack_enabled == 0)
+	if (smack_enabled == false)
 		return 0;
 
 	err = smk_init_sysfs();
-- 
2.20.1

