Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D344C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB12206DD
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ja0HNHll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfCGAAa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:30 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45599 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfCGAA3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:29 -0500
Received: by mail-pg1-f202.google.com with SMTP id 17so14122341pgw.12
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1/Q9WI1yRVatQ/yQs+U4SWm6wGnrwBw/w693pRoFvME=;
        b=Ja0HNHllquwFqNG1YcYRVsIuOz1GquTrJ6u28a+VNVnXPhxF0/mfK/FHq09suoplle
         7JqwJEgcdxpohcoOyj26m2vvd2O3DWaqqVJfBENoEsmPBIwdu9vxrBtRnHwgBn5u4uMz
         CGvyoeNzOQApATOK1KARCskkWxz6Zkg83BIqJ8sf7ZnfQ+y6DbqwKfs1rA5Lsw1IO0Yn
         86ZEJt3E1SPzRbvLNtuYph5p1H02Q+kVt115/5FBrrpN9ok4axreUzF+V4aHGUXoKvcY
         PoXpEbSBn/qn3twrhP+7BhbzPl6dPIAt0jvQxIn5hP4UbXMvUAaKhgGorMQDWn7McRPd
         22TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1/Q9WI1yRVatQ/yQs+U4SWm6wGnrwBw/w693pRoFvME=;
        b=j1sTL7PhkuHncWaRNqN2mUZYwKOH14q7DtH+tzZLfevoAedHqwl0+Qhzb1iY//uWFi
         yG36p4LMJdf8tuD9bhVE5pweCNNkzbzLFAmxIqAccqbt3jlDgPgHcQVYBJwZHcNtvHID
         oAcL77OLbNpXah0mJQkodGG8lbPN1laDg79RgQzBZV8Mnx8Uu6tVdysLiDx0XRBQPd7m
         jdp0MFOjPEi7Z7LuoYUoDajsZdNjxgR3HhM2m7hWN8nGRh5WWbccIEEfgz5RCn8LoXMJ
         y/uzpIZYK8wbdugTEdPef3tnyH4XyHsHBUF6OzyUsb/rFYe2K4X2UVUahOdb11diqmlI
         xcMA==
X-Gm-Message-State: APjAAAXDPWIVJFTOk//b/ldnEubEpfcY4kYp9hxRx2bgEmgBVlkJjGMf
        BMV8erxOClhGm/9k/efVE8iVjJP5kDpeR+OaGwI4bA==
X-Google-Smtp-Source: APXvYqzJGpcTZFiJ60Kt07J6NBi126oe9ezITe7lm1I1QgqAXsalOHpVGI9OZnjH4Zin/mrlx94uy1Z6ewP1nF8X/XrI7w==
X-Received: by 2002:a63:a506:: with SMTP id n6mr37123pgf.98.1551916826638;
 Wed, 06 Mar 2019 16:00:26 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:09 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 23/27] Lock down kprobes
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow the creation of kprobes when the kernel is locked down by
preventing their registration.  This prevents kprobes from being used to
access kernel memory, either to make modifications or to steal crypto data.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4ddfdd2d07e..6f66cca8e2c6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1552,6 +1552,9 @@ int register_kprobe(struct kprobe *p)
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
 
+	if (kernel_is_locked_down("Use of kprobes"))
+		return -EPERM;
+
 	/* Adjust probe address from symbol */
 	addr = kprobe_addr(p);
 	if (IS_ERR(addr))
-- 
2.21.0.352.gf09ad66450-goog

