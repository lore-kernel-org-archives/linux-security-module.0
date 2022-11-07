Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C84C43217
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Nov 2022 20:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiKGU6L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiKGU6L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Nov 2022 15:58:11 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597272B616
        for <linux-security-module@vger.kernel.org>; Mon,  7 Nov 2022 12:58:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36fde8f2cdcso118974697b3.23
        for <linux-security-module@vger.kernel.org>; Mon, 07 Nov 2022 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IAoAra9R2Xqdytgvb5FHE5lvqaFSAU/5jMDpLKBjdb4=;
        b=NB8+Ew0AYfjmdPJdO0XSLwfeZ+OYwIKA9BIG0WqV9UrxO3UPzg8TrtAk7vX7Fpgouh
         Rr0mu5WbmN5eVwxYMl0tb6d8HqaeDN5jziODCiHZrIr9GkLq1ikFlFRNaSGPbJrtaSha
         97hu4cLAScRvpdzS9lRQ3nMVtwtkOwhNnGz+F5c9kScSKtHJ8UkXaOIOjWXW+/NXl3os
         Vkk/TDoxm/DmVPBMqFDueVrFsDxqB87yhGLX9L4d/gGZsbHNcLoNaVM6Rzh0c5lZQEFK
         O1owrltdz5foiqAOjZEUYB8vm97E2wbZMy0EzGX4LIDDSF/FtmUJB7dspANhyP0/E8Aw
         7vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAoAra9R2Xqdytgvb5FHE5lvqaFSAU/5jMDpLKBjdb4=;
        b=nM390FoPBF20Vwd8ztoVpnxE02pVGfRXQNbS4iXTZdUnVKjkJCP8eF5ZFF/gPa1il3
         pJWQozYTG69OC6fC75iEf6Pqy9FZZFX9o7G40acDoI/P7UTyQoOtJjuaZC6/D/XUhxVo
         MJFCqkDPLN4+3FI+lcbcQU3A9Qzb6PDJ3ICGvYdK2QzFGjO9JY5jF83B8YmtA1h6up7o
         prYcprfQiPDIOUBW/zLpNVSxbm5U8gT6uHv4As1yKZpzIvB356GksmVH4mdGUXxb1SVs
         6J8TE5OpbQuEaM01jkrgRDpTQUjao6gkzxZ3RJXBZnpiCgw8E5ssNnCJQ3rUNcL94Os3
         gPIg==
X-Gm-Message-State: ACrzQf03AzFqrAim71jGMM2ThaVbRub886aMWCK61jxq+T8YjazQftbh
        TpeTJC+eKLDVyS37P4Ap0R6xfn+4Eg==
X-Google-Smtp-Source: AMsMyM7xHXCGj+7pqy5ZViDJCt7bvm3vyqjC4LS848X+8b6/op7HR4kC3hHLFiKF1yGjPQJpZbwBHpjO4A==
X-Received: from cukie91.nyc.corp.google.com ([2620:0:1003:314:8113:36e9:8e90:5fb8])
 (user=cukie job=sendgmr) by 2002:a0d:c481:0:b0:35b:cbe2:d66a with SMTP id
 g123-20020a0dc481000000b0035bcbe2d66amr833796ywd.125.1667854689567; Mon, 07
 Nov 2022 12:58:09 -0800 (PST)
Date:   Mon,  7 Nov 2022 15:57:51 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221107205754.2635439-1-cukie@google.com>
Subject: [PATCH v1 0/2] Add LSM access controls for io_uring_setup
From:   Gil Cukierman <cukie@google.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     Gil Cukierman <cukie@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patchset provides the changes required for controlling access to
the io_uring_setup system call by LSMs. It does this by adding a new
hook to io_uring. It also provides the SELinux implementation for a new
permission, io_uring { setup }, using the new hook.

This is important because existing io_uring hooks only support limiting
the sharing of credentials and access to the sensitive uring_cmd file
op. Users of LSMs may also want the ability to tightly control which
callers can retrieve an io_uring capable fd from the kernel, which is
needed for all subsequent io_uring operations.

This was tested by running the liburing test suite on a kernel
containing these patches.

Gil Cukierman (2):
  lsm,io_uring: add LSM hook for io_uring_setup
  selinux: add support for the io_uring setup permission

 include/linux/lsm_hook_defs.h       |  1 +
 include/linux/lsm_hooks.h           |  3 +++
 include/linux/security.h            |  5 +++++
 io_uring/io_uring.c                 |  5 +++++
 security/security.c                 |  4 ++++
 security/selinux/hooks.c            | 13 +++++++++++++
 security/selinux/include/classmap.h |  2 +-
 7 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.38.0.135.g90850a2211-goog

