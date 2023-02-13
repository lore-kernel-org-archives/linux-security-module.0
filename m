Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C294EC636CC
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Feb 2023 19:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBMTOe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Feb 2023 14:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMTOe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Feb 2023 14:14:34 -0500
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEEE20057
        for <linux-security-module@vger.kernel.org>; Mon, 13 Feb 2023 11:14:31 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PFvCn0pfDzMqWT9;
        Mon, 13 Feb 2023 20:14:29 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PFvCm0XzSzMrSB5;
        Mon, 13 Feb 2023 20:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1676315669;
        bh=8Wa1hCdi8R9DaLbjZaaW1zYJLnyOXujzClsqttMNq+w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ghNzmncwHGfwuRIiWftgEEMAZcDYZW2JlPH6qRQBsnbcgnCPIjMIU09WqSgLe5pky
         /PKqTehqMN/HtxvoZlIlcwbveUEgyFxEYUUafeMyyYAhBpX8Tpr/pInSZ7In+r52Bw
         VfOHXjgK/iwlTRPn3RPVzeK7TTF9pcQeIiGSvfWE=
Message-ID: <29b06bf8-cca7-f815-2e22-255297bf39cd@digikod.net>
Date:   Mon, 13 Feb 2023 20:14:27 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230202204623.10345-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230202204623.10345-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for the doc improvement Günther!

On 02/02/2023 21:46, Günther Noack wrote:
> Clarify the "refer" documentation by splitting up a big paragraph of text.
> 
> - Call out specifically that the denial by default applies to ABI v1 as well.
> - Turn the three additional constraints for link/rename operations
>    into bullet points, to give it more structure.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   include/uapi/linux/landlock.h | 41 ++++++++++++++++++++++-------------
>   1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f3223f96469..0cc58e0361f 100644
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
> + *   always denied by default.  If left unspecified during the creation of a
> + *   ruleset, linking and renaming files between different directories will be
> + *   forbidden, also when done on a kernel using Landlock ABI v1.

What about:
forbidden, which is also the case when using the first Landlock ABI.


> + *
> + *   In addition to permitting this access right, the following constraints
> + *   must hold for the access rights on the source and destination directory:
> + *
> + *   * The destination directory may not grant any access rights which are
> + *     forbidden in the source directory.  Otherwise, the operation results in

"forbidden to the source file."

Indeed, the check is done according to the source file and compared to 
the potential destination file. For instance, the parent source 
directory may not allow to execute the source file, but the link will be 
allowed even if the destination directory allows file execution in the 
case of the execution right being tied to the (linked) file itself.


> + *     an ``EXDEV`` error.
> + *
> + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for
> + *     the respective file type is required in the destination directory.
> + *     Otherwise, the operation results in an ``EACCES`` error.
> + *
> + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
> + *     respective file type is required in the source directory.  Otherwise,
> + *     the operation results in an ``EACCES`` error.

There is also the RENAME_EXCHANGE case when we need make and remove 
access rights in the source and in the destination directory, but it 
would probably confuse readers to specify that.


> + *
> + *   If multiple requirements are not met, the ``EACCES`` error code takes
> + *   precedence over ``EXDEV``.
>    *
>    * .. warning::
>    *
> 
> base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
