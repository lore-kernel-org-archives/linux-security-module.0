Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499CAC6379D
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Nov 2020 00:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A02E22470
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Nov 2020 00:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jM8EIof9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgKUAvE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgKUAvA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Nov 2020 19:51:00 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6347C061A48
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 16:50:58 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so12671833wrg.7
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 16:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHYuFHezrT9t+bXhh+4BwxAp3Fq0ikWSuSe4ApdveEs=;
        b=jM8EIof9lQVclLIGD3xTOvibG0Za+VuXbu11KvIDhCRFbWAEYuftdkOzVo8XkmOyVj
         L5XQqnm2dNfblavcW4ck2YB13zYThv5Bs9USbhOiBdn5IKFDa60229IM4iTDgyxyyXGc
         rwGXLs/65YR58zl2JTnlGUmbDAtDaP+fkStas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHYuFHezrT9t+bXhh+4BwxAp3Fq0ikWSuSe4ApdveEs=;
        b=dQRzKhyVo4piUxnq94SHs20hf49ZTUpTAkxbvSbCBoXlpwgr3TikhCUmaw4o/aW7wM
         hbNZtNRFMMUJ3+/4Wuayqew7Ao8l/4nu9Gv2ibqmU9INlRNFYatJcKh9AbOBsnrasBP2
         q9k2QGU5uLwy69rgnbT8iB6uf6aQPO2HfIYINQQ8LaOaMnCfAjP1InGTF0DbsfG+OeyZ
         Cd17SjzZmsm/Qx+VSO53nqAGc2gul+R9s3rCNLZ4SfNSAwdvIZTOK62jtWe1f7iX57eR
         Vk+BlrtA8bSQeJtpCCwpeQzgISLU5RQmBkL9wiJbEk0J92+SrepNW7bC7zy+BCh4snF5
         S2QA==
X-Gm-Message-State: AOAM531Glm6FJf5PZtim0HevDWA+9vLE/tZUrbSt2SXv0GVilXWNjSpy
        Bpp9ewlyFFCfmTdPFdmtZS+nbOORvsZ2pFpF
X-Google-Smtp-Source: ABdhPJxl0U2xlzd7qidv0xv0LULz8QKyqWnUPssCSpHZpCclg5jqanHFt0FllwP4X9kiHfQXuWLcBQ==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr18477408wrr.353.1605919857354;
        Fri, 20 Nov 2020 16:50:57 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id s8sm7133607wrn.33.2020.11.20.16.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:50:56 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next v2 2/3] bpf: Add a BPF helper for getting the IMA hash of an inode
Date:   Sat, 21 Nov 2020 00:50:53 +0000
Message-Id: <20201121005054.3467947-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201121005054.3467947-1-kpsingh@chromium.org>
References: <20201121005054.3467947-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Provide a wrapper function to get the IMA hash of an inode. This helper
is useful in fingerprinting files (e.g executables on execution) and
using these fingerprints in detections like an executable unlinking
itself.

Since the ima_inode_hash can sleep, it's only allowed for sleepable
LSM hooks.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/uapi/linux/bpf.h       | 11 +++++++++++
 kernel/bpf/bpf_lsm.c           | 26 ++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3ca6146f001a..c3458ec1f30a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3807,6 +3807,16 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
  * 	Return
  * 		Current *ktime*.
+ *
+ * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
+ *	Description
+ *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		If the hash is larger than *size*, then only *size*
+ *		bytes will be copied to *dst*
+ *	Return
+ *		The **hash_algo** is returned on success,
+ *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
+ *		invalid arguments are passed.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3970,6 +3980,7 @@ union bpf_attr {
 	FN(get_current_task_btf),	\
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
+	FN(ima_inode_hash),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index b4f27a874092..bec1f164ba58 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -15,6 +15,7 @@
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
+#include <linux/ima.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -75,6 +76,29 @@ const static struct bpf_func_proto bpf_bprm_opts_set_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_3(bpf_ima_inode_hash, struct inode *, inode, void *, dst, u32, size)
+{
+	return ima_inode_hash(inode, dst, size);
+}
+
+static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
+{
+	return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
+}
+
+BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct, inode)
+
+const static struct bpf_func_proto bpf_ima_inode_hash_proto = {
+	.func		= bpf_ima_inode_hash,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_ima_inode_hash_btf_ids[0],
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+	.allowed	= bpf_ima_inode_hash_allowed,
+};
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -97,6 +121,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_bprm_opts_set:
 		return &bpf_bprm_opts_set_proto;
+	case BPF_FUNC_ima_inode_hash:
+		return &bpf_ima_inode_hash_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index c5bc947a70ad..8b829748d488 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -436,6 +436,7 @@ class PrinterHelpers(Printer):
             'struct xdp_md',
             'struct path',
             'struct btf_ptr',
+            'struct inode',
     ]
     known_types = {
             '...',
@@ -480,6 +481,7 @@ class PrinterHelpers(Printer):
             'struct task_struct',
             'struct path',
             'struct btf_ptr',
+            'struct inode',
     }
     mapped_types = {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3ca6146f001a..c3458ec1f30a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3807,6 +3807,16 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
  * 	Return
  * 		Current *ktime*.
+ *
+ * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
+ *	Description
+ *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		If the hash is larger than *size*, then only *size*
+ *		bytes will be copied to *dst*
+ *	Return
+ *		The **hash_algo** is returned on success,
+ *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
+ *		invalid arguments are passed.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3970,6 +3980,7 @@ union bpf_attr {
 	FN(get_current_task_btf),	\
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
+	FN(ima_inode_hash),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.29.2.454.gaff20da3a2-goog

