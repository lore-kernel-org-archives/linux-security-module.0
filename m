Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B19EC61DA4
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Feb 2023 12:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBNMFQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Feb 2023 07:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBNMFP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Feb 2023 07:05:15 -0500
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81326EA6
        for <linux-security-module@vger.kernel.org>; Tue, 14 Feb 2023 04:04:41 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PGKcj60TrzMrfQf;
        Tue, 14 Feb 2023 13:04:05 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PGKcj233CzMs4Gt;
        Tue, 14 Feb 2023 13:04:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1676376245;
        bh=Hn8pyKXiGMV54Cg71TJp+lGJCaMbEOwe/VlvoLeHEk8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=t+EasRYeSPQMpyKG5/R5XHZTIZt5NXjfUOC8+CXGL9kzerNUnlLDxmD45ASan1B0v
         BCZL7QOzonKXcug+hzPApfzfpX8gIZHe4fGn7adz+tRrn/iKkIxhYskvtjZ89FjvPr
         xDp7zr2jOHWqVZ2hhaTFeFmclPTeZG2586jnO+ms=
Message-ID: <d8112efe-d270-3013-97e6-bcc7c5237c02@digikod.net>
Date:   Tue, 14 Feb 2023 13:04:04 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230213210115.5150-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230213210115.5150-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 13/02/2023 22:01, Günther Noack wrote:
> Clarify the "refer" documentation by splitting up a big paragraph of text.
> 
> - Call out specifically that the denial by default applies to ABI v1 as well.
> - Turn the three additional constraints for link/rename operations
>    into bullet points, to give it more structure.
> 
> Includes wording and semantics corrections by Mickaël Salaün.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   include/uapi/linux/landlock.h | 41 ++++++++++++++++++++++-------------
>   1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f3223f96469..f6bccd87aa0 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -130,21 +130,32 @@ struct landlock_path_beneath_attr {
>    * - %LANDLOCK_ACCESS_FS_MAKE_BLOCK: Create (or rename or link) a block device.
>    * - %LANDLOCK_ACCESS_FS_MAKE_SYM: Create (or rename or link) a symbolic link.
>    * - %LANDLOCK_ACCESS_FS_REFER: Link or rename a file from or to a different
> - *   directory (i.e. reparent a file hierarchy).  This access right is
> - *   available since the second version of the Landlock ABI.  This is also the
> - *   only access right which is always considered handled by any ruleset in
> - *   such a way that reparenting a file hierarchy is always denied by default.
> - *   To avoid privilege escalation, it is not enough to add a rule with this
> - *   access right.  When linking or renaming a file, the destination directory
> - *   hierarchy must also always have the same or a superset of restrictions of
> - *   the source hierarchy.  If it is not the case, or if the domain doesn't
> - *   handle this access right, such actions are denied by default with errno
> - *   set to ``EXDEV``.  Linking also requires a ``LANDLOCK_ACCESS_FS_MAKE_*``
> - *   access right on the destination directory, and renaming also requires a
> - *   ``LANDLOCK_ACCESS_FS_REMOVE_*`` access right on the source's (file or
> - *   directory) parent.  Otherwise, such actions are denied with errno set to
> - *   ``EACCES``.  The ``EACCES`` errno prevails over ``EXDEV`` to let user space
> - *   efficiently deal with an unrecoverable error.
> + *   directory (i.e. reparent a file hierarchy).
> + *
> + *   This access right is available since the second version of the Landlock
> + *   ABI.  This is also the only access right which is always considered
> + *   handled by any ruleset in such a way that reparenting a file hierarchy is

This is from me, but do you think "reparenting a file hierarchy" is not 
confusing? What about "reparenting a file or a directory"? Not sure 
which one is better.

I'm not sure either if we should use "deny" or "forbidden". Is there a 
difference? According to https://www.wikidiff.com/deny/forbid it seems 
that "deny" would be more appropriate because Landlock rules add 
exceptions to a forbidden set of actions… However, "deny" needs to be 
followed by "access" for the same use, which makes your wording correct. 
Just a thought.


> + *   always denied by default.  If left unspecified during the creation of a
> + *   ruleset, linking and renaming files between different directories will be
> + *   forbidden, which is also the case when using the first Landlock ABI.
> + *
> + *   In addition to permitting this access right, the following constraints
> + *   must hold for the access rights on the source and destination directory:
> + *
> + *   * The destination directory may not grant any access rights which are
> + *     forbidden for the source file. Otherwise, the operation results in an

The files/directories don't grant accesses but the sandbox/domain do 
grant some accesses for a set of file hierarchies.

What about "Any forbidden actions on the source file must also be 
forbidden on the destination file."
Or "Any denied accesses on the source file…"

This seems a bit weird according to the previous "must hold for the 
access rights on the source and destination directory" though.


> + *     ``EXDEV`` error.
> + *
> + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for
> + *     the respective file type is required in the destination directory.

s/is required in the destination/must be granted for the destination/ ?


> + *     Otherwise, the operation results in an ``EACCES`` error.
> + *
> + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
> + *     respective file type is required in the source directory.  Otherwise,

Same "must be granted for"


> + *     the operation results in an ``EACCES`` error.
> + *
> + *   If multiple requirements are not met, the ``EACCES`` error code takes
> + *   precedence over ``EXDEV``.
>    *
>    * .. warning::
>    *
> 
> base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
