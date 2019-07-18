Return-Path: <SRS0=m0b+=VP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B79C7618F
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEE42184E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJjhUT6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391587AbfGRTol (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:44:41 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56047 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391566AbfGRToh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:37 -0400
Received: by mail-pf1-f201.google.com with SMTP id i26so17159518pfo.22
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ze1m51/U9qyeKdYZTkURxXHO7/2Jq1vWiS2UsV2hr9c=;
        b=gJjhUT6gQ/zQNCY6elSDV6M1tQCeC0P5Tp4UAQyfBx3bH4p1ifDoKIdCUkhGhE/+gg
         1BYrEJUjZpq1lci7thr1J+jRZPv78zvcXe0wmCNbM+HBWEYXopMbBeSzpPtfVoUzVLk3
         pujXzLMr6fRScyxTI3Haqr4j2hTxpLfQ6HsQowNOgyplYLOfo3yUrKFDJokCeo5/2PKy
         FwUf46Shg+19/eA24HYXmwakU6FgvCH1rsx/twSxIE8e9p1SMqOpYC5sjsn8o8C0psq/
         OjMiRQ74r0yKmCrXaugmRON5LDzCp9Ky2OgcvlOWQFtleomMDWsvtTmBy0Cz29VGfC9M
         iF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ze1m51/U9qyeKdYZTkURxXHO7/2Jq1vWiS2UsV2hr9c=;
        b=getRYpodNixf/hWDbzCu817qUvNQKJGOKAYhRYP26vPFOBXG6XujGB6Trk28GmOip4
         ClO8zW4R1HsiA91kv64M8mcfAxu+zpEzx4NS526Z8L6UjWqsLKy0Un92sk6XP1FxoqaK
         vxSY746P6hgc2u/WG3/sCqvf9p5E6YP7aHf5c2VoVEjx6sCReBrHn3SzJukxGKCfIrda
         vJpYx0UXMjbdFS8DPI8F3h/wfY6JUK8or6N4qIKBpUAPALbjiY8U50YfrO77sV9M21K4
         1T6y/s1qRExllvxMugbnlsWyyarlXIR2EbdBeWPHzzSFyTPTHe4dhbQjRH5wtWm5HscN
         E3mg==
X-Gm-Message-State: APjAAAXscGEBtSMzdyQ+6EEcE59jUQ4jb7lVBiXynbK0+qrWs9n1KqVy
        UMFknsDlRiDFE/kDeiKWTf8NJunjO8vfQEHtnhH9DQ==
X-Google-Smtp-Source: APXvYqzrK8iF6hcgKRXBxAlD2H7TfZZ22Mkvge4q89mEFnRwAMWXxSRoqJN7TQmQtZur9PR4mpbHHV2qq0UGBlX+3fC93g==
X-Received: by 2002:a63:1950:: with SMTP id 16mr49329324pgz.312.1563479076972;
 Thu, 18 Jul 2019 12:44:36 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:53 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 07/29] Copy secure_boot flag in boot params across kexec reboot
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
2.22.0.510.g264f2c817a-goog

