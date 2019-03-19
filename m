Return-Path: <SRS0=+PDj=RW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4EEC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Mar 2019 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D3820685
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Mar 2019 01:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ro5mFo/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfCSBhP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:37:15 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:33431 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfCSBhP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Mar 2019 21:37:15 -0400
Received: by mail-vk1-f202.google.com with SMTP id x200so8262209vkd.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 Mar 2019 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oxLrVFgA5K2VrFmqjuGgoMdvHwMxEteTMdtMpCigLWw=;
        b=Ro5mFo/8VKGStal+WvRPQf5iZfNNrqXCEgrQOYimjcc+oRRjOLj855EH4daY3u632C
         TGstRQ29doBElkYZZOCcdGzGdm+yi4pwVvgYguH+iPcHoPKvGz6nsQN8HJp+4xn2hg0L
         8fPVWt5dFia1r64RnLsrS/ChWMZpqPKpqFDtZKI9+ctavrnmGpvnAcFBjJ6MmBoFY6sM
         dbWIsykhXp3ovl4NVfkDhvGc8iYmDHnrV1Fo16u1TdmveWhHl7umzaotEPdAM7PZLLgG
         eOEsoc4kgZShng9Orx7gY5sxpfM0j6sws067v9fXD+XhQr+sEnTkMRGJ9dLfuwJ7NdjI
         6qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oxLrVFgA5K2VrFmqjuGgoMdvHwMxEteTMdtMpCigLWw=;
        b=nBp+RitB1nJF8Rd+jBPxeRHvcmbKCTWpKs/8HyEe4iDgny6VCO3pup2D8J+GjyrVlR
         i2V96U0eFjWvONUfuF6ozZ+twiR85+JEzqL9qCAvc1PxLJjlXXFrAu9tz74NLVbDMf7S
         aw85RhjuouQUudZzKGwyXEEA5jTTgzmuGgVrprRMPr9trUVYiq18Vl9AUx1FqqZ6fXRD
         /PjDYMwEqT9WofKYCndNW3qeQALc1svbt2xOBROpQYR+upt3S5vvfRGRpjXioOUiyPgT
         5Jlm8Hlww2d+JMFuPUuMNn9JTqRqKyH8NxUnST56bYQWyzU43P+Rh5Hz5sqan84QL7+9
         0o4A==
X-Gm-Message-State: APjAAAUmSX4j2lwKskyn0UzaveEIlTlESF+22Ls7pGltvH1vOAmLc3Ty
        Qp/72JNlayGEwsAoOEvZTSZIKcghjw==
X-Google-Smtp-Source: APXvYqx50kUxib9LDp48jiiTw4UdyvfcFD9dK1b1J4aTvpg/lM85tbYMMNMd3SSrICQOPpOj4qx1Y4dc6A==
X-Received: by 2002:a1f:8d0b:: with SMTP id p11mr8920357vkd.0.1552959434311;
 Mon, 18 Mar 2019 18:37:14 -0700 (PDT)
Date:   Tue, 19 Mar 2019 02:36:59 +0100
Message-Id: <20190319013659.86199-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH] device_cgroup: fix RCU imbalance in error case
From:   Jann Horn <jannh@google.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jannh@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aristeu Rozanski <aris@redhat.com>,
        "Serge E . Hallyn" <serge.hallyn@ubuntu.com>,
        Michal Hocko <mhocko@suse.cz>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When dev_exception_add() returns an error (due to a failed memory
allocation), make sure that we move the RCU preemption count back to where
it was before we were called. We dropped the RCU read lock inside the loop
body, so we can't just "break".

sparse complains about this, too:

$ make -s C=2 security/device_cgroup.o
./include/linux/rcupdate.h:647:9: warning: context imbalance in
'propagate_exception' - unexpected unlock

Fixes: d591fb56618f ("device_cgroup: simplify cgroup tree walk in propagate_exception()")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Compile-tested only.

I'm not entirely sure who's supposed to be the maintainer for this thing.
The sign-offs on the commits to this file come from Tejun, but MAINTAINERS
claims it's part of security/, so I'm just sending this to both the
security folks and the cgroup folks, you can figure out whose tree you want
to take this through. :P
If the cgroup folks feel responsible for this file, maybe you could fix up
MAINTAINERS?

 security/device_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index cd97929fac66..dc28914fa72e 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -560,7 +560,7 @@ static int propagate_exception(struct dev_cgroup *devcg_root,
 		    devcg->behavior == DEVCG_DEFAULT_ALLOW) {
 			rc = dev_exception_add(devcg, ex);
 			if (rc)
-				break;
+				return rc;
 		} else {
 			/*
 			 * in the other possible cases:
-- 
2.21.0.225.g810b269d1ac-goog

