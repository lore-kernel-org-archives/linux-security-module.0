Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49DEEB64D9
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Jun 2023 23:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjF2XZJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 19:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjF2XZI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 19:25:08 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61401FD7
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 16:25:06 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a1fa977667so1111639fac.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688081106; x=1690673106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XkUN0EizrcPJdxYDyml9MD9K5nwnJEgupZt44caww4=;
        b=DIOrkzvu8itXrRDVqrYwNUO8RR/O0uEKATtMBGoLT7ZDMAULfOV2+XLpRMwb4lSo1H
         o8f4vm7uBwP6nRhUwyvViY15Yn73fB6S5rSl+En04NKl9NuKOjDAks0aqXtGB6itZkTx
         hFE5wR4rTEM4DrLYzlMegMS5O2+oAyJQsqHkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688081106; x=1690673106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XkUN0EizrcPJdxYDyml9MD9K5nwnJEgupZt44caww4=;
        b=Jf1fSl4YcerkK7aQ0EVIr1VTZo8DaQokhT15Fz6KZ6EBNpLHt3O8RByZkNM7wYs0Iy
         JxTVwFe6HDFFILAe1kY8aKfGDtSlL7y9nNXeXz9sNmAVrv8EiskIzfnsZ+U1PBaaIinj
         1vXYfahjVxuejZIlKuOBkjVe1/PSdGHsTuhjCqiClOrmAnqPiXevhIoc/vclvsntFd8Z
         OYo5ukPnjeamiCHwhwHIqp/bfFQ1RrJg/fZnTMH+y7WguPeKWawkYWkFaxuxsz3KGODX
         GRm0Yi1JL9Sq5aoisPZA/8/MXHc+ta67lwJDv+iN66Anob6OqvpYToKaqhTAU3MQp4bf
         mDcw==
X-Gm-Message-State: AC+VfDxq/XHo+0luCZbozCBOQYAscUV16P+IxSzmlCD9/TAYvGcSPdbE
        wuVGBDlA7L9xqymbfHh7qLpjhA==
X-Google-Smtp-Source: APBJJlGFQhB9pXlX/BZEhpArHhanMF0PsxvAgS8Ray5hkbYflejU/wjfaf/Ywe+hLWqeUIiTbaazMw==
X-Received: by 2002:a05:6870:3c8c:b0:1aa:9eb6:974d with SMTP id gl12-20020a0568703c8c00b001aa9eb6974dmr1593876oab.41.1688081105835;
        Thu, 29 Jun 2023 16:25:05 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id g15-20020a17090ace8f00b002636e5c224asm573038pju.56.2023.06.29.16.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 16:25:05 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] Documentation: mm/memfd: vm.memfd_noexec
Date:   Thu, 29 Jun 2023 23:25:01 +0000
Message-ID: <20230629232501.4157671-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Add documentation for sysctl vm.memfd_noexec

Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 45ba1f4dc004..71923c3d7044 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -424,6 +424,35 @@ e.g., up to one or two maps per allocation.
 
 The default value is 65530.
 
+memfd_noexec:
+=============
+This pid namespaced sysctl controls memfd_create().
+
+The new MFD_NOEXEC_SEAL and MFD_EXEC flags of memfd_create() allows
+application to set executable bit at creation time.
+
+When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
+(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
+be executable (mode: 0777) after creation.
+
+when MFD_EXEC flag is set, memfd is created with executable bit
+(mode:0777), this is the same as the old behavior of memfd_create.
+
+The new pid namespaced sysctl vm.memfd_noexec has 3 values:
+0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_EXEC was set.
+1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_NOEXEC_SEAL was set.
+2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
+
+The default value is 0.
+
+Once set, it can't be downgraded at runtime, i.e. 2=>1, 1=>0
+are denied.
+
+This is pid namespaced sysctl, child processes inherit the parent
+process's pid at the time of fork. Changes to the parent process
+after fork are not automatically propagated to the child process.
 
 memory_failure_early_kill:
 ==========================
-- 
2.41.0.255.g8b1d071c50-goog

