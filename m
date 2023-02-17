Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6196C636D6
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 19:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBQT2t (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Feb 2023 14:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQT2s (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Feb 2023 14:28:48 -0500
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2065305C1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 11:28:45 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PJMLM2NH3zMqs7f;
        Fri, 17 Feb 2023 20:28:43 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PJMLL2H68zMsJB7;
        Fri, 17 Feb 2023 20:28:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1676662123;
        bh=6rWJ8GVJca6zWRo8F6csrP13uHwk6tysTFtyAUwm1C8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=w+yIlSGEkkU7sUYT8sXxvoeOrerT19WijkbuVip/Pb11/2ogn1156pWAFh4Y7s/Vv
         ycpiar6Fi6RZabr4JUJV1dKsIDyB41t4y6J36UHZ2XTJ5srUIdrLaKtw+TarKFvcmq
         ITraEom2yoafZFDRQJQsUWN+KfsXQnOKW7eWQv3E=
Message-ID: <0e5bf1f7-47b5-382e-ae56-4556980a908b@digikod.net>
Date:   Fri, 17 Feb 2023 20:28:41 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v3] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-doc@vger.kernel.org
References: <20230216200729.12438-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230216200729.12438-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

(adding linux-doc in Cc)

On 16/02/2023 21:07, Günther Noack wrote:
> Clarify the "refer" documentation by splitting up a big paragraph of text.
> 
> - Call out specifically that the denial by default applies to ABI v1 as well.
> - Turn the three additional constraints for link/rename operations
>    into bullet points, to give it more structure.
> 
> Includes wording and semantics corrections by Mickaël Salaün.

No need to add this line, It's part of the maintainer job. ;)

> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   include/uapi/linux/landlock.h | 45 +++++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f3223f96469..e549ad6360b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -130,21 +130,36 @@ struct landlock_path_beneath_attr {
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
> + *   ABI.  This is also the only access right which is implicitly handled by any
> + *   ruleset, even if the right is not specified at the time of creating the
> + *   ruleset.  So, by default, Landlock will deny linking and reparenting files > + *   between different directories, and will only grant this right 
when it is
> + *   explicitly permitted for a directory by adding a rule.
> + *
> + *   When using the first Landlock ABI version, Landlock will always deny the
> + *   reparenting of files between different directories.
> + *
> + *   In addition to the source and destination directories having the
> + *   %LANDLOCK_ACCESS_FS_REFER access right, the attempted link or rename

Some of my suggestions are about style, so feel free to ignore them if 
you think the original is better. Anyway, I'm not a native english 
speaker either, so there are good chances I'm not correct on some 
suggestions. What about that?:

This is the only access right implicitly handled by any ruleset, even if 
this right is not specified at ruleset creation time. Reparenting files 
will then always be denied by default. Given that 
%LANDLOCK_ACCESS_FS_REFER is available since the second Landlock ABI 
version, using the first Landlock ABI version will always forbid file 
reparenting.

For these kind of link or rename actions to be possible, one or two 
rules must explicitly allow %LANDLOCK_ACCESS_FS_REFER on the source and 
the destination hierarchies. In addition, the following constraints must 
be met:


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
> base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
