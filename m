Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E639C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598CD2133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghzhVGL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfB1XNf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:13:35 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45635 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388170AbfB1XNJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:13:09 -0500
Received: by mail-pg1-f202.google.com with SMTP id 17so16142084pgw.12
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qg2yYq0hUq63hRGHhOba+WbLOFuIxBMUvDVZS8FGVBM=;
        b=ghzhVGL+EOOW50MsKqzFSDoDeqFyzfz4F+A809BdsxK5XLGujWuwUg7l6VN5hQdmOM
         vMnjgNtaM+yQpXyqcLTH9z1qhAcx9BdIaol/AXsZ6OTJgZURU7X3X9bofYed0AzAvIe3
         iOjhqa7KuPAk5HzkCcMo7pZctQbBYZonfIywEB4+Gx8GydwAwweihTpX6Q2pWv9Ys26O
         WuwnROqSZR2utNxjtQ862ffDx3/OrT6h3myNDaQ/A5MohGfCiAWL01m9zhDgk916WZ3a
         O3T7FTCp9VhHNKTCm+XK6YwJKPurLXup01ex8uwUJdV3j/f9UxuS9hCM4tl/A3NX4p7t
         Eu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qg2yYq0hUq63hRGHhOba+WbLOFuIxBMUvDVZS8FGVBM=;
        b=l2jzI9yj3BUb6GYaUFJbj6uODUZGhRDaUdhm5MTiotGiGZMgosb/MEq4zrGI/MTfjB
         oaYcaUgQBhzoOj8S1zKU0eXFmjA5Zkjn4PRHpqJJ9APw8MKuRme7TnjAZsPpQzzDeWwE
         /UIbbAhyqoa3vafSpjL39VQx3r8bUAdeWOKFncYmQKN18kslPtEgzhobQbRuHYKZtqcO
         i3KMTwObXNsAFgEaQ4wsvn93bqD+pgyc1R59i+Jd84xlGqxANC8FoC5x8+Tt1gqNzMJZ
         WaCfpsoMIkBUdtuqOxomyYsj7nMiP3x8J+mw4YMGAAtL0C5KaSimk1irX53L8F3AWrbP
         P4rg==
X-Gm-Message-State: AHQUAuYKYxsUEmjD/0rYdvd1rv42PvIj1UOoiQdwWPSpgqvv9MUnljfZ
        T8vGwH4RcWSJdJ4dNMUiNyAfQlIjCQ2+NR76ZDMJlQ==
X-Google-Smtp-Source: APXvYqzBqqwYEj+Y8BGFwz1Y2XBzaxPlC+fblom95C6AwBCpJ8V+4s+ZQmJYnnh4F1w8vPqKp/sZq5+3o2SXE8HUmTa4mQ==
X-Received: by 2002:a62:b60e:: with SMTP id j14mr975653pff.77.1551395589203;
 Thu, 28 Feb 2019 15:13:09 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:12:01 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 25/27] Lock down perf
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 26d6edab051a..4265ce43bca4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10477,6 +10477,11 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    kernel_is_locked_down("PERF_SAMPLE_REGS_INTR"))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-- 
2.21.0.352.gf09ad66450-goog

