Return-Path: <SRS0=YGRx=XF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B898EC3A5A2
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 10:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F33020863
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 10:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VS1WLrah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405552AbfIJKD3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:03:29 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:52844 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405546AbfIJKD3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 06:03:29 -0400
Received: by mail-pl1-f202.google.com with SMTP id v22so9524498ply.19
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2019 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bv5qoXxIm9QGTQUTxQOHCsSBy/Qj7ow+gIETe7B67Bk=;
        b=VS1WLrahvCRQTVPhrnh5NGtHefwOtMvCg1ehhBF6kQbjUks8gmIIHPTZiKlEzV5kxf
         GSILG6mOciwN7+TJw5Co4LVGFi5qK0QFAnE2m94COxwsfWZir8BcWl7qnooghwCvC2KW
         OrHCyqdAdw5Xn2p41aI6DRFF9qEKIfxrrip4grVq+YprBXZRDHq1v+BZhFfNqQZtGSU+
         MkTlOeSBfr1cmhliquwIJ1pSR72yuSao+a+Zeq7PDymvA1puCgUON+MjGbsFRIL7AKOB
         E2iQY+CsmctLt4DRgLWOU7nbzJNZo8Bprv0UoMEbGpfMu7q4jsa5cwb+eRL9UwxhaoQe
         RThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bv5qoXxIm9QGTQUTxQOHCsSBy/Qj7ow+gIETe7B67Bk=;
        b=XJx8kHfjhyIhHNrefE5s41xUY9MjUFJGXoIl3pF7saJrRql9xtcR2LykfB+9AfpaA6
         ZecUB8kxKoaVwToPOn3v5elS5IFqDvaDse52hSkRkGXOmAcKB7CB8eZ+d2wKa9VZllVz
         YJ+BNB4PMfpA1PIDs74n07NaYEvWJV2fHmnRFdvPaQrYWn59z1u4rWRFEpGTo8ePs07N
         xKDYFAISqpRWUd0J0D7nIRA0yjUpZ9S+zgo3nCsAFBJ02WDdKwWORM+cT2GZgz1l7yrw
         +0acZ8y/kPNLzMRLv/ivKDUmWvX3GcJGNOkIaoO+W1WlhX1a2tYxPxpT4xwKTMMhJOau
         TASQ==
X-Gm-Message-State: APjAAAULEyliDyr++Oi1KedIhpNBM7xWNstUstLgnEYs2k5x0Z1l3Kaf
        sY9/2NjUmUrwAu1Dc4HAxYvwTL94BpL9y7KkVNciww==
X-Google-Smtp-Source: APXvYqx8cHOYdn1JFbj+lJuVOsHB+4rC9cO4yzh0N7mo38wEIqxIpOO3PrkduWZWmrxebAtj1X8l6jj829HaWpjFrxVRmg==
X-Received: by 2002:a63:394:: with SMTP id 142mr27066827pgd.43.1568109808362;
 Tue, 10 Sep 2019 03:03:28 -0700 (PDT)
Date:   Tue, 10 Sep 2019 03:03:18 -0700
In-Reply-To: <20190910100318.204420-1-matthewgarrett@google.com>
Message-Id: <20190910100318.204420-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190910100318.204420-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 2/2] kexec: Fix file verification on S390
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I accidentally typoed this #ifdef, so verification would always be
disabled.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Reported-by: Philipp Rudo <prudo@linux.ibm.com>
---
 arch/s390/kernel/kexec_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 9b4f37a4edf1..9da6fa30c447 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -130,7 +130,7 @@ static int s390_elf_probe(const char *buf, unsigned long len)
 const struct kexec_file_ops s390_kexec_elf_ops = {
 	.probe = s390_elf_probe,
 	.load = s390_elf_load,
-#ifdef CONFIG_KEXEC__SIG
+#ifdef CONFIG_KEXEC_SIG
 	.verify_sig = s390_verify_sig,
 #endif /* CONFIG_KEXEC_SIG */
 };
-- 
2.23.0.162.g0b9fbb3734-goog

