Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6586FC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38863206DF
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5sdA5I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfCZS2E (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:04 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:55189 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732576AbfCZS2D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:03 -0400
Received: by mail-vk1-f201.google.com with SMTP id r132so697089vke.21
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J/O8uCPgOG3C0ZxSZ9IB3rxgWx3qFX62jDUsj+e+998=;
        b=K5sdA5I1sE//tLsvi5folYzvaOlJGge5wGHbTEfX+aWT54ddING0zVnNuLoD1bBwcg
         gjLVM6znIYvwcHeqwhtIEdbJyxbTy/EpYVnEckV1FU6h0uQvnInhH4CntIcrPrCNHgeh
         whtma18ma5ixu+z6D26uRzegoUdRlr6DfiOP6EDSld30DWglteeG7X8fivQOp/ibvREf
         4x0xKRoTsrL3BKW37+UZt9+d4vmcP3Ook/9PmuK0x4K1R2Eg5LJ04AJSMZvXgxhZmgVD
         7MhxCVABNsu2vAapO5xiGnKBb3C2ysBlByJmzKLoxts1P6Ukapc3hjKsUO70BZZ91uAz
         ncuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J/O8uCPgOG3C0ZxSZ9IB3rxgWx3qFX62jDUsj+e+998=;
        b=dEscqOAasCoq9bYcKNFKPzBZW8yqGV3k8pRyD1SHrdCAoHNPGk1I7CJo0Wqz14XEQs
         81ZtRAwYEjfmYTlV6vA3IqhzIIU5YlyUOc+OS3lXwNLiTaLqrbJypiuMo141gni/ufum
         j/Z+RKWaViIFvaJpjazcKe7Z3dUIXAEioqH8z3GUS1TgxmeoN9GXqLHhBkjrMLOgm83n
         RZzA42M7gXz8Rjy0zqTOREqFAgmqjOa88F8LUktc1qrEsIqCs/uGzt+SIfK793Ua8kPT
         mrvzX6fLHYVwLEr76hZCganqMdaGSahyQOzpyPHvUeU4+eOLCTvx2sxi3RqAQC0tLxHd
         9rbw==
X-Gm-Message-State: APjAAAUKW9defobvP2LNXAS85Fkm1q/DATZG4uYruh8KGmStS795XuEp
        KkP+E8Dq8na/J4oDglCE4xGAjfJG8asbTyLyD03KxA==
X-Google-Smtp-Source: APXvYqzjIT3j6D/3W+JJCtNIBBhklG4H27OmJuFi+A4uUlowWE/PlFjW1Ck18pWgkexJ4RTQcQWsikYrws3GECQHMeiRxg==
X-Received: by 2002:a67:fa52:: with SMTP id j18mr10694005vsq.118.1553624882922;
 Tue, 26 Mar 2019 11:28:02 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:19 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 03/25] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: x86@kernel.org
---
 drivers/char/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..67b85939b1bd 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -786,6 +786,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/dev/mem,kmem,port", LOCKDOWN_INTEGRITY))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-- 
2.21.0.392.gf8f6787159e-goog

