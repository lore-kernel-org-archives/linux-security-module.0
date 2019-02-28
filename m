Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F5BC43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7D72133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ruw+AyiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfB1XOf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:14:35 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36602 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387478AbfB1XMU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:20 -0500
Received: by mail-qk1-f202.google.com with SMTP id b11so10501490qka.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uJSG4DfOm5wajFhd/fVp5JjZRZbJ1ZIYh8VYeWgqjpg=;
        b=Ruw+AyiSDZ47njZAbBZaRrEZ+ClOByQdbrxyjiK4O6ppfEXb7Rv+WzMs/RrJ5O4jP1
         Dxm84G0NNsq1mR4oERWpXqSQIwujmDFAg4+h1xhzJIbfgxaH+XF1dRNP1najZMpc9C8A
         oBR1ZpNcbBgKGNf28Y2pyslDbDtAOg22nwGrQL1DIK/pgPL3UQPCZXBANWv9RpkTdcPF
         MQzsINxIhVkOmpux2VNHTvttTgDm5gtPSXr/aKGHeAt39PqSSTpfm3X3Q/Ws2gjhGAJR
         ztwjrhFoQiueFYKCmLth5vaunhFITzN6MdkANN3RuG8EZVqWK0Q1+k/3Yq6bOo5ojyZC
         VLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uJSG4DfOm5wajFhd/fVp5JjZRZbJ1ZIYh8VYeWgqjpg=;
        b=ai4DsIAaGyjO/1MYvfakIN2Qlu3N8zYMLxFFpQ0PdgFtsnwxVcghxSsiBkGJpyd8xk
         4RLWS6dd2TmL/3h45Za7iArGpjDJGLdkrot5nKIp7kJ33NNBHBZcLXUuSVxoxq/F4xRO
         tG5jBiGMBDgUvuhkR3kNHLNYzIE05v7TciqjivSF39wBdY4RcPAWxG6yWswPE0E/0qgG
         dBGnXTgHiLsMFrXBUhK7kkuv7WTfnm5tb1K3ylM/rjTAt9jqzJOjPzgzc40KylycqWJU
         cKN3OLdx6CdzHfmUkILMeMUjaJTxYr4M9jAjxNbYlpjQwL2Jy2v3Fwamu/EIeE+61PYX
         JCfg==
X-Gm-Message-State: APjAAAUMKGk51y01ZdQnKAeknDYyIv30ElHJ2dkNVxNdqjrGpmQUquQG
        PQEJ6idL/Fm9jPQ+2giVZnM+STj//FWWIyuvp3F5lw==
X-Google-Smtp-Source: APXvYqzfQKeEcAbnraohBadiJQXH1phr5qwXa6NhpSZOwRC0UMZMDCIv1gIs7WF6+nytf5B7sWkQz5s81QdNS935XYJSOA==
X-Received: by 2002:a0c:b8a3:: with SMTP id y35mr1037792qvf.25.1551395539553;
 Thu, 28 Feb 2019 15:12:19 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:42 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
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
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 53917a3ebf94..58301a11f6da 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -182,6 +182,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.21.0.352.gf09ad66450-goog

