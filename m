Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE2C47088
	for <linux-security-module@archiver.kernel.org>; Wed, 26 May 2021 11:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6C661248
	for <linux-security-module@archiver.kernel.org>; Wed, 26 May 2021 11:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhEZLqt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 May 2021 07:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232088AbhEZLqs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 May 2021 07:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622029516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Uw+/IY4PFLhc9QD0XQTD8Vq22Bv9V1A42B8cw/tcfQ=;
        b=KZW7SBXegZu/wpZtz8zD3v+c+Tfn24w8Eh3QahoBAYv0mpHdy6NN90Pi9eTOR4ih+SkyEC
        Jf0bJbiqlXJ21kPasLIbijiQ9LPvSbiQI8LWQ2eukOZjfTtYzxlONsPX/yCSUf1N4nyABf
        PSighAa3eR5ZZsVoX0qyYHzpK1vuiOQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-2oHCrqq_OSWl0FdUL-7llg-1; Wed, 26 May 2021 07:45:15 -0400
X-MC-Unique: 2oHCrqq_OSWl0FdUL-7llg-1
Received: by mail-yb1-f197.google.com with SMTP id x187-20020a25e0c40000b029052a5f0bf9acso1396995ybg.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 May 2021 04:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Uw+/IY4PFLhc9QD0XQTD8Vq22Bv9V1A42B8cw/tcfQ=;
        b=IMeK6HGibnqPV/AxX82CsXWemTDXnc1qXFwBe5n8VzwoTPQMeDb8x7DHOXg+4IOdsJ
         aLVcTQfB2jxszIoDHmLZF2bCQdYGucPo2QQFEJTT0xOOJ/ynNRpaYGlQom7WHqJg9F8Z
         nflA0XTgeYaE4MnexWhdcHukOi3R6u7AAW4OMH2cjuZJ6eqhnoB+nqtfRpSCXvbIWwfL
         +0y60eBVoFlQhnEFW54JpuZ82TU0t6Dj5Z4zHl1NOc1kKyLuCqmSFlNWezVDfWGxiMG6
         5EU4DNw5NGREcex89dycJtuW/2zmBtZZT0eccRAXaBTPU2rLZEjEMOiJfjXgH57ih5+S
         FO2g==
X-Gm-Message-State: AOAM530Va2LFSa2xe+4p4q2SFOAzVIoTkQr8GztK842RaaomOvayPxgZ
        GuQa3VnwIdN4sztQfSWuHsy2HS7035pOfFYvG/sdvFB0k03sj69QtdJBbsrklIuY1xfuTfjrZuf
        mJ+2vOiZNiZJOSV5ahyJkGgQszGdMpTprQCkopofmEFUjcsvmINSv
X-Received: by 2002:a25:f50e:: with SMTP id a14mr48352359ybe.172.1622029514559;
        Wed, 26 May 2021 04:45:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7JX0t9Q+MjZUdNuGYqNNwFWjv7mwlUzB5zjT5J9a7c3DzGoUhB3CdgL/OZI5wwTVrJZE9FoOnkmowu6kRXnk=
X-Received: by 2002:a25:f50e:: with SMTP id a14mr48352333ybe.172.1622029514339;
 Wed, 26 May 2021 04:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <87o8d9k4ln.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o8d9k4ln.fsf@mpe.ellerman.id.au>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 26 May 2021 13:44:59 +0200
Message-ID: <CAFqZXNtUvrGxT6UMy81WfMsfZsydGN5k-VGFBq8yjDWN5ARAWw@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Michael Ellerman <mpe@ellerman.id.au>
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
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 17, 2021 at 1:00 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:
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
> > implementation), fix this by modifying the hook to accept a struct cred
> > pointer as argument, where NULL will be interpreted as a request for a
> > "global", task-independent lockdown decision only. Then modify SELinux
> > to ignore calls with cred == NULL.
> >
> > Since most callers will just want to pass current_cred() as the cred
> > parameter, rename the hook to security_cred_locked_down() and provide
> > the original security_locked_down() function as a simple wrapper around
> > the new hook.
> >
> > The callers migrated to the new hook, passing NULL as cred:
> > 1. arch/powerpc/xmon/xmon.c
> >      Here the hook seems to be called from non-task context and is only
> >      used for redacting some sensitive values from output sent to
> >      userspace.
>
> It's hard to follow but it actually disables interactive use of xmon
> entirely if lockdown is in confidentiality mode, and disables
> modifications of the kernel in integrity mode.
>
> But that's not really that important, the patch looks fine.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks, Michael!

James/Paul, is there anything blocking this patch from being merged?
Especially the BPF case is causing real trouble for people and the
only workaround is to broadly allow lockdown::confidentiality in the
policy.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

