Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250DEFA3740
	for <linux-security-module@archiver.kernel.org>; Mon, 31 Oct 2022 11:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJaLH3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 31 Oct 2022 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJaLH2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Oct 2022 07:07:28 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3115ACD5
        for <linux-security-module@vger.kernel.org>; Mon, 31 Oct 2022 04:07:27 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bd2aea61bso13123096fac.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Oct 2022 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sMlKM22/vBjYG6XqmR4GF/IFfdYTzBgjEp3g+APsfwk=;
        b=mWkrrb+U58/aLUgoZbnCvf+7PUeEpgFmzXTIE3ZeDRp4An6IcGTQmNRWTB83Y30Eri
         rTXYdP4rlXt57vBoGvr/5R541P75FYw6l8H3P+fZ9kqvH3u3LiXysiWr8aN9+3zU0N5X
         DJ6qF0MpXic2BxobXvP3eMdkjftnOtOp+DXhXOnNR2gRqq/vn72snijzHCv0ym7/pE0o
         AecgDw4P/dezc1b4sWKjDKY44W25sXZpRuGUA26wvwBDnZlNGIYYS1x+WQ4tI+1jDNZz
         OM8svpGeIXkCZZxmEJUmDRU5ziUBShV8UL+8FABoIoFLEdGaA1siE/lj+VHICkNjJP6u
         BVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMlKM22/vBjYG6XqmR4GF/IFfdYTzBgjEp3g+APsfwk=;
        b=vZb4BSDdbrFPrsswlzrgu+J7JRlzqImA7HVjcF+VfVn3+vONx8NqPBNrW+aCcG+ClV
         35e6wQWi1A4Bxj8WXpSJYYuPKhlRkHX9JYftpsK52+r8FnBlZ1Mjj/H89lpjY7L6B4LS
         m6n4mMx6C9BJ+74W5E6+y84lQrVwTtOmRhjutmsxZ8DSPBHDyY0j/GCoFnfXX7h3zuzz
         VcRMGIqMnZ7iBJbxhvLT5JEMQSBE7MmSvn1fjhkVd5/jHLVoBMjebxKJqdbDFWFens3q
         8GXfWR9R8jdlsA+86vw2On4mthk70XF7hZ7E5qhnKQQq+pVCRkWhu+qqeKdNbe0IczQv
         aTCg==
X-Gm-Message-State: ACrzQf3YYZ2VXdG5Yq9GL1fymvMkEXe5nNf+XSzsis8FSEP0Obh5MbkS
        ToXMxDVN7rSd9pBH+H59a39UpJ6o34BGzv7XIk9D
X-Google-Smtp-Source: AMsMyM5SA4t8hi5LI9GwWyXVbUdkcZASUgHIE5ZRzkQ5+LQJfLcAOUXyKPGPcywgeSdkWVlOHd1I4kjBylr5HBCJMUs=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr17158926oac.51.1667214446436; Mon, 31
 Oct 2022 04:07:26 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Oct 2022 07:07:15 -0400
Message-ID: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
Subject: [GIT PULL] LSM fixes for v6.1 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

A single patch to the capabilities code to fix a potential memory leak
in the xattr allocation error handling.  Please apply for v6.1-rcX.

Thanks,
-Paul

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

 Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20221031

for you to fetch changes up to 8cf0a1bc12870d148ae830a4ba88cfdf0e879cee:

 capabilities: fix potential memleak on error path from vfs_getxattr_alloc()
   (2022-10-28 06:44:33 -0400)

----------------------------------------------------------------
lsm/stable-6.1 PR 20221031

----------------------------------------------------------------
Gaosheng Cui (1):
     capabilities: fix potential memleak on error path from
                   vfs_getxattr_alloc()

security/commoncap.c | 6 ++++--
1 file changed, 4 insertions(+), 2 deletions(-)

-- 
paul-moore.com
