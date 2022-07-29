Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB66CC00144
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jul 2022 10:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiG2K5K (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiG2K5J (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jul 2022 06:57:09 -0400
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D959A4D4FE
        for <linux-security-module@vger.kernel.org>; Fri, 29 Jul 2022 03:57:07 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LvPNz6xXbzMqGY5;
        Fri, 29 Jul 2022 12:47:47 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LvPNz2Wl7zlqwsf;
        Fri, 29 Jul 2022 12:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659091667;
        bh=IS0wWDEaxm7J7hz3ql/Wib6XtD72c6ZqUxK9nr111ag=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=XwPx6zBNxtuRzJBSMd+xpVXK84RuQKYpALLhAUmvDpJWdOS7kVTscTy0qCbwS3iYq
         E6665NowVi8On0NZdTpLaBXz1jutAGM+MygPS2fDQTTc0VYTQjqZt34pWgSkFYzGy+
         xfrVe1+IV2qbQ6mqOF51+1sV8nGQ98tJAYG4jXOE=
Message-ID: <d198d2b4-ebf4-c7a2-cf95-f028d48c09e5@digikod.net>
Date:   Fri, 29 Jul 2022 12:47:46 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
 <20220712211405.14705-5-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v2 4/4] landlock: Document Landlock's file truncation
 support
In-Reply-To: <20220712211405.14705-5-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 12/07/2022 23:14, Günther Noack wrote:
> Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> 
> Adapt the backwards compatibility example and discussion to remove the
> truncation flag if needed.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> Link: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
> ---
>   Documentation/userspace-api/landlock.rst | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index b86fd94ae797..41fa464cc8b8 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
>               LANDLOCK_ACCESS_FS_MAKE_FIFO |
>               LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>               LANDLOCK_ACCESS_FS_MAKE_SYM |
> -            LANDLOCK_ACCESS_FS_REFER,
> +            LANDLOCK_ACCESS_FS_REFER |
> +            LANDLOCK_ACCESS_FS_TRUNCATE,
>       };
>   
>   Because we may not know on which kernel version an application will be
> @@ -69,14 +70,22 @@ should try to protect users as much as possible whatever the kernel they are
>   using.  To avoid binary enforcement (i.e. either all security features or
>   none), we can leverage a dedicated Landlock command to get the current version
>   of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> -starting with the second version of the ABI.
> +remove the `LANDLOCK_ACCESS_FS_REFER` and `LANDLOCK_ACCESS_FS_TRUNCATE` access
> +rights, which are only supported starting with the second and third version of
> +the ABI.
>   
>   .. code-block:: c
>   
>       int abi;
>   
>       abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> +    if (abi == -1) {
> +        perror("Landlock is unsupported on this kernel");

"Landlock is not supported with the running kernel"?


> +        return 1;
> +    }
> +    if (abi < 3) {
> +        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> +    }

I guess we could use the same switch/case code as for the sample. I'm 
not sure what would be the less confusing for users though.


>       if (abi < 2) {
>           ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
>       }
> @@ -127,8 +136,8 @@ descriptor.
>   
>   It may also be required to create rules following the same logic as explained
>   for the ruleset creation, by filtering access rights according to the Landlock
> -ABI version.  In this example, this is not required because
> -`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
> +ABI version.  In this example, this is not required because all of the requested
> +``allowed_access`` rights are already available in ABI 1.

Good!

>   
>   We now have a ruleset with one rule allowing read access to ``/usr`` while
>   denying all other handled accesses for the filesystem.  The next step is to
