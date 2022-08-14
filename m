Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4288CC25B06
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Aug 2022 17:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiHNRGM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiHNRFh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Aug 2022 13:05:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1091DFF7
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 10:05:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z20so7008854edb.9
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=tZcCB2gC9m8Y31d7V/x8BlzpzNtqrtS99NVpRNEbvlI=;
        b=JcE/WoD8y7dDqJAcSlpuM69/kU83laWaeQKBGuNiwIF0NvrRIynb+Yp7ZLVu1Bccl1
         tMC+IrB7WMxhHnbLlf1yaXmx601Oj1IhOLaIG5AJ1Zhgd3LoGcs9pS/gZYcFjX1PQ5Yk
         fdBs6xWWCi5o4N4X4xPhOdJD7NS3D0ZDPurIzfKwCxODzsWqjTpQupdxcEtnac1HYOz5
         LIRfT+MPk2BDd/BEyVqcyenDtOI6o20Vjrrk7t8gR3fNiriSIPKyYqDFaZkMwvv3M2iO
         XwGPhZ7ZAo3K5TZ7yKY53JlssXASHfKiWe4H/Q3vVASyE6L2P8GhVHvXb6iSv5hv+oJk
         LFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=tZcCB2gC9m8Y31d7V/x8BlzpzNtqrtS99NVpRNEbvlI=;
        b=pBqKu0Z+xGL4LDYS7vyag7kPJp2lfenfsH3jxu1SA8SL66FvD053ac0R/7ekguQxuQ
         s+wNkNehU6wfDwJMhoRVudTh+TEVHYedg+vO/5xiAoXfL9ztnK6+TolwQpjMdIlmhWqg
         C4pa60uDGW7f1nKxWtevYAVN7Xt7CTZRXasBwEG3nUc7WPbxTU05K1HPgFqqOSBzO/Uq
         fYtWm+UEnWoCW8opGJ+OYTDETLx0O5JWfmNxInZNO4vSw/B+gfL/nJfTpdp6munCvRgF
         71xWqbZBW77TTkMKdFMbOOakZGSya9vFPQQjhKYDOTHuz3t4EXPrUAYdmoIq8SEnzgbE
         Ztkw==
X-Gm-Message-State: ACgBeo2KV5VjQ/BN9iePWBOTxyASug2EchYKU9evdMgNNDwQqyZcSfPY
        23FBbeiOohriIOtj7v6QBCc=
X-Google-Smtp-Source: AA6agR76XozZpyFxrLhcCMjsDgYGEby6BErVsgHrVsfhbhg+5GmPmp66cGBdAw7ZxEGgLb92rwUOLw==
X-Received: by 2002:a05:6402:5388:b0:435:71b:5d44 with SMTP id ew8-20020a056402538800b00435071b5d44mr11151292edb.364.1660496734158;
        Sun, 14 Aug 2022 10:05:34 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id b6-20020a056402138600b004418c7d633bsm4996808edv.18.2022.08.14.10.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 10:05:33 -0700 (PDT)
Date:   Sun, 14 Aug 2022 19:05:32 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3 4/4] landlock: Document Landlock's file truncation
 support
Message-ID: <YvkrXA1p8GqaWi9H@nuc>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
 <20220804193746.9161-5-gnoack3000@gmail.com>
 <b559e738-f000-f279-ef00-50906c79464b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b559e738-f000-f279-ef00-50906c79464b@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 12, 2022 at 01:19:47PM +0200, Mickaël Salaün wrote:
>
> On 04/08/2022 21:37, Günther Noack wrote:
> > Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> >
> > Adapt the backwards compatibility example and discussion to remove the
> > truncation flag where needed.
> >
> > Point out potential surprising behaviour related to truncate.
> >
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   Documentation/userspace-api/landlock.rst | 41 ++++++++++++++++++++----
> >   1 file changed, 34 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index d92e335380d4..9c3c9fa65958 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
> >               LANDLOCK_ACCESS_FS_MAKE_FIFO |
> >               LANDLOCK_ACCESS_FS_MAKE_BLOCK |
> >               LANDLOCK_ACCESS_FS_MAKE_SYM |
> > -            LANDLOCK_ACCESS_FS_REFER,
> > +            LANDLOCK_ACCESS_FS_REFER |
> > +            LANDLOCK_ACCESS_FS_TRUNCATE,
> >       };
> >   Because we may not know on which kernel version an application will be
> > @@ -69,16 +70,24 @@ should try to protect users as much as possible whatever the kernel they are
> >   using.  To avoid binary enforcement (i.e. either all security features or
> >   none), we can leverage a dedicated Landlock command to get the current version
> >   of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> > -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> > -starting with the second version of the ABI.
> > +remove the `LANDLOCK_ACCESS_FS_REFER` and `LANDLOCK_ACCESS_FS_TRUNCATE` access
> > +rights, which are only supported starting with the second and third version of
> > +the ABI.
> >   .. code-block:: c
> >       int abi;
> >       abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> > -    if (abi < 2) {
> > -        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > +    switch (abi) {
> > +    case -1:
> > +            perror("Landlock is not supported with the running kernel");
>
> Because there is a distinction between "supported" and "enabled" (as
> explained in the sample), let's make this message more generic. The
> additional strerror() output would then be enough to distinguish the error
> type.
>
> "The running kernel does not enable to use Landlock"

Done, good point.

>
> > +            return 1;
> > +    case 1:
>
> This switch/case logic might be a bit confusing; let's explain it for this
> doc *and the sample code*:
>
> /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */

Done, added them to both the sample and the documentation.

> > +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > +            __attribute__((fallthrough));
> > +    case 2:
>
> /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
>
> > +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> >       }
> >   This enables to create an inclusive ruleset that will contain our rules.
> > @@ -127,8 +136,8 @@ descriptor.
> >   It may also be required to create rules following the same logic as explained
> >   for the ruleset creation, by filtering access rights according to the Landlock
> > -ABI version.  In this example, this is not required because
> > -`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
> > +ABI version.  In this example, this is not required because all of the requested
> > +``allowed_access`` rights are already available in ABI 1.
> >   We now have a ruleset with one rule allowing read access to ``/usr`` while
> >   denying all other handled accesses for the filesystem.  The next step is to
> > @@ -251,6 +260,24 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
> >   process, a sandboxed process should have a subset of the target process rules,
> >   which means the tracee must be in a sub-domain of the tracer.
> > +Truncating files
> > +----------------
> > +
> > +The operations covered by `LANDLOCK_ACCESS_FS_WRITE_FILE` and
> > +`LANDLOCK_ACCESS_FS_TRUNCATE` both change the contents of a file and
> > +sometimes overlap in non-intuitive ways. It is recommended to always
> > +specify both of these together.
> > +
> > +A particularly surprising example is :manpage:`creat(2)`. The name
> > +suggests that this system call requires the rights to create and write
> > +files. However, it also requires the truncate right if an existing
> > +file under the same name is already present.
> > +
> > +It should also be noted that truncating files does not necessarily
>
> FYI, I'll send a standalone patch to remove all contractions and get a more
> consistent documentation. Please, keep it this way.

Acknowledged.

>
>
> > +require the `LANDLOCK_ACCESS_FS_WRITE_FILE` right. Apart from the
> > +obvious :manpage:`truncate(2)` system call, this can also be done
> > +through :manpage:`open(2)` with the flags `O_RDONLY` and `O_TRUNC`.
>
> Good!
>
> nit: you can use a 80-columns limit.

Sounds good, applied that in this place and a few others that I touched.

>
> > +
> >   Compatibility
> >   =============

--
