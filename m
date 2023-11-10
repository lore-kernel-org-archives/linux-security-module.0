Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE4C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Nov 2023 17:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjKJRls (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjKJRlh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:37 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5A44BC9
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 09:34:50 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d76904928so14370006d6.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 09:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699637689; x=1700242489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=806uJi/RCmHW2I8pFpVv69nOUnRec8UzjlA94kcoeiU=;
        b=UIQoOVV5IJUZ28rYJ/HNpUQwin527HydemPkBcE0X8R/G9cJfkfvxCF/x1UMgvTwte
         iq1bTcn8VVgmtrzMzLFbDHFUCyvB6jlJike1i/9ZymBHGI6iGMGRlJDeQfIshO33MAkb
         Z1EY0soQt/idvqX+hYfb8SlOUHMdSoITy8Lx9gnNpDVe/0N4YRuQTIPD4R9AiOpbBw2k
         qFL8MPWFz+ZjPNJv+SybCmvgbn6WCH4/uL17gLMgdL6d8UezmiF+GaJu0FkF4yCvHMVK
         IlktqkyFywB4W9emoPiPA8dxa0PMxEqQ2qE87A0/tdGiX/p9Wcd5P9FPeogxXSMA5mXK
         maNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699637689; x=1700242489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=806uJi/RCmHW2I8pFpVv69nOUnRec8UzjlA94kcoeiU=;
        b=BGxh/XMaBioEh55l4FigjY5tsXZHUSIi5mvFVZikZeB21nasZ5MJn2XD8uxrNW1RG6
         fy11LXOFvz4+d5nWbShMvOjC1GfH0JoDiFhpdXuAoOy4Rq9KtDtyjBI701+oQf7Qnz16
         CTp6BT4375QFI8B04J1sSyaYwkqoTp/54WRgsDpkIhwEBIG5+/n7UW0Qb7GDnU96oVl/
         iw/V7aiyyZoDzu7BCJ7ntoCQf/grJUj3XxyLRn8DVFD68+LLr0xqfs2xe+Cgbue6ez+i
         g8BCw2vPLDquHcbKvo0fbIf3v4PbSvM7Fi7INbr1s/ZC1JbTHLmBzi11+SFRo/JK+wZh
         n5lQ==
X-Gm-Message-State: AOJu0Ywx+KDiRjJ09oiRN+IMqDuxi+6uR/MN+Wv4iWeOtVWeJZ9jM88q
        FO/2U4qI5txRTtGa1fUUefd/0r899EOsV7KIhA==
X-Google-Smtp-Source: AGHT+IGlsJ1CE/72NXIjn+g6/nhHoLqq8a02UdGwYr0ph42J0bkkAGhcbZaagt1SZrRkO469umVZHw==
X-Received: by 2002:a05:6214:301a:b0:66d:62a2:3281 with SMTP id ke26-20020a056214301a00b0066d62a23281mr10942068qvb.39.1699637689203;
        Fri, 10 Nov 2023 09:34:49 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pz6-20020ad45506000000b0065823d20381sm3051177qvb.8.2023.11.10.09.34.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 09:34:48 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] mailmap: update/replace my old email addresses
Date:   Fri, 10 Nov 2023 12:34:43 -0500
Message-ID: <20231110173442.79462-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=paul@paul-moore.com; h=from:subject; bh=iP2HHgqUdiwTA/MeoUYRjxrBAijj/SmAVsvvAQgg2ok=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlTmmyQqdV+5wpmJUX/zcLernCvew5yD3yRqYaS LF3vRHAL3OJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZU5psgAKCRDqIPLalzeJ c7cvEACNKcvlxRmKwAUbTbI2W13rrMA1+sWW9Mcpfb9OanGu9/X8VTtIdIjfwxPWct3JStw0Zgb coyLoQ2xPGqlQrzXxX/Ef401B81j4C+6Db4/CTSxNDZxrGsRL6ZUkOWPfDQJ0AOV79Z6vkp58ca 5Pk5A1QMvKjxHeXIcQ7C+NCmGoJqphtOm5ajF98Y2VG9evyb7G8k89WOV24VsgBSqgVawihqxx8 nBEzBfPqbYZ//NPP/43S5/Qu/mNIEvLdvvmXh1MMx1Pz2WUsgDwKRKbgNxjSbNQnWnSfmxKr6Jf j2wZpnfFIhnunf35T/RwykpvQRwT/2bKXTcDCzfqug5PX1dE4bcn9fFzK04CGzYFn+YKN7Y1P/f dmxaLMmJ4XETwFTg9WwCKF6V6SSIx6LXpjD4Q+CpfLeMr+IKgM2HMThxEkOyzbRHNGhOAspBavJ hLe4ApkeGO+bzQkZhElPqLHXv49yBxaHu152Dug5UAWIR+ictmz/SGcDka+eX5rl6Xn04mpfkIG ZBF0Fjxw764n2QEBZicdrAcKpthSptT+8zGIMXU6X5OZO9r83JFJDSbguEowS+2Ozde/ez64Nld pJG1+Eh4j2CY4LggVs1BN5T74s8BBJkUwFMdn1MB7If2Zqupa7oEY5vaZFtmI5wQsVZRz/I2nE7 Ql4Lzt/onBldziQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I was recently reminded by someone who was unable to reach my old
email address that I really should update the kernel's .mailmap
so that people looking for me in old commits can reach my current
email.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 43031441b2d9..2ba581ebb2cf 100644
--- a/.mailmap
+++ b/.mailmap
@@ -469,6 +469,8 @@ Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.vnet.ibm.com>
 Paul E. McKenney <paulmck@kernel.org> <paulmck@us.ibm.com>
 Paul Mackerras <paulus@ozlabs.org> <paulus@samba.org>
 Paul Mackerras <paulus@ozlabs.org> <paulus@au1.ibm.com>
+Paul Moore <paul@paul-moore.com> <paul.moore@hp.com>
+Paul Moore <paul@paul-moore.com> <pmoore@redhat.com>
 Pavankumar Kondeti <quic_pkondeti@quicinc.com> <pkondeti@codeaurora.org>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter.oruba@amd.com>
-- 
2.42.1

