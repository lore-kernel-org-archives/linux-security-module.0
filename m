Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844F4EB64DD
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jul 2023 11:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGRL46 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jul 2023 07:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGRL45 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jul 2023 07:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5E61B1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689681374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HzrRHf2xvIEmTHm/Gu7FM0e+zDruuUgopzejA6ZU6c0=;
        b=IvV3Y6Ldq6PFzkCUjT42nH3EsBgMv/5YJyVc56dIDpvWU0oac5ck56CyGRQuuMQ4xMdgYk
        +juA64xmHRlF82hyOr5OVRtQzww0DANDmWyvl9tcdDhCzSMmMjTz1L3044t84+UE93SXAL
        zwW9HPoaaWL2Jm5fEy9JwQ6q9xhRboo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-P77wtZoPMYW1e9pmT8-ZHQ-1; Tue, 18 Jul 2023 07:56:13 -0400
X-MC-Unique: P77wtZoPMYW1e9pmT8-ZHQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635a4267cf5so46684616d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 04:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681371; x=1692273371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzrRHf2xvIEmTHm/Gu7FM0e+zDruuUgopzejA6ZU6c0=;
        b=ZMZalw+uThsAYH8QS1ZQAl+6rDWq2A4RHzFMoQ/89nLe42sAIcmM91iSUlSu32vUlS
         H7RTCSyoO/OPyd6OCiwOdPaEAhv5K9itmfWfxRpsByqM7ujmZhnZVEuG432KV97Uaa77
         SJhmc0Zw7O+/GOa7T7gb8iCaeuKxeZU1Vs3V3JvbMGK1AMVzlJNfRuMdNZGbglQ2+XM7
         WhaO9Y0rGf6y58asffAKZ17uBsqmaWozxOKc7AaRK4l22FI0mKOBlu2QGwoN6GoUnKEB
         +wLO238fRVdzODPiE+k9bg3vD1xuRLFpNbbynG2k5V1XpplcrAPg20fPKxU5YkpS+fcc
         XKpQ==
X-Gm-Message-State: ABy/qLYrDcoCED6iIYckyKsnmcO4eoqJshFOEuZZM6dk8vTDQlE2aocZ
        k5Zr4KW6pGiLAH8KdsIl2Dd3bjxmsFQIAWBBtzFpFlIE11k4kq7Jmz8sm7klFujNQxSYbzAG3cT
        5VzyIMTm4ZbJJO4UBbVFbKlYHFftd/52f+oM+
X-Received: by 2002:a0c:e283:0:b0:623:9ac1:a4be with SMTP id r3-20020a0ce283000000b006239ac1a4bemr2032993qvl.12.1689681371133;
        Tue, 18 Jul 2023 04:56:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSJUN7slcgvMgDdDG5JP24NhEZr3/218cgdV5hvCjvLFTCVdt9XTG4M2tXJraV2xCUUP3dVw==
X-Received: by 2002:a0c:e283:0:b0:623:9ac1:a4be with SMTP id r3-20020a0ce283000000b006239ac1a4bemr2032986qvl.12.1689681370899;
        Tue, 18 Jul 2023 04:56:10 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i4-20020a0c9c84000000b0063612e03433sm657864qvf.101.2023.07.18.04.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:56:10 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: don't audit the capability check in io_uring_create()
Date:   Tue, 18 Jul 2023 13:56:07 +0200
Message-ID: <20230718115607.65652-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The check being unconditional may lead to unwanted denials reported by
LSMs when a process has the capability granted by DAC, but denied by an
LSM. In the case of SELinux such denials are a problem, since they can't
be effectively filtered out via the policy and when not silenced, they
produce noise that may hide a true problem or an attack.

Since not having the capability merely means that the created io_uring
context will be accounted against the current user's RLIMIT_MEMLOCK
limit, we can disable auditing of denials for this check by using
ns_capable_noaudit() instead of capable().

Fixes: 2b188cc1bb85 ("Add io_uring IO interface")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2193317
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7505de2428e03..a9923676d16d6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3870,7 +3870,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 		ctx->syscall_iopoll = 1;
 
 	ctx->compat = in_compat_syscall();
-	if (!capable(CAP_IPC_LOCK))
+	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
 		ctx->user = get_uid(current_user());
 
 	/*
-- 
2.41.0

