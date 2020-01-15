Return-Path: <SRS0=2BO2=3E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A2C32771
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195282467A
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LBAXJRfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAORNv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:13:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgAORNb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so16555285wru.4
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2020 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BaXbvr8+/AA5pEwEC4kv+1bgxSxLzCBOcAqmhtuHoC8=;
        b=LBAXJRfH3GQwmfbGHhOP1Qs+7KpRm8fZjQ41I8LdOrmCDEDC2viG0gJQUFHB/CVPGk
         oj75ReZAzSfNOXgWbBKxLiPwi8i+/+EawU5XrPOsLq3jjkkBS1xYPzP1d0YrdhdZTiAm
         6y9G1Av8SYD6NNmlGhd8DNjum6poEDVsfuZVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BaXbvr8+/AA5pEwEC4kv+1bgxSxLzCBOcAqmhtuHoC8=;
        b=W9VPiBpeDnHUbTBGAWDrRms1AfujgEnHG0aez25ZR6qTe5DrHiSH9DQ+UcanDy9n9M
         iOOEHgFeGj3ZXChzMgfCPXKM3cH5qyCLUc3vfysYJNiAHZ06qBujOpbA+uhK416swQWT
         nn3+DBl3K/7LoXOZ82iSDYm1JgfitKd4wK30qGUVsVdV64MwOPVvtADA6Y7vxRG/GFa0
         EfCa8X1BPYptPNIctPNC7EbKk+4PMxbikABVGVYw/YyqcYjzOyJzXrDwrKg+Ry5Yl5lw
         AwsgV6TDTyuTDTT82Pi3fxxK9e19voKhM5+5nL0bsoXbSjzjGsr+t5SDIk6yRfKF0ssx
         7zgw==
X-Gm-Message-State: APjAAAUpfpmkxanrvvO/5ZLw/nEFOYFzLNDuLSpbNfPZznvDhRjot+si
        JijsYRrCLJfTHtXh22XpZJTAQQ==
X-Google-Smtp-Source: APXvYqz+g9S4xsM16ZfhVtVBf5Pz0OA7zWuCU8BbSiBF/2A6sRIyLfsT4wowSgFNOpCHDbrvJcI30g==
X-Received: by 2002:adf:df83:: with SMTP id z3mr33208227wrl.389.1579108408840;
        Wed, 15 Jan 2020 09:13:28 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:28 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH bpf-next v2 07/10] bpf: lsm: Make the allocated callback RO+X
Date:   Wed, 15 Jan 2020 18:13:30 +0100
Message-Id: <20200115171333.28811-8-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
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
---
 security/bpf/hooks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 4e71da0e8e9e..30f68341f5ef 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -222,6 +222,15 @@ static struct bpf_lsm_hook *bpf_lsm_hook_alloc(
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

