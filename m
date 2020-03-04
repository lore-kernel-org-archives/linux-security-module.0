Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A25C3F2D7
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 01:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257652166E
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 01:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dydE0fdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbgCDBz4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:55:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44632 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387555AbgCDBzn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Mar 2020 20:55:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id n7so346006wrt.11
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2020 17:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=dydE0fdupSCSgVGrBqAu7BEK7YS/h8wM7+7qNQDN2fplhkdABH767hEJX4e9Z4s7ki
         UGoRSNWWepKiAFpfQ80oZO021g8hSXTocLjcuZzQIzMr2c3DkJYJBBmgeFY/J54ftLGw
         dhWtOYBd6PtPRXMxKl7C8G2pXNOdr7Px4GHLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=roh8UUVmLEhsPFfr7KHwe1lhspWyHG0Uy+JLJ9ZKO4oa/xHO1BLX9/jVol7hm4UufM
         3qaJFp4G6NrxLIc+HTWRVWNQ+8d4KBJjnR1CGW9fPtK9g5S/zUxh6GPkxUS1YoyA9o3v
         FRW2zdaT42g8EcHC0Ibnj8iglI+gM/Z3Ar8uuSO7QgCvTdV02KHrjM2yB01UNq6LWvRK
         LqVpolB8g1gzUP0INe20ZkM+IlmrQ/k2a0RF3OsrrWjrwyNUUr/xMLYJjZGzlVYCSEJS
         pPt7txnABheLs+ce0Qp5X7AKvQKte8F/ejb0Mn9fggVpgcYpG1d2FK2tHkeQsx46rR/Y
         tzEA==
X-Gm-Message-State: ANhLgQ2OfAEvo094jGbLqbO/4hzby59rJfz1mE4dJzmVorl1JKVBz3j7
        gmiDJONNdPWnSow3CVFSfd5cGz+oRz4=
X-Google-Smtp-Source: ADFU+vsFTzDOzPrEEGIEWOFKPIMd52mPzRQ4gov9+uWYUBxtEJVUO56l4lizKPgU29gQYWP0AXCQqQ==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr952253wrv.2.1583286941461;
        Tue, 03 Mar 2020 17:55:41 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a184sm1475444wmf.29.2020.03.03.17.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:55:40 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 02:55:26 +0100
Message-Id: <20200304015528.29661-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304015528.29661-1-kpsingh@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f8c4042e5855..223be01dc466 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6288,6 +6288,10 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_FENTRY,
 		.is_attach_btf = true,
 		.attach_fn = attach_trace),
+	SEC_DEF("fmod_ret/", TRACING,
+		.expected_attach_type = BPF_MODIFY_RETURN,
+		.is_attach_btf = true,
+		.attach_fn = attach_trace),
 	SEC_DEF("fexit/", TRACING,
 		.expected_attach_type = BPF_TRACE_FEXIT,
 		.is_attach_btf = true,
-- 
2.20.1

