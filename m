Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10EDC3F6B0
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Aug 2022 16:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiHDQp4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHDQp4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Aug 2022 12:45:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502AFD2D;
        Thu,  4 Aug 2022 09:45:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tl27so370730ejc.1;
        Thu, 04 Aug 2022 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LvrnXCwtv5XHtMInXUKtDOn3It9BRLTfFYtNjh6ssqk=;
        b=XEHGgov0RYLghH9FXzXqDRL+IMOdobJ10apI0VhCUxMt8Hw9mb7wh1m6IYu0YYDup1
         WT+2x7RsovYzx6QWjqrGj1pj6QqCbGpMmOiaWa5FiTgnpI95Wp2UUKxm/gOwvvFPIb5b
         m523pl2Hl5y2NxOF64KpwluJvuogzSeeGeutvH2o0YtvGFUi1+08jGksb8OIdJu0LpC8
         S2yofSQm8EagzfEZm93aXGg8DVRaxIlbk8ZOsmwep7q2gWGc3hvLNVtOsh2jfCUQ9+Ae
         znimak4uRWGFomYLg5tmtgxpDXHHeVSJbuuf1nF8tbx9RSOfJpU81xL1BdM6NCtaesKg
         1L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LvrnXCwtv5XHtMInXUKtDOn3It9BRLTfFYtNjh6ssqk=;
        b=eeSmGqe2HTG9MdgO3YpmHREIwFz5YUuvaMDsF0yVJwq0DsqfXGS6aawxRK+sTiQ38/
         WjOrd/kUGnjEmrA2Gbp2TMPrL91rv+67lblEfN0sAbJ1FyXuZKzjYXZjv/2W8TvSaMG6
         ejJTwdgCRn+fpT7Il//9VEMqdKD5L6aW4yVcVFATTvKwIPvL+3VI0tH6b5Kv8nE9roEk
         yHfHXoniUzBaxXizMTuJST3VKbCfW7KXYxIwGX9zGTsxyZKvWGgEA3fCO/iHKogcUOwg
         yPTtmSKd+mN7p53h5LxjCJfU/vPVxb5TW8uaED77nTqbNDOuMnM9HzuQYtWXEhnsAmdg
         5KhQ==
X-Gm-Message-State: ACgBeo0Kfu716gmrFynn4Wj7prGNdGyznrcy4Lt1VrRCsuKfIAgfkqZU
        IVw9KAL2DYsjMmz8bkRXdRA=
X-Google-Smtp-Source: AA6agR6WbdMBoJ1rxIgQWinbQTwv5zfPEdGzVlp7VnGWHgjI/Mpjn623/U0h88RuCPkRAvOcDwqbSw==
X-Received: by 2002:a17:907:2bc4:b0:730:aa9c:bd86 with SMTP id gv4-20020a1709072bc400b00730aa9cbd86mr2064543ejc.341.1659631553514;
        Thu, 04 Aug 2022 09:45:53 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906314d00b00730948cd6c9sm515761eje.118.2022.08.04.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:45:52 -0700 (PDT)
Date:   Thu, 4 Aug 2022 18:45:50 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] landlock: Document Landlock's file truncation
 support
Message-ID: <Yuv3vte5eMCuIULv@nuc>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
 <20220712211405.14705-5-gnoack3000@gmail.com>
 <d198d2b4-ebf4-c7a2-cf95-f028d48c09e5@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d198d2b4-ebf4-c7a2-cf95-f028d48c09e5@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 29, 2022 at 12:47:46PM +0200, Mickaël Salaün wrote:
>
> On 12/07/2022 23:14, Günther Noack wrote:
> > Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> >
> > Adapt the backwards compatibility example and discussion to remove the
> > truncation flag if needed.
> >
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > Link: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
> > ---
> >   Documentation/userspace-api/landlock.rst | 19 ++++++++++++++-----
> >   1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index b86fd94ae797..41fa464cc8b8 100644
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
> > @@ -69,14 +70,22 @@ should try to protect users as much as possible whatever the kernel they are
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
> > +    if (abi == -1) {
> > +        perror("Landlock is unsupported on this kernel");
>
> "Landlock is not supported with the running kernel"?

Done.

>
>
> > +        return 1;
> > +    }
> > +    if (abi < 3) {
> > +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> > +    }
>
> I guess we could use the same switch/case code as for the sample. I'm not
> sure what would be the less confusing for users though.

Done. (Both are mildly confusing, IMHO %-))

> [...]

--
