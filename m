Return-Path: <SRS0=o9Ra=WJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE6FC32750
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02929205F4
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsSWHVmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfHMTVq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:21:46 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:45490 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfHMTVq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 15:21:46 -0400
Received: by mail-vk1-f201.google.com with SMTP id x83so45764618vkx.12
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U4sqvdKOHk6dd3bPdrZadjO6yR4my3JBXo6uYepBVBY=;
        b=SsSWHVmB3VKy9t0EY0Vi920PorFVCWXYmiLt3Ikok8W4LD59Z7p0a7y4LOlHI9zHL7
         OToRrq5Z+CreeX6SDf4hpxRROlIqvMxLzn0NqOUhtal8gQce5IgTrNKh1CWUmobRZAwj
         QJCRss7oQWBuYu+K7505i2HCL7AiBinNapi8Gd95r3LKCgw0F6ytkYd5+hPeWkFaWgLl
         y6ykOnAGQEAbcnJuGLqDplx/ibrJ9jDDwgYGQ5+AHfRwud/T9TyeqxrcGOiPzUeuWL6U
         yEMQ4kToBR1mvhVUL0JRmTo4Z8+6N0dOkpWjwjJZ7R0kkzWPRjAI3va6hbnlQL/e0oyU
         oXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U4sqvdKOHk6dd3bPdrZadjO6yR4my3JBXo6uYepBVBY=;
        b=MvINziPcJcj+OypHTOwoM9+Nvq577BIzXTuJAowtwgtmIFhCT5O20thMtPeGgOeYAT
         o6R0stLs6z6xDcrLGzzeOKJPZSxA/vNdOYho2CPHdqEG8C8ba623nTEK3YUAbXQ2wgHG
         Qdr2Lvy60jKfUUSdaO35gagKn/hUO2mQZY2bq1ZRFw+NCIKqF5xo3XNwA8KRm2Y4tjiH
         hLcb0CygGr8A6pb1To2YOSNfk0fr0cCbsMxRrPQCl8jHkm5VcdkyzfLGp/gC5Z7GI7m+
         xHzZ435U8vfDU3FVGEHPvk5F3LWUS1S4eduqw+tV4O+DerLmhQYO/pE0DKbAYZk6kUdm
         5FfQ==
X-Gm-Message-State: APjAAAUYFacHOLP4EA8Fw1OmT0VbIcLhbfJ8o3KaIvAQIDTsiZrrU+3o
        LW3nLuiMgO1B3qhgxeqlvgMbqRuzUa/NcCVSX9sExw==
X-Google-Smtp-Source: APXvYqzAE/erA5sSA4sUWQJ44I89ctbCbVNVQtqbb7rQPZwii3Rb4chhl0+b/gWVV3N1Y7i7AKkQSjAUBSWNtzNexJpZkQ==
X-Received: by 2002:a67:8ec6:: with SMTP id q189mr27008065vsd.43.1565724105306;
 Tue, 13 Aug 2019 12:21:45 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:21:26 -0700
In-Reply-To: <20190813192126.122370-1-matthewgarrett@google.com>
Message-Id: <20190813192126.122370-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 6/6] Document locked_down LSM hook
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        kbuild test robot <lkp@intel.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The kbuild test robot pointed out that this wasn't documented.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: c360be6c ("security: Add a "locked down" LSM hook")
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/linux/lsm_hooks.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5ec2912c8661..2f4ba9062fb8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1446,6 +1446,11 @@
  * @bpf_prog_free_security:
  *	Clean up the security information stored inside bpf prog.
  *
+ * @locked_down
+ *     Determine whether a kernel feature that potentially enables arbitrary
+ *     code execution in kernel space should be permitted.
+ *
+ *     @what: kernel feature being accessed
  */
 union security_list_options {
 	int (*binder_set_context_mgr)(struct task_struct *mgr);
-- 
2.23.0.rc1.153.gdeed80330f-goog

