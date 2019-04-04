Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14DBC4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A66A20820
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1y6ny4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDDAez (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:34:55 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:37164 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfDDAdb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:31 -0400
Received: by mail-vk1-f201.google.com with SMTP id y19so443311vky.4
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B6VKNJoBZyOp9UQCoOkYqDvTMA68uU6nV4VivW8ayKY=;
        b=S1y6ny4+jWv/gWeoO1G3tzhnZv+bXGsPYsaXFnXd9BW0WIzzQVHNEe7Mp+1DhTvAHK
         t04RZjK7SgpfIcQ1TcyiglrSXM7BLVu/37v1Z/a8Sc4pLE+s5Db8MMk7UKxtmzWktqE/
         X8SdZ0h/jX8QLITQGrFaqZ6fF58W542kSDEK3m9lj2nwIuuh06se57HA/kz+meVOIelG
         LTqKKtWdgYWx9QaE0QaXcQKZhD4t7pX6zz9lWi/Oxf4hYzQMFOLZsdUhhRRuR7npfP/J
         wSz86q5bCjocH/M3nlOoj8+mOAvkNzpYe8YcGPLNxa3nDue6VGNiU/igoU0QMLovvU6E
         lwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B6VKNJoBZyOp9UQCoOkYqDvTMA68uU6nV4VivW8ayKY=;
        b=Hy/UgeivrH/+MgXEulPs3DyhYldxnBkY5JON0fDAbr8N3ms9gKMlqXPfOhqwxGf2i8
         HkDmooPlXALGrDIDpM62ezm56D/om2hSqdj+xZVStKiH2OPkSGuexKwskLqzOLnTVNEb
         Y1oxGfC6ojlyNyb2R2Lkd6AIVG1sR33uTuo5xCYati3D1Psh8V1XHV9UdxFlsM2vPSFM
         2sVtDpvbleoHIo01ucFn9vKfg7V2Rpbi2r+frXtP12SLOEkhuS+C/VkD9+6i3cFqwRNx
         XdcanMlzf332YHNbk8eDjpOWOh3WpY76YKTY6/V+pmfao+EI0W0zY0900l3BOo4p3USV
         lQ9g==
X-Gm-Message-State: APjAAAUyxzDcctDnl+HC3jsStfb4TU6KgAO6Yd8YKZquv7MHnU8pUiWf
        F5kymg3dV0XGuT9z3+5KcsZ05iZac+KWdkNBM85QBw==
X-Google-Smtp-Source: APXvYqwKkPizHiC4OnZjT0pH7YvylRNZ+BSxAOhO5bw2H08BAHNzQZo5RvC3LnRmNcoFcH18MAP9iudbn4wRZZXcLgMy+w==
X-Received: by 2002:a1f:5842:: with SMTP id m63mr366264vkb.15.1554338010216;
 Wed, 03 Apr 2019 17:33:30 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:36 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 14/27] acpi: Ignore acpi_rsdp kernel param when the kernel
 has been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..cd5bba7b8eb3 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -194,7 +194,8 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !kernel_is_locked_down("ACPI RSDP specification",
+						LOCKDOWN_INTEGRITY))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.21.0.392.gf8f6787159e-goog

