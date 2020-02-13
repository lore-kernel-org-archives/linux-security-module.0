Return-Path: <SRS0=7Hmq=4B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCEC352A4
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Feb 2020 00:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F3F20714
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Feb 2020 00:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581555334;
	bh=4uvldRuyIv1cDszKDs6APHQYKSaXNPxB+JSUbcUjM54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uU6rPkTAa1JBqMFRqBB3r4+kGw3OdQRt+PfVsY0j+uScjX2dO7nwxbOe/KgH6vUgN
	 jn3B4tX4Q85VPTzXqThaXOYDUuNnhvYaPl4bbpx03B9cMSyjeoVRH1c9nEnxp24DzZ
	 LVrk4hVwM0w1XsINK1CuTY79T6FLbM8mf1LSyz+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgBMAzd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:55:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34935 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgBMAzc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Feb 2020 19:55:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so4691508edv.2
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 16:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqI0VbPVaJfcsCTXac52W5YMJCYaSOj7FaTDjIsxYoQ=;
        b=RRc0XamveMQXj/q8pfpDyw3+6RSQiI77zx4rXZCf1ovpx19fhSLX9IAuu7EAbdT6D5
         hRgPzQzTBFhOQsMCJ5pC8fUtChqlceueXHqMOFdtZldjIC/GLh+J70scUbbfpK2vng/u
         uee+XaR52NHzT1hMiW+QFymxjV6nraNw8Kd1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqI0VbPVaJfcsCTXac52W5YMJCYaSOj7FaTDjIsxYoQ=;
        b=R0Y/NuH33Oax3aMQjHLTbNlVU414RuH9C9gi9EDoE4VPuk0mULhIlINlgaJLLLy+Xq
         cVFU2te5bclJmnMXE1EYouplERmpsBgBiXCXGWVqzdYVSShg66TcHBFaAEZfndL8wwNH
         ps4hLa2SOAMDNK4GP36XkpvbNGd8eFpKst52e3+TwrKveuHJYWOkLDIAj2M7qHuGwxm8
         zBqeqEh7IEgxYHtuLFUz0ftrxtZ5hIPaO3UEWEz886qar5865Dt4ppU21Uo5sYmpxaL0
         yoPZ3qQGAFY7po/sSN67B2EAgyKx/KLyZ+vUqjyGX78Na0GjQbbfjlQReARKRWgUJejD
         GqCw==
X-Gm-Message-State: APjAAAXnWSx8Mchxb3lwKraS/4rx56/IEpjAfguLzFEl8zN251/ILYbh
        Zt10nfKS8RwSCu7lwaDlV8GlLLHqJEQ=
X-Google-Smtp-Source: APXvYqyemWARYqwDGk5DzzO5zDGo8Ms88v6x2wAVhvhc3BiaxpCfAwD9ewtWnHhKvuhlzAUuZoEGNA==
X-Received: by 2002:aa7:d856:: with SMTP id f22mr12304064eds.61.1581555330694;
        Wed, 12 Feb 2020 16:55:30 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id f25sm50559ejx.33.2020.02.12.16.55.30
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 16:55:30 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id f8so4691441edv.2
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 16:55:30 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr9459753ljb.150.1581554910763;
 Wed, 12 Feb 2020 16:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com> <87lfp7h422.fsf@x220.int.ebiederm.org>
In-Reply-To: <87lfp7h422.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 16:48:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
Message-ID: <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 12, 2020 at 1:48 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The good news is proc_flush_task isn't exactly called from process exit.
> proc_flush_task is called during zombie clean up. AKA release_task.

Yeah, that at least avoids some of the nasty locking while dying debug problems.

But the one I was more worried about was actually the lock contention
issue with lots of processes. The lock is basically a single global
lock in many situations - yes, it's technically per-ns, but in a lot
of cases you really only have one namespace anyway.

And we've had problems with global locks in this area before, notably
the one you call out:

> Further after proc_flush_task does it's thing the code goes
> and does "write_lock_irq(&task_list_lock);"

Yeah, so it's not introducing a new issue, but it is potentially
making something we already know is bad even worse.

> What would be downside of having a mutex for a list of proc superblocks?
> A mutex that is taken for both reading and writing the list.

That's what the original patch actually was, and I was hoping we could
avoid that thing.

An rwsem would be possibly better, since most cases by far are likely
about reading.

And yes, I'm very aware of the task_list_lock, but it's literally why
I don't want to make a new one.

I'm _hoping_ we can some day come up with something better than task_list_lock.

            Linus
