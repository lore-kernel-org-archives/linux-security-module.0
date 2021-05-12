Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA23C43461
	for <linux-security-module@archiver.kernel.org>; Wed, 12 May 2021 13:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADA8611CE
	for <linux-security-module@archiver.kernel.org>; Wed, 12 May 2021 13:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhELNXB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 May 2021 09:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhELNW7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 May 2021 09:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620825711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtvrIv0gd9IsJeuZT9VIJXOOFa9yzPvKusGPJfLQ7f4=;
        b=A9HOWi9KmzFFBTNqyY4ed5tNzt6Z/G0TAo1zXJQ+9ORQz1SNXSd6gmCqma9xc6OSYNDqmh
        9QWsaMp1odA6cfPYSDGeRB3et+tqYOA0Ql6EFRefzo9/O0Ge/5sDJ8igY2qZ3+vNqXLV+F
        YeaGoGlJv7AFYoY30h7ZGxBft5bGNvY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-IuUUeasCPTC6KklZJexV7A-1; Wed, 12 May 2021 09:21:49 -0400
X-MC-Unique: IuUUeasCPTC6KklZJexV7A-1
Received: by mail-yb1-f197.google.com with SMTP id n129-20020a2527870000b02904ed02e1aab5so27875570ybn.21
        for <linux-security-module@vger.kernel.org>; Wed, 12 May 2021 06:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtvrIv0gd9IsJeuZT9VIJXOOFa9yzPvKusGPJfLQ7f4=;
        b=EteTmJv7EDD8hbxMNM+LWalfUjbyvjQPVt93NDQBJbjGj+QrJBxlO9mAz1C2SDDGOY
         xubnpEYPSF1dby/53s/bmqDIeVN19KeUY8VgL8aHsOrNnva35IG96ejt3wPlDCb1Gp6F
         yveZdSg54IDHqyTsS2cWjv+vvaQ5ru5EW9PGFDxJkt/UWX0IkiuuyiEwZ6W3ntrkWeCV
         u6WUKIjB2qQaDxXbLWBQD76mVmX06IVge/jY/iLfV65cUtoEzD7PB2m5Fmpft4NI3cgQ
         u5eitmSfVmQ5+RxD2Dj46c40mwctXRKCdbv8MuIvAqBUHdAmXbHH+ZYtL+O2Pev0hD6A
         caXA==
X-Gm-Message-State: AOAM532BTBegAA9lkgHyFJuGZJEcBLSpLdRqBcwc9QCc92uc8DZwe6cX
        8vxdPMWnlMY43qh/B1i/q0oR2MLYKWsMVyxZPsQUfXBhoS5o1b562EDht+SL3Ln5f/zEiOBK2fg
        iRjjdME5YWVQ1uYZtaxkFw6nu6KUUTmr7Xw6L+davITtbGRa4uGMx
X-Received: by 2002:a25:6983:: with SMTP id e125mr46782754ybc.81.1620825709170;
        Wed, 12 May 2021 06:21:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmv2Qjn6VYEo9c/oXPEmu6i04CA+M1aunHQiWM6u48mJ31LcpQnTbka787MtlSpRVc8GFLI9xcdcVeHkvyMsg=
X-Received: by 2002:a25:6983:: with SMTP id e125mr46782731ybc.81.1620825708981;
 Wed, 12 May 2021 06:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210507114048.138933-1-omosnace@redhat.com> <a8d138a6-1d34-1457-9266-4abeddb6fdba@schaufler-ca.com>
In-Reply-To: <a8d138a6-1d34-1457-9266-4abeddb6fdba@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 May 2021 15:21:37 +0200
Message-ID: <CAFqZXNtr1YjzRg7fTm+j=0oZF+7C5xEu5J0mCZynP-dgEzvyUg@mail.gmail.com>
Subject: Re: [PATCH] lockdown,selinux: fix bogus SELinux lockdown permission checks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 8, 2021 at 12:17 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/7/2021 4:40 AM, Ondrej Mosnacek wrote:
> > Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> > lockdown") added an implementation of the locked_down LSM hook to
> > SELinux, with the aim to restrict which domains are allowed to perform
> > operations that would breach lockdown.
> >
> > However, in several places the security_locked_down() hook is called in
> > situations where the current task isn't doing any action that would
> > directly breach lockdown, leading to SELinux checks that are basically
> > bogus.
> >
> > Since in most of these situations converting the callers such that
> > security_locked_down() is called in a context where the current task
> > would be meaningful for SELinux is impossible or very non-trivial (and
> > could lead to TOCTOU issues for the classic Lockdown LSM
> > implementation), fix this by adding a separate hook
> > security_locked_down_globally()
>
> This is a poor solution to the stated problem. Rather than adding
> a new hook you should add the task as a parameter to the existing hook
> and let the security modules do as they will based on its value.
> If the caller does not have an appropriate task it should pass NULL.
> The lockdown LSM can ignore the task value and SELinux can make its
> own decision based on the task value passed.

The problem with that approach is that all callers would then need to
be updated and I intended to keep the patch small as I'd like it to go
to stable kernels as well.

But it does seem to be a better long-term solution - would it work for
you (and whichever maintainer would be taking the patch(es)) if I just
added another patch that refactors it to use the task parameter?

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

