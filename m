Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0420BC433EF
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Jul 2022 09:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiGHJfA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Jul 2022 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbiGHJe6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Jul 2022 05:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0733D2A96A
        for <linux-security-module@vger.kernel.org>; Fri,  8 Jul 2022 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657272895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sMFHzJKRiYj62gdYRhno9WSMM22FrLKbwCUpBPEktWM=;
        b=bCvyEzC53qDveupISkYfFDOap37I9aSjw+CKk1UR52Io4oXq87fMokavGSyFQmR+/mgBRJ
        UWVDUC1WRpbrYD/Hy57CP86U6kCG4IB6hF+rs3A06fLNFXRjhceKfTOAQg5vFC10ko7bs+
        Fw+MrSsPX+qf8Q9JjilkSAqbeHSxvvQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-sSPU8xiZPc6S2Os76bCqsg-1; Fri, 08 Jul 2022 05:34:54 -0400
X-MC-Unique: sSPU8xiZPc6S2Os76bCqsg-1
Received: by mail-ej1-f71.google.com with SMTP id hp8-20020a1709073e0800b0072629757566so5423344ejc.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 Jul 2022 02:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMFHzJKRiYj62gdYRhno9WSMM22FrLKbwCUpBPEktWM=;
        b=66zW+eV46cG2QDyxmBNX1q+feGXD3wsSU7Aw1kKmsYd7SlT3X1TvaGJ9nhHWasnyF5
         D4hOQEqig5ASTdcNFUnUAYlma45DC5Eczty+ULmrGk9oC9KWJfQKyPrByPY5J6zKJ0Gn
         F6208Wz03UQ3IO7IvlAJlwErvwxlJfM9lWd7tBUw5O0CHfUvLtR4iTlVAsMmmLYU93UL
         65I2wajqpLByqKjRH8pBzRomNhj/zSPKmcqY4gy9KXhjHw+ERA7u98UnESQpIASThNBp
         VRcHVmxX5bLEMyKwlTUze9lVhInqM0/5MMd5HXRxgNR3i7ldSxG8vcpSPR4Hf/XHAcML
         vsFA==
X-Gm-Message-State: AJIora8YVqu7KMnj6eDNwokV7U9UsgRzA7AYe1YewlaNMMgKV/LKhzRP
        XN1FhjxR9CLXfJUnx3zdyhFh1CGCrMEqCL/Em9/mKRmsznKDJyVfvGz7X/R/2RU751or5gKnzrf
        C3U6veCBjzgSZxJCtRljPX6RVe/QLneaaDkrQ
X-Received: by 2002:a17:907:2895:b0:72a:f3bd:6e5f with SMTP id em21-20020a170907289500b0072af3bd6e5fmr2545874ejc.767.1657272893407;
        Fri, 08 Jul 2022 02:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqzsj8D95ygzAuhY0cpDJI7xEx8WuoI4Z9hfBmeRv2uPXFteeEPUMGrkSiqA1aqHu8V5VEjQ==
X-Received: by 2002:a17:907:2895:b0:72a:f3bd:6e5f with SMTP id em21-20020a170907289500b0072af3bd6e5fmr2545851ejc.767.1657272893155;
        Fri, 08 Jul 2022 02:34:53 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j24-20020aa7de98000000b00435726bd375sm29359084edv.57.2022.07.08.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:34:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert O'Callahan <roc@ocallahan.org>
Subject: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
Date:   Fri,  8 Jul 2022 11:34:51 +0200
Message-Id: <20220708093451.472870-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Since userfaultfd doesn't implement a write operation, it is more
appropriate to open it read-only.

When userfaultfds are opened read-write like it is now, and such fd is
passed from one process to another, SELinux will check both read and
write permissions for the target process, even though it can't actually
do any write operation on the fd later.

Inspired by the following bug report, which has hit the SELinux scenario
described above:
https://bugzilla.redhat.com/show_bug.cgi?id=1974559

Reported-by: Robert O'Callahan <roc@ocallahan.org>
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Resending as the last submission was ignored for over a year...

https://lore.kernel.org/lkml/20210624152515.1844133-1-omosnace@redhat.com/T/

I marked this as RFC, because I'm not sure if this has any unwanted side
effects. I only ran this patch through selinux-testsuite, which has a
simple userfaultfd subtest, and a reproducer from the Bugzilla report.

Please tell me whether this makes sense and/or if it passes any
userfaultfd tests you guys might have.

 fs/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e943370107d0..8ccf00be63e1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -989,7 +989,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
 	int fd;
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
-			O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
+			O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
 	if (fd < 0)
 		return fd;
 
@@ -2090,7 +2090,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	mmgrab(ctx->mm);
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
-			O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
+			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.36.1

