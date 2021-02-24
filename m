Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3006BC433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Feb 2021 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE1664F03
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Feb 2021 21:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhBXV6B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Feb 2021 16:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236144AbhBXV57 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Feb 2021 16:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614203793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y2xtIg1rSurBFwpghTPTPH96YSTByMFiJ7edqAoGTLA=;
        b=RvgpqwqRMP1BFWytjjWcffg/vbl/HIOGQX2ehJMChUbJiZxNeMaKttFm5kidhjzqgCyjcB
        fTChQDjyk8CcrzPEsAiIWNXai/Rg+MWz77um0VpbhtXkmA+g/ynl10GFMPQVFYanItpMSj
        01NG1y6kQqiATVB9RWyjlibyNzrLQBI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-XiWJM3GqP5mC18zF3-6CBQ-1; Wed, 24 Feb 2021 16:56:31 -0500
X-MC-Unique: XiWJM3GqP5mC18zF3-6CBQ-1
Received: by mail-ej1-f69.google.com with SMTP id h8so822321ejx.12
        for <linux-security-module@vger.kernel.org>; Wed, 24 Feb 2021 13:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2xtIg1rSurBFwpghTPTPH96YSTByMFiJ7edqAoGTLA=;
        b=LnW19B95FROYBgnYRuMk55s8fWfJYjae+9F8lO9VvP9dMBd7XnsfxO2XNhVrg/MDNh
         4GbqhkihhiuQDxFUNxIRwdvvbXrOx3XQ/Ejev3jYI3y2ZHhGTBahIv0ytmsfE25oscG/
         CiPPsGWTsG5RPHFHVMfJBql1rkgN2aqry4+RzcW75eVnuLAh+7uE/aEA5rStlwyMd3sq
         sia1G2AewzbTP/xWsJCe8RCJ2/ZZYyKcZklMU7UOOWYZywiVu28OiVBRhKB/7g4KNS4o
         6304D9z9hs/6UGwDz9VALR3iFzKulxvRis0MCmCBcsamGZNZmx9z1hYkA/s72fPNaxR3
         SuwA==
X-Gm-Message-State: AOAM530KijujJxhKJNQXfMysqbA/34L4Nqeb1knMFEK4pIPxRsSDUbVD
        OJl9hVC+OYGHvwljJY3ikslhc+5PHwqkZgNoNjkfcBR96KbBkKiYUuaT2WiIHx3zuHaGNh+SImN
        5zRm3b9C94H9rLeZOAEa2ZD0Jd2lV5HceUIA1
X-Received: by 2002:aa7:cb49:: with SMTP id w9mr31759124edt.375.1614203790234;
        Wed, 24 Feb 2021 13:56:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwh03A/SHGL6oyftkfM/eugp4Q9CGTSQ5JvfkSISyNIsGpcDjf/MK7OUy1ujdf7OnQU+FFQhw==
X-Received: by 2002:aa7:cb49:: with SMTP id w9mr31759113edt.375.1614203790041;
        Wed, 24 Feb 2021 13:56:30 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id gx16sm2045794ejb.56.2021.02.24.13.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 13:56:29 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH] perf/core: fix unconditional security_locked_down() call
Date:   Wed, 24 Feb 2021 22:56:28 +0100
Message-Id: <20210224215628.192519-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently, the lockdown state is queried unconditionally, even though
its result is used only if the PERF_SAMPLE_REGS_INTR bit is set in
attr.sample_type. While that doesn't matter in case of the Lockdown LSM,
it causes trouble with the SELinux's lockdown hook implementation.

SELinux implements the locked_down hook with a check whether the current
task's type has the corresponding "lockdown" class permission
("integrity" or "confidentiality") allowed in the policy. This means
that calling the hook when the access control decision would be ignored
generates a bogus permission check and audit record.

Fix this by checking sample_type first and only calling the hook when
its result would be honored.

Fixes: b0c8fdc7fdb7 ("lockdown: Lock down perf when in confidentiality mode")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/events/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 129dee540a8b..0f857307e9bd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11796,12 +11796,12 @@ SYSCALL_DEFINE5(perf_event_open,
 			return err;
 	}
 
-	err = security_locked_down(LOCKDOWN_PERF);
-	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
-		/* REGS_INTR can leak data, lockdown must prevent this */
-		return err;
-
-	err = 0;
+	/* REGS_INTR can leak data, lockdown must prevent this */
+	if (attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+		err = security_locked_down(LOCKDOWN_PERF);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
-- 
2.29.2

