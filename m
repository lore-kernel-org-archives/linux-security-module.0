Return-Path: <SRS0=QZUe=3M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C2C33CAF
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E28422464
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 15:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DhF+pYEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAWPZW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:25:22 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36604 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgAWPZV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:21 -0500
Received: by mail-pj1-f67.google.com with SMTP id n59so1465506pjb.1
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2020 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gr0/iRYX6pdOjlgLU2+c3EE2UdU46bZbHnnZWF6Q8ck=;
        b=DhF+pYEnaJLadjh0xvWG6frOgofZmY5KGQv0Ra7JLsEmIYIrXaDCwrhLH+KEJB3XfT
         ZPXMaZmNsnIIzP/K8ifQzl/nqzBDbJJHIzezdOIFmW8aAo2ZHfWGIdpnUcLFQX2WaFEk
         cAUI+5IeWTtj0jk9HcBsZYznFtXQGXC/FhTYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gr0/iRYX6pdOjlgLU2+c3EE2UdU46bZbHnnZWF6Q8ck=;
        b=DAaZ7NJ45SrizIEGeuWkb72G+wFQpvuRUugHZ/Wxgfc43S/nvlYj6FjswTWgPXiQWu
         NLDyt0/97Dj5zADu/VYX6Fhx2+t1BvP7VDcXYHlD3hIf77iqHYlLGc4iIH+x/6wa0Jgs
         wnvQ9Ezxg+hYbf3Hu4hSZQC0rbwW6Ku49J4ReiNRyEid8neMPaw61tdFmIgSG6L5rBda
         vrZ8m83v6aJ5Fqe02xbQu/1LDVnZYGC2YvyMBDvA8sYbvHPyW3JsTrSuIBl1TaZ1AD36
         2Z3okT6n6pX755jxTD4lw0/CsTiJuVkryQTxC7stpnatZooYB28Kx4otYoXJoGP66p9T
         g56A==
X-Gm-Message-State: APjAAAVu86dDnz8KTf21XXTFNYDW6bKXZr4nSL4uFyThVjD66vlX4qf7
        JpEzCsOwCHQqkiEAWGR6+nNmIQ==
X-Google-Smtp-Source: APXvYqytWStB+PLHy6l1PwU0Kl/ckTbrVoaaES13I9k1Gj6vADdaBkpnZmW87jvwYSAwHUvvnl/NeA==
X-Received: by 2002:a17:902:aa05:: with SMTP id be5mr16132824plb.142.1579793121265;
        Thu, 23 Jan 2020 07:25:21 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:20 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v3 07/10] bpf: lsm: Make the allocated callback RO+X
Date:   Thu, 23 Jan 2020 07:24:37 -0800
Message-Id: <20200123152440.28956-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123152440.28956-1-kpsingh@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

This patch is not needed after arch_bpf_prepare_trampoline
moves to using text_poke.

The two IPI TLB flushes can be further optimized if a new API to handle
W^X in the kernel emerges as an outcome of:

  https://lore.kernel.org/bpf/20200103234725.22846-1-kpsingh@chromium.org/

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 security/bpf/hooks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index f1d4fdcdb20e..beeeb8c1f9c2 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -190,6 +190,15 @@ static struct bpf_lsm_hook *bpf_lsm_hook_alloc(struct bpf_lsm_list *list,
 		goto error;
 	}
 
+	/* First make the page read-only, and only then make it executable to
+	 * prevent it from being W+X in between.
+	 */
+	set_memory_ro((unsigned long)image, 1);
+	/* More checks can be done here to ensure that nothing was changed
+	 * between arch_prepare_bpf_trampoline and set_memory_ro.
+	 */
+	set_memory_x((unsigned long)image, 1);
+
 	hook = kzalloc(sizeof(struct bpf_lsm_hook), GFP_KERNEL);
 	if (!hook) {
 		ret = -ENOMEM;
-- 
2.20.1

