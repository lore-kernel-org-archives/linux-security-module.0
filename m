Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326B4C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0010120663
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcOpK9az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCFX7m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:42 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36447 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCFX7m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:42 -0500
Received: by mail-pg1-f202.google.com with SMTP id h68so14124553pgc.3
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 15:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J9HskZ77OUFICI41Y6vWx6qjidmwsaOE6tSBtlsEq6A=;
        b=PcOpK9azISxtDIMoSR8lrqsGa2jzKe5DpkkVwC2lvPLouHJ+vxS0aioyTJZIJTIalp
         l2w1dyY3icZy5F2BbXRiOSOF6JKLNx6ZDSl4jPxhtjlbkeUmAGR5NLhNY/jl0Yj/UyKx
         Ky/L1DecjxO0eL/TXC88bCzSUQPTJnVc0yxiluRZyQ6euvebM9bQTAM+Pi2ngMPQSNvu
         /qWm8mUzjhDcr5Dbeapg9eZmk+eoR06cg69/g4BBxK6tvxx1NASQpRZHlPkLQxPniMJm
         RMDQslYkVwE9UPxpgtmv+vZEoFMyZdYlMcn1sN68WeheHf4ybL5NvgLvkJlAvtuNrobN
         Oo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J9HskZ77OUFICI41Y6vWx6qjidmwsaOE6tSBtlsEq6A=;
        b=r1dI4Jq5mtRW8bnDkYqydGEZjW4uaL7OeJ/fbCmTqkwPhzoj8ELR5cwbb1aDs5hRJE
         y+LtjNqoUW5ENOCnz7bnAi+67PE/Ku0okLOlYo8bc6H1ybQl/Qg+8X2jXe05moS5qGfX
         HYkv+XfidMqu/jkdWUYF7H6miKQ3nd51c46IaQEpUJZaa2fFnMsnaLn2WhYH8ahTvxAU
         7QXdZGJMAGnonzEC1p67drz6J61Ug1WVVjZ0iVjFJQWiwwxKoH/pX1j3WXZiPK/aO5jJ
         qVecGj/wZq6genDcpBDKvqvVXuhyylG8DMjbFl1dVRwPK6Jensk5TUopUZEuBph/lPd6
         q1Hw==
X-Gm-Message-State: APjAAAVwAru9TVl6DgYFeqyinS/Nud4TnzGCNXKBo1jdbi2ZMo65n2vm
        d3jXUAzYxBGF1GN5Pth/4fCqZUFEZR/q8rRGNLK0tg==
X-Google-Smtp-Source: APXvYqxJI9YBy3Tx4TeP2k8b5JTYfjwF/BZZOjH1sXAgR2zDWSwPhEvf3n0YHoxi6RUqjKeGDYELgoSp30Xy4R9fLnYRpQ==
X-Received: by 2002:a62:b401:: with SMTP id h1mr3868938pfn.61.1551916781465;
 Wed, 06 Mar 2019 15:59:41 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:52 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 06/27] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: kexec@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 278cd07228dd..d49554b948fd 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -179,6 +179,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.21.0.352.gf09ad66450-goog

