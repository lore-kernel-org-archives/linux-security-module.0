Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB64C10F1B
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Dec 2022 19:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLIT5x (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Dec 2022 14:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLIT5v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 14:57:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3810B7E
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 11:57:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so9219400pje.5
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 11:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XypqeZMvpiFBQfKazI4yp1JHuUPb1a6M6ceDHFy28A=;
        b=M5n6hU4k6Urjc1b8A4bfo2FADCmgqjyOT5RWHnMPB/SqqsUDZ4fLBlIY4ROxrMpBye
         uKNUel9RHTB4ltOibK0PvCyC8WYugKqdmfTgUEVSB7es6TMeUtpv2Mjg2KhG2NQklR3M
         8vg7HvNWzvPLaSc2wADx8p+NEGdzyw9Gk05dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XypqeZMvpiFBQfKazI4yp1JHuUPb1a6M6ceDHFy28A=;
        b=DUKqDsgY2PV+tDlNZHStmV/L0y4l73bErOVpCjmuD0MSNCJe+1Fg0K5RKaXXs84zAW
         snUtRitpLZAolOhzeKyhXlBGikD+QplaqRZ5MN7li7OAaQyFohXcY7JmAB423vhAoqXa
         97iDjxrwcUBZPYDvOj9t98Ip2EE2KRTtRhwZlzRaEoBz8jWhEPhSUSTg1iYo0+/78HhM
         lhrzzTxERCWo4gjGoS6zZUjM2wUdmKoE1l8jwsT0LEkyoaIdhWJaMSlGzFYQAIMcEFfe
         Bq82rzsns5CyC6ji0jDdxCRrqwfrnzGRynEnclBclvXDfRA9QXO4+A+Jw1Ljmv1cAK/v
         n2Dg==
X-Gm-Message-State: ANoB5pmcP2TAGjanIB2B94+hvjwjccJXxZgIjmrVoOU2/XqsfMo0cugo
        qktqwnNyMDeRE8DXJ1vj3IMVCFhMznUxnDSN
X-Google-Smtp-Source: AA0mqf4fudLoPpO6yNB6YzDD7437nfNWC6VO0ndSpCuM6VKuXMc04sPe/nHaL1cMX/EWJAhsqqJ/Vg==
X-Received: by 2002:a17:902:b907:b0:186:c958:663 with SMTP id bf7-20020a170902b90700b00186c9580663mr7692837plb.31.1670615868692;
        Fri, 09 Dec 2022 11:57:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b00186ad73e2d5sm1686971plg.208.2022.12.09.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:57:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/4] LoadPin: Refactor sysctl initialization
Date:   Fri,  9 Dec 2022 11:57:43 -0800
Message-Id: <20221209195746.1366607-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209195520.never.357-kees@kernel.org>
References: <20221209195520.never.357-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3295; h=from:subject; bh=2jYh3TDSFdAvtFu+IUiUHb6OJqlYWF26TibciCwoy0A=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjk5M4s2Lx06O6PsfoKPZkusBCOUn9OHge4MMdEYfy Cr6MTKCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY5OTOAAKCRCJcvTf3G3AJrXZEA CLu03tFYWms+1oT8WWKW3aJMSIOjW3IFV7RdQCC2FpRaUBfJS9K0q1KRIorqezt7pR4iSy6Wh+f3N2 2QEaE6jVUJPwX4J0iP2bTMC/96T99A+wvf5fmFfq+jL+PJimhoYkMyk1+IVbCJ77nws3y6PfRovNZh 3Usea7tIDp99kVDWs3FBH23s7PUwSh7j2hElSUHsemNbYbolH3aT43Dqqr8WjlRNb5pbGFnVlTUuzE HlMNqFkCIJB7Flym1x5N5Ikd6x08YjRX1C25jEkTOUKSkBDoNA6QlLPY5AuPSXBukLssNQkNl2Oymw K+4/1l9u2uVwa50CiBZ16FsYoxGjGQUAz35iTpBI8Lu+hQAvcNDtEhdAJsOYhm3+NaIb6sK9hjCzAq +9LjJMaAlLXvAsGTTr+DLaFoUef9WWMzLI+4TRAcA0TpAjqPSU+lcqZ9U3mB9RcLRFHCFyLMfX3AaR mibsBk2mtLfza0B/I3sLVNDQTBzsRX+7IOEodVPgCPI4glPfNMq2PSnDzeolnRae3XGOv7IW9cdMYs rIeeO0bdC2iFBrqWqtG7PxVjTOvm6WmIihUi8lXoIz8aEJDPyXeyk2gWAHd5di8to/bgyh88xle0Cd LJNgJ8NtPx7vOibucXKKRkaitsq0iM0ildBzFjfQSTjMUJe056Ko9Ry1uV6w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In preparation for shifting root mount when not enforcing, split sysctl
logic out into a separate helper, and unconditionally register the
sysctl, but only make it writable when the device is writable.

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/loadpin/loadpin.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index ca0eff3ce9d0..5b15f8f7268d 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -52,7 +52,6 @@ static bool deny_reading_verity_digests;
 #endif
 
 #ifdef CONFIG_SYSCTL
