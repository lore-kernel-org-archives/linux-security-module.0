Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE6C3F2D9
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 01:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E2C20828
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 01:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qj2MnbGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbgCDBzo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:55:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53943 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbgCDBzm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Mar 2020 20:55:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id g134so147821wme.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2020 17:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFwEDFxwFXmUVLWHUZGmwB/3Av3jfmxGtvvX+N4FdrI=;
        b=Qj2MnbGGaVof30dTj27lh/GZBYLE3PIXTsAxY968A4WBF2LCnLGMHNx5w536mCOBWJ
         kWzWp+sIQJ0HY2sfzs6Gv0oivqxnZ48PvtYlJSfAqI0rLyefi4arTvONE9v+n/Wmrnzl
         54vExE7YOctQs++jGd+knO1HDUin25BmGNJWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFwEDFxwFXmUVLWHUZGmwB/3Av3jfmxGtvvX+N4FdrI=;
        b=NpkJtoek5Zj5pc+nofEKLS/SyKMt1Ti0frHNLq+Bh776y/2s14mm1XsMxqfVX+Ff06
         F00dO8EkMHW+/yMSP60PNDQMmUx9B51N/0QVmqMP9OBhVy9vFCD8mZkaPR/vaam1bxF0
         Y+s2lF0nYlM/rr1HolKSU7LUaKwN5cZFJVghBjdkxJRmaCFRNVRykN55ZjudG3S5joRI
         Tc0hVk4uOQJlsLhJAwcolPPvhucx7P1FpVMwHto1MgUB8bl3/JABqvJiGBhJJvmNd/Z0
         3+yNjhO9foeRkUJ1WywlW0VN8y30f1d1KBHXZIj+FD7wq90GyZzjKrxZC92bwuISaBbT
         dZWg==
X-Gm-Message-State: ANhLgQ0PFNuCj6GCMEVz33MslI6CNmiy0fafwq9+igpKDIvWdBx15ooC
        UV48sxAAJ/eG5OBC3sO3OIkCRSjjyi0=
X-Google-Smtp-Source: ADFU+vtP1w+hxhEvIU1HHqb6T0eu+C852+A3z482LZmcNH4X4lYJTf3fu9OeA25zRoU99Q/fgMWESQ==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr623325wme.114.1583286940417;
        Tue, 03 Mar 2020 17:55:40 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a184sm1475444wmf.29.2020.03.03.17.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:55:39 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 4/7] bpf: Attachment verification for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 02:55:25 +0100
Message-Id: <20200304015528.29661-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304015528.29661-1-kpsingh@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

- Allow BPF_MODIFY_RETURN attachment only to functions that are:

    * Whitelisted by for error injection i.e. by checking
      within_error_injection_list. Similar disucssions happened for the
      bpf_overrie_return helper.

    * security hooks, this is expected to be cleaned up with the LSM
      changes after the KRSI patches introduce the LSM_HOOK macro:

        https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/

- The attachment is currently limited to functions that return an int.
  This can be extended later other types (e.g. PTR).

Signed-off-by: KP Singh <kpsingh@google.com>
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

