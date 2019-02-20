Return-Path: <SRS0=vYSA=Q3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E48C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 16:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2D42146E
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 16:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOj1Su+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfBTQYO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:24:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40427 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfBTQYO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Feb 2019 11:24:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id v20so9139904otk.7
        for <linux-security-module@vger.kernel.org>; Wed, 20 Feb 2019 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORGrnK1trmprAnL0JcpQ8ytTugD6+mY9UlqHdbFcRbE=;
        b=bOj1Su+fxfKmJLfSPKrYbJLHXwDgaRZNBoiKi50SaBBxFE978KqUSQmFMOnXs/N96Z
         FOwW4G0q7eXSQX82ESxfSKOLg1alKIy5InZkDhitvyGt0Zu5J+o6IxiZqszYUZrJ1CY4
         SyAuJm7t24A/aQOiz80hnaydSm3qeJoaEP2voHX1E8FwfM55YCWe+t5kqPQKkj/p21lq
         JZz6ughapR9fobrLPUaCxqsFnL6di81ptOa4U99oL75Jv/uT8RVwpV4cw1DZvQaj3Fz2
         iQSzJcooJuwQeVVoW3lRxhbG5GfpruDA70gU0HBuq1RJOjSnEcSBfHEUJPK3sofwC1A3
         WsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORGrnK1trmprAnL0JcpQ8ytTugD6+mY9UlqHdbFcRbE=;
        b=pOK3PwL19TL0TLfTFwsRmdJNpXG7wUHEY3UtZHltn2tTCucQsoaeZhd1CrXC+6YFqc
         qoBb673dxalo4lsviQO2w3uODyNXN4cO8IddFAarC8qJ2WQsj/HUIkr3pw6MZrSSSxww
         9YcJpS37uzgKSE0QGB9199JF72MG6NwlkUIKmvKwu1APxiHuwg7fdH9MltugYqInMdLV
         FEP0gbiMXTbS4CJNyHepvXhwvyEzBxMsaxumM4qDc0eRE6/xE4jIK3aGbwuqOTd2LvW9
         ROt0kzjK0CHgNOzxICDv/YYMXIyX6IMz+bI58U5FZ+TucurKVI8mQbQAvHMc738vLmyw
         YnUw==
X-Gm-Message-State: AHQUAuZ1RSlVwW9pKvgh1ZjI3tDFtuKjnu5XGwYSJZSfju98dwZ0d50P
        aZpZl4RPozkefLOZQhXGx1zaaITsbFyRuAnf9k0MAQ==
X-Google-Smtp-Source: AHgI3IZCKcQNOHqTzTXMF8klABaoKRKGastNJI10WOxRUkQyb7sKZ25RArcWvque84hD9QY6+UhF6Y6FwvPRDGqT4Og=
X-Received: by 2002:a9d:6c84:: with SMTP id c4mr15170293otr.242.1550679853054;
 Wed, 20 Feb 2019 08:24:13 -0800 (PST)
MIME-Version: 1.0
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Feb 2019 17:23:46 +0100
Message-ID: <CAG48ez0fvv4CT5S7xgW92Ouad8N-r9RY89QbUwRVYd9DLKePiw@mail.gmail.com>
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts around
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 19, 2019 at 6:08 PM David Howells <dhowells@redhat.com> wrote:
> Add a move_mount() system call that will move a mount from one place to
> another and, in the next commit, allow to attach an unattached mount tree.
>
> The new system call looks like the following:
>
>         int move_mount(int from_dfd, const char *from_path,
>                        int to_dfd, const char *to_path,
>                        unsigned int flags);
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
[...]
> +/*
> + * Move a mount from one place to another.
> + *
> + * Note the flags value is a combination of MOVE_MOUNT_* flags.
> + */
> +SYSCALL_DEFINE5(move_mount,
> +               int, from_dfd, const char *, from_pathname,
> +               int, to_dfd, const char *, to_pathname,
> +               unsigned int, flags)
> +{
> +       struct path from_path, to_path;
> +       unsigned int lflags;
> +       int ret = 0;
> +
> +       if (!may_mount())
> +               return -EPERM;
> +
> +       if (flags & ~MOVE_MOUNT__MASK)
> +               return -EINVAL;
> +
> +       /* If someone gives a pathname, they aren't permitted to move
> +        * from an fd that requires unmount as we can't get at the flag
> +        * to clear it afterwards.
> +        */
> +       lflags = 0;
> +       if (flags & MOVE_MOUNT_F_SYMLINKS)      lflags |= LOOKUP_FOLLOW;
> +       if (flags & MOVE_MOUNT_F_AUTOMOUNTS)    lflags |= LOOKUP_AUTOMOUNT;
> +       if (flags & MOVE_MOUNT_F_EMPTY_PATH)    lflags |= LOOKUP_EMPTY;
> +
> +       ret = user_path_at(from_dfd, from_pathname, lflags, &from_path);
> +       if (ret < 0)
> +               return ret;
> +
> +       lflags = 0;
> +       if (flags & MOVE_MOUNT_T_SYMLINKS)      lflags |= LOOKUP_FOLLOW;
> +       if (flags & MOVE_MOUNT_T_AUTOMOUNTS)    lflags |= LOOKUP_AUTOMOUNT;
> +       if (flags & MOVE_MOUNT_T_EMPTY_PATH)    lflags |= LOOKUP_EMPTY;
> +
> +       ret = user_path_at(to_dfd, to_pathname, lflags, &to_path);
> +       if (ret < 0)
> +               goto out_from;
> +
> +       ret = security_move_mount(&from_path, &to_path);
> +       if (ret < 0)
> +               goto out_to;

Wouldn't you want to call this from do_move_mount() instead for
consistency? If MS_MOVE and this thing perform the same logical
operation, they should probably also call the same LSM hook.

> +       ret = do_move_mount(&from_path, &to_path);
> +
> +out_to:
> +       path_put(&to_path);
> +out_from:
> +       path_put(&from_path);
> +       return ret;
> +}
[...]
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index fd7ae2e7eccf..3634e065836c 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -61,4 +61,15 @@
>  #define OPEN_TREE_CLONE                1               /* Clone the target tree and attach the clone */
>  #define OPEN_TREE_CLOEXEC      O_CLOEXEC       /* Close the file on execve() */
>
> +/*
> + * move_mount() flags.
> + */
> +#define MOVE_MOUNT_F_SYMLINKS          0x00000001 /* Follow symlinks on from path */

"Follow symlinks" sounds a bit misleading. LOOKUP_NOFOLLOW only
applies to the last element of the path; and there is a pending
patchset that's going to let userspace ask the kernel to actually not
follow *any* symlinks on the path with O_NOSYMLINKS, so this might
confuse people. Maybe change the comment to "don't follow trailing
symlink", or something like that?
