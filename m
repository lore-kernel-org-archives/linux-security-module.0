Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F02C63777
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Nov 2020 07:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD02722240
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Nov 2020 07:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqqdXLzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgKUHA2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 21 Nov 2020 02:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgKUHA1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 21 Nov 2020 02:00:27 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51216C061A4D
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 23:00:27 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id l10so12433765lji.4
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 23:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7RjcsAj6PX+UJP0fflQn8MvjwEMgqrgy1hcrPo11aE=;
        b=CqqdXLzD4RSHdi1Ar3pP94BnBGH2/7bkpPzT9SZ3UVxCKNiRlNpe2RQapzql1gIm0T
         am2xz+0cm1WQPK4hE+ua1jVGF9VC83UFcIaMXQypAw6jE5utgWdZxOUYUFylOjfHEs4k
         cbp452z2BIJGzCSR/2hAGhsY0QSIsJEbDk4heZBZkmBlDwTtBd/AS/iCd8874yBuTf5T
         QD+koJXBJ9jZQb3KOZ/bZx4j7vb4L3rrLTabgKItYXXLtwSGDtDG7O0HsRGP6T2iCLK+
         GNND4eZIvTwEJpJW7cZw1UxpXIjICH63bduH7dU7mXrLoZSkTtgZZS91V8myLILWnfZq
         nenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7RjcsAj6PX+UJP0fflQn8MvjwEMgqrgy1hcrPo11aE=;
        b=IhhVo7qbqweQx+lJCZahz7hDNWwhMY3eoAPiypi8S9m5UHe7FxcvKBvoQL4ga0lwFO
         bQYrBPv2BMFjcXY6fnVbyCvHY4iiglp/mSjCgqRjM0nLs+W1hfJ8Ml/UJ5A58Vh6qLHJ
         Xb6qpARiQZmtZsgAMoiB83EFwCVMv3ADAlHPUGuGUJNl4PfGL1wM9ETngNIefcYvoWUR
         drbRKX7khkj60ksvpFJ44jdAZJwMVv3qsNtOMbfA84oOOjR8e8DiVfbvw5NMAf6Enw6E
         xjDMmZ/lHxJsfOSJqI8aQd8nq7Vcf3l518GRb7tzQQ57xu3WJ7tBlPJnHbGHVWIlK/cn
         4W2g==
X-Gm-Message-State: AOAM533qaWKTcxHTmalPR/0nUfyNMAjdXhj+UUCAqVph155OZP9lMDx3
        U3Mi3eVmjCUMEBaB3KNlAgGdV+4dNqgUM6vEb6n3kw==
X-Google-Smtp-Source: ABdhPJye0kUCNabvyYI/kru6Sk+gDfuo1c3+OQCYedsONLwptjC7PC4GO6R82FjXNTZ0iHwPOIZ11/4ebb/ZeEYyrjQ=
X-Received: by 2002:a2e:8891:: with SMTP id k17mr8949700lji.326.1605942025591;
 Fri, 20 Nov 2020 23:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-9-mic@digikod.net>
In-Reply-To: <20201112205141.775752-9-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 08:00:00 +0100
Message-ID: <CAG48ez28mn2YH65D67sr22Ur25kdNUchDbfuph+0TJ4iPwwvwg@mail.gmail.com>
Subject: Re: [PATCH v24 08/12] landlock: Add syscall implementations
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 12, 2020 at 9:52 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> These 3 system calls are designed to be used by unprivileged processes
> to sandbox themselves:
> * landlock_create_ruleset(2): Creates a ruleset and returns its file
>   descriptor.
> * landlock_add_rule(2): Adds a rule (e.g. file hierarchy access) to a
>   ruleset, identified by the dedicated file descriptor.
> * landlock_enforce_ruleset_current(2): Enforces a ruleset on the current
>   thread and its future children (similar to seccomp).  This syscall has
>   the same usage restrictions as seccomp(2): the caller must have the
>   no_new_privs attribute set or have CAP_SYS_ADMIN in the current user
>   namespace.
>
> All these syscalls have a "flags" argument (not currently used) to
> enable extensibility.
>
> Here are the motivations for these new syscalls:
> * A sandboxed process may not have access to file systems, including
>   /dev, /sys or /proc, but it should still be able to add more
>   restrictions to itself.
> * Neither prctl(2) nor seccomp(2) (which was used in a previous version)
>   fit well with the current definition of a Landlock security policy.
>
> All passed structs (attributes) are checked at build time to ensure that
> they don't contain holes and that they are aligned the same way for each
> architecture.
>
> See the user and kernel documentation for more details (provided by a
> following commit):
> * Documentation/userspace-api/landlock.rst
> * Documentation/security/landlock.rst
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>

Reviewed-by: Jann Horn <jannh@google.com>
