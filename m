Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23219C00144
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jul 2022 10:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiG2Kte (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiG2Ktd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jul 2022 06:49:33 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4081238A5
        for <linux-security-module@vger.kernel.org>; Fri, 29 Jul 2022 03:49:32 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LvPQy4mnkzMqN4n;
        Fri, 29 Jul 2022 12:49:30 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LvPQy22YWzlqwsd;
        Fri, 29 Jul 2022 12:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659091770;
        bh=r+xXx39JPgnwVgdK8Y3U4PBGTxLOIMg5oIHhE6BFq6U=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=kC1rl4+dZMSSNurC/i+zVARWlOwx7me2UCc8l39CHNXN15rJemGP9MJjo8nMwD2hg
         u/jQUMOhYqEXj1F09e9kuVUpyBWf1BtDap+Auq59DRELvmIB13u+JQgL9EeAqf8Jh7
         C6taHEJia1L5YPnd+kTPf1xpIsn9NQ9aI1EubCOI=
Message-ID: <77116641-4f5f-f152-4032-d83011b05d97@digikod.net>
Date:   Fri, 29 Jul 2022 12:49:29 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
 <20220712211405.14705-2-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v2 1/4] landlock: Support file truncation
In-Reply-To: <20220712211405.14705-2-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 12/07/2022 23:14, Günther Noack wrote:

[...]

> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 23df4e0e8ace..9ca7f9d0d862 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -96,7 +96,12 @@ struct landlock_path_beneath_attr {
>    *
>    * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
>    * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
> + *   Note that you might additionally need the LANDLOCK_ACCESS_FS_TRUNCATE
> + *   right in order to overwrite files with open(2) using O_TRUNC or creat(2).

Please use the :manpage: notation for syscalls.


>    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file through file truncation
> + *   APIs like truncate(2), ftruncate(2), open(2) with O_TRUNC or creat(2).
> + *   This access right is available since the third version of the Landlock ABI.
>    *
>    * A directory can receive access rights related to files or directories.  The
>    * following access right is applied to the directory itself, and the
> @@ -139,10 +144,9 @@ struct landlock_path_beneath_attr {
>    *
>    *   It is currently not possible to restrict some file-related actions
>    *   accessible through these syscall families: :manpage:`chdir(2)`,
> - *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
> - *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
> - *   :manpage:`utime(2)`, :manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
> - *   :manpage:`access(2)`.
> + *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> + *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> + *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
>    *   Future Landlock evolutions will enable to restrict them.
>    */
>   /* clang-format off */
