Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E765FC76191
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C094E2171F
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxSl7ByC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfGOUAO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:00:14 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56293 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732276AbfGOUAM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:12 -0400
Received: by mail-pf1-f201.google.com with SMTP id i26so10821207pfo.22
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ze1m51/U9qyeKdYZTkURxXHO7/2Jq1vWiS2UsV2hr9c=;
        b=AxSl7ByC571hgB4NOLtS7SsxUTZj2nJz1kjFEvu6QXZNWkTAq4ckIZ3uMUWLg+omXa
         gQCF60SO+5FhvuloODfitEKxnqK2Ud9Ke7Ut2KXrASynck2/yJDhEmUCv/SiCL/LnS6Z
         foFn7LR0MludcBbwvt/rK79Awp3YN1kE+UStUw6ZmdDsTm4ffGswjufyLrxfXF6AE/NN
         7a+spbgSULZAlT5LjRxTXyiyoO5QMa8kyRslayysR0pLUMt4Sna3aoVdhhA3DgT6uj94
         DwwivdBwt/SuDS6eAWJhtbrGn7o2yongnexmhT6mrymBMoRm2BEZbfvlnh4PW+U/EQ41
         XlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ze1m51/U9qyeKdYZTkURxXHO7/2Jq1vWiS2UsV2hr9c=;
        b=da03vjEC0e+Yq62ZBGfUBl4uf9Nx2frcCHd2g5BC4VZq1AtWLLbta7TExAncyzihpQ
         rBN+CThyn2/tJvwob15KbLUwHGGuKrG+CBDnQzj8LupJVczDmA1DWnb5eMTM+bgpi01B
         6w966c3F+iO0SFUnYQ9JnWxGUA+ewCCzuOxaaV+J41iCAeo+MpaXqz4a87CQWMCy5Ann
         /qLgE05STJxazJWoBdsdjxTo/GmVl+HE2PFBPkFW7HIsM0c2zcbvZBcAidlmyh8TK0WF
         4HlpzMQnQDyKZ7UjflvYhpmwFN3m7qiNB2AOCO5pgyAmAouPZpmIeW/QVcJ5u/XFKL/W
         K4fw==
X-Gm-Message-State: APjAAAVrDKa3t9WRgJXTnqiFas4xrnIs+hC53JMmfPDWJYPZSvRWBEOz
        lieiXAsz3ejiM6a+Lk5DaDn+IWLTwxJNiLXHtLlI9Q==
X-Google-Smtp-Source: APXvYqw3kz8vxqJr04RTj1gLbL27dI8ApTISQuqjlO54p7acDyqHccEy7zqlCPthKqcQRy7/95xxR7ZdHBOEJmGBPjFQUA==
X-Received: by 2002:a63:2ad5:: with SMTP id q204mr15899633pgq.140.1563220811612;
 Mon, 15 Jul 2019 13:00:11 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:24 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 07/29] Copy secure_boot flag in boot params across kexec reboot
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

