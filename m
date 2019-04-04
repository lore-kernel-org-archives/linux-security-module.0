Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDBAC4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF41120820
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Crz5pwAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDDAdj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:39 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:34376 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDDAdi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:38 -0400
Received: by mail-vk1-f201.google.com with SMTP id y82so446088vkd.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4G8m95jwtwdfjA5z7EFk9aUl9ztD0RqYosPZp4xmjEc=;
        b=Crz5pwAhhGfJ0QYGLtrhjgTwc28guJi6H/Id0SKwWnJIKYGPPm2VUMcicPe48h/eOT
         UcmCpUt3C0UrJ4X77h+cvV41W2pqvyneD2rLGVq1W8zMb6190GtxQWQ3ncoa3Vx+D5HJ
         mgC7r5/geCa4OpN5ejJlsGjspfTd0+y6LC4AE7j9RvCqR2HKzcRq18fSSnEagdIIAEad
         0yVCAn6iJ70IVGzVf7QUDOATfxcDtENqwBx1POTRzmWqsvLuikbJYNFT6+TJyiLOgo0Z
         DdQ1SjRYn09pSaYBc8g+Slk8tipFCdyY/lz7hBqGwUaED4rQA2H1saWZEAXRPPFV3INX
         N5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4G8m95jwtwdfjA5z7EFk9aUl9ztD0RqYosPZp4xmjEc=;
        b=uhvqiTbaJH4pRYHYDmZiFzgyZx3yfw8Q1Uc+gkxHdIRP8CuUis7S4C3v3F0uv9cQ3H
         a9oR562UsMd4enhpuPekpzLhRit9KKlV3HJu0jCAfTtyo0cNxdAF+/DfCbqZlGMnYShD
         AiRQkqjaWhm5GjAO70TANM8jxJNgm3u/EZn1K2E182vJfqO53amoZzT06ecx7ivZMJah
         khv4o5OSKohwsppd2D0N4wGK5kQojmIQW6NejkLh1PpWx6rNkkX8kl7Eit8M1pqz3BYj
         +wXE7GIbL4Izxg4q+NUreV05WFxSYVZeDvvnkeF8jzNehV/yyYpLr3CPWeRbKxz9yILD
         mbsQ==
X-Gm-Message-State: APjAAAXeNVF4Y1ja2HaaeoDs5jo1sau8gVYvmITAFsh7Jv0px9uAsZyv
        10FjKZg8gdAqbJONKlTPAWHmOhK7XGBixOdJkRUzhA==
X-Google-Smtp-Source: APXvYqwCJbB1Ph8ibXeXAEcWqJMS+HDQJVi4XlZx7IvM+zE0X/miIe9mQ2NXG8cXGUbuQbUvq6zUtkUVOg0BqqaypiQ8iA==
X-Received: by 2002:a1f:3c0a:: with SMTP id j10mr367978vka.17.1554338017457;
 Wed, 03 Apr 2019 17:33:37 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:38 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 16/27] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/pcmcia/cistpl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..9e23300a55e5 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1578,6 +1578,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (kernel_is_locked_down("Direct PCMCIA CIS storage",
+				  LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
-- 
2.21.0.392.gf8f6787159e-goog

