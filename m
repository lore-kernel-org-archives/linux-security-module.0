Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384F2E7C4F2
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Oct 2023 20:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjJDUIU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJDUIU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Oct 2023 16:08:20 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FFCA6
        for <linux-security-module@vger.kernel.org>; Wed,  4 Oct 2023 13:08:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-417f872fb94so1394161cf.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Oct 2023 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696450095; x=1697054895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1HZ6Nfm2SBF5FAP7f2Bm6ygCN95kYUjyXZ1vs07p60k=;
        b=BXRowayEFHefYz3N3oMmDZ3M/AhmBfKcbY/sCPzOYpgXDgZJLZWjUGjS7Kp3+3NU8g
         QfQ/cQLybKQi8LvzxXElFIFdJvdSjEe0gmjTLEqgiU1O1k4QR1FWKq8aN1FpM59ZmX7H
         i3nfDwE+yqhbiY2bLnrISR9PRylrGMqUNplwvC28dEzNGMeo1sQIvTu0OLsAnMG/7/TT
         mXl0ApsF6dkwnXhwMLoe5DKHDRF7Rtxnlw97rsJ6yth3MNI2+/+c87P6E2kp5AZ25Qb+
         803YVhQNa5SKCoCL7dk9E/JPG3KgYXAjPJ61TydG5J6psgvKI/p0gubATwE74hY3SJ+t
         upqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450095; x=1697054895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HZ6Nfm2SBF5FAP7f2Bm6ygCN95kYUjyXZ1vs07p60k=;
        b=rCHz4rJkIDdkuD99siJ+wI7EZ9cZFTrDlWLi+53JO4YSjCVlNPEwZf0SE0yCggVbCc
         kMxuMUv1ar7Rs1oXNCz9z31rFfVi4xn9cm84lX6jr3vfdic76fq5OGl9/w12xPD/EG36
         WZKciFzY+a7m5Akm0eiDwN03XFAEhs56qqVHJmXMvFk84pMh4bs6Hi+SluVYYWBMKGUr
         zuzRF1GBUBS9p12iFmQCtqZtQo5vE5vQf+mBthg3rbKe8GiGiOvu9juQKDvofLn6IDTX
         gsgzzZC/c3QksaU3fSt6E4w2rfOIqIuH5zyqTy7Ql2cm+MPQcr/qMLgYoexe88AlKqlM
         D6Cg==
X-Gm-Message-State: AOJu0YxaqoFsxBp3pbIGERuMQyBF9RWWwhjy3wzIi0ltTNBBXGr6OPEM
        w2t/e9961h1Ln41nrj3fczzhStkEKYo/sw4BkA==
X-Google-Smtp-Source: AGHT+IH8IlvGFiG6davfeQONbMbgiOTqSf+9ZsMXqwC3MH0KD6w5/Fs2INcosULTJ6ZnGczzWbEy2g==
X-Received: by 2002:ac8:5a44:0:b0:415:1683:9cf1 with SMTP id o4-20020ac85a44000000b0041516839cf1mr4150251qta.21.1696450095631;
        Wed, 04 Oct 2023 13:08:15 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g26-20020ac84b7a000000b004180fdcb482sm1438093qts.81.2023.10.04.13.08.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 13:08:15 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: fix a spelling mistake
Date:   Wed,  4 Oct 2023 16:08:09 -0400
Message-ID: <20231004200808.317935-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=752; i=paul@paul-moore.com; h=from:subject; bh=Tkw6LK9L2L6mODdg42xzbNlF96MX+Mqzb9MxfziFn2I=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlHcYo5NiaLN/5j4lcNm++R8jcAIOO6MSR4zQ30 aSGYHFMaA2JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZR3GKAAKCRDqIPLalzeJ c2OtD/93BueQTBam9BXowx0azKAufELP1I9T1vAOAo2eQPKJ7dItwgYDlcE9H9S8wNWBoLgMBlU XBNYSkl1iGKTLj0TDSVo5ZbgfJ/LKu4ecmYrYa8NV42zuBY95yTnVpyA9j10x7/+yNfxamtfzsI BWiB9ZmD+myvav5/PjFRpUjS/iKXYZ5YHsoLdN4FftLw523gCehwL6U0udCrqwJRJ+qxs3mhWdI rxp4eR+xo0ND/lVXxuFNmad1Zs2ab/oYrrC2UrMlhhae+jKcOAhdrRdDZFRIBp7nw4RfRBXe49Z EuCIIIGNe3q4hQPRQ6aOKAXCB/Wd474Z/oWIEXM7c21DhCJs91pvoYEXRJo8hMTl8RLsb2+c0tA MVHrhGKtEREil3+ZP+J8N+K5HtgSCZaMC2crTjXr84jmfPRivx+EzeN/HjqrsdSwVImm9bR7WFQ rHGHW7vMLb5Y1GRhPZ2o8Lq5L48utlqSE/7Ws3DEOLDLeIKfKE3ZXPO5uky6ro7MW9XHQlHm1dZ EWby3uMYfX1e76QKmo0g/Gql08LMh3L5m9g3M7bfy09/ufy+AG6jc6815x6QOcGDCwYWP4m4mvI pwXKY6XzJa3c4l4xp+fnGcH51BrBnQ9fGH0EchLdha2Vfa2M/nDI3mp1t5PB21Nhec8Wf1xS23n hQBB2fJ7Eg0kvlw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix a spelling mistake in the security_inode_notifysecctx() kdoc
header block.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 7b0052e96806..dcb3e7014f9b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3957,7 +3957,7 @@ void security_inode_invalidate_secctx(struct inode *inode)
 EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
 /**
- * security_inode_notifysecctx() - Nofify the LSM of an inode's security label
+ * security_inode_notifysecctx() - Notify the LSM of an inode's security label
  * @inode: inode
  * @ctx: secctx
  * @ctxlen: length of secctx
-- 
2.42.0

