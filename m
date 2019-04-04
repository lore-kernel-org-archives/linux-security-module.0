Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E622BC4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B012177E
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNx4l+uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDDAdx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:53 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37671 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfDDAdw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:52 -0400
Received: by mail-pf1-f201.google.com with SMTP id p8so530550pfd.4
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/UVUOH/6siV2b/2LDB8wDIhEmSTMU547j99QGLitSA4=;
        b=UNx4l+uYxC2/8yEfLLnvPjeztGUpZ/k17H1PH96tTx77KaMo+uQMxPkXWfsx5eLYVk
         W+ADfxCS0pWxwheheyJcmGu3LGPDQuiVdLB5xMb4rGnUR9rDa5ak0eiVcuL1XU0WQcod
         71WBPtNkfHxrhFsr9Ijjqe9y2AaijksBWob6H1yicFYbfkWGTf6rRuXlqvdY+M2ObZwv
         N+822NfjdibPbg/am0i68cS9xk0C3hP4zbvmroCUl8NhECmm4eMpp1C7s2HxLq1bVsoP
         HLJ4iqdP7RM9qvbmiRle6HBquZ0gdJuk3WXukSMAP0IN3spUvTUIjPFxz/AOAV3jSkUt
         KBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/UVUOH/6siV2b/2LDB8wDIhEmSTMU547j99QGLitSA4=;
        b=mnok9inBcWawmq88ElAvoYGegIZ184Fx/ym/RCN0QPkFf2yFojCIsUFJysSE0EjJT+
         5J5s4XS2/VjKJsozfTdAfkirxFmJT9eAI6bf8bl1h5+9WXcAL7V/eIkJ+6mrUARblweu
         J8RVN9MucSRGIwXQCs5fhOK8rYtvM+RVWfS1+1Yf9IisMPQB61rJdu84MN/a6oCYz8UG
         TRvngZfZlc4FSd59CJDS6OHC+ZOT+F9HrCEgW9scshLpdGI72/PDtGDQkXMQpC4SRhu7
         Yh52FpkuN76EeI8MsRurt7+chLPW0BYWDkRjfJMqBiEkx81Ndc6B7YTeLXusKpeRD6z2
         zfKA==
X-Gm-Message-State: APjAAAUlIN+IhVc0xAlV+RsrNJMYwR+Dv9SeoaZ3yPznEvgxFxwZ+HcU
        oaWc8ugwOSNIReBIvB9jD4/WUU/7EINffkYRkyNfmQ==
X-Google-Smtp-Source: APXvYqytkhwGEo6KJI9bBnasM3o3ugsBZVxr+gxHJUJuytlkBrlS2VQ/SpP9mGUjcCydNQLO3I4PbXNhRbxTL9xazROS9w==
X-Received: by 2002:a17:902:280b:: with SMTP id e11mr104020plb.55.1554338031058;
 Wed, 03 Apr 2019 17:33:51 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:44 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 22/27] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>, netdev@vger.kernel.org,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

There are some bpf functions can be used to read kernel memory:
bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
private keys in kernel memory (e.g. the hibernation image signing key) to
be read by an eBPF program and kernel memory to be altered without
restriction. Disable them if the kernel has been locked down in
confidentiality mode.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: netdev@vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/trace/bpf_trace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8b068adb9da1..9e8eda605b5e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -137,6 +137,9 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	if (kernel_is_locked_down("BPF", LOCKDOWN_CONFIDENTIALITY))
+		return -EINVAL;
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
@@ -156,6 +159,8 @@ static const struct bpf_func_proto bpf_probe_read_proto = {
 BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	   u32, size)
 {
+	if (kernel_is_locked_down("BPF", LOCKDOWN_CONFIDENTIALITY))
+		return -EINVAL;
 	/*
 	 * Ensure we're in user context which is safe for the helper to
 	 * run. This helper has no business in a kthread.
@@ -207,6 +212,9 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	char buf[64];
 	int i;
 
+	if (kernel_is_locked_down("BPF", LOCKDOWN_CONFIDENTIALITY))
+		return -EINVAL;
+
 	/*
 	 * bpf_check()->check_func_arg()->check_stack_boundary()
 	 * guarantees that fmt points to bpf program stack,
@@ -535,6 +543,9 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 {
 	int ret;
 
+	if (kernel_is_locked_down("BPF", LOCKDOWN_CONFIDENTIALITY))
+		return -EINVAL;
+
 	/*
 	 * The strncpy_from_unsafe() call will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
-- 
2.21.0.392.gf8f6787159e-goog

