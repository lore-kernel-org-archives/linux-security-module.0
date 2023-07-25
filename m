Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83425C04A6A
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jul 2023 11:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjGYLKZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Jul 2023 07:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjGYLKG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jul 2023 07:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0C30F8
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jul 2023 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690283288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIk2rY8kbIKJb0IQXAUy6YHfdWW3cnFIe2mfNcTspbo=;
        b=XmGrg45GoBLwLHRn8ciWtS/vheV/iLrDIVZ6lcGDNlI6xOtnDAug/0qMZYtIAU+gf4rtgR
        ypUmF55KXOj84sju0LToqpBnRaED8QnRxx3JnJgYL5dmCg3qxykV0iv2qWcaHeCn7FBAF/
        DOTp9CFgWIH+daX480IRwmA7YkLxZiY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-ZNl5X6BpNHugJkwvXPOH2Q-1; Tue, 25 Jul 2023 07:08:05 -0400
X-MC-Unique: ZNl5X6BpNHugJkwvXPOH2Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26814a0122dso1485171a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jul 2023 04:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690283285; x=1690888085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIk2rY8kbIKJb0IQXAUy6YHfdWW3cnFIe2mfNcTspbo=;
        b=IxQey/oRV2IOmCNDPdjxlZxQVtPsHPKKkdbBpyFL+1E76HqcATXQCG4Pz4pJ+O3RET
         5QJy1KlVaKir3W9wEXPEQ0HfVIN4/WXO/LXxHf/cykpd8CYq2nRbN+4Eaa+0u/NnjbOy
         auuj9SE7ucsXjfs5sx9xkybscCWcmPCprs7Kr29Gecqph4X70VIAV93LOlots+0DRGxJ
         RxvX3A2bnQ4+pSBIAX/bQUaBBoSomdHy19LX2ODpbBzWzI4C6EyNLpjmLPOxgjj8t2jV
         BI8w+Uvijvt/VRrR+mp8svYnFurOCS6IZQC+QbEmiCnikMvUPfBcej46POe+d11tStKQ
         SafA==
X-Gm-Message-State: ABy/qLbcfkn62ZjqWHr4VDT8CH0Txtbh7ui1zVs+FCLV0k9/eThCe0G3
        X6gLRlWis4awgdaYELg9+k7g8RBcm/5IGRZkt32X9K6rBWH6eWSK7WWs4bPrfAKKqk8oHKBPvx/
        Fxz1cQ36x870DyeeR6Wj9AnSV12MTkBSUyqvVctwQgjRiiqd/8GIV
X-Received: by 2002:a17:90b:30cb:b0:268:abf:6431 with SMTP id hi11-20020a17090b30cb00b002680abf6431mr2408048pjb.24.1690283284969;
        Tue, 25 Jul 2023 04:08:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUO5iRoKmcTndiV1yc+RB63ntBijY7f5j5g118bUiJEFickPVx8jsUlZUrzSyxeXZ1uOPR28AIDchVPKuta5A=
X-Received: by 2002:a17:90b:30cb:b0:268:abf:6431 with SMTP id
 hi11-20020a17090b30cb00b002680abf6431mr2408031pjb.24.1690283284663; Tue, 25
 Jul 2023 04:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230718115607.65652-1-omosnace@redhat.com> <x49lefd4aad.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49lefd4aad.fsf@segfault.boston.devel.redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 25 Jul 2023 13:07:53 +0200
Message-ID: <CAFqZXNt5UXWagXu5QR5k5wOAeQJVKWrET4prEzb+5aftFEtyZw@mail.gmail.com>
Subject: Re: [PATCH] io_uring: don't audit the capability check in io_uring_create()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 18, 2023 at 3:24=E2=80=AFPM Jeff Moyer <jmoyer@redhat.com> wrot=
e:
>
> Hi, Ondrej,
>
> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
> > The check being unconditional may lead to unwanted denials reported by
> > LSMs when a process has the capability granted by DAC, but denied by an
> > LSM. In the case of SELinux such denials are a problem, since they can'=
t
> > be effectively filtered out via the policy and when not silenced, they
> > produce noise that may hide a true problem or an attack.
> >
> > Since not having the capability merely means that the created io_uring
> > context will be accounted against the current user's RLIMIT_MEMLOCK
> > limit, we can disable auditing of denials for this check by using
> > ns_capable_noaudit() instead of capable().
>
> Could you add a comment, or add some documentation to
> ns_capable_noaudit() about when it should be used?  It wasn't apparent
> to me, at least, before this explanation.

This has been requested before, so I finally forced myself to look
into it and only now I realized that there is a subtle difference
between the has_capability and capable helpers. As the docstrings say,
the former doesn't set the PF_SUPERPRIV on the task when the check
succeeds, while the latter does. The problem is that I don't know what
the exact implications are and thus I'm not able to document which
helper should be used in what situation... It is possible some of the
existing call sites use the wrong helper in the noaudit case (possibly
including ones that I added/suggested).

The comment at its declaration says "Used super-user privileges" and
it seems to be used only to propagate into the ASU flag in task
accounting information. But in the case of capability checks that do
not fail the syscall it is not easy to tell if "super-user privileges"
were "used" or not (or, rather, whether the task should be accounted
as such or not after a successful check).

If anyone is reading this and has a better understanding of the
PF_SUPERPRIV flag semantics, I'd be thankful for a clarification so
that we can sort out this mess :)

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

