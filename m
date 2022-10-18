Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A290C43217
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Oct 2022 06:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJRGsr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJRGsq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Oct 2022 02:48:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26536A8CEA
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 23:48:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fw14so13114716pjb.3
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToonhdBLDtMeji9lvBWJLo1j2sJZnvI8FZyXgr9kDwc=;
        b=nRzLEDXMegikXEZwDVYnd3CTiKqZwA/k6ZY7UuZzk1vlYrZHb3sBvfD2uprc2g3sJM
         9bBBOL6zmL5wgNaxEOcd2b/gtUt15CwfzeqMdL6k0Riz0SmkOxFEQ0t8N1dIVOGoMCVu
         ZPGfp2fxICo0/jLEuyd86vfU2zjY1L9FuOSbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToonhdBLDtMeji9lvBWJLo1j2sJZnvI8FZyXgr9kDwc=;
        b=SgA2TcUdiDZPOiyIj9QKXzcNYBPm8JagakphX+KGRgAmqc2F6A205QMUBRYOmwO6fi
         Zn4KneSEaBCfrZr4aveR9vgrL9lsfhxQeMsyLQ8UNOpLs1iSy9xlFkXM/WLq9KvnMsKd
         AcFv3LAn0JR9QN13fAAafRxRH05T2H1CTeRJ+jaTbUNqspBsz4fasIjsP6hrrVX/f35r
         tQ6RqdNEkOa5jzvRtPTCh/hFYNHj2aSz2PXwIW/pehfQJETDhzgXr89KpUhd/wLcXFNl
         qrPhiovrHRDdRncfEQxHp37JqTv19a+GRVAP+Q3/aQMajJD4DAHKZdNz/0E5+L5UcxHe
         5BBA==
X-Gm-Message-State: ACrzQf19sX9GkD18HFNn54tOQBVYncx4XHfEMa2xtLgedLi4nrbua3n5
        h2gksPqHdNjQp3DTb+EQiXnVEQ==
X-Google-Smtp-Source: AMsMyM7KlgUWb2ylzOoezjJfRpNXv3Yab59Vb7Sc81HwnPpz+tUiH1PV4Br+iAJwwwpUoYtQOYL6Gg==
X-Received: by 2002:a17:902:d4c3:b0:185:4c1f:7457 with SMTP id o3-20020a170902d4c300b001854c1f7457mr1585462plg.117.1666075724634;
        Mon, 17 Oct 2022 23:48:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a7ac800b00205d70ccfeesm10561637pjl.33.2022.10.17.23.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 23:48:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] LSM: Better reporting of actual LSMs at boot
Date:   Mon, 17 Oct 2022 23:48:41 -0700
Message-Id: <20221018064825.never.323-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5652; h=from:subject:message-id; bh=y6QbTEGfxV+PUTmVZZur9G80o7SxzSNODkhtDQVLdL8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTkxJT/Gfi3Xq8j2Rk7pydFAhXJIH0C9vEIFUdvVI Emr/SjaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05MSQAKCRCJcvTf3G3AJustD/ kBxHNzsmBxjlFo2AB7MuaH5En/OQXTRyRz285TBekkDYlxbdxNZEN/ODOIGdZbvvqSorNTIcaIx8GG dbAn33NygacNJMS9CzQ/LSDXKMqCdQYzbMqXji2GN3ncmPYv+IzeoIjgdqUtLyFSLVORL6Gnq9Xby1 pn9GNavUPFH9kmoNrNmPnddsEpHWqehEjbnTPkMh8Vb9TsO4kHuULs8Atal0LjEq/smX59VV9SHXoJ uO75h2Y2n59EGIe1x9M84/LGaD4Bgb7XJ3t2RMEoVqAfw5FVeoOdZ0ZAeCoRsDMa2ULzaQszNlnOZq rQ+CAPegUgK+McXrz7Qk80vcmBA2eZRlxpI26b2wX790pr7WC2kzYX12kb/Db2gaHSlPesQqz6b8E4 /gwcmLCHxVd+QxJ09IM77hqAiIIsv/IWRmSLTm2qpmBsHfBWSmekld20rfmXiM38smmxRf1nHdsEQa vJSZpibxC6KYgtEf0Y7cV3VEzXThI3Xkw8ESb49+ZlNfymDsf5+/N5kohnQgv2z/KxzmiZBWALu6qz dkCibw1QRRsfx6tm0MVKv4vmQ7asuM+ZBUk6PzDrh20ubPbYlo/gUkB5FZ7lE+CTVijtPqH9Y4qLpf 0+VN8PDPbT70wrr//uYMBHRaajTLtKeJh6pYtlvd3sJ6MP/zpj2gmHdgA7wg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Enhance the details reported by "lsm.debug" in several ways:

