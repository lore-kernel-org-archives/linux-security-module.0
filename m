Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0AEC25B0E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Aug 2022 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiHPTTB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiHPTSj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Aug 2022 15:18:39 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770354C97
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 12:18:36 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M6gt23W4vzMpnZc;
        Tue, 16 Aug 2022 21:18:34 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4M6gt15F4pzln8Vj;
        Tue, 16 Aug 2022 21:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660677514;
        bh=6V4iNwz2tJ/llXSuD4WLyfGpfpIquRyjZkRx97pl93E=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ezYVnxwC9VWPUFMd3ABY/b/CNsyyvzkBJ1Cp7PIA1bn2fo1MYR8BpWWUJrIchgdBi
         XXHILmOBjD0jAhYgY7nvYlOXG/dvSDu5t31t2KmPZ1QwyOpdHnoZLfevJMvnnP1q1c
         fA9aAN7KGbNJK7kQyO3FWR4PTRcDd/fXrpBL4osQ=
Message-ID: <bd1487df-3277-6429-8724-6e3727e76091@digikod.net>
Date:   Tue, 16 Aug 2022 21:18:33 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
 <20220814192603.7387-5-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v4 4/4] landlock: Document Landlock's file truncation
 support
In-Reply-To: <20220814192603.7387-5-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 14/08/2022 21:26, Günther Noack wrote:
> Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.
> 
> Adapt the backwards compatibility example and discussion to remove the
> truncation flag where needed.
> 
> Point out potential surprising behaviour related to truncate.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   Documentation/userspace-api/landlock.rst | 48 +++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 6648e59fabe7..3ceb97cbe9d1 100644
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
> @@ -69,16 +70,26 @@ should try to protect users as much as possible whatever the kernel they are
>   using.  To avoid binary enforcement (i.e. either all security features or
>   none), we can leverage a dedicated Landlock command to get the current version
>   of the Landlock ABI and adapt the handled accesses.  Let's check if we should
> -remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
> -starting with the second version of the ABI.
> +remove the `LANDLOCK_ACCESS_FS_REFER` and `LANDLOCK_ACCESS_FS_TRUNCATE` access

s/and/or/

> +rights, which are only supported starting with the second and third version of
> +the ABI.
>   
>   .. code-block:: c
>   
>       int abi;
>   
>       abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> -    if (abi < 2) {
> -        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> +    switch (abi) {
> +    case -1:
> +            perror("The running kernel does not enable to use Landlock");
> +            return 1;
> +    case 1:
> +            /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> +            __attribute__((fallthrough));
> +    case 2:
> +            /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> +            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
>       }
>   
>   This enables to create an inclusive ruleset that will contain our rules.
> @@ -127,8 +138,8 @@ descriptor.
>   
>   It may also be required to create rules following the same logic as explained
>   for the ruleset creation, by filtering access rights according to the Landlock
> -ABI version.  In this example, this is not required because
> -`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
> +ABI version.  In this example, this is not required because all of the requested
> +``allowed_access`` rights are already available in ABI 1.
>   
>   We now have a ruleset with one rule allowing read access to ``/usr`` while
>   denying all other handled accesses for the filesystem.  The next step is to
> @@ -251,6 +262,24 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
>   process, a sandboxed process should have a subset of the target process rules,
>   which means the tracee must be in a sub-domain of the tracer.
>   
> +Truncating files
> +----------------
> +
> +The operations covered by `LANDLOCK_ACCESS_FS_WRITE_FILE` and
> +`LANDLOCK_ACCESS_FS_TRUNCATE` both change the contents of a file and sometimes
> +overlap in non-intuitive ways.  It is recommended to always specify both of
> +these together.
> +
> +A particularly surprising example is :manpage:`creat(2)`.  The name suggests
> +that this system call requires the rights to create and write files.  However,
> +it also requires the truncate right if an existing file under the same name is
> +already present.
> +
> +It should also be noted that truncating files does not necessarily require the

I think "necessarily" is superfluous here.


> +`LANDLOCK_ACCESS_FS_WRITE_FILE` right.  Apart from the obvious
> +:manpage:`truncate(2)` system call, this can also be done through
> +:manpage:`open(2)` with the flags `O_RDONLY` and `O_TRUNC`.

`O_RDONLY | O_TRUNC`.


> +
>   Compatibility
>   =============
>   
> @@ -386,9 +415,8 @@ File truncation (ABI < 3)
>   File truncation could not be denied before the third Landlock ABI, so it is
>   always allowed when using a kernel that only supports the first or second ABI.
>   
> -Starting with the Landlock ABI version 3, it is now possible to securely
> -control truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access
> -right.
> +Starting with the Landlock ABI version 3, it is now possible to securely control
> +truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access right.

This is an inconsistent hunk, patching the first patch.

Please also move this "File truncation" section below the "File renaming 
and linking".


>   
>   File renaming and linking (ABI 1)
>   ---------------------------------
