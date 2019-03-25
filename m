Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A62C10F03
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C2120830
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pU/fGwEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfCYWMh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:12:37 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:36011 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbfCYWKL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:11 -0400
Received: by mail-ot1-f73.google.com with SMTP id i4so7325534otf.3
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zcfKxdpFss4fpHHRB0+Lld7eiBsD+1c7SytE6cVbYAQ=;
        b=pU/fGwEeJo9W057Fiz2WhB5YvIlTU26ECcXPrtXpWYJgVMbu/bjoyYznMie0JvzhO/
         RMWldH0Yt0MU7YLBeDyWytBHuMzqJERlwFdmfJJbi+ZbOAUjxFR/HBN5ujwrCkiJxwOL
         VRT4+Jfgx18zSIZ6t/4LruqHwEooU53sBrBvTqizKQLihltKb4R4UhhHC2dT1e03v6tw
         ba42wMht7Dbvh018RXehhlCnq6oZpGQ5iQRkbDEaHPGBfbFXqo2WGwghiUe0Z2ELy1q+
         qDbcd2uG+W2swTs872ukoJgbdOqFSd9dVTBjUcrMZelQnG/pbmRs7A9z1NDqna2/ivZI
         SSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zcfKxdpFss4fpHHRB0+Lld7eiBsD+1c7SytE6cVbYAQ=;
        b=E+XZZ7tM2t3UecKQvkc2SS38ai8/jvnE5qXq3rBE30nWip4dqNH19xVI8bP4Hv+bIB
         MwymYRJCOacio8d7asTCr7MLtBLrN6Uu+KNWS6PyLV/R6Dn0OD0xRCWnky5u9TuAx3jv
         KAss1mWdUJT1yllDGFyYbpEMh+PzgYG2vnFYPKIYvLy9g1gnJ+0V5IQIqAA0xFXCBGbm
         8OeQa6D9mU+cEYVUy94+u+45I7CwnLoAoUNbp1h5t2F2SjmLqAbQEGkVZDXhpfAWvfz1
         hvOySRzgjlvT7DJTyzlF9M50ua7mP7Sb2Wm2xqGPrMViZzv951HTCSq2/EY3K4DfEEDG
         t7cw==
X-Gm-Message-State: APjAAAUV5V6YhCNpOIn6KJIbE4FCqJwWP5zq/wAq/mH/FVbb/rZ3fM8a
        FEZ2U+MMQ8oQob0YoNgAJ+QV+yHnRsf1b9GkQAMKmw==
X-Google-Smtp-Source: APXvYqwktqdQX/p1H08SM6z/cXSn1zOYuT+GzSkXGL8oTth/89sdx8ETR6kIXHqW7yX4nGJrq537WoWTTNpL5yyI3e2xdQ==
X-Received: by 2002:aca:ed4e:: with SMTP id l75mr13734881oih.62.1553551810951;
 Mon, 25 Mar 2019 15:10:10 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:32 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 05/27] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Matthew Garrett <matthewgarrett@google.com>
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
2.21.0.392.gf8f6787159e-goog

