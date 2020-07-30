Return-Path: <SRS0=eGAW=BJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97470C433E3
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jul 2020 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7E206D8
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jul 2020 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E0A4i2w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgG3OHk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgG3OHb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Jul 2020 10:07:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13B4C0617A5
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2020 07:07:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so5853733wmg.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2020 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQ16REQXrSbKev4TR9CO+cQbvJXM0xTGqyjThPsZu04=;
        b=E0A4i2w6tM01pRL+XftpnC3ZA5wD7+Limpje30YG9NJ9LV2S2nzWX9z9rjgcYChD4J
         XAmIZ0NEW63fiqrZk9Fzdx8Gtk/U/slSvozmbr3QR1I+iyLlcI1dLU3QhcQgCnJBrLJq
         iiWQ5lt5V5OqrK8fqVlT58BJjoSBTTJmijZ8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQ16REQXrSbKev4TR9CO+cQbvJXM0xTGqyjThPsZu04=;
        b=Tzb/DnLDGawHgrSf86aWj7uSbNG6vmLN98llmdcpj9x7isSzpMbPVPcuvEQN4pDDds
         iCEZ4S9pHhvHwTc4BTdLMKlE01EExOYvW2ot0ZAPDNdA8Y10bfwBnX114yi8T74FFSH7
         75IQEGyMXjw6zUOwvY+9bQkGi7yKApEdLWhgeK+CC7JHsDJMPk6BS5kHcH+DNXt4e+Cv
         rq1Q8SUzMxhDQIKsjuv+2K3BESPWYmRq1jsQy/HXWOsNPEzAWSwzv3EbM0emJij9fOI5
         2qIqpwf3mKyTUXGYbGh8HzCpZLNACWKDlMy+0RW33bWnM/Adt+rAWokLkaFp/A3W1sWj
         9ftg==
X-Gm-Message-State: AOAM531j+Mng4WL/rDsB9aIVfeLhdf+ZjFjTBJhR1vqIRTX1cieG+PBk
        mIiuLScA/E+0ln6N1FtR4PKnZg==
X-Google-Smtp-Source: ABdhPJwCt3tX4VM5zodhoXO+5nRHp3XyzzidaDHKottr+bMSq0lhtT07TUjF5WO2UoGCf4rziZ/SKg==
X-Received: by 2002:a1c:b156:: with SMTP id a83mr14371059wmf.189.1596118048387;
        Thu, 30 Jul 2020 07:07:28 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a10sm19088599wmd.3.2020.07.30.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:07:27 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v7 6/7] bpf: Allow local storage to be used from LSM programs
Date:   Thu, 30 Jul 2020 16:07:15 +0200
Message-Id: <20200730140716.404558-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200730140716.404558-1-kpsingh@chromium.org>
References: <20200730140716.404558-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Adds support for both bpf_{sk, inode}_storage_{get, delete} to be used
in LSM programs. These helpers are not used for tracing programs
(currently) as their usage is tied to the life-cycle of the object and
should only be used where the owning object won't be freed (when the
owning object is passed as an argument to the LSM hook). Thus, they
are safer to use in LSM hooks than tracing. Usage of local storage in
tracing programs will probably follow a per function based whitelist
approach.

Since the UAPI helper signature for bpf_sk_storage expect a bpf_sock,
it, leads to a compilation warning for LSM programs, it's also updated
to accept a void * pointer instead.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/net/bpf_sk_storage.h   |  2 ++
 include/uapi/linux/bpf.h       |  8 ++++++--
 kernel/bpf/bpf_lsm.c           | 21 ++++++++++++++++++++-
 net/core/bpf_sk_storage.c      | 27 +++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 ++++++--
 5 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 847926cf2899..c5702d7baeaa 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -20,6 +20,8 @@ void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto sk_storage_get_btf_proto;
+extern const struct bpf_func_proto sk_storage_delete_btf_proto;
 
 struct bpf_sk_storage_diag;
 struct sk_buff;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d3617f1ce3fc..c01211c8a7bc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2802,7 +2802,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2818,6 +2818,10 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
+ *		For socket programs, *sk* should be a **struct bpf_sock** pointer
+ *		and an **ARG_PTR_TO_BTF_ID** of type **struct sock** for LSM
+ *		programs.
+ *
  *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
@@ -2830,7 +2834,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index fb278144e9fd..9cd1428c7199 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -11,6 +11,8 @@
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
 #include <linux/bpf_verifier.h>
+#include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -45,10 +47,27 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
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
+		return tracing_prog_func_proto(func_id, prog);
+	}
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
 const struct bpf_verifier_ops lsm_verifier_ops = {
-	.get_func_proto = tracing_prog_func_proto,
+	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 8f6a8d6549be..c547ddf69b91 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -12,6 +12,7 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
+#include <linux/btf_ids.h>
 
 DEFINE_BPF_STORAGE_CACHE(sk_cache);
 
@@ -374,6 +375,32 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 	.arg2_type	= ARG_PTR_TO_SOCKET,
 };
 
+BTF_ID_LIST(sk_storage_get_btf_ids)
+BTF_ID(struct, sock)
+
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
+BTF_ID_LIST(sk_storage_delete_btf_ids)
+BTF_ID(struct, sock)
+
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d3617f1ce3fc..c01211c8a7bc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2802,7 +2802,7 @@ union bpf_attr {
  *
  *		**-ERANGE** if resulting value was out of range.
  *
- * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+ * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
  *	Description
  *		Get a bpf-local-storage from a *sk*.
  *
@@ -2818,6 +2818,10 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
+ *		For socket programs, *sk* should be a **struct bpf_sock** pointer
+ *		and an **ARG_PTR_TO_BTF_ID** of type **struct sock** for LSM
+ *		programs.
+ *
  *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
@@ -2830,7 +2834,7 @@ union bpf_attr {
  *		**NULL** if not found or there was an error in adding
  *		a new bpf-local-storage.
  *
- * long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+ * long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
  *	Description
  *		Delete a bpf-local-storage from a *sk*.
  *	Return
-- 
2.28.0.rc0.142.g3c755180ce-goog

