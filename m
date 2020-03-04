Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D42C3F2D1
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 19:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B88E21775
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 19:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FE5efpYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgCDTTF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:19:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43545 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgCDTTF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id h9so3855592wrr.10
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=FE5efpYRwoF7VVTPXIG28AriU/JlAE3lJtKyUjEtXvjYIKn4CTF1F8sA/xwVRw7/Ja
         ZGoPiWq0rU9dhtjilYW3yxsFLNJ2FSZsUN9mawMbbAqDAYSfXLgdKXYW7JOlDqLHKyiF
         nEpGRY+LiTH44lDXfBDzT0XKESedJkyr3VfSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=fTVdJzjJQhPpD1vpJXksvjpt02oyH9tJMYCodh7CAExGVwayeC3rf7bveUsE4BHuLk
         SFKogHG8Gz9YQE4hfxfB+LPNGq0pMTpO/PaMESC9h8uu44jWGSjSrJI+9pw5+OO92DT7
         G89NZB38uzSbLXz33HYENXHcqFr6aaAbhvZWjRtPksgiD4k/rpuznkDVAgKqadX/yJ8D
         7mDDtaIyhfGyo1pItCk16XDKScL8bL+w+bGk3dBqlPoq8k1rLEphq1AZZ0CtWgOoV7tt
         VqbdZh7TbIWF9CpsaWqMhvIVtpk39Dx4TtfctIsXa0LUv1v6Zx3OoIoX9cjfFn0e0LTU
         33Aw==
X-Gm-Message-State: ANhLgQ1zYWoubaB0KQNS10NlGwR+tEewyPujee3eEUp886Ih12BxXqt2
        Y3TBwHSySiPQl4xpR3jkywC9Ani6yxw=
X-Google-Smtp-Source: ADFU+vvid5xxJMg8IBmdx1lMpOT5FCqtAp9hZz0BwM3M7ATWDojbEADvNTiFjxbb4CrCBf8z0L7W+w==
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr5541348wrv.83.1583349543923;
        Wed, 04 Mar 2020 11:19:03 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w9sm2018556wrn.35.2020.03.04.11.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:19:03 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 20:18:51 +0100
Message-Id: <20200304191853.1529-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304191853.1529-1-kpsingh@chromium.org>
References: <20200304191853.1529-1-kpsingh@chromium.org>
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

