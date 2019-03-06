Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D09FC43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBDA20663
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLboHTMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCFX7w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:52 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:43100 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCFX7w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:52 -0500
Received: by mail-yw1-f74.google.com with SMTP id r8so20859038ywh.10
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 15:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JJMzCu+QpYD9Z8bckP0m6/xbjWctPMS7pd0b7hNmVSQ=;
        b=tLboHTMMoMV+yRf3rMjN1/hTQNg/8muTL2AwsTexQzcvw3NgdeYfhtTcpiJqFfIUB0
         37eVsZnj2OHgLGKYMUaoTIjBxEyPUDRdn+d4GtnwAuLkNDndOXzUxAneLXi5m0ocs9cY
         8/iiGPiCS4IHrBXgVjfoNrehXn58s6SKrlaQq3Xp0VQD95pUZPnZlBX14hu9F4J4qocJ
         CL8cUZvbqaAj3lvvbYvEjZJowX1ZxeAAF9iJEJmMZs2yLtbDwFrM5iQE+n7t0zy8lPyv
         Abr86iUavjIxK/vFIqmKm4uxNNaO2dosOCi/oMgW+ZL1joZj0fOxNgjte+HsXLqPjvGF
         BpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JJMzCu+QpYD9Z8bckP0m6/xbjWctPMS7pd0b7hNmVSQ=;
        b=bfNq/T+PxMcht7rsdkis6H4e6DVaqpAJCaU/gB73XFrN4CjWud+V11aR3NWV4ozOu5
         tR3A1HoBos1sT5kn0Uz8jFszix9yO8CHsJ8eB1v1gUZyoupWKgFxohZPGVJXYUTrw+cg
         BfaRHLMPEPL5q9Kj1kaOi+8GwyPypJl4TH/2vDjrCGB1utgZ7mNMqtIuhhKlbAF2zhjw
         eGH2rpFmz38xdrK+pUaabNcFpFBQX1teBPZp1U2QcQqpmcszjVCmV98kPC2mLp822dnf
         qjWDhiuttJIahdvmjeCFUwawNa0Ly0Z6ialhlzK8oaWzm+xWLqqT2Bfb4UcdCiMM8Lih
         QX8w==
X-Gm-Message-State: APjAAAXmNHxYvh+q2HG8rCNeYA+Wy5LVh8Uc4niIgGo82Bqni7ewg+Bk
        mz2yUyRrTMGF8ph+9/BgEYsHjElFYM7fuTuJhw1FTg==
X-Google-Smtp-Source: APXvYqytdTMYqNrVlhZkwaY3/u8OMYHj1aQSIB663TPgr1lcKmQ3eCVuz1JuFTVE8od0nbZkPQ9oXCKDc3obGrQfsUF4ew==
X-Received: by 2002:a5b:44e:: with SMTP id s14mr1091714ybp.55.1551916791554;
 Wed, 06 Mar 2019 15:59:51 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:56 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 10/27] uswsusp: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: linux-pm@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/power/user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..0305d513c274 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -52,6 +52,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (kernel_is_locked_down("/dev/snapshot"))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
-- 
2.21.0.352.gf09ad66450-goog

