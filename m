Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4741EC83F01
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Aug 2023 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjH3Sqq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245732AbjH3QF2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Aug 2023 12:05:28 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33F19A
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 09:05:24 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5922b96c5fcso65438867b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693411524; x=1694016324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6wWR6vPSewXdystMdP/BcryutnZfkXis7EkLLpd/jjA=;
        b=NwNavoqzJ5tpUrXjnFg7a3TCF4E3SA9elR+qNrZAESoUsfJCPgJhzrzOoMgligrHwB
         xzxcBVgBJk7cLVmjncAd/tnnL9DtjiOhkl20TJ6kYxDoDvYmVuKOv8YXLne1f2oHEBRr
         fucWKR2NB93ZCuuL8yx0qBxBOiaqy3o7VIRCQK8aALyxKIbVs3aV6/6gOOhB0A8G2CfQ
         NAyiBYsmOHGt5009CAvnI6lF/vWxL1iZyA11/I7ykAoS7/yuB4DiPzmlCJ4Sm1+b2g0A
         vrq8vly6AAs1PEOWVLLEAr4ms78A8pn0TSAMEyrkV9eq2vQf2DZEGBhyy/yEsUj6/w67
         pT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411524; x=1694016324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wWR6vPSewXdystMdP/BcryutnZfkXis7EkLLpd/jjA=;
        b=RxjzMM0YRnqDK7skHCb1DSi7w5dRgn7zdoEvHSh1wfpUquQ1NecKr5/MRbKwJxCq+P
         LOIvnH+5oYpdcN8NZEd/9ORIZ7AiAYz5AE0zRD+Hs0jmBTsUCtZSW2wXJtrKPv36AskD
         qIp3CVkIEjWFAuRgbYwSgrp5lZigJhctLzSHEIJroJOwRdzLwwGwcm/sbhmHwyrk6CYO
         cv2qIvQ9UlGYqc3L4Ght/tHtGr93HXbkNoixRiJyxVYIZ27sf/v73v2a4L7Uh+YYM9UY
         mOHXAMXmzGHOUNxvKMMYa2pOta7dFbbdWXNe9hGh/8jZoILG5E5/8JLutjkA+/3Spts5
         /PJw==
X-Gm-Message-State: AOJu0YzpSUf/q0jLriqBRac34aYeTp56uIWrXSxF+yUPbVTHANz55HP/
        9pS37787cooL4t2pMmOkRndb9HIJieKS6UEM7WEhpmoybn4oBhpvCw==
X-Google-Smtp-Source: AGHT+IG6O2vD9Ui9R6aID4YcLbGDbyy3BOVdDWgdUShKy6tkG2weeuIdcj1Dzsn85ebN3Q5Fbo4k8brbkjhEGBtNmqQ=
X-Received: by 2002:a0d:e483:0:b0:595:2de4:c991 with SMTP id
 n125-20020a0de483000000b005952de4c991mr2549978ywe.29.1693411523984; Wed, 30
 Aug 2023 09:05:23 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Aug 2023 12:05:13 -0400
Message-ID: <CAHC9VhQr2cpes2W0oWa8OENPFAgFKyGZQu3_m7-hjEdib_3s3Q@mail.gmail.com>
Subject: LSM hook ordering in shmem_mknod() and shmem_tmpfile()?
To:     linux-mm@kvack.org, linux-security-module@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello all,

While looking at some recent changes in mm/shmem.c I noticed that the
ordering between simple_acl_create() and
security_inode_init_security() is different between shmem_mknod() and
shmem_tmpfile().  In shmem_mknod() the ACL call comes before the LSM
hook, and in shmem_tmpfile() the LSM call comes before the ACL call.

Perhaps this is correct, but it seemed a little odd to me so I wanted
to check with all of you to make sure there is a good reason for the
difference between the two functions.  Looking back to when
shmem_tmpfile() was created ~2013 I don't see any explicit mention as
to why the ordering is different so I'm looking for a bit of a sanity
check to see if I'm missing something obvious.

My initial thinking this morning is that the
security_inode_init_security() call should come before
simple_acl_create() in both cases, but I'm open to different opinions
on this.

-- 
paul-moore.com
