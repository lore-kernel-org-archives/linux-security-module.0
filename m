Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D29C433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Oct 2021 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5703260524
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Oct 2021 21:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhJNVmt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Oct 2021 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhJNVmt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Oct 2021 17:42:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F6C061753
        for <linux-security-module@vger.kernel.org>; Thu, 14 Oct 2021 14:40:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p16so33014797lfa.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Oct 2021 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc/19Sw3gCuiuNL5yxr53ROwuXXqpzpfHWWhYwbvjUo=;
        b=kJBigErm8oj6naJt86CzR6I4CvyMKAEXIVyQZPIrMf9IoLfG6qoK2Nq9bXwvpuHo2J
         Lg08sgiU6TkZK1UvhW0mdBh5Q6WXOe6Sg2Kim3mdWddM4s0AeL5swVZ9//9wagHv1vru
         dKFtjaT5p68KyiXkhio3E5UpjxsKFkLvwyorZ7jYbL0T4QtRHO+lqnrOGSBYfJQeEmAB
         flP3P3UXqw3OSfk2f7NqFdB1B0cqZ2wiR4JUYJa76vUInbAI10oirsmSkwmdO0WMoSJX
         BqqkLINBbUlLRUwRI8ft2z3Qk5rShAsQGnFJqE6kcQrS+pNAELb8WaTBBINwKDNZzja7
         5aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc/19Sw3gCuiuNL5yxr53ROwuXXqpzpfHWWhYwbvjUo=;
        b=7kDQkv7OMXIIGufLiXJYAT4aEXP69PwXza1526JlHTfCmogmZLZl0dgWbyDMMLv5KJ
         1X9zut5fN2RSlLKo4r6prmlVcnSFU5VfjMB6rCULDf6ihBJU4ukl2cdAESfvVTU2MKNJ
         eAIM3IMK1kTObub5UrncXK3JkPvpxa9ydLkl3cZcoCLXLdrewiUGGwWXddNmHyrCv6h9
         wY8ET8L0xMm9A10SyOLjGI9rKnJgLB4SrBwHvkICLY1o6Q/6QVqW0YIlVU+unRqYt8vb
         tkqRXO3ylF34blx3Q4kNmVDaTMG9gmqjJosj4fm+ofXxfYOCQXylzctT6lNUfUnujChl
         R9hg==
X-Gm-Message-State: AOAM532u4t4YvupHt1M3IictfY663W+BUDRSmZoNySY/r2H8/zh2yQqV
        cFk/CakrO83kL8T4E+pXM9CX+vzPJeUFzFkKxXdY+w==
X-Google-Smtp-Source: ABdhPJxPLLk8qMtDlWK65ixYe3AxwSYOuLQWzgY8dPGbhyExlDVFcUshw6mboG8LnO3GIAmGuyVWP85em6Bc1cncdkE=
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr7406070lfa.403.1634247641451;
 Thu, 14 Oct 2021 14:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211012165614.2873369-1-tkjos@google.com> <CAHC9VhQ6W=8rX6hryk_d+iTc90MAoZOw=KVDhjXsXE5Laccn_A@mail.gmail.com>
In-Reply-To: <CAHC9VhQ6W=8rX6hryk_d+iTc90MAoZOw=KVDhjXsXE5Laccn_A@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 14 Oct 2021 14:40:27 -0700
Message-ID: <CAHRSSEwjFicpr2=4S37KmVTav+aNQqFwy1eUo8r_z1OPSX1LFw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] binder: use cred instead of task for security context
To:     Paul Moore <paul@paul-moore.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 14, 2021 at 2:34 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Oct 12, 2021 at 12:56 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > This series fixes the possible use of an incorrect security context
> > when checking selinux permissions, getting a security ID, or lookup
> > up the euid.
> >
> > The previous behavior was to save the group_leader 'struct task_struct'
> > in binder_open() and using that to obtain security IDs or euids.
> >
> > This has been shown to be unreliable, so this series instead saves the
> > 'struct cred' of the task that called binder_open(). This cred is used
> > for these lookups instead of the task.
>
> Hi Todd,
>
> I just merged all three patches into selinux/next, thanks for your
> help patience on this patchset.  Ultimately I merged these patches
> into selinux/next as opposed to selinux/stable-5.15 because I felt
> that a couple of weeks in -next before going to Linus would be a good
> thing.  I'm also not certain how widespread binder is outside of
> Android so I figured the practical difference between next and
> stable-5.15 is likely very small.  Regardless, all of your Fixes and
> stable tags remain in the patches so as soon as they go up to Linus
> during the next merge window the stable folks will be notified.

Thanks Paul. This all sounds fine.

>
> --
> paul moore
> www.paul-moore.com
