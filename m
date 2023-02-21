Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19417C636D7
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Feb 2023 17:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjBURWn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjBURWm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Feb 2023 12:22:42 -0500
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A502A15E
        for <linux-security-module@vger.kernel.org>; Tue, 21 Feb 2023 09:22:30 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PLmLr6DBBzMpr0G;
        Tue, 21 Feb 2023 18:22:28 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PLmLq6N7VzMsKtW;
        Tue, 21 Feb 2023 18:22:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1677000148;
        bh=34Ssu0wUZyf6eVsByeZtzrLrakIic0WB4p7uULtqblA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AEUYdSRfygw2L6eE3xS45x2zUqXfvWe4qW9EjUhhlrAVY/DSW/lPrFUpsw3c5soKm
         +d2wBnLQyXPZV7wmga+O+Anp/m0KGZS607aZ0ORIklaye4EBTf98GNNjYIV1ouYwXD
         /O43IKYihGGXHEFGBOCYYAuxITRgs1deV12Z9MQI=
Message-ID: <a75cda50-11ec-97da-7a78-20b3833a6897@digikod.net>
Date:   Tue, 21 Feb 2023 18:22:27 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v4] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230221165205.4231-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230221165205.4231-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Perfect, thanks for your perseverance Günther! I've applied it to my 
-next tree: 
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

On 21/02/2023 17:52, Günther Noack wrote:
> Clarify the "refer" documentation by splitting up a big paragraph of text.
> 
> - Call out specifically that the denial by default applies to ABI v1 as well.
> - Turn the three additional constraints for link/rename operations
>    into bullet points, to give it more structure.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   include/uapi/linux/landlock.h | 46 +++++++++++++++++++++++------------
>   1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f3223f96469..81d09ef9aa5 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -130,21 +130,37 @@ struct landlock_path_beneath_attr {
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
> + *   ABI.
> + *
> + *   This is the only access right which is denied by default by any ruleset,
> + *   even if the right is not specified as handled at ruleset creation time.
> + *   The only way to make a ruleset grant this right is to explicitly allow it
> + *   for a specific directory by adding a matching rule to the ruleset.
> + *
> + *   In particular, when using the first Landlock ABI version, Landlock will
> + *   always deny attempts to reparent files between different directories.
> + *
> + *   In addition to the source and destination directories having the
> + *   %LANDLOCK_ACCESS_FS_REFER access right, the attempted link or rename
> + *   operation must meet the following constraints:
> + *
> + *   * The reparented file may not gain more access rights in the destination
> + *     directory than it previously had in the source directory.  If this is
> + *     attempted, the operation results in an ``EXDEV`` error.
> + *
> + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for the
> + *     respective file type must be granted for the destination directory.
> + *     Otherwise, the operation results in an ``EACCES`` error.
> + *
> + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
> + *     respective file type must be granted for the source directory.  Otherwise,
> + *     the operation results in an ``EACCES`` error.
> + *
> + *   If multiple requirements are not met, the ``EACCES`` error code takes
> + *   precedence over ``EXDEV``.
>    *
>    * .. warning::
>    *
> 
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
