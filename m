Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3F6C47089
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Dec 2022 17:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiLGRtR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLGRtQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Dec 2022 12:49:16 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182368697;
        Wed,  7 Dec 2022 09:49:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n7so14251079wms.3;
        Wed, 07 Dec 2022 09:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fXNqkXGWcmQ6UKPLwLmTN6pvQwCbW2EJ14f2E+6Nf+k=;
        b=P3WHISqE1fEcapvnL1QBGBCZt5fe40TD1H7qzJEbJJQzWmoaiDQGBBkUXwyJwFeYl9
         T2zb7YS+N5OIcfAYoQqgNZ6jtAdCIVpERcJG/jiiH/3GE0XB8zuq6WB6QYNODXji4nzw
         SzxM1YZaVXGRHZ/WpOoaZP1ZDfGx6+17nK2+3sNEdbwXJbohalhjrYQ0caq0oQLmVWWS
         fGhNril1RFO3Jy/G6zp3jJTs2lyfx351ASvdSb71niotA46/FWaPWPMXJnOhKdhV1K2T
         hfBavjC1ZI3Jr0ImSKgZ5AdV5155C9JolmkBxSjaT88op16exPSEBSn3YKZ+4zmIJTDk
         j3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXNqkXGWcmQ6UKPLwLmTN6pvQwCbW2EJ14f2E+6Nf+k=;
        b=kH3rQfVtwAcBCVJ48/JJWYwWjOJuG272R0l/CKNXIMa9gYCE8wFzwVWt37liDeeM4y
         nv866LWJmKkmOZOb5ONoVmEjYnAK3NNEuaMM91JXuhH4qlpOmw8hfIweef3mDHxLaL//
         ZlTzkrizZEeGe3LSqftt2OyemKkkWbqrjgsGQ6NJL6uATAfcx/29nzLKl+oR8KOoKmQ/
         83mIL5JTwKOJ5N5dB9uNILFKi1I8VoXjNWjlXKYAwuFj27ORa1iH8ytENsNncLAhDaNa
         W5rOf6o6vM2qIHk758icr10NmQaY1W52mlX/CpXgL06o9XkglLbjCiRCNqx0DogFAMPl
         NqqA==
X-Gm-Message-State: ANoB5pmlwz3NqXOQ3vmEypVfULTGgMy9gj8UWScwGG4gHNrRxkUiVu21
        gj5wQd581PYhYdeFClyZ55uZ7Tn3CnA=
X-Google-Smtp-Source: AA0mqf78uQ5ryk9TDBaHEuak28VHkWpHoYS4xaJcekIidnr3o+QpVv9kZ/xrhDcK42F4Y4V7o1C3vw==
X-Received: by 2002:a1c:f617:0:b0:3cf:5584:7730 with SMTP id w23-20020a1cf617000000b003cf55847730mr71788516wmc.187.1670435353504;
        Wed, 07 Dec 2022 09:49:13 -0800 (PST)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d4e92000000b0024206ed539fsm19887689wru.66.2022.12.07.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:49:13 -0800 (PST)
Date:   Wed, 7 Dec 2022 18:49:11 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Explain file descriptor access rights
Message-ID: <Y5DSFwHoYZwYEn0T@nuc>
References: <20221205112621.3530557-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221205112621.3530557-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi!

Thanks for sending this patch! I have overlooked to update this in the
original patch set.

On Mon, Dec 05, 2022 at 12:26:21PM +0100, Mickaël Salaün wrote:
> Starting with LANDLOCK_ACCESS_FS_TRUNCATE, it is worth explaining why we
> choose to restrict access checks at open time.  This new "File
> descriptor access rights" section is complementary to the existing
> "Inode access rights" section.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20221205112621.3530557-1-mic@digikod.net
> ---
>  Documentation/security/landlock.rst | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> index c0029d5d02eb..bd0af6031ebb 100644
> --- a/Documentation/security/landlock.rst
> +++ b/Documentation/security/landlock.rst
> @@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
>  ==================================
>  
>  :Author: Mickaël Salaün
> -:Date: September 2022
> +:Date: November 2022
>  
>  Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>  harden a whole system, this feature should be available to any process,
> @@ -45,8 +45,8 @@ Guiding principles for safe access controls
>  Design choices
>  ==============
>  
> -Filesystem access rights
> -------------------------
> +Inode access rights
> +-------------------
>  
>  All access rights are tied to an inode and what can be accessed through it.
>  Reading the content of a directory does not imply to be allowed to read the
> @@ -57,6 +57,25 @@ directory, not the unlinked inode.  This is the reason why
>  ``LANDLOCK_ACCESS_FS_REMOVE_FILE`` or ``LANDLOCK_ACCESS_FS_REFER`` are not
>  allowed to be tied to files but only to directories.
>  
> +File descriptor access rights
> +-----------------------------
> +
> +Access rights are checked and tied to file descriptors at open time.  As a
> +consequence, it may be allowed to create a file without being allowed to
> +truncate it if the file hierarchy doesn't grant such access right.  The
> +rationale is that this approach is simple and consistent with all access
> +rights, however file requests are based on path or based on file descriptor
> +(obtained with the same path, by a thread restricted with the same Landlock
> +domain).  For instance, updating an application from using :manpage:`mknod` and
> +:manpage:`truncate` to initialize a file (i.e. path-based), to using
> +:manpage:`open` and :manpage:`ftruncate` to initialize the same file (i.e. file
> +descriptor-based) should work the same way with the same Landlock restrictions.

Nit: The paragraph seems a bit long and is mixing more general
considerations with examples. Maybe they could be split into separate
paragraphs?

Regarding the "As a consequence..." example: I would word it as "...it
may be allowed to open a file for writing without being allowed to
ftruncate the resulting file descriptor...".

The example you are giving with creating files is also accurate, but
it is potentially confusing, because creat() and open(..., O_TRUNC)
are also implicitly truncating files when opening the file.

Regarding "The rationale is that this approach is simple and
consistent...": The word "simple" is often a sign that we could be
more concrete, and there is also a risk that a reader might not
perceive it as simple ;)  How about this:

```

The rationale is that equivalent sequences of operations should lead
to the same results, when they are executed under the same Landlock
domain.

For example, for the LANDLOCK_ACCESS_FS_TRUNCATE right, the following
sequences of operations are roughly equivalent and should have the
same result:

* truncate(path)
* fd = open(path, O_WRONLY); ftruncate(fd); close(fd)

```

(I think it's a bit more readable with bullet points, and the
truncate/ftruncate example might be a bit more familiar than the
somewhat unusual mknod?)

> +
> +Processes not sandboxed by Landlock may still be restricted for operations on
> +file descriptors coming from a sandboxed process.  Indeed, this is required to
> +keep a consistent access control over the whole system, and avoid unattended
> +bypasses through file descriptor passing (i.e. confused deputy attack).

"May still be restricted" is leaving the reader a bit in the dark
about the exact circumstances where this might happen? I think we
could be more bold and give a guarantee here, like:

```

Access rights attached to file descriptors are retained even if the
file descriptor is passed between Unix processes (e.g. through a Unix
Domain Socket). The access rights will be enforced even if the
receiving process is not sandboxed by Landlock.

```

--Günther

> +
>  Tests
>  =====
>  
> 
> base-commit: 0b4ab8cd635e8b21e42c14b9e4810ca701babd11
> -- 
> 2.38.1
> 

-- 
