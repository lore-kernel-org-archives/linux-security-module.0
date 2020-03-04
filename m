Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BAFC3F2D1
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123E322B48
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jeBpg3zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbgCDPsR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:48:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34960 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbgCDPsC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 10:48:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id m3so2373685wmi.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 07:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnY0sLzc6EG75w+2zGbx52f2fr6wBzB9p2HqJRSWjIE=;
        b=jeBpg3zx7Fq/WdtomdsFbKI/7lD4yn2XfYDa5pB6rTmiZ12Y115rivK54p00W4iK3w
         1oirVnEoTQV9OKlV+/MaN2u15j9SZI2YyEz2rRzfxxDzE3go9t3zRfzpO8zmihWIMJLb
         2jSWVAnSZjoyr7Y3W/CZpolMgiS8wq7Ypo414=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnY0sLzc6EG75w+2zGbx52f2fr6wBzB9p2HqJRSWjIE=;
        b=RVHJPQSkS7y39Wgx63G0AQ4JTRBHkBeYc94Wo6OCBm4k2e8WaUivv4K26GytGJjwcD
         bOzYKcDTLmLViYMfj1N1fTO/pPVQo7PjQuDvBkLaSK/FrkrosN27DOGnj9JhdGphCHZq
         1jQUj1rJevnsuk7K77ATD+5CHXUOao/zrGvXlzDxy2aWRyODOfeFFr1ZOe2SdQSOKOVe
         rrAGU9ZveAKnwN2rKqmQOtDczSgvmUbl1RKYxRabqxP0FaNt16a705GlIaadnHtTa5M6
         4GcpR9DoJV3R5e3137OucqI7nXaytfZ0TGzLeQj7APpObl1lV0d9j3AyigtGhe7jX87I
         9Lug==
X-Gm-Message-State: ANhLgQ1ee+shZtw8fLdf7XPaKtC8ZSqJyq8w5Sg0uO7pJNnKX7oz1zCo
        3FjePzJIVlzmHC3nf1Ppd/DozxjrOUc=
X-Google-Smtp-Source: ADFU+vtyWWEd7y4ar3XJjKvHHh8Lk8eZl5HKOd3/C8g5c0EZydhJWiwJ4rMhfCmFH57jJGr+drrg5A==
X-Received: by 2002:a1c:1b11:: with SMTP id b17mr4150774wmb.93.1583336878995;
        Wed, 04 Mar 2020 07:47:58 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id u25sm4816091wml.17.2020.03.04.07.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:47:58 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 4/7] bpf: Attachment verification for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 16:47:44 +0100
Message-Id: <20200304154747.23506-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304154747.23506-1-kpsingh@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

- Allow BPF_MODIFY_RETURN attachment only to functions that are:

    * Whitelisted for error injection by checking
      within_error_injection_list. Similar discussions happened for the
      bpf_override_return helper.

    * security hooks, this is expected to be cleaned up with the LSM
      changes after the KRSI patches introduce the LSM_HOOK macro:

        https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/

- The attachment is currently limited to functions that return an int.
  This can be extended later other types (e.g. PTR).

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 30841fb8b3c0..50080add2ab9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3710,14 +3710,26 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		nr_args--;
 	}
 
-	if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
-	     prog->expected_attach_type == BPF_MODIFY_RETURN) &&
-	    arg == nr_args) {
-		if (!t)
-			/* Default prog with 5 args. 6th arg is retval. */
-			return true;
-		/* function return type */
-		t = btf_type_by_id(btf, t->type);
+	if (arg == nr_args) {
+		if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
+			if (!t)
+				return true;
+			t = btf_type_by_id(btf, t->type);
+		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+			/* For now the BPF_MODIFY_RETURN can only be attached to
+			 * functions that return an int.
+			 */
+			if (!t)
+				return false;
+
+			t = btf_type_skip_modifiers(btf, t->type, NULL);
+			if (!btf_type_is_int(t)) {
+				bpf_log(log,
+					"ret type %s not allowed for fmod_ret\n",
+					btf_kind_str[BTF_INFO_KIND(t->info)]);
+				return false;
+			}
+		}
 	} else if (arg >= nr_args) {
 		bpf_log(log, "func '%s' doesn't have %d-th argument\n",
 			tname, arg + 1);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2460c8e6b5be..ae32517d4ccd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19,6 +19,7 @@
 #include <linux/sort.h>
 #include <linux/perf_event.h>
 #include <linux/ctype.h>
+#include <linux/error-injection.h>
 
 #include "disasm.h"
 
@@ -9800,6 +9801,33 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 
 	return 0;
 }
+#define SECURITY_PREFIX "security_"
+
+static int check_attach_modify_return(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
+
+	if (within_error_injection_list(addr))
+		return 0;
+
+	/* This is expected to be cleaned up in the future with the KRSI effort
+	 * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
+	 */
+	if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
+		     sizeof(SECURITY_PREFIX) - 1)) {
+
+		if (!capable(CAP_MAC_ADMIN))
+			return -EPERM;
+
+		return 0;
+	}
+
+	verbose(env, "fmod_ret attach_btf_id %u (%s) is not modifiable\n",
+		prog->aux->attach_btf_id, prog->aux->attach_func_name);
+
+	return -EINVAL;
+}
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
 {
@@ -10000,6 +10028,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		}
 		tr->func.addr = (void *)addr;
 		prog->aux->trampoline = tr;
+
+		if (prog->expected_attach_type == BPF_MODIFY_RETURN)
+			ret = check_attach_modify_return(env);
 out:
 		mutex_unlock(&tr->mutex);
 		if (ret)
-- 
2.20.1

