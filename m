Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC8DC43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5966E2133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPF6Q7LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfB1XM3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:29 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47043 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387689AbfB1XM2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:28 -0500
Received: by mail-pf1-f202.google.com with SMTP id j10so13843074pfn.13
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5zx9SlvOWbOM3aQxwWawliOAIMYFC517bf1Wue1q92g=;
        b=gPF6Q7LOzQP1CW6ypT8jIjswLBrVEyj1YiXGn66YsKob18h+lmUAvhQmwfVgJasMXT
         9x4raDkz+8Fxvj94kTef6TVvnZ9H9fqHReWufNibRyMSmpX7JmCVLtf7lyEiSibybIxl
         q86MYyzxplgzA/p9/FwFC9RxMDd4MqtBnlAt3cTMTftdZzX9ZX1yVIezxHmEIYeRBouI
         FTi1OYE4Y8cwANVb4Hqjj6gXhvn4iSkyE7qJ+qRVIEd5dYe5XT+4aObm1ljMwYmgLeel
         JyhfL2kM1GIRPR4jEZzllZztae7DaxOQdH5OB2k3SEnXNTNmChiAh5KvdsK/L/QGhSs8
         V6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5zx9SlvOWbOM3aQxwWawliOAIMYFC517bf1Wue1q92g=;
        b=nDXCGw8AtnAcvSJR1NIpMf5jlxGNchd4fYGt/hWUqChsuEnMCxHZkkb8YK6Lji40Ss
         Isw/J69nnLluf1icELzSZ/G7IvDr1QWCZamevM4e0OIBRGy5SCN3HiDlkK1bQ6hH3iQE
         g6FyZT3eTjDs31YtS2Y6u+PJBwUat+fAeFDxP6gANt7ePluENb4mElAUMWaP95e6g/vZ
         ZdQhFDmoWyaVOh3useq13pcNAlLn2BMIOw9gOZb03lS9cBxhd9cbZg0reiGsFq2gShGM
         /N8PWVieSghEA24uG7yxTEf4gZnif64rmxz0+CWUIpgWnz62Gk/RXxkP94Xfr3bkxyvH
         BjKg==
X-Gm-Message-State: AHQUAuagwZQk3pbVn0+5Bw5ZebDHFY15rRdWNStqZJ/a9+TwbrxYgSBR
        nPWQ6pSv3OO5e0qSledIlDEnjHL5WGfmrtrvX+kOJQ==
X-Google-Smtp-Source: AHgI3IYHFAzilMiF+RwK36ywhmsTVHUeEVlPErGx/+wmznl47NQPW7l0VhhJ6mpmNAd/Pdnyn3J0nHF3BJbnFw4Cr9VuyA==
X-Received: by 2002:a62:15cd:: with SMTP id 196mr960512pfv.105.1551395547687;
 Thu, 28 Feb 2019 15:12:27 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:45 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 09/27] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-pm@vger.kernel.org
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..802795becb88 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -70,7 +70,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !kernel_is_locked_down("Hibernation");
 }
 
 /**
-- 
2.21.0.352.gf09ad66450-goog

