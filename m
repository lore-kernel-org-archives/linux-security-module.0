Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E63C19F2D
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Aug 2022 09:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiHMJKe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 13 Aug 2022 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJKd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 13 Aug 2022 05:10:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B171313D0F
        for <linux-security-module@vger.kernel.org>; Sat, 13 Aug 2022 02:10:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y13so5560459ejp.13
        for <linux-security-module@vger.kernel.org>; Sat, 13 Aug 2022 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=6A6zGy+Dw7QRnjj1aohdeyT4LCVZKfkSwo4XZQgFQyk=;
        b=atv3pnMMjrvS7ck6x/bLSSgxemd09vniMm6RGiQsJR4q9qxvsstPmLtDOS+796E6lC
         F7WwEMAD+alRSnnUMxwD+fgUpI2O8bMtXovzNb04LYRI2twqODuCCQM0lUI4NoCIBz5Q
         PRyEKGOY/+m+fsOqa0536rkY6NXArPcKhBxJ8A4lB5Dv7Smd+sxkhgfsAMoEx46IeY/K
         r088pDFo3claSkwVOi3YnlBmy8fzn0VklpZ3xTb+NrAYRLamLDV2F3crjeiHljKmNCrF
         sbAv96JtOjzAcGqC4rd5PApsoWh3Vs8a/fbSApe/96lQs1BXx7zAEIwFEWVM3VQ7KBVh
         eeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=6A6zGy+Dw7QRnjj1aohdeyT4LCVZKfkSwo4XZQgFQyk=;
        b=yqY+g5VEP9+pTd6gPIyrEkHsufeyBKRcFjqDmjLhNkZM6FdVPK3An8tsA+zgiHmL+r
         /dmhfPXRHFQyWiBLz9Qn/FaEemT6hW/ct9YI/ecq5Uhex24E3dKeun4FAyfJ9wmq1gGt
         A3T3aULjDaz749D9IFA1JSUWJ38xrH3BNN1fHrBAq1IYpZ2QoZtc1T9itihH5fqyZtoS
         XjwYo6DE20d5IIUy7pLKWQocnu2QhM8Du2bRJFWh8XZl8kTt2GxwK6Etqjf7TJkNp2Ro
         KfPOJ/6L3K4PMKg7+NKmzgJmCAPIDr/afLHZPwCicRwED6lb3UtnZoLQc1tylACvWigf
         IyBA==
X-Gm-Message-State: ACgBeo3QxiNMexX+c/bifNVCaH7FRjYTL3ZSpARU9O3kfHlDzTaSadua
        7Eg6+DO6mF/aSkj7oAlBp+k=
X-Google-Smtp-Source: AA6agR54VmiRToPlvxf8fTOSO/7A98y2N5Vw2TYBhfm2o3S2AAPztTp2dmUn8aavGTHbucRhwKMKmw==
X-Received: by 2002:a17:907:970b:b0:732:f76a:97a2 with SMTP id jg11-20020a170907970b00b00732f76a97a2mr5083839ejc.396.1660381830180;
        Sat, 13 Aug 2022 02:10:30 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id f25-20020a17090631d900b00730ad7c0d42sm1641832ejf.207.2022.08.13.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 02:10:29 -0700 (PDT)
Date:   Sat, 13 Aug 2022 11:10:27 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3 1/4] landlock: Support file truncation
Message-ID: <Yvdqg4XzPrl9skiS@nuc>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
 <20220804193746.9161-2-gnoack3000@gmail.com>
 <a9c9124c-84a3-da5e-23f1-3eecf0b226ce@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9c9124c-84a3-da5e-23f1-3eecf0b226ce@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 11, 2022 at 06:59:28PM +0200, Mickaël Salaün wrote:
>
> On 04/08/2022 21:37, Günther Noack wrote:
> > Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> >
> > This flag hooks into the path_truncate LSM hook and covers file
> > truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
> > well as creat().
> >
> > This change also increments the Landlock ABI version, updates
> > corresponding selftests, and includes minor documentation changes to
> > document the flag.
> >
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   Documentation/userspace-api/landlock.rst     |  6 ++++++
> >   include/uapi/linux/landlock.h                | 17 ++++++++++++-----
> >   security/landlock/fs.c                       |  9 ++++++++-
> >   security/landlock/limits.h                   |  2 +-
> >   security/landlock/syscalls.c                 |  2 +-
> >   tools/testing/selftests/landlock/base_test.c |  2 +-
> >   tools/testing/selftests/landlock/fs_test.c   |  7 ++++---
> >   7 files changed, 33 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index b8ea59493964..d92e335380d4 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -380,6 +380,12 @@ by the Documentation/admin-guide/cgroup-v1/memory.rst.
> >   Previous limitations
> >   ====================
> > +File truncation (ABI < 3)
> > +-------------------------
> > +
> > +File truncation could not be denied before the third Landlock ABI, so it is
> > +always allowed when using a kernel that only supports the first or second ABI.
>
> I think this addition could make the documentation more consistent and
> helpful:
>
> Starting with the Landlock ABI version 3, it is now possible to securely
> control truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE`
> access right.

Agreed, I added that sentence.

>
>
> > +
> >   File renaming and linking (ABI 1)
> >   ---------------------------------
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 23df4e0e8ace..1beb8289708d 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -95,8 +95,15 @@ struct landlock_path_beneath_attr {
> >    * A file can only receive these access rights:
> >    *
> >    * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> > - * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
> > + * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> > + *   you might additionally need the LANDLOCK_ACCESS_FS_TRUNCATE right in order
>
> Please use backquotes for code such as `LANDLOCK_ACCESS_FS_TRUNCATE`,
> `O_TRUNC`…

Done.

>
>
> > + *   to overwrite files with :manpage:`open(2)` using O_TRUNC or
> > + *   :manpage:`creat(2)`.
> >    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> > + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file through file truncation APIs
> > + *   like :manpage:`truncate(2)`, :manpage:`ftruncate(2)`, or
> > + *   :manpage:`open(2)` with O_TRUNC or :manpage:`creat(2)`. This access right
> > + *   is available since the third version of the Landlock ABI.
> >    *
> >    * A directory can receive access rights related to files or directories.  The
> >    * following access right is applied to the directory itself, and the
> > @@ -139,10 +146,9 @@ struct landlock_path_beneath_attr {
> >    *
> >    *   It is currently not possible to restrict some file-related actions
> >    *   accessible through these syscall families: :manpage:`chdir(2)`,
> > - *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
> > - *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
> > - *   :manpage:`utime(2)`, :manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
> > - *   :manpage:`access(2)`.
> > + *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> > + *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> > + *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
> >    *   Future Landlock evolutions will enable to restrict them.
> >    */
> >   /* clang-format off */

--
