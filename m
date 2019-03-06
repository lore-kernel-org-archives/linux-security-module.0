Return-Path: <SRS0=0cm5=RJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C649C4360F
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4714920663
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRB6MFnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCFX7u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:50 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:32865 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfCFX7r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:47 -0500
Received: by mail-io1-f74.google.com with SMTP id e1so11196116iog.0
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rcoY9tEENkPaxN2uc2H4A3TvvTCasWpC/2OBy6PWjj0=;
        b=JRB6MFnI6CPHKumtls+v+QBW7huDdcHgUo+9G6jnfMgtqnoDu+NHyFBZ3cUbo632t2
         PlyEn7WDWbPymbRpkF3y3nrGsSdRqjr6WuE0wI5aQpoDoJtOPImZywpluRwMVNUtzYnv
         vr8adGb/tSGxj/r/6bBGVZYEhsyms0OeDTa+7aU7+SmwYVp224csVMQWZUWLnSPI0P4K
         udeBcAK3Ti48QozUBr3XOz3jl02KsXDgn3AOjVOj03xEtm8S7aLowHKVDYj6l5OL6cLW
         rYZtqPka5Y+F/WjoAzm6m9vHA8cgp3v6by7Z5TBVbSp/uAEjvbwkH3xvVDBUX5flQAGx
         qC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rcoY9tEENkPaxN2uc2H4A3TvvTCasWpC/2OBy6PWjj0=;
        b=Yszu9hgLpENJkfqFCNl+vmRdgyOle1g6tVVlIOooOkxvZnI2Pdjg/H81KdTNO0ObwG
         L82wyFLRcGRoZwbJJqmqrRe2uRpAds0ZJditwPfLgzzECBcuUuuYbHq8vl1dcQQDI+5q
         PU5my0xA+uWYAXkCCjubL4ilJf+DSeTasIUxAo1zStiC4+W/Ml+T0Zcz4pmzedOZKW8W
         PIyROewHxSa1H6XGiDsFjE8FD3ZeaYSeucRFM05LR7KQvhH2gSpjXWXCxvHqOZajM3bT
         KmbZaMVXGrLK9L0kHnj1sYAtvjLl8Q5KBl2E1IjBBgbl5HVX6seeglzqNWPLhqmlkL/g
         oVOA==
X-Gm-Message-State: APjAAAW9R+KT3braHvmMxb8hnF/ZMtp8VOFiB1WprD8/D5ybC2DhfTnp
        HtVeC3fCWwNzMDfHtuqqNz9jEZc9j5NgDrXfrXeKXg==
X-Google-Smtp-Source: APXvYqxGw8B9EHptHkokWDqZZE64N4QJSY8ps2Pub8k3OebCUGaqCst4r3RFxG/Nq8WYbm1W63x0ibE/nq1ckHdCxbwYTw==
X-Received: by 2002:a05:660c:48:: with SMTP id p8mr7384486itk.31.1551916786498;
 Wed, 06 Mar 2019 15:59:46 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:54 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 08/27] kexec_file: Restrict at runtime if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Chun-Yi Lee <jlee@suse.com>
cc: kexec@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..0cfe4f6f7f85 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+
+		if (kernel_is_locked_down(reason)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.21.0.352.gf09ad66450-goog

