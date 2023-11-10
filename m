Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5388C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Nov 2023 17:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjKJRls (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjKJRlh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:37 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7644BC8
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 09:34:35 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41cc537ed54so13521471cf.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 09:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699637674; x=1700242474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gb2GPQxPJQ5IJEeZ0DL1pZGv1tdizA9Fxs4gXLll26Q=;
        b=CrbQUq/dQZFug2Ek1ziIilnwER7esmmm/zf9VugEvKPeVg18ZggxrsnWoDDWeiAUwV
         8F/Yz8osaCewInNtfeYKrTQSfq+86Nay5TfF9jOTrLa3MqPE/w7L9jH4xO351NB1hg0H
         coZQ9Sq6Hxz2L7j1nLIv79fsRtQ9lb4j9/3XYuvergr8OQs4OpthYvfZQH8457xdyNcs
         5YSS5XVQWVeBnYdp+1WjhywrJNklfxaXq4xcx8RBGBg+4kg4UNRw5Y7nO/BvXlEULzcE
         DpduAR2xxhUJg9uEpMqbZuuslJQiHh2+kF2KwVCwrR4u69ZVTxF4V5+f/Fuu90jWsn+k
         honw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699637674; x=1700242474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb2GPQxPJQ5IJEeZ0DL1pZGv1tdizA9Fxs4gXLll26Q=;
        b=i1lpkqWmwp1ZzYnwAJsNoBv5f+CxEKuRkz3c0RzHsBgTtQhNZwFJfi0TMx1EJwv4fX
         qXRgjqVN/Ap1lFvd5YTwTIOECLg0tLs9BfZ5ZHYm0qE6dxfdf7+Q6FvduG144wcFnvmv
         WSj7azRvBdXa4aqR8iangYWVVmo16/p5P+UV5NarfPIDebuub5Vxu/SF/ohzy0GyPexw
         DDxw+pA+Qf6W03VzzTzDDL/HwlwKm85+VOVfGOwtmxWuJhqcXwOaa/kFW3e1OZF9XUBO
         IzQfgxf6qKLgtiu1NDWDJEXZODagmk2uZ03Uae0s1uM4yUMxgAUZIsxPimj3bbcIlIcv
         PJXA==
X-Gm-Message-State: AOJu0YzkA1kne/k2yfQGtRsmk7UwRVZ5Qt3H9BbIRDFHqXNXdJul8ZCZ
        1FfMzvM75L7LWORUQtuXZqSDmtn+oSHHytTmOw==
X-Google-Smtp-Source: AGHT+IHWiQ1cz3/a8ixQeTq8PhbMrmf23GEBydZ8AR8pfng3eiEGcYszTurGmSzuo5GMJ46w0BS/rg==
X-Received: by 2002:a05:622a:60e:b0:41e:2314:8dde with SMTP id z14-20020a05622a060e00b0041e23148ddemr9194913qta.38.1699637674067;
        Fri, 10 Nov 2023 09:34:34 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r17-20020ac85e91000000b0041520676966sm2952290qtx.47.2023.11.10.09.34.33
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 09:34:33 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: mark the lsm_id variables are marked as static
Date:   Fri, 10 Nov 2023 12:34:28 -0500
Message-ID: <20231110173427.79275-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4707; i=paul@paul-moore.com; h=from:subject; bh=vYD1CzT8jhOszJn7pO4nFORSiKDtLHYhhUEvQDEmwVA=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlTmmjXTrmyDYJiqHYVMlG/KbBpGmm463iFXCe0 KhW2QGMI/+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZU5powAKCRDqIPLalzeJ c3MmEADEf87j+xFBWLUzvmv8GMYwY/6i3wIRp8paBb0AXrOGpf3Wud5Cf8SsawO1NWn2ITwAh9V foBSNSbBEJGLGMGhiye9mXOBvZBGpP58ZKNaTy1z359D40av1hp9jrp8OlB1Gbu1rvhRKl+oTVZ Uy6r8cbuVO19eyrfeYPqevauJcRxjd32FX5hX+Y79TDYkZX0EybBoJDEx3Gt/7hZITYbn7kutou pUROsy0UR9U90645VdybumL20hi1bL64dY55NAHdT+Yn4S1sQIwK+LvsFt+LtlzspmtmDS2Y7y5 QKyzprkDPr1rFHdqtUdz/4+T6KAF3Ud9MZHMj3Y7zeP2KxdxcKq+RecF6pXgqSfP2EtXbaGxspK 5JTUw1iRYfL0lUghlHiWYhU7WMI//jMb5+SsHB6BlVQ/saab4yHakIgfEdb8UwDN8jBVFpsCEls CEszW8elNvD7ak+MBjeACe04X5ThINNg2lr7QFO7VOEPSz37IlG0zAC6quB3rZPhRknbpEx5KED vvfD9KGOMoeBh2XXrlxqfLMCGV7WMFvPc3+yq8jz+qQvr97yDxZfpb/jaLtFkA3ill4pqHvXOn3 v0LcdCSpbhlFXytKLUEbBZYBDVsj42btTO5GF87Jj8t/l1IYr88R/iNVjpeCZ8kYe4Yly++xxmb MiXNpT32pFSYnBA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As the kernel test robot helpfully reminded us, all of the lsm_id
instances defined inside the various LSMs should be marked as static.
The one exception is Landlock which uses its lsm_id variable across
multiple source files with an extern declaration in a header file.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/apparmor/lsm.c    | 2 +-
 security/bpf/hooks.c       | 2 +-
 security/commoncap.c       | 2 +-
 security/loadpin/loadpin.c | 2 +-
 security/safesetid/lsm.c   | 2 +-
 security/selinux/hooks.c   | 2 +-
 security/smack/smack_lsm.c | 2 +-
 security/tomoyo/tomoyo.c   | 2 +-
 security/yama/yama_lsm.c   | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 332198e0a017..e490a7000408 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1454,7 +1454,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
-const struct lsm_id apparmor_lsmid = {
+static const struct lsm_id apparmor_lsmid = {
 	.name = "apparmor",
 	.id = LSM_ID_APPARMOR,
 };
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 91011e0c361a..57b9ffd53c98 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -16,7 +16,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
-const struct lsm_id bpf_lsmid = {
+static const struct lsm_id bpf_lsmid = {
 	.name = "bpf",
 	.id = LSM_ID_BPF,
 };
diff --git a/security/commoncap.c b/security/commoncap.c
index a64c0c8592bb..162d96b3a676 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1441,7 +1441,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
-const struct lsm_id capability_lsmid = {
+static const struct lsm_id capability_lsmid = {
 	.name = "capability",
 	.id = LSM_ID_CAPABILITY,
 };
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index d682a851de58..8e93cda130f1 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -209,7 +209,7 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_check(NULL, (enum kernel_read_file_id) id);
 }
 
-const struct lsm_id loadpin_lsmid = {
+static const struct lsm_id loadpin_lsmid = {
 	.name = "loadpin",
 	.id = LSM_ID_LOADPIN,
 };
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index f42d5af5ffb0..1ba564f097f5 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -262,7 +262,7 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
 	return 0;
 }
 
-const struct lsm_id safesetid_lsmid = {
+static const struct lsm_id safesetid_lsmid = {
 	.name = "safesetid",
 	.id = LSM_ID_SAFESETID,
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 942f2b8c4ebb..b340425ccfae 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7031,7 +7031,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 }
 #endif /* CONFIG_IO_URING */
 
-const struct lsm_id selinux_lsmid = {
+static const struct lsm_id selinux_lsmid = {
 	.name = "selinux",
 	.id = LSM_ID_SELINUX,
 };
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 99664c8cf867..53336d7daa93 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5006,7 +5006,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 };
 
-const struct lsm_id smack_lsmid = {
+static const struct lsm_id smack_lsmid = {
 	.name = "smack",
 	.id = LSM_ID_SMACK,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 722205433105..e10491f155a5 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -543,7 +543,7 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
-const struct lsm_id tomoyo_lsmid = {
+static const struct lsm_id tomoyo_lsmid = {
 	.name = "tomoyo",
 	.id = LSM_ID_TOMOYO,
 };
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 5cdff292fcae..49dc52b454ef 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -422,7 +422,7 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
-const struct lsm_id yama_lsmid = {
+static const struct lsm_id yama_lsmid = {
 	.name = "yama",
 	.id = LSM_ID_YAMA,
 };
-- 
2.42.1

