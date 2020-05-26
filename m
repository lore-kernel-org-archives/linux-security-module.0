Return-Path: <SRS0=6tJK=7I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B94C433E2
	for <linux-security-module@archiver.kernel.org>; Tue, 26 May 2020 16:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE0E20776
	for <linux-security-module@archiver.kernel.org>; Tue, 26 May 2020 16:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OJHulCff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgEZQdp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 May 2020 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgEZQdo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 May 2020 12:33:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDFBC03E96D
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2020 09:33:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n5so183583wmd.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2020 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWEW3WlniXpG51wWswVmYGNyCPa8cDkW5Yfe1j0NFdU=;
        b=OJHulCffT3ruBfvHd9SEc+9Txcjt3lQLkYzB8VZ4Ly5FjtzUoowlahdPAXYFkbKNTP
         3TKt/XeT4Ok+xHE/FND2NiTLG1RCx4FSVSG5MRFzhb2YLP9VqW5rsDnzNw3uYcRAUaJL
         KLOzC7W7DuCP6phTmYMhs4wZbJORByuv/Xx9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWEW3WlniXpG51wWswVmYGNyCPa8cDkW5Yfe1j0NFdU=;
        b=iFbePXE5fXmtvPOGGrd7nL50kHtioumzr06Hf4mn0ISceHZV7NkifLTqE0Bbk2cYxm
         twODtJLxAEh3+6/OxqQ8NsTDRqmd7RrB7Klxnbs9ey+o/njp0GzI+q5l8Y8TQT0uDaCn
         L9yHgK8LbKIxXWLgytfxsHub0XsXSCSDYCNFEptPGLr2FgsQv6jtHkLjCoX0xSs7BELR
         e4cTARKv0aJjKxrjlZLltVuLVGCFjSMq596xPinrMhynJPMhlDX3McQyCVxCGZkHuvBa
         QKiHg1wt0ES84E/D9AQfrohLGTnc3u4N/li8n8WRc7WUNQc+N5HKSrSuapuceeS4O2mv
         01Yg==
X-Gm-Message-State: AOAM533CnsNPwXXF263l/5gF/PLn4wvfL7fyp0OltrASGuwI/hStkKdf
        x18dJg0+YOFZq1rJ7lEc8mKY6g==
X-Google-Smtp-Source: ABdhPJwFCjwCW+QKk6mRvbi8i9/QCbA0M9NZTRlpz1u4B6kn5XIh14q2bhdwwZJRPDCX+1hkrnG9AA==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr63514wmh.27.1590510821258;
        Tue, 26 May 2020 09:33:41 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id k17sm48654wmj.15.2020.05.26.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:33:40 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 3/4] bpf: Allow local storage to be used from LSM programs
Date:   Tue, 26 May 2020 18:33:35 +0200
Message-Id: <20200526163336.63653-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200526163336.63653-1-kpsingh@chromium.org>
References: <20200526163336.63653-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Adds support for both bpf_{sk, inode}_storage_{get, delete} to be used
in LSM programs. These helpers are not used for tracing programs
(currently) as their usage is tied to the life-cycle of the object and
should only be used where the owning object won't be freed. Thus, they
are safe to use in LSM hooks, but can only be enabled in tracing
programs using a whitelist based approach.

Since the UAPI helper signature for bpf_sk_storage expect a bpf_sock,
it, leads to a compilation warning for LSM programs, it's also updated
to accept a void * pointer instead.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_local_storage.h |  2 ++
 kernel/bpf/bpf_local_storage.c    | 22 ++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c              | 20 +++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index c6837e7838fc..8982c0c69332 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -9,6 +9,8 @@ void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto sk_storage_get_btf_proto;
+extern const struct bpf_func_proto sk_storage_delete_btf_proto;
 extern const struct bpf_func_proto bpf_inode_storage_get_proto;
 extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index bf807cfe3a73..07e02d32feb0 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -1305,6 +1305,28 @@ const struct bpf_func_proto bpf_inode_storage_delete_proto = {
 	.btf_id		= bpf_inode_storage_delete_btf_ids,
 };
 
+static int sk_storage_get_btf_ids[4];
+const struct bpf_func_proto sk_storage_get_btf_proto = {
+	.func		= bpf_sk_storage_get,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	= ARG_ANYTHING,
+	.btf_id		= sk_storage_get_btf_ids,
+};
+
+static int sk_storage_delete_btf_ids[2];
+const struct bpf_func_proto sk_storage_delete_btf_proto = {
+	.func		= bpf_sk_storage_delete,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.btf_id		= sk_storage_delete_btf_ids,
+};
+
 struct bpf_sk_storage_diag {
 	u32 nr_maps;
 	struct bpf_map *maps[];
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 19636703b24e..fce0a11b63ca 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -11,6 +11,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
 #include <linux/bpf_verifier.h>
+#include <linux/bpf_local_storage.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -45,10 +46,27 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 	return 0;
 }
 
+static const struct bpf_func_proto *
+bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_inode_storage_get:
+		return &bpf_inode_storage_get_proto;
+	case BPF_FUNC_inode_storage_delete:
+		return &bpf_inode_storage_delete_proto;
+	case BPF_FUNC_sk_storage_get:
+		return &sk_storage_get_btf_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &sk_storage_delete_btf_proto;
+	default:
+		return bpf_tracing_func_proto(func_id, prog);
+	}
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
 const struct bpf_verifier_ops lsm_verifier_ops = {
-	.get_func_proto = bpf_tracing_func_proto,
+	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
-- 
2.27.0.rc0.183.gde8f92d652-goog

