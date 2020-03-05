Return-Path: <SRS0=spL8=4W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0D6C3F2D2
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Mar 2020 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927220870
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Mar 2020 20:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oB/PPOYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEUuF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:50:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44570 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgCEUuD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Mar 2020 15:50:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id n7so8663904wrt.11
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2020 12:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KEfmruotSqhGTFUFxO/QW9JoUqhcmY2AakhHNMdqRo=;
        b=oB/PPOYSUG+ODvgRhZg5BbzVpqBfv+G+lqC3thkF+aDFBy1G1+1TSx08xO50tVNH28
         flJXZhESLQjxU4hoo8x9/4ckg453ezuG396NaKCx+HkzRITMFuwp0jR3UivxapLfEiOC
         vU/qF0FIjUNxLRugU665iHhYQtCySF5kKx9Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KEfmruotSqhGTFUFxO/QW9JoUqhcmY2AakhHNMdqRo=;
        b=im3rEYFplzAg155MMRVdv4cmHLuyi0QyDhiYLSuwXXsddNNeoSOxrYrUs5k6Yz19mS
         JNrttr8b8X8/NYsflk4IBH8Sfs+eR2eFzicfb1C1F81tUaPkkhUc1X8N9JnIcGp/xaLh
         kwX15j9a3z6ndWp/6YWSUlqHIYD8EmN3gkFbjdUYIY27tEWnVolDegCaRvNg0Z2aWr3V
         LddqoWrKGB3IjG6rifzxU6NP61j3N+uj16J/r4DVZFYP38+cXv3jqqMGArlo/3p9Q3Ez
         /VRC3lLMbQIMOlaQs4PrkMEPHXji9TrlOVRdQXwcQmB/uC3Sgyg1RaNAYOk/g3GLz6cl
         CH2g==
X-Gm-Message-State: ANhLgQ1FaAwsAvuzSiUrGb+0++uY3lI+A0EVuYx7TcfaAxxZry+du7aK
        /2Je4paX0zcr/Sib+2tWKBbj5ig1m20iGQ==
X-Google-Smtp-Source: ADFU+vsnUQrZpOi5VFZtfDihFlFQvHK8Y7uNQrEn+6t32yP+GM+QPKOlo7OKipnSjH7ihs/CuMFnxw==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr787323wrt.132.1583441400388;
        Thu, 05 Mar 2020 12:50:00 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id r19sm10150874wmh.26.2020.03.05.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:49:59 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] bpf: Remove unnecessary CAP_MAC_ADMIN check
Date:   Thu,  5 Mar 2020 21:49:55 +0100
Message-Id: <20200305204955.31123-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

While well intentioned, checking CAP_MAC_ADMIN for attaching
BPF_MODIFY_RETURN tracing programs to "security_" functions is not
necessary as tracing BPF programs already require CAP_SYS_ADMIN.

Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/bpf/verifier.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ae32517d4ccd..55d376c53f7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9808,20 +9808,13 @@ static int check_attach_modify_return(struct bpf_verifier_env *env)
 	struct bpf_prog *prog = env->prog;
 	unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
 
-	if (within_error_injection_list(addr))
-		return 0;
-
 	/* This is expected to be cleaned up in the future with the KRSI effort
 	 * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
 	 */
-	if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
-		     sizeof(SECURITY_PREFIX) - 1)) {
-
-		if (!capable(CAP_MAC_ADMIN))
-			return -EPERM;
-
+	if (within_error_injection_list(addr) ||
+	    !strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
+		     sizeof(SECURITY_PREFIX) - 1))
 		return 0;
-	}
 
 	verbose(env, "fmod_ret attach_btf_id %u (%s) is not modifiable\n",
 		prog->aux->attach_btf_id, prog->aux->attach_func_name);
-- 
2.20.1

