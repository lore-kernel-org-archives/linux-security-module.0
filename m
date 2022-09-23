Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEFFC04A95
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 21:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIWVDp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiIWVD0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 17:03:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FA811DFD9;
        Fri, 23 Sep 2022 14:03:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u24so1754200edb.9;
        Fri, 23 Sep 2022 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=LyvlT9tEkQMk15ax3Nvj2cknFiDcZlMMJsOqNEe7EIw=;
        b=V0iCqG8fIjjTk+XhnrpQ/4b98A0x6//ZGiHA3khL7ZJxQWlO/ACl9NC6iOM+LHj/7P
         bizyTyp83jSHcxD2Bd5w3JLJPc4g5yOTHk/OezywGKWOpe/nrzmZdD5PoPCwi9RhuEri
         ETIeZF+rZBka8ZEfbldU75gP+T01Jap2sfNrHxdGXgR4SPO0sbQCqqnDusHjj+l+SR6p
         SiMBpdLZUK0DwZt38NGVJTCK3y/24TSTnFFqrHYu1R28vw4+ZQ8vcEelSedr1iqgvEGd
         dUjTmR0tBLgHfn4zaH3Ibf/NF+zDVf8sJggianJiqHhu62PfWmsrhP3Vvvty7Hl0ZgT/
         0FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LyvlT9tEkQMk15ax3Nvj2cknFiDcZlMMJsOqNEe7EIw=;
        b=voFcEcqTcBVcjSproo0zRSHWUGYpBvIvF6fKHrBLH1rMjRBaIUwjYJZJ3TQpc9nMIV
         W4jqLSwPZ1nF4+fB6zxhciNaI1084SD05syoKdq6KEkgi/OzToNLqXPoJO6sWt8XqLBs
         tDDk0XyNdCqWFq506M96SFE0T+WEtWN7tRRWFetnSltSNcVzJB4wQx5nln62tnwZWn4v
         iod04tsKYlXD4ppTb6XH6ML3t7ZNRJQgkq1w8i1iJdp7yUnlI9IZkxcoMcj6ieVCQxEL
         VqIlR29ckyIo/YqE5WnahJ+/eHuE1Gj9YXxmd//k5FuTXPzwVeCEYN3qEGqnB57ZF1wV
         MgIw==
X-Gm-Message-State: ACrzQf35NrT6UIPP/NCmUZOg6B09GzadynXe9lahAovWyjT57PMC1PVA
        EtttpmLSH4XQxm4CzoPrvso=
X-Google-Smtp-Source: AMsMyM5roKyUzH6qvBS5UXCqSBYt2stLx09SrmIaJHZxrQvY3L86grLC/Dpuo9DSqfke4HHAN3Zg5A==
X-Received: by 2002:a05:6402:11c8:b0:451:7220:6343 with SMTP id j8-20020a05640211c800b0045172206343mr10207432edw.184.1663967000518;
        Fri, 23 Sep 2022 14:03:20 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906345500b0073c8d4c9f38sm4544318ejb.177.2022.09.23.14.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 14:03:20 -0700 (PDT)
Date:   Fri, 23 Sep 2022 23:03:18 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 2/3] landlock: Slightly improve documentation and fix
 spelling
Message-ID: <Yy4fFkyGWnOaosX7@nuc>
References: <20220923154207.3311629-1-mic@digikod.net>
 <20220923154207.3311629-3-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923154207.3311629-3-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

On Fri, Sep 23, 2022 at 05:42:06PM +0200, Mickaël Salaün wrote:
> Now that we have more than one ABI version, make limitation explanation
> more consistent by replacing "ABI 1" with "ABI < 2".  This also
> indicates which ABIs support such past limitation.
> 
> Improve documentation consistency by not using contractions.
> 
> Fix spelling in fs.c .
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20220923154207.3311629-3-mic@digikod.net
> ---
>  Documentation/security/landlock.rst      |  4 ++--
>  Documentation/userspace-api/landlock.rst | 10 +++++-----
>  security/landlock/fs.c                   |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> index 5c77730b4479..cc9617f3175b 100644
> --- a/Documentation/security/landlock.rst
> +++ b/Documentation/security/landlock.rst
> @@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
>  ==================================
>  
>  :Author: Mickaël Salaün
> -:Date: May 2022
> +:Date: September 2022
>  
>  Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>  harden a whole system, this feature should be available to any process,
> @@ -49,7 +49,7 @@ Filesystem access rights
>  ------------------------
>  
>  All access rights are tied to an inode and what can be accessed through it.
> -Reading the content of a directory doesn't imply to be allowed to read the
> +Reading the content of a directory does not imply to be allowed to read the
>  content of a listed inode.  Indeed, a file name is local to its parent
>  directory, and an inode can be referenced by multiple file names thanks to
>  (hard) links.  Being able to unlink a file only has a direct impact on the
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index b8ea59493964..83bae71bf042 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: May 2022
> +:Date: September 2022
>  
>  The goal of Landlock is to enable to restrict ambient rights (e.g. global
>  filesystem access) for a set of processes.  Because Landlock is a stackable
> @@ -170,7 +170,7 @@ It is recommended setting access rights to file hierarchy leaves as much as
>  possible.  For instance, it is better to be able to have ``~/doc/`` as a
>  read-only hierarchy and ``~/tmp/`` as a read-write hierarchy, compared to
>  ``~/`` as a read-only hierarchy and ``~/tmp/`` as a read-write hierarchy.
> -Following this good practice leads to self-sufficient hierarchies that don't
> +Following this good practice leads to self-sufficient hierarchies that do not
>  depend on their location (i.e. parent directories).  This is particularly
>  relevant when we want to allow linking or renaming.  Indeed, having consistent
>  access rights per directory enables to change the location of such directory
> @@ -380,8 +380,8 @@ by the Documentation/admin-guide/cgroup-v1/memory.rst.
>  Previous limitations
>  ====================
>  
> -File renaming and linking (ABI 1)
> ----------------------------------
> +File renaming and linking (ABI < 2)
> +-----------------------------------
>  
>  Because Landlock targets unprivileged access controls, it needs to properly
>  handle composition of rules.  Such property also implies rules nesting.
> @@ -410,7 +410,7 @@ contains `CONFIG_LSM=landlock,[...]` with `[...]`  as the list of other
>  potentially useful security modules for the running system (see the
>  `CONFIG_LSM` help).
>  
> -If the running kernel doesn't have `landlock` in `CONFIG_LSM`, then we can
> +If the running kernel does not have `landlock` in `CONFIG_LSM`, then we can
>  still enable it by adding ``lsm=landlock,[...]`` to
>  Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
>  configuration.
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index a9dbd99d9ee7..64ed7665455f 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -712,7 +712,7 @@ static inline access_mask_t maybe_remove(const struct dentry *const dentry)
>   * allowed accesses in @layer_masks_dom.
>   *
>   * This is similar to check_access_path_dual() but much simpler because it only
> - * handles walking on the same mount point and only check one set of accesses.
> + * handles walking on the same mount point and only checks one set of accesses.
>   *
>   * Returns:
>   * - true if all the domain access rights are allowed for @dir;
> -- 
> 2.37.2
> 

-- 
