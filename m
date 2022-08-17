Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE2C28B2B
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Aug 2022 18:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiHQSVQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Aug 2022 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiHQSVP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Aug 2022 14:21:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98694106
        for <linux-security-module@vger.kernel.org>; Wed, 17 Aug 2022 11:21:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o22so18564825edc.10
        for <linux-security-module@vger.kernel.org>; Wed, 17 Aug 2022 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=wjGsYl9KStUiTWhRv2sOoItuIlTv/rF0IzGQstX8/UA=;
        b=mNPnd07hoQhRQLWhyjkKdsXzUWR+Z211vKWnYe5iIt0rDtaWazHdXu9l+AkTOhJojV
         iv20Q4CtGIzpQvLA/cseHARIGBLXVDrNvsOCDCRtZW9al46iN2XUtJq2FTyCJsSY9v3E
         xfBPe5geI9te1tJD9bANw4L4d4olrOBx8RgYrmPjcYuH1cqeY7MLBmi1o0KBR01E0krV
         cdGn9rRvd9a1OiIwoPkxjn2Bv3r2r41SHcyCc2PpxBuCVp/qKP12Ah/daM4OVcb/qizz
         0P9QsOjalLRZwAdhQOqP9Q1uzk1n0CFdBsqrsKqCnIbgM5Q5kl6+VyzxA7HBmFjDwfCY
         oG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=wjGsYl9KStUiTWhRv2sOoItuIlTv/rF0IzGQstX8/UA=;
        b=VYAeICHAQl5jmi54kCk0TEBHc5aVf1IASWh/UCHBLSthB5GEPtMycvMfSAkAQf4ihf
         Kk3HvS618SANm5gHNRuIVVrH90wld1VvmmgVW+DPBkaKudjsOmY1Ogupx3V0t+p5qZPX
         Mu1AHxpZK2rd+YcW1rBEiuqzHxSCjc60PoNEw/T2wnAKz57tkt1kOKeS6h50lJlvRytC
         vE/iW1RDBq1DdiTZ/kYeQWgpFKhtqshAAf48JBHulgJw4c85slR8ZPe4WoO3rjfkONGb
         yMe/1hdOUHFdZo7TcNP1DqP4UW6912zWEzrb/sCK/Za4yxIpxiGV10MZBUGAKW1a5Fju
         ZWfQ==
X-Gm-Message-State: ACgBeo3wmStHit2ffXeHS9CwnYix+zhbZbXwTErARMXgY/pBUK51iAGI
        bYN2Dpv2TeGbTv5y2d4VQE8=
X-Google-Smtp-Source: AA6agR68AcKQxbFJ6jXo3yaeOOHgECQPmhUc7gEHdtu2HKb4n/yM20ujnIrTx6ZQX++ze8wcnaBQ2Q==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr24447982edb.348.1660760472763;
        Wed, 17 Aug 2022 11:21:12 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id az8-20020a170907904800b0072ae174cdd4sm7062397ejc.111.2022.08.17.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 11:21:12 -0700 (PDT)
Date:   Wed, 17 Aug 2022 20:21:10 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4 4/4] landlock: Document Landlock's file truncation
 support
Message-ID: <Yv0xloyfq4SycNHS@nuc>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
 <20220814192603.7387-5-gnoack3000@gmail.com>
 <bd1487df-3277-6429-8724-6e3727e76091@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd1487df-3277-6429-8724-6e3727e76091@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 16, 2022 at 09:18:33PM +0200, Mickaël Salaün wrote:
> On 14/08/2022 21:26, Günther Noack wrote:
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index 6648e59fabe7..3ceb97cbe9d1 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> >   Because we may not know on which kernel version an application will be
> > @@ -69,16 +70,26 @@ should try to protect users as much as possible whatever the kernel they are
> >   using.  To avoid binary enforcement (i.e. either all security features or
> >   none), we can leverage a dedicated Landlock command to get the current version
> >   of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> > -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> > -starting with the second version of the ABI.
> > +remove the `LANDLOCK_ACCESS_FS_REFER` and `LANDLOCK_ACCESS_FS_TRUNCATE` access
>
> s/and/or/

Done.

> > +Truncating files
> > +----------------
> > +
> > +The operations covered by `LANDLOCK_ACCESS_FS_WRITE_FILE` and
> > +`LANDLOCK_ACCESS_FS_TRUNCATE` both change the contents of a file and sometimes
> > +overlap in non-intuitive ways.  It is recommended to always specify both of
> > +these together.
> > +
> > +A particularly surprising example is :manpage:`creat(2)`.  The name suggests
> > +that this system call requires the rights to create and write files.  However,
> > +it also requires the truncate right if an existing file under the same name is
> > +already present.
> > +
> > +It should also be noted that truncating files does not necessarily require the
>
> I think "necessarily" is superfluous here.

Done.  I dropped the "obvious" too.

>
>
> > +`LANDLOCK_ACCESS_FS_WRITE_FILE` right.  Apart from the obvious
> > +:manpage:`truncate(2)` system call, this can also be done through
> > +:manpage:`open(2)` with the flags `O_RDONLY` and `O_TRUNC`.
>
> `O_RDONLY | O_TRUNC`.

Done.

> >   Compatibility
> >   =============
> > @@ -386,9 +415,8 @@ File truncation (ABI < 3)
> >   File truncation could not be denied before the third Landlock ABI, so it is
> >   always allowed when using a kernel that only supports the first or second ABI.
> > -Starting with the Landlock ABI version 3, it is now possible to securely
> > -control truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access
> > -right.
> > +Starting with the Landlock ABI version 3, it is now possible to securely control
> > +truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access right.
>
> This is an inconsistent hunk, patching the first patch.
>
> Please also move this "File truncation" section below the "File renaming and
> linking".

Thanks, fixed the ordering of commits and moved the truncation section
below "File Renaming and Linking".

—Günther

--
