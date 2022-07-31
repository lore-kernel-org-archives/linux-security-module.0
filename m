Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7857C00140
	for <linux-security-module@archiver.kernel.org>; Sun, 31 Jul 2022 04:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiGaECS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 31 Jul 2022 00:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiGaECR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 31 Jul 2022 00:02:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2C12A96
        for <linux-security-module@vger.kernel.org>; Sat, 30 Jul 2022 21:02:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o13so10047946edc.0
        for <linux-security-module@vger.kernel.org>; Sat, 30 Jul 2022 21:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dS1gnirPaPIBPW+4HAsPhAM2Po3GcMN0qT2m5lg+fpg=;
        b=phMdau5Q+uuFquEvPmnS6HSL/18zz+bUW5aMUMyObJZ0NF9q1xVKLI3BQjQlfmM2uJ
         Of/mTF0xmIu/Vj2G44REluOqYnduXIF6+pad9Fz7HXwxywUejputsnD2s0Nma05Rv8cZ
         Ykn0+GYcu2aPF3Jj0CBMXsDFPGYIQu/old0U+j9Czye/9COJvmpjr2GMU1fRTNoEc8Jg
         wPra2i+MnfMHTVt6cKD2Go8THWFMUbQ2f3Jwp/i7Ts+0JcN/nLZhsqciusn3o/H7Ekui
         OxBDiwY11WtJJEh0jABmMFqJr+aIcDNmPhva0XS0sAxvusJ06fY3cmkpXRhLoljs8mJN
         Bu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dS1gnirPaPIBPW+4HAsPhAM2Po3GcMN0qT2m5lg+fpg=;
        b=uYElW3SgbMIAluTTkxpcNVq8Noen1FIAQqz5Vm7N2TdAuthLzFUMRgRDAr0bt3L0GT
         Nwrnth7omJflmAfzDp5Oome2+v/TuiPshv5lYY9sYMR1MB4PktdpYgMplTU7MDhK5jO3
         PkEVzOgt3POg3y8r5mSDKlCZS7LJoO1f/+rbhd1hmEQA5NM0QX2tIIWVNVxLIrOEtm3x
         tN9x8Zj0aHmF/JEUsVQ6ddiNBUE2BNRKcc9u/dufwXslifhmtkLm4QRMB8GQ+UsCLLEM
         3yPCXF8AmzcAMz8h94nOrwzBJjRBNpPz5mZ4onpippRfsNLaGwbqXGlLUQPGyExawwYm
         XY3A==
X-Gm-Message-State: AJIora9lHeHG/yHwHjECwAl6aggwSUhmWTIRot6BjupOmCc2c7KgP+GP
        T3Lc5XtJXNx3MI/dQY1jUv0=
X-Google-Smtp-Source: AGRyM1u7NZvP+Xzrt7OZ0vARDj/6M2wa4dK7uocIn0rzH07JXU9ZzisazBwcopgv4L8DkMvxpVIMrQ==
X-Received: by 2002:a05:6402:51ce:b0:43c:4326:26d3 with SMTP id r14-20020a05640251ce00b0043c432626d3mr9836732edd.411.1659240134371;
        Sat, 30 Jul 2022 21:02:14 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i23-20020a1709063c5700b007306ae5bb1esm323255ejg.82.2022.07.30.21.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 21:02:13 -0700 (PDT)
Date:   Sun, 31 Jul 2022 06:02:12 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 1/4] landlock: Support file truncation
Message-ID: <YuX+xGUMubWnWAwp@nuc>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
 <20220712211405.14705-2-gnoack3000@gmail.com>
 <77116641-4f5f-f152-4032-d83011b05d97@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77116641-4f5f-f152-4032-d83011b05d97@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 29, 2022 at 12:49:29PM +0200, Mickaël Salaün wrote:
>
> On 12/07/2022 23:14, Günther Noack wrote:
>
> [...]
>
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 23df4e0e8ace..9ca7f9d0d862 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -96,7 +96,12 @@ struct landlock_path_beneath_attr {
> >    *
> >    * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> >    * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
> > + *   Note that you might additionally need the LANDLOCK_ACCESS_FS_TRUNCATE
> > + *   right in order to overwrite files with open(2) using O_TRUNC or creat(2).
>
> Please use the :manpage: notation for syscalls.

Done, will be included in the next version.

>
>
> >    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> > + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file through file truncation
> > + *   APIs like truncate(2), ftruncate(2), open(2) with O_TRUNC or creat(2).
> > + *   This access right is available since the third version of the Landlock ABI.
> >    *
> >    * A directory can receive access rights related to files or directories.  The
> >    * following access right is applied to the directory itself, and the
> > @@ -139,10 +144,9 @@ struct landlock_path_beneath_attr {
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
