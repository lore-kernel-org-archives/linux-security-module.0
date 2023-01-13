Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFFFC54EBE
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Jan 2023 05:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAMFJ1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 00:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjAMFId (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 00:08:33 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D685D43E
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 21:08:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id dw9so19901453pjb.5
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 21:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bV7scq2ffXO1k0SYyS0OYJHJMOY3E2fENBddswV39DI=;
        b=BsXceKDieNwRvqssVmoVQUZVAbJDpelK33gVs9kPRYpxDfGCGKlL9LzWznRSVOHf+w
         IDmJIl2TYlE6ViOwP278iLpMGadpzOJpUA+aaZcDm3UIPU7jgFXqi+7rUQcrYIbPdJ3C
         8RwGRaMyeyoJYhr+dipHSrg5cJd501Z4if8gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV7scq2ffXO1k0SYyS0OYJHJMOY3E2fENBddswV39DI=;
        b=b1iyCzaF9Fp7CbwRbPQ24nt/+FJnnqJmP1rUsADA2qXBG9rT8YGMDpDdGZ/BC76qt3
         ist7d4X78P1BpbkQ9Z128IYHAdDiIJ1MHvlokuwC914m67UPpQBpg0cGqvko58oL1fMP
         lfANGqPZjyGMdRzHM5TAsqxyKa4OdDEpuq0G6tfiiO9HKFVRSuI4dn7lV57kdgYhmcBz
         KfhosnjfHkrFY/vPORLEBKUBzRGGBXLFrUMGhfwWF9uGgyB8u0lM276uhRo+bcAs5pU4
         VRvxXiTqE4OgWREywrS/Y7fzncsPE1dlwQFwmVHt670hxh8lZkbonY9P+JeJSUj3aqos
         5sOg==
X-Gm-Message-State: AFqh2kow+bp4HlXGeIVuTEj9fYq7F9+uiSZhk5K46jvvjOyt3yPeuZN1
        vvtIic5eI4Jm6j0Ur1rmr+2Cjg==
X-Google-Smtp-Source: AMrXdXt6ragV/voVXP5NXINya82my2eiV2IAW4wuBxjV1qH4vZhVt3LfDqHjxBA2U46u7o7zkImpnw==
X-Received: by 2002:a17:902:a604:b0:194:5de4:52d0 with SMTP id u4-20020a170902a60400b001945de452d0mr4414261plq.41.1673586485212;
        Thu, 12 Jan 2023 21:08:05 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b00192849e1d0asm12995350plk.116.2023.01.12.21.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 21:08:04 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v5 0/1] selftests/landlock: fix ptrace_test
Date:   Fri, 13 Jan 2023 05:07:54 +0000
Message-Id: <20230113050755.1277736-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Landlock ptrace failed because YAMA is enabled.
This patch check YAMA value and skip related tests.

V5:
- address comments from groeck@google.com

V4: 
- https://lore.kernel.org/all/20230103190314.3882177-1-jeffxu@google.com
- apply can_trace_parent and can_trace_child to smaller scope.

V3:
https://lore.kernel.org/all/20221227140244.1041292-1-jeffxu@google.com
- add can_trace_parent and can_trace_child to handle yama value.

V2:
https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
- update from code review comments.

V1:
https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
- skip specific testcase according to YAMA value

V0: 
https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
- skip entire ptrace when YAMA is not 0.

Jeff Xu (1):
  selftests/landlock: skip ptrace_test according to YAMA

 .../testing/selftests/landlock/ptrace_test.c  | 82 +++++++++++++++++--
 1 file changed, 76 insertions(+), 6 deletions(-)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

