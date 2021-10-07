Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC9C433F5
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Oct 2021 00:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA8460F4A
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Oct 2021 00:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbhJGAsi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Oct 2021 20:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbhJGAsd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Oct 2021 20:48:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C4C061764
        for <linux-security-module@vger.kernel.org>; Wed,  6 Oct 2021 17:46:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g2-20020a256b02000000b005b71ee6a855so5707036ybc.8
        for <linux-security-module@vger.kernel.org>; Wed, 06 Oct 2021 17:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zPCs1rEpKuQz4LUSoTxaJ0G3vwf7KAFSlUITLwZs6tU=;
        b=p7C8NObDL/qgsnHg5/TYMe/e2qJ6I/Lq4YqPZ2gUnySyfykd5F/A2vU/1m3ceyFytV
         I/7OeC1DNhDBO/Sg1SZmblT8zSDOS20AEaXhLm2H/qlJpIU+UkrwJgwQR6ZhajMJlwdg
         H0AQ8c2Ji4cC5UGLPFyjbyHiVLS1+KBXJaeDkVYrBsKAL2mDeRIuBNWlxuMFkZA9ZGV8
         A7qky4OO4I/PaZtI6fTe4+d1q4NwNuqcs2UJX5Gqm7isuGeOruusB375wUngfU0n4dV1
         v6iAo7zDuAInyEyLRn9Rt/0nvTXYRScq+aeug+gsRlashaZxAnGdEcAqgBxeJf60frPU
         Y76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zPCs1rEpKuQz4LUSoTxaJ0G3vwf7KAFSlUITLwZs6tU=;
        b=YPdf6h9H+9/BRtfEcGYQDmXot8pUzgjqTkWbbVI0oWYKQS8dxDU/ej4BfT7Xp2i1lA
         8FJ0P9Zpsxu5W6m5A9iqpjteM88HPsvHqYrry+GFRfU2vqLlUqbgciUWEm1U7bOCR0n0
         37nHR9LwljuEurUbJxCMNHr+M+Ud+T4d2DZ1YjdhZFT4L2PqGDOKrs4+5It2WZsoutEv
         cw01xQaHGiUe0/QX5Vd7fqCDWP4tkhRPYPpS8v6E9xoEtivr9xhRrcHIbeOyJgELEw0f
         Z/MfWc+b9uYgMhzA0pGn9iBFNYcfnFX3jf0EbW5NV7+NaLYJTybLynvAvf3zZk+sW2J+
         N6og==
X-Gm-Message-State: AOAM532/48PL2AVIrWfxRWiNcejYhKYEtwg9fRgUQjd7OGeEivDD9r6u
        78sP3buhd8NoH6Kpy0lgE9nEQrJ1sg==
X-Google-Smtp-Source: ABdhPJyjO6u79sIe1Ctn1/EYwfXuBQtVGMw40kM5yChFcDVNsb4RU39eXJBDBGttGXiLTmWRzysZNXQWxg==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:6ff2:347f:ac4a:8a04])
 (user=tkjos job=sendgmr) by 2002:a5b:501:: with SMTP id o1mr1359354ybp.402.1633567600035;
 Wed, 06 Oct 2021 17:46:40 -0700 (PDT)
Date:   Wed,  6 Oct 2021 17:46:29 -0700
In-Reply-To: <20211007004629.1113572-1-tkjos@google.com>
Message-Id: <20211007004629.1113572-4-tkjos@google.com>
Mime-Version: 1.0
References: <20211007004629.1113572-1-tkjos@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 3/3] binder: use euid from cred instead of using task
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

Set a transaction's sender_euid from the 'struct cred'
saved at binder_open() instead of looking up the euid
from the binder proc's 'struct task'. This ensures
the euid is associated with the security context that
of the task that opened binder.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
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

