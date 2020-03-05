Return-Path: <SRS0=spL8=4W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A0CC3F2D7
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Mar 2020 22:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B13206E2
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Mar 2020 22:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OyN0As3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgCEWBi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:01:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37852 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCEWBi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Mar 2020 17:01:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id 6so19589wre.4
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2020 14:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRs769N8QUo0slXGjoV/bE6quT349p8P4cDyvi5+xSs=;
        b=OyN0As3WtsQyPWrtZ0mTiBeTZecUOCo749mffQpTDmTx69lKJuE4osS24tJYR/gpHX
         9VrzXIzE920xZDE0WeBQEVk4jHfPgbL+L8RNeX1VBPd6m95OUXVDG4faYkaORxj/wR5E
         oXvLlM71z+RvpZVtk0IWK8zhjSZ6NIBdrlVwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRs769N8QUo0slXGjoV/bE6quT349p8P4cDyvi5+xSs=;
        b=kebzF5bFwRjps3th4WB+F7V8an/JOl6iLxhiy4J2vjAnOCRK5qEnG1aYA6+CT7uD1Z
         Ndn26DTKQDxIEA+sgPKf3YgajkWC8UU4GNG49MRaOXe6X7n2ps4itKtQXyhZftt0Uw19
         uMwLe/CpFc7mnCXhb7oNS5svdVx380vP2DM7mvXEUG/F2reT7k4KPPbitElAJ7wUGEV2
         fdvfhcT+3qFJOiatjMXTUHgT44w4dxaYmd45M2aVnUigEBsyNYKMc8QVlU97/NPfJNVa
         Tkl8hApu63GZIT1seHsRAS8UJY6UoLiQh+2v8vT6m8GmAjk8jKKUmPY1cEOizEz0qRMi
         vaHA==
X-Gm-Message-State: ANhLgQ06Jijn8ZaYJmwavQ1EqgGHURcyYk8cr9Zbrs4i8UMhIEDs8cyf
        HUikYObYWyHczkAjuY6JR8VdiHkxbZQwBw==
X-Google-Smtp-Source: ADFU+vuNWeddf1HH7nZX+stJXAplqB1550B+DJXHvxhEuJ8KddsSUGbg7If5vezjuGur7ZvPeojLkw==
X-Received: by 2002:adf:d4d2:: with SMTP id w18mr66826wrk.180.1583445696430;
        Thu, 05 Mar 2020 14:01:36 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id x9sm5002641wrx.0.2020.03.05.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:01:35 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org, linux-next@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] bpf: Fix bpf_prog_test_run_tracing for !CONFIG_NET
Date:   Thu,  5 Mar 2020 23:01:27 +0100
Message-Id: <20200305220127.29109-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

test_run.o is not built when CONFIG_NET is not set and
bpf_prog_test_run_tracing being referenced in bpf_trace.o causes the
linker error:

ld: kernel/trace/bpf_trace.o:(.rodata+0x38): undefined reference to
 `bpf_prog_test_run_tracing'

Add a __weak function in bpf_trace.c to handle this.

Fixes: da00d2f117a0 ("bpf: Add test ops for BPF_PROG_TYPE_TRACING")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/trace/bpf_trace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 363e0a2c75cf..6a490d8ce9de 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1252,6 +1252,13 @@ static bool tracing_prog_is_valid_access(int off, int size,
 	return btf_ctx_access(off, size, type, prog, info);
 }
 
+int __weak bpf_prog_test_run_tracing(struct bpf_prog *prog,
+				     const union bpf_attr *kattr,
+				     union bpf_attr __user *uattr)
+{
+	return -ENOTSUPP;
+}
+
 const struct bpf_verifier_ops raw_tracepoint_verifier_ops = {
 	.get_func_proto  = raw_tp_prog_func_proto,
 	.is_valid_access = raw_tp_prog_is_valid_access,
-- 
2.20.1