-
 static struct ctl_path loadpin_sysctl_path[] = {
 	{ .procname = "kernel", },
 	{ .procname = "loadpin", },
@@ -66,18 +65,29 @@ static struct ctl_table loadpin_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
+		.extra1         = SYSCTL_ONE,
 		.extra2         = SYSCTL_ONE,
 	},
 	{ }
 };
 
-static void report_writable(struct super_block *mnt_sb, bool writable)
+static void set_sysctl(bool is_writable)
 {
 	/*
 	 * If load pinning is not enforced via a read-only block
 	 * device, allow sysctl to change modes for testing.
 	 */
+	if (is_writable)
+		loadpin_sysctl_table[0].extra1 = SYSCTL_ZERO;
+	else
+		loadpin_sysctl_table[0].extra1 = SYSCTL_ONE;
+}
+#else
+static inline void set_sysctl(bool is_writable) { }
+#endif
+
+static void report_writable(struct super_block *mnt_sb, bool writable)
+{
 	if (mnt_sb->s_bdev) {
 		pr_info("%pg (%u:%u): %s\n", mnt_sb->s_bdev,
 			MAJOR(mnt_sb->s_bdev->bd_dev),
@@ -86,21 +96,9 @@ static void report_writable(struct super_block *mnt_sb, bool writable)
 	} else
 		pr_info("mnt_sb lacks block device, treating as: writable\n");
 
-	if (writable) {
-		if (!register_sysctl_paths(loadpin_sysctl_path,
-					   loadpin_sysctl_table))
-			pr_notice("sysctl registration failed!\n");
-		else
-			pr_info("enforcement can be disabled.\n");
-	} else
+	if (!writable)
 		pr_info("load pinning engaged.\n");
 }
-#else
-static void report_writable(struct super_block *mnt_sb, bool writable)
-{
-	pr_info("load pinning engaged.\n");
-}
-#endif
 
 /*
  * This must be called after early kernel init, since then the rootdev
@@ -172,6 +170,7 @@ static int loadpin_check(struct file *file, enum kernel_read_file_id id)
 		 */
 		spin_unlock(&pinned_root_spinlock);
 		report_writable(pinned_root, load_root_writable);
+		set_sysctl(load_root_writable);
 		report_load(origin, file, "pinned");
 	} else {
 		spin_unlock(&pinned_root_spinlock);
@@ -259,6 +258,10 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
+#ifdef CONFIG_SYSCTL
+	if (!register_sysctl_paths(loadpin_sysctl_path, loadpin_sysctl_table))
+		pr_notice("sysctl registration failed!\n");
+#endif
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
 
 	return 0;
-- 
2.34.1

