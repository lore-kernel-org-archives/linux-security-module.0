Return-Path: <SRS0=Q99v=V4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DAEC32751
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Jul 2019 22:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45767214DA
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Jul 2019 22:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMSAts35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfGaWQq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:16:46 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37607 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbfGaWQp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:45 -0400
Received: by mail-pl1-f202.google.com with SMTP id n4so37817954plp.4
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=gMSAts35o/wnPODCro9DydMZX5y7p1KI0EhPMUuNYbyd5Q6Xxxy0tL/90yw+6/qQMj
         l9giTy0CijDgmA/xNQp8tpz9dJXEq7ZHBw3gHX4fMKITsYLeBVXKVVIfdulVbq3Peg3w
         1TyRbM+Rhhp85lz2YXYM+pwcYW01E767r909bQZxS1gcHPQc7p/oodSsz0ThkQlOlKHm
         ZbG6AATiMeGGcbzOk7aKYt2t/PNN56kMp7qxsWj5tSxTcaZIr/FUg24BjVgqRi3tVaLa
         ecwG54oEFOZzMaQ088eNT1XtbXcxzLAhwq7fC+roMT/tuZTDal1sDiD3x3VDkDdvwB4A
         d6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=ak0nwklEGVdToQvY0EgH9zQOweCWZDGrh8Lc+RGQAOmIRvWuqpFnrEIN3WeSBWeSs6
         6QhrAjiD46Wp67CqsWimFCoJ6cOgDcOQfv7fcjyUEmDq3i9+MAss+dFmySdTjLvhymrZ
         A8mrwqA3i+iHY96neRtARfV+AjxCObxtLF7Hvk3QZkVnkAxhJFaZ8+i6trQsZQ+4Gl+o
         c76ZwgN4NMLGS4nW1W4nmpyGbUdA35bETMS2IWHpEaon8QLTcLJ/aGSDE9Fc+f2yhQQm
         HDIIJZrqw2kBvrPW6DsBP/CVj83909mNL0tauNlU4Z5nvLwgcyh4qq7ZUI3tii/eUW8+
         POKw==
X-Gm-Message-State: APjAAAUc3h+jucUMczEpiefC7JeG7BeE6b40+jxGjhjeEnWSnk1cMXM6
        EB5LDS2+GSheNxhpApu7/zHgzXFQ2hkOFmAJueVbaA==
X-Google-Smtp-Source: APXvYqyTX+qLDnmSpQam3pjkGQYBiZyG7S1znrHAEzFD0MX+bZTxK74CZsUoHaPZuUmDe6v6/5kjbS4vOej9Zu44WrYy9g==
X-Received: by 2002:a63:125c:: with SMTP id 28mr62619278pgs.255.1564611403845;
 Wed, 31 Jul 2019 15:16:43 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:55 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 07/29] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Dave Young <dyoung@redhat.com>

Kexec reboot in case secure boot being enabled does not keep the secure
boot mode in new kernel, so later one can load unsigned kernel via legacy
kexec_load.  In this state, the system is missing the protections provided
by secure boot.

Adding a patch to fix this by retain the secure_boot flag in original
kernel.

secure_boot flag in boot_params is set in EFI stub, but kexec bypasses the
stub.  Fixing this issue by copying secure_boot flag across kexec reboot.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 5ebcd02cbca7..d2f4e706a428 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -180,6 +180,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.22.0.770.g0f2c4a37fd-goog

