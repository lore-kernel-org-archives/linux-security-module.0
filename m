Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C054C4167B
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Dec 2022 07:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiLLHjW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Dec 2022 02:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLLHjV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Dec 2022 02:39:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE98E95A6;
        Sun, 11 Dec 2022 23:39:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so4399855wmh.0;
        Sun, 11 Dec 2022 23:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=STrIrKUR3jl78R5rHhUdL3l1spr1Dw99yVoevMjCOYc=;
        b=fbPZb8Ytekt5SnJDlf0q4gpbNF/6kbE5e+iUC166UTZSMbJj7yxdGPnzkYDbctZtt0
         64V2RQnSNyvTLDsB+t9B58E2yAk4C5ryDJPvN7c/AxCkoqmGcw+1/YygkC0ALtAfBpGx
         sbl+HMXhb/CBAsVOR8iU8xXvuT7XFfRnrlqI1r+z8pex4Bud2XI6MfsXKpWJBBxO+JKA
         jxpwjU+VHIA62XpkjsX+Y2aUo44fJYp5m6Iwal1l0OcQLXs9ljEDUb+A1rt1TS3euYzl
         WM2dO3AUdWLEVzJ20G/bi79bcNa2zgbg7dUCR+cAroj+nUnLdPUv5AorqQr+1cw9pcUN
         +UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STrIrKUR3jl78R5rHhUdL3l1spr1Dw99yVoevMjCOYc=;
        b=51c50sZ++dnwg1KhrHzNGWnpauL7JQ3x/LkCaEd5m/Hyoep63L4THyHjd9bMSpmfxB
         jpfLTjlAXwIETb1/FJ+HbQHVMCaxIEBBJ59l3tyScSoxAEihS+/giIppMQhipO39xYZX
         DGd05DU728cq7VX/DWZBp2tXUB1RRDG7s3nTSuImO+EA4y+9sso1aMnx8abe6W8fIcIA
         MClziyuAfAV6kyQvVLSovZIPOakW/Asx06hkQFPgAAZe5qd1kEFPpK05UZTv9KpPatJs
         WGsLRK2Wny6sTJibNQE//L8jNsjSugC3g72wGfabGzjnzBjFOYptJZwVhqkMdYOKsSzb
         v1XA==
X-Gm-Message-State: ANoB5pnBu296BG10Z5PkcaSAsGs4orh8ntnXXx1fTullA6vvTvtcMlj7
        xL/0yhqk0cmGD2AYolzRCKxGi39pIbU=
X-Google-Smtp-Source: AA0mqf7xO4wfjMcJEGpTaXUfx9bjXOOzwTLVX+fOhZOzMl8csMrtOVj0swLG500MaJQR62ffCmaC4Q==
X-Received: by 2002:a1c:6a04:0:b0:3c6:e63e:89ae with SMTP id f4-20020a1c6a04000000b003c6e63e89aemr11942643wmc.10.1670830759211;
        Sun, 11 Dec 2022 23:39:19 -0800 (PST)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003d1f2c3e571sm8713365wmq.33.2022.12.11.23.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 23:39:18 -0800 (PST)
Date:   Mon, 12 Dec 2022 08:39:17 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] landlock: Explain file descriptor access rights
Message-ID: <Y5bapU9dWu0sBed6@nuc>
References: <20221209193813.972012-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221209193813.972012-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 09, 2022 at 08:38:13PM +0100, Mickaël Salaün wrote:
> Starting with LANDLOCK_ACCESS_FS_TRUNCATE, it is worth explaining why we
> choose to restrict access checks at open time.  This new "File
> descriptor access rights" section is complementary to the existing
> "Inode access rights" section.  Add a new guiding principle related to
> this section.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20221209193813.972012-1-mic@digikod.net
> ---
> 
> Changes since v1:
> https://lore.kernel.org/r/20221205112621.3530557-1-mic@digikod.net
> * Reworded the new section based on Günther suggestions.
> * Added a new guiding principle.
> * Update date.
> ---
>  Documentation/security/landlock.rst | 33 ++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> index c0029d5d02eb..95a0e4726dc5 100644
> --- a/Documentation/security/landlock.rst
> +++ b/Documentation/security/landlock.rst
> @@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
>  ==================================
>  
>  :Author: Mickaël Salaün
> -:Date: September 2022
> +:Date: December 2022
>  
>  Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>  harden a whole system, this feature should be available to any process,
> @@ -41,12 +41,15 @@ Guiding principles for safe access controls
>    processes.
>  * Computation related to Landlock operations (e.g. enforcing a ruleset) shall
>    only impact the processes requesting them.
> +* Resources (e.g. file descriptors) directly obtained from the kernel by a
> +  sandboxed process shall retain their scoped accesses whatever process use

Optional nit: Maybe add "at the time of resource acquisition" to stress that part?

> +  them.  Cf. `File descriptor access rights`_.
>  
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
> @@ -57,6 +60,30 @@ directory, not the unlinked inode.  This is the reason why
>  ``LANDLOCK_ACCESS_FS_REMOVE_FILE`` or ``LANDLOCK_ACCESS_FS_REFER`` are not
>  allowed to be tied to files but only to directories.
>  
> +File descriptor access rights
> +-----------------------------
> +
> +Access rights are checked and tied to file descriptors at open time.  The
> +underlying principle is that equivalent sequences of operations should lead to
> +the same results, when they are executed under the same Landlock domain.
> +
> +Taking the ``LANDLOCK_ACCESS_FS_TRUNCATE`` right as an example, it may be
> +allowed to open a file for writing without being allowed to
> +:manpage:`ftruncate` the resulting file descriptor if the related file
> +hierarchy doesn't grant such access right.  The following sequences of
> +operations have the same semantic and should then have the same result:
> +
> +* ``truncate(path);``
> +* ``int fd = open(path, O_WRONLY); ftruncate(fd); close(fd);``
> +
> +Similarly to file access modes (e.g. ``O_RDWR``), Landlock access rights
> +attached to file descriptors are retained even if they are passed between
> +processes (e.g. through a Unix domain socket).  Such access rights will then be
> +enforced even if the receiving process is not sandboxed by Landlock.  Indeed,
> +this is required to keep a consistent access control over the whole system, and
> +avoid unattended bypasses through file descriptor passing (i.e. confused deputy
> +attack).
> +
>  Tests
>  =====
>  
> 
> base-commit: 0b4ab8cd635e8b21e42c14b9e4810ca701babd11
> -- 
> 2.38.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thank you!

-- 
