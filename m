Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF6BC433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Oct 2021 19:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39A3610C7
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Oct 2021 19:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbhJFTsI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJFTsH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Oct 2021 15:48:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD73C061753
        for <linux-security-module@vger.kernel.org>; Wed,  6 Oct 2021 12:46:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d1-20020a056902060100b005b9c7c04351so4773076ybt.14
        for <linux-security-module@vger.kernel.org>; Wed, 06 Oct 2021 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zeBwNlDoWoc6hewgbBFOSf0IbwrMqp7EIQyS/tILiuA=;
        b=QTqrR48AsqVhuPqy1PxKG1Y5IC8aLCxSncaEgXDbLH9avUoW0EbJle6j7ssOzIruus
         ZwDOiyleOymrMvvlMVCqxnEQT/z5Ys5+kgrzUr+pJxNTbBDDaqkDMHZ4ipFXxwihV8MF
         0unQK1jaxfaUsKxcryhs+xPyrAVmdo3hMMNh7cUrXAqdpX8CPJvtyedrihtXkRH4m6BA
         HWnYBBHqptcPpyOwn76ReutNQ+hLdOznlRqlrDejyolnmXCMfSfeJw2HeYPkDH3SICDF
         ztPNddQ/4BagBb8ROAWtUrC54pgum5IoJmWjbzuYvqhKKETIvrVbRSa60DKvXhDPlLDm
         DH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zeBwNlDoWoc6hewgbBFOSf0IbwrMqp7EIQyS/tILiuA=;
        b=GIo8DHLYEXEzVdn1q56tQSJqpv7cjRciCq3UFXe9jt9aXBMNjM26a5jMNirKWvUZa1
         LTATh2iIt/ZKYsOEwGzn74prqjLRMo4ZR+lXn0jzCiK7DCYBzZjCjmM0pTMPozzK1OCh
         NDGDh+TM72tzCVHHyRhzSy80heLmi2q4fYn+ouvboAIGnf8nnlo+01EKgjLExqMy03tw
         wfzymQvatJBQKnAXdI5ioWNL18/Mvijj5FYjeOTPeAcz4N1W6BgmhXTEF2Ld5rYrtj7R
         dTQGA9yerAvtxnMvIuZyZEzgGN3BQmgXbczc3JSGUhulMNCIauFJJ8zL0PlRlL/EdEpE
         jrAw==
X-Gm-Message-State: AOAM530fx77IofJXmwnItVY0cU9kl9akcg1zaeD5uDI+XTfo9GgYQuIP
        EAIqmJtJ69/jFWcEWZsl57B5D1bKqw==
X-Google-Smtp-Source: ABdhPJzKw784oDeJqW2PQeb3pJYAXmSHTh0N8s3rKTBeB5szm8C6rXRdBdEnjZCG2tkvsBw2iC6fL3kXfA==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:6ff2:347f:ac4a:8a04])
 (user=tkjos job=sendgmr) by 2002:a25:df84:: with SMTP id w126mr30874545ybg.109.1633549574377;
 Wed, 06 Oct 2021 12:46:14 -0700 (PDT)
Date:   Wed,  6 Oct 2021 12:46:07 -0700
Message-Id: <20211006194610.953319-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v3 0/3] binder: use cred instead of task for security context
From:   Todd Kjos <tkjos@google.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This series fixes the possible use of an incorrect security context
when checking selinux permissions, getting a security ID, or lookup
up the euid.

The previous behavior was to save the group_leader 'struct task_struct'
in binder_open() and using that to obtain security IDs or euids.

This has been shown to be unreliable, so this series instead saves the
'struct cred' of the task that called binder_open(). This cred is used
for these lookups instead of the task.

v1 and v2 of this series were a single patch "binder: use euid from"
cred instead of using task". During review, Stephen Smalley identified
two more related issues so the corresponding patches were added to
the series.

Todd Kjos (3):
  binder: use cred instead of task for selinux checks
  binder: use cred instead of task for getsecid
  binder: use euid from cred instead of using task
