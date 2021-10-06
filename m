Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47021C433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Oct 2021 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E92C60F5C
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Oct 2021 19:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhJFTsZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbhJFTsP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Oct 2021 15:48:15 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B131EC061755
        for <linux-security-module@vger.kernel.org>; Wed,  6 Oct 2021 12:46:22 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c13-20020a056214224d00b00382f21b95fcso3588491qvc.5
        for <linux-security-module@vger.kernel.org>; Wed, 06 Oct 2021 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S46yz478S8g1jd3FQde3QS+N6MClLovbhy1xDKfV8s4=;
        b=LTnJjPOs+ZrjG0fHZJG5cMVX7InUq2MqrkMbeo48RoAHPz31PRLdH8EOCHwXyVPyc1
         X10w6ZZcI/Hsx7ienxn79JbwedGc+RPfPqaKzL5G/tmWw7NSxvn6Q4nw541XyO7uOiy2
         jJIVJfZILKhWwS3qA1i7qPKnmFdKmYF56wf3Xityp9t7QBQTeFhPdok+rnGnUwLmP9c4
         kTMU7DwzzBEDSl5VEmeAFQQ5twDjGLJLEnvb/JeuNTKjr0YTbuTXc0UCmpHGy0P8tCS1
         Z2XjLcil0IT80vK0kdj7sKduydQnvvj4LI6rlUBOnIu3KJ4NsuTDZLY5lZA6h6CVNn9T
         QHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S46yz478S8g1jd3FQde3QS+N6MClLovbhy1xDKfV8s4=;
        b=sf9lwmjHRGg2/a3lUkWXNR8ac5YvgbiapQfaYPkSKqUTTPH2fTGuGY022oVigGaNiK
         Yx+8cGTX7ttqOnqPQ+0OulzpsiFnUQSJuPZUcu/TIKXfivwyGVjGKGe04W5jPInu4SG7
         6q6o5N6UoZCtTgp4OZTHdf43DtylcSQDPNj8Ue2jaD2pe3TzBBvSjZXytQnvCDr9Mkmf
         NJC1Ay9MVZQHi8+yAaSJr/wnZXwxuMdbsiobSZVKlofhcaynvnzyXzYEAtD89EXIkfql
         FvMf34zqHpGRX9NYNafJYqmXc9xUrCYuc+eFMB3wUbB7ZVqgljUVikKEhiLe7HQC7m7h
         3G8Q==
X-Gm-Message-State: AOAM531xvMbnjav7jvmh15Y3eSQA3xGeSYfyiYU7q/OIg4aCd2sCmzvZ
        unomBvzoxNmvUlKrtQuWxb8nZuT9PQ==
X-Google-Smtp-Source: ABdhPJwethn/u+nenu/8wM0paTR5+kkIhr4fatlk63zkiST7M/XeOk6Gp0cs5DvZ0ktg8MeudPwnwmd6zQ==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:6ff2:347f:ac4a:8a04])
 (user=tkjos job=sendgmr) by 2002:a05:622a:188e:: with SMTP id
 v14mr108103qtc.62.1633549581824; Wed, 06 Oct 2021 12:46:21 -0700 (PDT)
Date:   Wed,  6 Oct 2021 12:46:10 -0700
In-Reply-To: <20211006194610.953319-1-tkjos@google.com>
Message-Id: <20211006194610.953319-4-tkjos@google.com>
Mime-Version: 1.0
References: <20211006194610.953319-1-tkjos@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v3 3/3] binder: use euid from cred instead of using task
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
        Todd Kjos <tkjos@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Set a transaction's sender_euid from the the 'struct cred'
saved at binder_open() instead of looking up the euid
from the binder proc's 'struct task'. This ensures
the euid is associated with the security context that
of the task that opened binder.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Todd Kjos <tkjos@google.com>
Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: stable@vger.kernel.org # 4.4+
---
v3: added this patch to series

 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 989afd0804ca..26382e982c5e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2711,7 +2711,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = task_euid(proc->tsk);
+	t->sender_euid = proc->cred->euid;
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
-- 
2.33.0.800.g4c38ced690-goog

