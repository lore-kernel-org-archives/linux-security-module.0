Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7008C3F2D7
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A067B21D56
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ie8ZqTul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbgCDPsM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:48:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56216 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388117AbgCDPsD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 10:48:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id 6so2651427wmi.5
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=Ie8ZqTulx72jXcIilsU1d/WAVSGRYBCLfmfJux0wONI0NlvrKQ9Enw2cSDDGVsHmSU
         lVYjEsE+LZfyyPRfmG6NsHrFnMRoLf45pDyr8xuxkLLuVPPWwBFDc/7quKSaQnxJb1tH
         pPdtLx8zLfLFzNwYXT8e6srppXRhLdtZmK/Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=oC08YdUDQ102NVR1ROG5lj+qh330F18UNl22To6BZ1ScvY+5+PY0YVDeE1/yT1Lx1d
         dYhWT7rVeoObWjdDIcqdvAyU0Rp7CSl95yTqEoulgzx6k2sgTs0LL0k1CnnOdxmcjcCl
         k1hl+KJiKuf8kEPbxeR+BdXP+WiUdEHVCbPxCvButawY5bKbkI5Z84pMAFhG1Zm/2Gwn
         HyMuAb6VuB6x9SfIpj+6srUOMGRHYGiCzzMgXpwcBqxHSmPYlf2+8Y4eMVjzQWn4LxC0
         PZZpdccWwFYtlw0NEkEzLVnpsJXTxuns/vzQNsx9jPNu1om+wDwbt1rHqehxL2nuGoXG
         X3ow==
X-Gm-Message-State: ANhLgQ0bFJiPcjCKF7p5PosMidK6YnL2r6GPPPb2ffWMpd/VFtlt8Twp
        T9sTJlF/PedVnPaugk5mcK5YfO/fBjc=
X-Google-Smtp-Source: ADFU+vtGAQk6b9qNhtaeyie9qoPkeL44V/Y93fExB9w/SWb+vlwG17d+/ILecdmYCU41C5LszJwThw==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr4094248wme.173.1583336879927;
        Wed, 04 Mar 2020 07:47:59 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id u25sm4816091wml.17.2020.03.04.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:47:59 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 16:47:45 +0100
Message-Id: <20200304154747.23506-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304154747.23506-1-kpsingh@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
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

