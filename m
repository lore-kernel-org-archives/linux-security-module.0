Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33641C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F202133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzIVR3i8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbfB1XMx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:53 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:40667 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387993AbfB1XMw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:52 -0500
Received: by mail-vk1-f201.google.com with SMTP id s143so11244183vke.7
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z211FiTElcD3CjDX6rl7HqMiBwionirC+FEZdLCWzco=;
        b=HzIVR3i8V/+98alctTtA7gEK4hLlZxu2Z5vBER34X6K1Ynqobi7o0Nmru4vCoXuERU
         Z8/v+mXxw+eOl0qxEVdS1sLwPAyUrWXR2MBX377cOjr8lqmPnLWFcrALX5dmzvEszAsq
         OQUINSsez5jKlD5cszNoUeRFbEfmqxcAB3z/1tAa6v7i9iToKStcvl5LKpRbGlEgT3CC
         MPvV8kXEKrq7oz4JgbnJziyLBr6ltu4D3Q98NnU57HoxAl1rtpx4IflpsbcI33y483Hm
         3QJVsFQ/tZtZAz9HB1JxcaQ5JzWBD2zf7eTMRfGycacEjGOg2WFPfjaeioTVPh58HuHX
         MNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z211FiTElcD3CjDX6rl7HqMiBwionirC+FEZdLCWzco=;
        b=aLU0ZisulKah72cFBLkJwE6hzD/yHBGwaHpF0ERzcaXB1R2vK/UJ+uCSObV1cTBwmp
         aKaa7t2L3idutBl6M7js/sshdHdx5JHzNWx3UXb1840bhejHzPTQT57YIE2YiVLf2+Cb
         5xJHYaI9E7PJx33VJMrIRjq0NXqljpbDg5p8mLoZ8EsCXQhaA/5Ytnh/s8BGBUXmx4co
         Uk5cM0dc9VX7xKBm/Cuq1pSonDrHcRWzrwyaQWReLVNZPdvyaEcDcvUdKJVmJkGQJcVK
         x1SK33UcB4YM9e5vpJPE9J8Jum1cfgzIDkpr7uC1A1P4TY9E1kqxuh+Bbk8cQe1+fP2M
         lUhg==
X-Gm-Message-State: APjAAAXhkc6BEq8l8JFzQp0DGjgfx43Ly02qawxtb+4knAPxY/XQV9ML
        lGCclnn387YKwR/6vHYCcfi2ElZPk6mXIHIUwT1mJA==
X-Google-Smtp-Source: APXvYqymJnMwoBdBo2NT2lteH4kP+TDr8bkEoN35nObwRtoOLjzs9jvV7ELP34iPO+nsEkvESt5zhCKSvCh4McMdH2Lxcg==
X-Received: by 2002:a1f:94c6:: with SMTP id w189mr1463770vkd.6.1551395571429;
 Thu, 28 Feb 2019 15:12:51 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:54 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 18/27] Prohibit PCMCIA CIS storage when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-pcmcia@lists.infradead.org
---
 drivers/pcmcia/cistpl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..8adf092d0e18 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1578,6 +1578,9 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (kernel_is_locked_down("Direct PCMCIA CIS storage"))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
-- 
2.21.0.352.gf09ad66450-goog

