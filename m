Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82072C433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Oct 2021 19:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692A161A10
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Oct 2021 19:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355434AbhJATiV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Oct 2021 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355182AbhJATiU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Oct 2021 15:38:20 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D7DC0613E2
        for <linux-security-module@vger.kernel.org>; Fri,  1 Oct 2021 12:36:31 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id y141so12622247vsy.5
        for <linux-security-module@vger.kernel.org>; Fri, 01 Oct 2021 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncpD09HrWdsLy8bDLfJfKviG+ORhH5WPZobcjdnhN2Y=;
        b=h4JxF1Gz8/rZtQryZ58tzfrjmFQJHy8pXdA+XVyH9Fqdb0qfc5YRuk9Br2pZkYfA3Z
         u+c7gvbgOjnZcggR3qC0TZrm5H/4U2VSlQEe+vCWlSCzpMyavpFYZJyFPdE/V2V6TOp5
         8+ZC21PGqakdfItweP6Uf7vaivNHbYZiE+bHh2HCAVXycpRxEq6lJdFrrfnw8wz11MJH
         ID2HwbFskMK01GXRjdgbr+ucQVwTYaXOaZsez8o+ID1uQvTOR3zCr6meo6NqUxecvdyh
         u6QNLNgGQiLmEP2JwJXgPeBk6HY+I0+GGQAhztNT3MG5wdZw5hy3sxsKPb0GLFY00pSA
         +TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncpD09HrWdsLy8bDLfJfKviG+ORhH5WPZobcjdnhN2Y=;
        b=7tI7BxGAaBmi98dX75bBBYkQeGFj7Nmk9kOUt/gkPa1wj7DmHAclyBIGv32neflPKG
         SeI749ZNMymr2fHMYCj+3rPkju/4lO5Yscyg8Ii2z5AqL8jFwZMESFQjRwJ2Dh017Frj
         MTPqeZgy4DOcADh+vS2lO8lBxXB/Fkd2enLGmq4+jw4ipbr4l+iqYXjNN3P+3A6pXwKj
         MAOZqzKl6/tX0YtE7MA1cvJegSEw98/fUjcJ5D/WsWywomiCLYckbViql68EQ2orCUke
         511r5HNAIqmGiqs8fkN3IwAQE7R9+P+zLdGzjJuQ77Ivcnc3AAGVfeud6sVhIkyIKdxy
         lbdg==
X-Gm-Message-State: AOAM531MvC+0qjCCjmKtQThU1dGIpp0OzwiG6PibYmQqXthvP/jHzyax
        iZmZVWI9zkeWWFiX+3miVG3zoYxM/Cc+p7ecc4sVDw==
X-Google-Smtp-Source: ABdhPJwsGl7nxAallIVBRgklsPwI+PeKHMlEt+Axurp07KyiWVIGR4YqquAuQY5TQelPRo437fBIf/q1Hw1HKn43oKM=
X-Received: by 2002:a67:eb95:: with SMTP id e21mr6360791vso.53.1633116990129;
 Fri, 01 Oct 2021 12:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211001175521.3853257-1-tkjos@google.com> <c6a650e4-15e4-2943-f759-0e9577784c7a@schaufler-ca.com>
In-Reply-To: <c6a650e4-15e4-2943-f759-0e9577784c7a@schaufler-ca.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Oct 2021 21:36:03 +0200
Message-ID: <CAG48ez2tejBUXJGf0R9qpEiauL9-ABgkds6mZTQD7sZKLMdAAQ@mail.gmail.com>
Subject: Re: [PATCH v2] binder: use cred instead of task for selinux checks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Todd Kjos <tkjos@google.com>, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 1, 2021 at 8:46 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/1/2021 10:55 AM, Todd Kjos wrote:
> > Save the struct cred associated with a binder process
> > at initial open to avoid potential race conditions
> > when converting to a security ID.
> >
> > Since binder was integrated with selinux, it has passed
> > 'struct task_struct' associated with the binder_proc
> > to represent the source and target of transactions.
> > The conversion of task to SID was then done in the hook
> > implementations. It turns out that there are race conditions
> > which can result in an incorrect security context being used.
>
> In the LSM stacking patch set I've been posting for a while
> (on version 29 now) I use information from the task structure
> to ensure that the security information passed via the binder
> interface is agreeable to both sides. Passing the cred will
> make it impossible to do this check. The task information
> required is not appropriate to have in the cred.

Why not? Why can't you put the security identity of the task into the creds?

SELinux already identifies tasks through their creds (see e.g.
task_sid_obj()), and doesn't use the task security blob at all.
Apparmor also identifies tasks through their creds (see
aa_current_raw_label() and __aa_task_raw_label()), and just uses the
task blob to store information about other labels that the process may
transition from or to.

From what I can tell, the only LSM that actually identifies the
caller's security context through the task security blob is Tomoyo. As
far as I know, that means Tomoyo is kinda broken. (But does anyone
even use Tomoyo?)

> I understand that there are no users of the binder driver
> other than SELinux in Android upstream today. That's not
> the issue. Two processes on a system with SELinux and AppArmor
> together may be required to provide incompatible results
> from security_secid_to_secctx()/security_secctx_to_secid().
> If it's impossible to detect this incompatibility it's
> impossible to prevent serious confusion.
>
> The LSM stacking isn't upstream yet. But I hope to have it
> there Real Soon Now. If there's another way to fix this that
> doesn't remove the task_struct it would avoid my having to
> put it back.

You fundamentally can't identify the recipient of a binder transaction
through its task_struct, because the recipient might have given the
binder FD to a child process and executed a setuid binary since it
opened /dev/binder. If you look at the credentials of the task on the
other side, you'll just see the setuid binary that doesn't even know
it has an open binder FD, and won't see the child process that is
actually going to receive the transaction.

You can't even usefully identify the opener of a file through its
task_struct - especially with io_uring, any userspace process can
cause kernel threads to open files and perform I/O on them *on behalf
of userspace* - and this "on behalf of" relationship is only visible
in the overridden credentials. (And yes, I do think that means Tomoyo
doesn't work properly on systems with io_uring.)
