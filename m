Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E3C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD3E2075E
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWvLXqUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfCYWLD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:11:03 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:53824 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbfCYWLB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:11:01 -0400
Received: by mail-oi1-f201.google.com with SMTP id c21so4456471oig.20
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3+VKqpN9HOYaIvT2+O3RmkFaED64oX5fAU7Jkszi2gg=;
        b=mWvLXqUtDJA6ZLQ4rljXx/YaZEYZSY7mEfqNWbs0oXQfF43ZORE6QxhourW5k0jnJR
         EOW/YzXY2k9Y/KSzznidAk77H9YCAgP6qmLaA8i7271DXENkkL83AXVxTKa/Meu4Q2co
         m8fTI12PGZS3e44w3/pqpyVKbejs8l+8KA8+tKOSmF5W1GlmrnasS7nHxNENL0GL5XQ+
         br75aVOU3PTCH7P9nYFy3uguV+OntpJ2wGZepe2FUIbVWrydycpb+54B1Hdm4WN8q64S
         zz2puwjsK3PPtJ47euvqUEzpvVrFHK8DvYd+YxQNYnD46/jx2VVSSWYUg1drwzVpSubk
         Cf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3+VKqpN9HOYaIvT2+O3RmkFaED64oX5fAU7Jkszi2gg=;
        b=rfmj6OQsogAGYiJ2BP42lX/HNV+5XzRMynUpbogk7I38po6/V9zA5u3NCXlfxew06K
         c1k2O2TkuJZZRy/p3r6PrZ4/EgNPaGaU74kahvbCN5iHga43W4zQXxWFmB3Etq4gWygn
         kKQscYc5+iKuBaarRSIjAmFgHAYgA+UjHY7fNq/dbnYNn9+FX8jQw5i9RaEdPxjvN9GL
         a7FLT0XxiFybVs9ZwYvsh70x5EUBh48CAZu3OnQLNsv1zY70Jzn72Bi9dwVhrmN/Fh/4
         FdSNwOKFktLGyLbLWBykKqXtUPKrktbItUVy7bOqxryF+PGGDTfFdf8zMBkHAftIn51F
         mTlg==
X-Gm-Message-State: APjAAAXpuvYJ4ue4tisCTbguDOLC1PTObXOrOKjc+ZNZ6+OlBg5VhfY9
        3foRm7fyhhNmQA5VTorEnP3E3mLOnNanqVYgjudhlw==
X-Google-Smtp-Source: APXvYqwWnnRUoY5R/OT5gcEm/ggiwDceTHXuykWXRhTc4QGkHiNci4Egd2xX6G579iCHrIPXxi6s8Cbr11+1Z/L75xFCVQ==
X-Received: by 2002:aca:aa91:: with SMTP id t139mr13629092oie.174.1553551861302;
 Mon, 25 Mar 2019 15:11:01 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:51 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 24/27] Lock down perf
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 kernel/events/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..7748c6f39992 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10461,6 +10461,11 @@ SYSCALL_DEFINE5(perf_event_open,
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
2.21.0.392.gf8f6787159e-goog

