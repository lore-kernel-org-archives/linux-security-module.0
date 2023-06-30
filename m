Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BA1EB64DD
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jun 2023 03:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjF3DRb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 23:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF3DR2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 23:17:28 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DF3595
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:17:26 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b7541d885cso1185650a34.3
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095046; x=1690687046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4tMW9nYu8CG1Kx5U0JNQJGDDgvExBfXDekuGxOI5L0=;
        b=KPAc3EBdnLrZTuhZ0JBA91GkCQdZi1yBfADyAF7KOgyzmnpDl4S+IGni/BtmgUcrH3
         sbgYHnHSeF3KErNlwH76FXcDGpT0YJHsPG42/z5A2rpu6t71HdZ1FdW+/DfA4ASgCAHE
         ryqzVSoM0Cg4D98+NoLyA6oKWkl5NF8mEgGUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095046; x=1690687046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4tMW9nYu8CG1Kx5U0JNQJGDDgvExBfXDekuGxOI5L0=;
        b=jm0XnGqm+3wdPA6SaaFKKWK08+lUfFqhZx9re9vScttif++f9zIY7KC/77nY8FN1bX
         coBaXNwSKk7e4mpbJIsDTbbM2s3qCyP2EwkTlszri9D2KXVbT14bi4G6pnvktYGzXmmR
         6qpRnFCKBEVJuQiC7xDEJWq89v66rZmLnPFYxjDWH4r9obfEx2YaX27XplA677J3bbQm
         W5ozx/HTkdZtBorjRDxqDLXiuqxJegbdur3M6ZXuU/Exh0N7srD5xEX1zzI7NQAVeA3s
         8zYHYcciV6ax/0XlvEOtLatPt/xLdFMjYaM3xb47bTXUgklJq/Nxmwxj1QBRTYM3osUJ
         J5qA==
X-Gm-Message-State: ABy/qLZ7p7D3A4eToqJChHt42XRRGFjqtkA6vc51xgmAVCBj06/DXjKd
        26o1q2Qgd52bOcP8RAd7Ah/dQQ==
X-Google-Smtp-Source: APBJJlEJphhEXB8Hvzt4GfIdNcqhB5iF/w0ojswIeIzAdwLdkQe+337jwOl6sU6apnlxbfP2RALgMA==
X-Received: by 2002:a05:6359:bb0:b0:134:cb1d:6737 with SMTP id gf48-20020a0563590bb000b00134cb1d6737mr1429484rwb.7.1688095045912;
        Thu, 29 Jun 2023 20:17:25 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id jh2-20020a170903328200b001b3fb1119fdsm3668851plb.297.2023.06.29.20.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:17:25 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/2] mm/memfd: fix sysctl MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Fri, 30 Jun 2023 03:17:18 +0000
Message-ID: <20230630031721.623955-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

When sysctl vm.memfd_noexec is 2 (MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED),
memfd_create(.., MFD_EXEC) should fail.

This complies with how MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED is
defined - "memfd_create() without MFD_NOEXEC_SEAL will be rejected"

Thanks to Dominique Martinet <asmadeus@codewreck.org> who reported the bug.
see [1] for context.

[1] https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/

Jeff Xu (2):
  mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
  selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

 mm/memfd.c                                 | 48 +++++++++++-----------
 tools/testing/selftests/memfd/memfd_test.c |  5 +++
 2 files changed, 30 insertions(+), 23 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

