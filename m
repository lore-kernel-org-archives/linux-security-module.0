Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C985C43217
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Oct 2022 20:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiJFUUp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJFUUm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Oct 2022 16:20:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA631727A2
        for <linux-security-module@vger.kernel.org>; Thu,  6 Oct 2022 13:20:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so5401118pjs.0
        for <linux-security-module@vger.kernel.org>; Thu, 06 Oct 2022 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date;
        bh=Rk5zz4A39+pbcgAoB20NzVrsEawygpTbgx4vBx4ppIs=;
        b=BYx3cjQRaQ61qD4kci8lj8sUlKGwxBQTGugOVwVFovwHCmI/LQDbCjb+DkICpsvW4m
         STdWXo4QVJpb8zGJImpu91r/m8zGJm3KZaeFnkzRlgCgjI+0GDcxB5MTmrhucCW633IN
         I6hYYHjSrLy5aixD/PhLwPqvTzNVP1wuQopiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Rk5zz4A39+pbcgAoB20NzVrsEawygpTbgx4vBx4ppIs=;
        b=NGvJQ6Qwz6xq96NMqeQRkst5PVpEKboo3T5GotJ8D05YUwhpFL9otdesgMiRHd9Kof
         C/50ia0tGGhKO4q1Zh0hTMj8BpLldAV867+m942jhQeQ1Vt2hW7BDKlnlUasEZaGjwWP
         uXBnctglBVitY0iAzEJFupADG4xHwmoOn78QvPgkWmb1QWhudaNoInWBhSvRcdfbd5Jo
         +6RjWM8vNuL3jx93vC4QpUfzKZ1tAq9yGEmgQydcwNfiSUw63Bw/wUZch8UF3mtcOWsU
         yRmgudUDDTg5+9v+tiQdcnzw4s5CQH/i4Vnwm+CRICBltgo5gk4jZHCndolhpJEqj8u9
         gEQw==
X-Gm-Message-State: ACrzQf0qmRof2pCd7aadLixPsTazRWhhkiy4zoAIG6gefonvS8hs5pT9
        MwJrJ98FBx1P1VMzYegCMATokA==
X-Google-Smtp-Source: AMsMyM6jQK6faWu8ciVNIyHuo5DdhGUHU792hu5M2+fkiWdd1JDFyJ7HN7J/+hDDUVtrL381rrTPHQ==
X-Received: by 2002:a17:902:864c:b0:179:fe02:611e with SMTP id y12-20020a170902864c00b00179fe02611emr1539895plt.10.1665087637621;
        Thu, 06 Oct 2022 13:20:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p8-20020a635b08000000b0045328df8bd0sm148201pgb.71.2022.10.06.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:20:36 -0700 (PDT)
Date:   Thu, 6 Oct 2022 13:20:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jorge Merlino <jorge.merlino@canonical.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Message-ID: <202210061301.207A20C8E5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209131456.76A13BC5E4@keescook>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 13, 2022 at 15:03:38 -0700, Kees Cook wrote:
> It seems quite unusual to have a high-load heavily threaded
> process decide to exec.

In looking at this a bunch more, I actually think everything is working
as intended. If a process is actively launching threads while also trying
to exec, they're going to create races for themselves.

So the question, then, is "why are they trying to exec while actively
spawning new threads?" That appears to be the core problem here, and as
far as I can tell, the kernel has behaved this way for a very long time.
I don't think the kernel should fix this, either, because it leads to a
very weird state for userspace, where the thread spawner may suddenly
die due to the exec happening in another thread. This really looks like
something userspace needs to handle correctly (i.e. don't try to exec
while actively spawning threads).

For example, here's a fix to the original PoC:

--- a.c.original        2022-10-06 13:07:13.279845619 -0700
+++ a.c 2022-10-06 13:10:27.702941645 -0700
@@ -8,8 +8,10 @@
        return NULL;
 }
 
+int stop_spawning;
+
 void *target(void *p) {
-       for (;;) {
+       while (!stop_spawning) {
                pthread_t t;
                if (pthread_create(&t, NULL, nothing, NULL) == 0)
                        pthread_join(t, NULL);
@@ -17,18 +19,26 @@
        return NULL;
 }
 
+#define MAX_THREADS    10
+
 int main(void)
 {
+       pthread_t threads[MAX_THREADS];
        struct timespec tv;
        int i;
 
-       for (i = 0; i < 10; i++) {
-               pthread_t t;
-               pthread_create(&t, NULL, target, NULL);
+       for (i = 0; i < MAX_THREADS; i++) {
+               pthread_create(&threads[i], NULL, target, NULL);
        }
        tv.tv_sec = 0;
        tv.tv_nsec = 100000;
        nanosleep(&tv, NULL);
+
+       /* Signal shut down, and collect spawners. */
+       stop_spawning = 1;
+       for (i = 0; i < MAX_THREADS; i++)
+               pthread_join(threads[i], NULL);
+
        if (execl("./b", "./b", NULL) < 0)
                perror("execl");
        return 0;


-- 
Kees Cook
