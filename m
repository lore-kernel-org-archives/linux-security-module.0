Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F6EC4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5D20820
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2EFYZwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDDAdT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:19 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:38307 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfDDAdS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:18 -0400
Received: by mail-ot1-f74.google.com with SMTP id u18so304160otq.5
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UWUYbOZniscPzPib57I8cPwH1j1zNPSziYufzU02lOY=;
        b=A2EFYZwEC5y58dctC8LWHsqA6qoE5h0LFuFYwP6Uwqnal/NFUhQVsKZ/0Ysr8bH//x
         FT17CqgqigWaJaw5c+416HEm1SOJ5orG1jO9WJ4kVGBoTxfe2sFF3NgIGiHr1ETJUCoC
         AGe5N/8cJDz2uObdp0e8WjGFpC8mGvo4d5ebbKSY9TuIQ8SyXWnil8fW2KzUZCt/aofk
         8biDkpWIJeJyZnldpFA5lFAbH8dXFWs7Ho0n0l1twAexbAB/330nKb/6uAkKYGyTrW0N
         OJepi47SLo9FwbAlZUvw24949yhqGJ+zGZV7oTsTvqOH+6+6k01sIrImWHkw9JwsgDIu
         28oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UWUYbOZniscPzPib57I8cPwH1j1zNPSziYufzU02lOY=;
        b=VP89GDkVzO8Dn4zJOl7wOoSfXX67hBNxcOgXcSGyRwF+6GHhUzaTFDTvUMmXZGGckx
         /MEOwPN49/QT4TFyXWDI9Kiwd2iMeBWj0tP4tZC7neWd21OdXVUa4QWw3ZEFDTZVf537
         qSWiNpau9z+qKh2PRJVp7RJ0xI+cQ7xXe15GSsA9TcxqWZAu0seQ2j4Cxqzl0lTZhFUA
         4ruFH6Px49nnShWYv1NISUAi/NU+DWnxBFVl0zhSl0Y1odApU7WkKUsWr+G/Q7cNEGqm
         vnR4FCdt5OoWG/C5rwgYpId5TuSB5ttSIcmekL3jdbDSqTZTCj9KV2pG/o9MQfPNPGJR
         ZkPw==
X-Gm-Message-State: APjAAAXbiV/JQ0A5gxLPpCzPfUBFyuyO6L5V5tgOcj3KOHfPnAenZ7nm
        6IjcIWWVv31UMINK5cB6VeGBSWJtm+T5oIYCTidOvw==
X-Google-Smtp-Source: APXvYqzL3jPDtiMeU77dXPt0+VSnZ8pBp/Uh79/K3V3E8HHlCSQfc9Fzun4Dp6GY5hR8FwEKn511hYcZ8i+fnLxtrC+4KQ==
X-Received: by 2002:a9d:6343:: with SMTP id y3mr301853otk.38.1554337997827;
 Wed, 03 Apr 2019 17:33:17 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:31 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 09/27] uswsusp: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: linux-pm@vger.kernel.org
Cc: pavel@ucw.cz
Cc: rjw@rjwysocki.net
---
 kernel/power/user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..99e13fd13237 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -52,6 +52,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (kernel_is_locked_down("/dev/snapshot", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
-- 
2.21.0.392.gf8f6787159e-goog