- report contents of "security="
- report contents of "CONFIG_LSM"
- report contents of "lsm="
- report any early LSM details
- whitespace-align the output of similar phases for easier visual parsing
- change "disabled" to more accurate "skipped"
- explain what "skipped" and "ignored" mean in a parenthetical

Upgrade the "security= is ignored" warning from pr_info to pr_warn,
and include full arguments list to make the cause even more clear.

Replace static "Security Framework initializing" pr_info with specific
list of the resulting order of enabled LSMs.

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 61 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index 9696dd64095e..6f6079dec270 100644
--- a/security/security.c
+++ b/security/security.c
@@ -159,7 +159,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		lsm->enabled = &lsm_enabled_true;
 	ordered_lsms[last_lsm++] = lsm;
 
-	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
+	init_debug("%s ordered: %s (%sabled)\n", from, lsm->name,
 		   is_enabled(lsm) ? "en" : "dis");
 }
 
@@ -222,7 +222,7 @@ static void __init prepare_lsm(struct lsm_info *lsm)
 	if (enabled) {
 		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
 			exclusive = lsm;
-			init_debug("exclusive chosen: %s\n", lsm->name);
+			init_debug("exclusive chosen:   %s\n", lsm->name);
 		}
 
 		lsm_set_blob_sizes(lsm->blobs);
@@ -250,7 +250,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* LSM_ORDER_FIRST is always first. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "first");
+			append_ordered_lsm(lsm, "  first");
 	}
 
 	/* Process "security=", if given. */
@@ -289,7 +289,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		}
 
 		if (!found)
-			init_debug("%s ignored: %s\n", origin, name);
+			init_debug("%s ignored: %s (not built into kernel)\n",
+				   origin, name);
 	}
 
 	/* Process "security=", if given. */
@@ -307,7 +308,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		if (exists_ordered_lsm(lsm))
 			continue;
 		set_enabled(lsm, false);
-		init_debug("%s disabled: %s\n", origin, lsm->name);
+		init_debug("%s skipped: %s (not in requested order)\n",
+			   origin, lsm->name);
 	}
 
 	kfree(sep);
@@ -318,6 +320,44 @@ static void __init lsm_early_task(struct task_struct *task);
 
 static int lsm_append(const char *new, char **result);
 
+static void __init report_lsm_order(void)
+{
+	struct lsm_info **lsm, *early;
+	size_t size = 0;
+	char *effective, *step, *end;
+
+	/* Count the length of each enabled LSM name. */
+	for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
+		if (is_enabled(early))
+			size += strlen(early->name) + 1;
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		if (is_enabled(*lsm))
+			size += strlen((*lsm)->name) + 1;
+
+	/* Allocate space with trailing %NUL or give up. */
+	size += 1;
+	effective = kzalloc(size, GFP_KERNEL);
+	if (!effective)
+		return;
+	end = effective + size;
+	step = effective;
+
+	/* Append each enabled LSM name. */
+	for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
+		if (is_enabled(early))
+			step += scnprintf(step, end - step, "%s%s",
+					  step == effective ? "" : ",",
+					  early->name);
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		if (is_enabled(*lsm))
+			step += scnprintf(step, end - step, "%s%s",
+					  step == effective ? "" : ",",
+					  (*lsm)->name);
+
+	pr_info("initializing lsm=%s\n", effective);
+	kfree(effective);
+}
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -327,7 +367,8 @@ static void __init ordered_lsm_init(void)
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
-			pr_info("security= is ignored because it is superseded by lsm=\n");
+			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
+				chosen_major_lsm, chosen_lsm_order);
 			chosen_major_lsm = NULL;
 		}
 		ordered_lsm_parse(chosen_lsm_order, "cmdline");
@@ -337,6 +378,8 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		prepare_lsm(*lsm);
 
+	report_lsm_order();
+
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
@@ -393,13 +436,17 @@ int __init security_init(void)
 {
 	struct lsm_info *lsm;
 
-	pr_info("Security Framework initializing\n");
+	init_debug("legacy security=%s\n", chosen_major_lsm ?: " *unspecified*");
+	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
+	init_debug("boot arg lsm=%s\n", chosen_lsm_order ?: " *unspecified*");
 
 	/*
 	 * Append the names of the early LSM modules now that kmalloc() is
 	 * available
 	 */
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		init_debug("  early started: %s (%sabled)\n", lsm->name,
+			   is_enabled(lsm) ? "en" : "dis");
 		if (lsm->enabled)
 			lsm_append(lsm->name, &lsm_names);
 	}
-- 
2.34.1

