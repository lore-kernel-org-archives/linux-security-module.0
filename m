Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC7AC49EA5
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jun 2021 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7DC6613DA
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jun 2021 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhFXP1k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231708AbhFXP1j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Jun 2021 11:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624548320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yv7m1AvCn7O6dTH1q9vdjmlX/RhwF6AeGVa6Oa4+0Qw=;
        b=MdWVBAv+FCDSXegECxJ/N0ebI1Ym4RXYnx2IggZwB1aHd71iqlMlp0fYIM0fWoabvdg+zA
        Ni64SnfPS5i8P7kmIUAt2+IRaibbOy3oEUY28jY1seiAB/KG/twlHkeUffwowaVwKGp1vr
        g0nT+j1q/xGUvQlqs6wx/Qw55BPNZ0o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-2HeUnOc6Ml-xJ3pyjNUCBg-1; Thu, 24 Jun 2021 11:25:18 -0400
X-MC-Unique: 2HeUnOc6Ml-xJ3pyjNUCBg-1
Received: by mail-ej1-f72.google.com with SMTP id w13-20020a170906384db02903d9ad6b26d8so2166997ejc.0
        for <linux-security-module@vger.kernel.org>; Thu, 24 Jun 2021 08:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yv7m1AvCn7O6dTH1q9vdjmlX/RhwF6AeGVa6Oa4+0Qw=;
        b=EQjOyPsMIqV7zzKywVAs4QQoHxfcUxbFlma7N/tQ9JHQSM6+dvZnD8Jr1wdW0o06s9
         sF+ccTnr04Z0F5+7QovL7ln08mYnIzOh8dOUWHMVscV7cuTw5qeTtUeDPPfMVB3YNIi4
         0wzNLR0UJ6UR8AW6jhIZuw99cQUFO5AM8S9SihbYtkMfY5Fxf7k2e/G40VByLokVeXFl
         kwtQmxoaez7UeEWTrSrrTO09b7SnZfp8IqxploRE8gpdFH4EcPqv3doWWt39IuYxfYzW
         ndsCwPxA1exUTsKYz6BTb1Ju/Z9z1X5Zcn2ptZdRwNyNM0c82tHetLLVQ0pBDvv6/+g0
         49ng==
X-Gm-Message-State: AOAM533XZ94meTmg2Q17gJGriGZ1BabDf8aYIxQO8BeRdb6XooRoN0+m
        4v76gT18H7ybOC/TeSlyEsV9bUSOjuH8NCfFt1Vmd00MYfG2UXcH9J5jNQPyvL96mO6lX97o1Q/
        nIexZvaMJofNC5xJScvply88KcJXXyFl4wFQk
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr5836129eja.275.1624548317667;
        Thu, 24 Jun 2021 08:25:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDFvu9eksuXynDzV/xksZCJe2btC6g1NOCWnVD/di1wd6CsF0Z7byzAfEPlhofKBrJp+8MwA==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr5836107eja.275.1624548317485;
        Thu, 24 Jun 2021 08:25:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id a2sm1399830ejp.1.2021.06.24.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 08:25:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert O'Callahan <roc@ocallahan.org>
Subject: [RFC PATCH] userfaultfd: open userfaultfds with O_RDONLY
Date:   Thu, 24 Jun 2021 17:25:15 +0200
Message-Id: <20210624152515.1844133-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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

I marked this as RFC, because I'm not sure if this has any unwanted side
effects. I only ran this patch through selinux-testsuite, which has a
simple userfaultfd subtest, and a reproducer from the Bugzilla report.

Please tell me whether this makes sense and/or if it passes any
userfaultfd tests you guys might have.

 fs/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f92285d04f..24e14c36068f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -986,7 +986,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
 	int fd;
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
-			O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
+			O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
 	if (fd < 0)
 		return fd;
 
@@ -2088,7 +2088,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	mmgrab(ctx->mm);
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
-			O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
+			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.31.1

