Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B725C56201
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 19:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E772E206D8
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 19:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WyGxkfyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgKJTyy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbgKJTyx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:53 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A02CC0617A7
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2020 11:54:52 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id o11so15577697ioo.11
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2020 11:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsdnGlbr0lhPE8SmZBaqR38QYeMCLW6DuvC/cOgRs/4=;
        b=WyGxkfyjaXlDiuURVfEAzg2/B37i0KaIjIOmRp2sLG3t4BIP5WDrztqce5d88zI7e/
         okoRLtZWM+nDZMhlyAtaaQtJ0ObabN3Ddm96ECDpJ1ezzal9/AwWAjEWIiU1GTC2EIWL
         E8SFomEE6CcZ4oKv5+z79UhA0NIcRN41dhG9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsdnGlbr0lhPE8SmZBaqR38QYeMCLW6DuvC/cOgRs/4=;
        b=aDSZu/5mREx3MhkWe7428+CywExKyYa5Bm4XndK+xlNuGSH1T8MFV1gtMVvHlqqY5p
         m2S4W36s+zyIrFP1us+R7PaMLYCyULpGL/nrjEUeszDQkyP7qt9hA0XznALIESi9n/Hs
         2SqB9NYeZSmIz+78uqZpDY09KOkktCSAzgK19lRCVKb/DxmxoWNpyAyGxMGrYifDNOE+
         uC8OzB0yPZEgtEtp+ADlDieE0faaWo8b17rhJvVZzoixpYf4/AtLx0Ecwf52V4xSvTrU
         FYrioV/BwBwFBtEozdHw9QtYTAn9E5/oFC/ilVuU+Y/Z9QtrBYl545EMKx1sh2vx0+iW
         HBgw==
X-Gm-Message-State: AOAM533RL873dmQ9kd8xLEggiqoPTs5UbWwyVxZqaEf4uW9zw1q52Rth
        wmBZ8IbDsIeXEULo32FuEt8mnw==
X-Google-Smtp-Source: ABdhPJwE3cmu+WVZjNO1l/Yc6cqVUBLsboZpdk8T7Qvt+1Ev96zCzn549KZrMkNryg9QLHOcwWJACw==
X-Received: by 2002:a02:3b67:: with SMTP id i39mr6318143jaf.7.1605038091724;
        Tue, 10 Nov 2020 11:54:51 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:51 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] security/integrity/ima: converts stats to seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:39 -0700
Message-Id: <cbc346bbeb306db3effefac0d27c93e143ac0442.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

seqnum_ops api is introduced to be used when a variable is used as
a sequence/stat counter and doesn't guard object lifetimes. This
clearly differentiates atomic_t usages that guard object lifetimes.

seqnum32 variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used for eima_htable.violations and number of stored
measurements and ios_threshold are atomic counters, and violations is
only an idicator and can overflow. No chane to the behavior with this
change.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 security/integrity/ima/ima.h       | 5 +++--
 security/integrity/ima/ima_api.c   | 2 +-
 security/integrity/ima/ima_fs.c    | 4 ++--
 security/integrity/ima/ima_queue.c | 7 ++++---
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6ebefec616e4..55fe1d14c67a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -21,6 +21,7 @@
 #include <linux/tpm.h>
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
+#include <linux/seqnum_ops.h>
 
 #include "../integrity.h"
 
@@ -174,8 +175,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 extern spinlock_t ima_queue_lock;
 
 struct ima_h_table {
-	atomic_long_t len;	/* number of stored measurements in the list */
-	atomic_long_t violations;
+	struct seqnum64 len;	/* number of stored measurements in the list */
+	struct seqnum64 violations;
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 extern struct ima_h_table ima_htable;
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..b1a203435698 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -144,7 +144,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	int result;
 
 	/* can overflow, only indicator */
-	atomic_long_inc(&ima_htable.violations);
+	seqnum64_inc(&ima_htable.violations);
 
 	result = ima_alloc_init_template(&event_data, &entry, NULL);
 	if (result < 0) {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ea8ff8a07b36..03a78b445052 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -39,12 +39,12 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 static int valid_policy = 1;
 
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
-				     loff_t *ppos, atomic_long_t *val)
+				     loff_t *ppos, struct seqnum64 *val)
 {
 	char tmpbuf[32];	/* greater than largest 'long' string value */
 	ssize_t len;
 
-	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
+	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%lli\n", seqnum64_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index c096ef8945c7..87db50dd1721 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -17,6 +17,7 @@
 
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/seqnum_ops.h>
 #include "ima.h"
 
 #define AUDIT_CAUSE_LEN_MAX 32
@@ -33,8 +34,8 @@ static unsigned long binary_runtime_size = ULONG_MAX;
 
 /* key: inode (before secure-hashing a file) */
 struct ima_h_table ima_htable = {
-	.len = ATOMIC_LONG_INIT(0),
-	.violations = ATOMIC_LONG_INIT(0),
+	.len = SEQNUM_INIT(0),
+	.violations = SEQNUM_INIT(0),
 	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
@@ -106,7 +107,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	INIT_LIST_HEAD(&qe->later);
 	list_add_tail_rcu(&qe->later, &ima_measurements);
 
-	atomic_long_inc(&ima_htable.len);
+	seqnum64_inc(&ima_htable.len);
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
-- 
2.27.0

