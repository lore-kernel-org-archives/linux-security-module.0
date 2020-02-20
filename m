Return-Path: <SRS0=0oss=4I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40B2C11D00
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 22:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D8A207FD
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 22:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582238965;
	bh=+Jk8ZLGepwfSKBz/r/AeAIirnEIPybIoNRaHLfpkM8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eZ/iQVQLmfpS5+1HmJs/ScY+eGeBL7BiGYO/5SjOOhozJ2CNqFpi00qPUznSukgtR
	 cqED8yVSUm6v7N0IDKUl47FFn5HkC3UOg+2TVya5GN+2GJryklbqfPdkd+OT56TTIO
	 u/7DeaVH3Gkw8owf8Lhd6f0GBUsys1rYVQeiNGhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgBTWtZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:49:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38188 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgBTWtZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Feb 2020 17:49:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id p23so5253edr.5
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsBAqEZQag0ypHqg0PyTqrCBxrLtLK/vf3m5Pbo+Q1I=;
        b=HocGqZaPvPbj2Rc3tHfIsXtvsU9ZExNqDhyGTd1FkLfg2CixXSIhWg+lhtFLFy7LH5
         Ll9ajjeSCLGyVGJFCP3pr8MzRIUlhdaSf4zT2trYK3NmUY7kfmF8q56qyO7AFc70i6vi
         mx1gRvncgXwtZTQp0OujHwfoGsQovufSXPaY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsBAqEZQag0ypHqg0PyTqrCBxrLtLK/vf3m5Pbo+Q1I=;
        b=V7fHnPfyLso48PAVdhQeon8LZKdNu9eNPWQ6GVcYoekGu2f7F7B2lvcCUKSHFyDnv8
         adaiOwg9wj34YrYUGD68+lMSLYcZY+ws4ranCc/xg4xfdsNVPlVzYBDM7QP/mi3m0g6d
         wA5eIBzFQmatBcWc8HNiZRq2pM6UAs08M8rA2sVWjEmla0i9mfdnLXNrJT6qONCmZs4x
         AOY7Bg7cLvTmwjDmKjGQ81CZKdeigEESbQwuHwRkDnkfEJoUlAVlDLQxwmIaDIvmQIFf
         G+E9+oNJ1K0+hkWhb7rccVVVOV8c+Vv7Fb5FhJeflTmcyPiF+I7xgJvJxu++LDJVYeJ9
         QfTg==
X-Gm-Message-State: APjAAAWOJvtjaLq4P9ymgyr6j7E7k5Eno0bkDD+/C8PF+fIDRb8+4Xji
        4k+f5Au+Bd3vOSIASSYXToXdsRZKSYE=
X-Google-Smtp-Source: APXvYqwTU5njjRK+5GT/qPKgPgVzJHUgzwJVv2RY0gMImCRrQkFaAo6NcfovU2caXXTwUIfSJhl1gA==
X-Received: by 2002:a05:6402:1e1:: with SMTP id i1mr30357240edy.338.1582238962822;
        Thu, 20 Feb 2020 14:49:22 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id d9sm89599edp.97.2020.02.20.14.49.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:49:22 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id v28so35639708edw.12
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 14:49:22 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20465844ljk.201.1582238633679;
 Thu, 20 Feb 2020 14:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:43:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmwfv6zGwTRR8zTyTdfxgYoc7SE3Z0nKHu_srG_8NPWw@mail.gmail.com>
Message-ID: <CAHk-=whmwfv6zGwTRR8zTyTdfxgYoc7SE3Z0nKHu_srG_8NPWw@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
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

On Thu, Feb 20, 2020 at 12:51 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> To use d_invalidate replace d_prune_aliases with d_find_alias
> followed by d_invalidate and dput.  This is safe and complete
> because no inode in proc has any hardlinks or aliases.

Are you sure you can't create them some way?  This makes em go "what
if we had multiple dentries associated with that inode?" Then the code
would just invalidate the first one.

I guess we don't have export_operations or anything like that, but
this makes me worry...

            Linus
