Return-Path: <SRS0=Pmdf=22=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDACC33C99
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Jan 2020 17:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4EB20848
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Jan 2020 17:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVmAoO9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgAERkI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Jan 2020 12:40:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43463 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAERkI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Jan 2020 12:40:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so47162760wre.10
        for <linux-security-module@vger.kernel.org>; Sun, 05 Jan 2020 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffE4PL/VW47BHxGKSsmTtFKmcCav79yU0qqjDBklMK8=;
        b=nVmAoO9Y3GkBB9ZaeAbQdM5+KOpyFhcbVBjWpPVUZwZPhATPVs8JGcAbTkdKhR7GrS
         s0eBpxutjdR5mNvdn30ojHxnsmUEr3CsDhKFoRCbx9uCaXzpNdfdZSVGufP4uErkpjqm
         VY9X5oOsM/z3lAEo/pTVqLp2cAkQgaTznjcn7jy5GZsfl+dXXItTbsYS5xhiX0q5YZaa
         61c2UuDG3Etk3TjuQqgfhc42aR8cINLmNbw3yMRDSdA2yisYjXyMjsGN09yOnljwD8Py
         Rh5kpqVOCnSGMZnIL8d/ulxrn7+YUP6XWwLk2c+4f4eZaU+OokQnbJeX30h6pLbpse+j
         lHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ffE4PL/VW47BHxGKSsmTtFKmcCav79yU0qqjDBklMK8=;
        b=on3BUPaZKW39Q23XxtdWOtgO4YmhVniRfVmBtOuZsNyEt8mBpV11/r4dKBtOThvtca
         D6feRDaVcj7JGXdD59rVlU+8ASHxXWQBLdLThHJvNbsPBRlbr5DInarBAV5Z6EOF8iwL
         Bn9DmgwEajsRJIVv73ZJWRpp1T9z0o9AYa3qWm8xUB1STKwCPWt8GrHTnCjOD6qfLn83
         i7wT9Raric8OvcWCo35Y1lLbs8yXI3/lNprWfIQ2j+ToznTPjg8QgGa06gF1r0bH/FdV
         lXwdlx4p/3tF65UarmadxuPghVFFD9buMijiuBobtTfpjj0p6VieQeHWDZn6ZWOp9pB4
         RUtw==
X-Gm-Message-State: APjAAAWdRl1YTeTBp9BvNiPGrDTLvlljPlOoypSx2ESEFI0qXTl1zTt/
        bFlhtvsk3sj9+A3K1fythPg=
X-Google-Smtp-Source: APXvYqzsRO/59BK2HBP/eEWZQpbbelmiwHPaTY4j4HySxuAAjLIpo6wI7U8KB2PQOIZo2ptrqXh7JA==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr98031682wrt.362.1578246006120;
        Sun, 05 Jan 2020 09:40:06 -0800 (PST)
Received: from localhost.localdomain ([138.68.105.35])
        by smtp.gmail.com with ESMTPSA id n16sm69112878wro.88.2020.01.05.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 09:40:05 -0800 (PST)
From:   ignat.loskutov@gmail.com
To:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        Ignat Loskutov <ignat.loskutov@gmail.com>
Subject: [PATCH] efi: Allow some cert-related UEFI variables to not be present
Date:   Sun,  5 Jan 2020 20:34:24 +0300
Message-Id: <20200105173424.20140-1-ignat.loskutov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Ignat Loskutov <ignat.loskutov@gmail.com>

get_cert_list() prints an error message if no UEFI variable exists with
the given name. However, the calling code doesn't always consider this
an error. Fix by returning silently in this case.

Signed-off-by: Ignat Loskutov <ignat.loskutov@gmail.com>
---
 security/integrity/platform_certs/load_uefi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898aad56e..163ede8d2abc 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -43,6 +43,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	void *db;
 
 	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
+	if (status == EFI_NOT_FOUND)
+		return NULL;
 	if (status != EFI_BUFFER_TOO_SMALL) {
 		pr_err("Couldn't get size: 0x%lx\n", status);
 		return NULL;
-- 
2.20.1

