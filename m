Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037F7C43217
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Nov 2022 23:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiKGXK1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Nov 2022 18:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiKGXKZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:25 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78C2317B
        for <linux-security-module@vger.kernel.org>; Mon,  7 Nov 2022 15:10:24 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so7444313otl.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Nov 2022 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3/fVZYQ2JVpTiGx6skt/0tkMTqCCwQ5hILAeoHIzSs=;
        b=J23GC8EYhjiHcauLwHf3AkHmpNjY+UGFWDCJ575jzVT/d14snbPbn+Vgxzh3MLJCi2
         H0Fc2LrcQtdGr+3N+jICTx3q3HLad5BGDFRmXZNJ84dVJBseNtE+f+SHdfG5T18xg/77
         sgFNoNw0X7whV+ZxFfD+4x8/6UFiCefWYtqkcfrZivAfydaRlpfB1OrDuFq8IAz6NsYU
         VvMR3RnGsDcb6QYap/zqk9xl7M1XwonqFizZ6/oMx+8LQdSYve7DQRvaMJWewOLni+8u
         pQzpCwVmDTSUENjmAhAs6QMoRn9EKRaWHywGyv3sIB10roPMW0hbW4LtRwcbdpFHAolz
         Vt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3/fVZYQ2JVpTiGx6skt/0tkMTqCCwQ5hILAeoHIzSs=;
        b=nVmWSxhwIVUDJOhEqxzGtD6yzgNvkjVnv0Gz1xH+6Hv0EV2zBFBiWXT1b5NSgZlB0D
         yk2vHciwlzDINzQKdi6yvHIbz1/2ZgE5SArYP1gj5T8+LWO4Yt4ABJVh0TXwCTwbGxST
         REAan+U6XdSuaWvQy1NnX/6JXdMnM0epZSXfqN2cpXLslCV1B77yQADGk3mk9v9bLnOK
         Nm0wvgddYNst2uHtu7dp7FdEthMTQJIBY3jD71E41mNwhwBKLpe5+9GBQdT3xxa68NQq
         pJQOK5WACv+rytUAHMvcgqYSOJ9Z5NUid3RlvHUqAACh9494iPGaFQFkSOTs2NU1nKSl
         yxYw==
X-Gm-Message-State: ACrzQf3ytIAjjA3YXjkBvulP49ENNl64FEWqg5PQ/4/cZtq+csm3QvVl
        YALUO8jcHqtSopRVP51fQ/pPULBYsxV5VvZ/EMlj
X-Google-Smtp-Source: AMsMyM4W/0y9JtQ3t/NY6zug1jyXjavMlNOeuLnGr2315i/UdxHomZ2WOKbgdifWVTbkNUq/EgTXbb0flGJ6KKpEOK8=
X-Received: by 2002:a9d:7f84:0:b0:66c:53ef:e555 with SMTP id
 t4-20020a9d7f84000000b0066c53efe555mr20871959otp.34.1667862624045; Mon, 07
 Nov 2022 15:10:24 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Nov 2022 18:10:13 -0500
Message-ID: <CAHC9VhSbLE-Uw7X9oYpqewgVWLsqBE0xeRPgwvE=0B4O6Yne_A@mail.gmail.com>
Subject: [GIT PULL] LSM fixes for v6.1 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

A small capability patch to fix an instance of undefined behavior in a
shift operator caused when shifting a signed value too far.  While the
fix is trivial and I can't imagine it causing a problem in a backport,
I'm not explicitly marking it for stable on the off chance that there
is some system out there which is relying on some wonky unexpected
behavior which this patch could break; *if* it does break, IMO it's
better that to happen in a minor or -rcX release and not in a stable
backport.

Please merge for v6.1-rcX.

-Paul

--
The following changes since commit 8cf0a1bc12870d148ae830a4ba88cfdf0e879cee:

 capabilities: fix potential memleak on error path from vfs_getxattr_alloc()
   (2022-10-28 06:44:33 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20221107

for you to fetch changes up to 46653972e3ea64f79e7f8ae3aa41a4d3fdb70a13:

 capabilities: fix undefined behavior in bit shift for CAP_TO_MASK
   (2022-11-0501:25:57 -0400)

----------------------------------------------------------------
lsm/stable-6.1 PR 20221107

----------------------------------------------------------------
Gaosheng Cui (1):
     capabilities: fix undefined behavior in bit shift for CAP_TO_MASK

include/uapi/linux/capability.h | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul-moore.com
