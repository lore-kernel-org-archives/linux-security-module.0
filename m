Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE0EC25B06
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Aug 2022 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiHKRP0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiHKROr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Aug 2022 13:14:47 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD3EA6
        for <linux-security-module@vger.kernel.org>; Thu, 11 Aug 2022 09:59:31 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M3Y1t1RrqzMqNP5;
        Thu, 11 Aug 2022 18:59:30 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4M3Y1s2yH3zln8Vd;
        Thu, 11 Aug 2022 18:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660237170;
        bh=LSlcy2SLvMkGTKXYuNvaBfeuyw7ATcD4CeV8gpzoDQ0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=dEUQJhS26w7CbWzHz6pue1x3aAcbSQfmsqisr8ntWmKizc8G4ZzHeL0gV3BoQSBGn
         L22DQObhJQlY/8v2FGGpyunl9TlPvC0d6NX1/QUEz6ZQm2lED4+feo+JMO/VkWdPj9
         ezE6U0ZR2PR7D0Uq2EE6q6xAfNtU5hScAw+vVJoM=
Message-ID: <a9c9124c-84a3-da5e-23f1-3eecf0b226ce@digikod.net>
Date:   Thu, 11 Aug 2022 18:59:28 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
 <20220804193746.9161-2-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v3 1/4] landlock: Support file truncation
In-Reply-To: <20220804193746.9161-2-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 04/08/2022 21:37, Günther Noack wrote:
> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> 
> This flag hooks into the path_truncate LSM hook and covers file
> truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
> well as creat().
> 
> This change also increments the Landlock ABI version, updates
> corresponding selftests, and includes minor documentation changes to
> document the flag.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   Documentation/userspace-api/landlock.rst     |  6 ++++++
>   include/uapi/linux/landlock.h                | 17 ++++++++++++-----
>   security/landlock/fs.c                       |  9 ++++++++-
>   security/landlock/limits.h                   |  2 +-
>   security/landlock/syscalls.c                 |  2 +-
>   tools/testing/selftests/landlock/base_test.c |  2 +-
>   tools/testing/selftests/landlock/fs_test.c   |  7 ++++---
>   7 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index b8ea59493964..d92e335380d4 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -380,6 +380,12 @@ by the Documentation/admin-guide/cgroup-v1/memory.rst.
>   Previous limitations
>   ====================
>   
> +File truncation (ABI < 3)
> +-------------------------
> +
> +File truncation could not be denied before the third Landlock ABI, so it is
> +always allowed when using a kernel that only supports the first or second ABI.

I think this addition could make the documentation more consistent and 
helpful:

Starting with the Landlock ABI version 3, it is now possible to securely
control truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE`
access right.


> +
>   File renaming and linking (ABI 1)
>   ---------------------------------
>   
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 23df4e0e8ace..1beb8289708d 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -95,8 +95,15 @@ struct landlock_path_beneath_attr {
>    * A file can only receive these access rights:
>    *
>    * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> - * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
> + * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> + *   you might additionally need the LANDLOCK_ACCESS_FS_TRUNCATE right in order

Please use backquotes for code such as `LANDLOCK_ACCESS_FS_TRUNCATE`, 
`O_TRUNC`…


> + *   to overwrite files with :manpage:`open(2)` using O_TRUNC or
> + *   :manpage:`creat(2)`.
>    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file through file truncation APIs
> + *   like :manpage:`truncate(2)`, :manpage:`ftruncate(2)`, or
> + *   :manpage:`open(2)` with O_TRUNC or :manpage:`creat(2)`. This access right
> + *   is available since the third version of the Landlock ABI.
>    *
>    * A directory can receive access rights related to files or directories.  The
>    * following access right is applied to the directory itself, and the
> @@ -139,10 +146,9 @@ struct landlock_path_beneath_attr {
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
