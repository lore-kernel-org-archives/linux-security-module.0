Return-Path: <SRS0=ikEQ=WE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDAAC433FF
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9340A21872
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQ32ZYFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbfHHAJh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:09:37 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56122 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389402AbfHHAHn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:43 -0400
Received: by mail-qt1-f202.google.com with SMTP id z93so1973024qtc.22
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=AQ32ZYFy04wA4mb2XkzJMu41uBwdTPJVCQkZLoSqoG5BPESh7PtahcJElB42fN7yCa
         RgpAdVhcQ5fuL4/xbllTjDfI2lyqus7qV8tRpcqdDJ/VX1SpE4XMZ3HvF0pfgCWIcmbA
         Zz9a2qpUoHBQ5fw1br+vqmDeXDCgSck943n71lbq0K8fl99KDPL9Cr+apC6baNZBDpqB
         yetG9rfVr7XgiWV+oEMuvXWmxki7WHMWAVAgsDWQ3kUNYceMtvrIEGX+u90sxOg52+xU
         WwDTm3LZ/jev4cFV6SJG2fghnPLj1QbrnL9bCZ9OKuqjQneM4UxIH4SbmaYnC+fTKyUe
         xoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=mTyiZ5lCzJWpmi7QLBpq/iBN1CoXkNhX5bZsssAZk2XgRVhjsMD6nYjFpm/wdyrDNs
         QUsyn+nwNu6N4TVLQ0NYI4Lu7zCVvBamMeU+bgFL65KIyRk6EzDiFNN6u3TVc3++CffD
         gMPG9p2PnPnHzJyv6JjWd0qIojK4Rl308ZPCU2J9Hj9MZpDvOF9xhagWzIry0BswYDxa
         6ytAeyXXaCQU3/NvhiwTByssK0yPGNy06kvlKKouR65/+FwQRUE3rHiMEH6rRCz+00xx
         QC/d3lvNM5aKYlfDpInZrwE3SWFffrEBIBAsEU/PA+Ko0B3XnQqPmhrpMz66mV+LBXVK
         m+fA==
X-Gm-Message-State: APjAAAVM8ODMdXKSWBJhUq5R8w6BTlMGjyDbgaOhSUw4nv4oP6U1gQiR
        8cGd2DZJXQVMVMuW7icyW0SgyUlfu2RnrQDZ4MLqyA==
X-Google-Smtp-Source: APXvYqwbxMXMHnAWnMCnOqh54UKVOkglSwlrJqk2yQseIK/mHSAACIPxF2yMxL4MhNvEpmU0x5PUPo+FVwhaY2V8uK4ABw==
X-Received: by 2002:a0c:eec2:: with SMTP id h2mr10594442qvs.189.1565222862448;
 Wed, 07 Aug 2019 17:07:42 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:59 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 07/29] Copy secure_boot flag in boot params across kexec reboot
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

