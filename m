Return-Path: <SRS0=0oss=4I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81349C11D00
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 23:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370E208E4
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582240048;
	bh=npUvA3Z4rYmLdHA5oXZiFkJuo1vKCyirh+g/aJDCmjc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K7cwJrtvQd8mTyS0/YpDCcU3FfDCZ3ioI9N5PTiq2642dGH7J8yHataNNs8O4lb7K
	 Puhrc6q1Ne2o47IG6ZWdvRzPRxJLCxRs3uoDLYwuSmQFpLIrSEOqmO343uRQNHRiVP
	 52eZ8WCJX650bCUufIwLJgRrgOeTfAYxNwTXZaGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgBTXH1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:07:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35482 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBTXH1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Feb 2020 18:07:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id c7so67091edu.2
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oW+dHyuXcdgcpFOp9rkCYNNzyvxL/1mmVUWMW1tVkn8=;
        b=HsJYplXHj9WIosfuyYDxgCIpizr4Q2QTncG0r8kQoBcqx1jdtsR9fFVeYAPGlhnI5Y
         7UWBHhKU9LT9oEd08VowjnmWRULPbdq+faWGzRjHU4lCzwffnnc4X3O8+YTbupxrOXam
         he3lTa6POmGxUb6ylyx451mYPhWfQQq6/MfdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oW+dHyuXcdgcpFOp9rkCYNNzyvxL/1mmVUWMW1tVkn8=;
        b=fO0OtkhOblCsgRrsrpKdWq8NmmuTYT6+6Xms+PdGKJOkrZDMaOIL/K9HgFrzHyPzuJ
         RLXhnxN7E/pBkOTP+COatVqJ/ZPKyZ18nlVGLps/rnrDSV4Z5Ubz0Kto23Mj/eUsfTCj
         EGlQlTkcFklpic+GM+AKYnRv/7o0khuwQkm9WCRGkxfktL58WwaNpO0qGFd2JRXk0PyR
         X9EiXPuZLLck0oydNJTtC4oFkKe0QqNVogbGWxplEHaFjDgH+CB7BfMKGkektSWN/k3C
         kcgcFQg6hlgMtml0Zdyzija7H9QAG0Cyf46065hmykYh8x6mIb9u7o4jtjVjvc4hZVc0
         ldtQ==
X-Gm-Message-State: APjAAAV2cPVJ9f7k9Ypitux9/1cUTJs40Gl+6gdSUloZMl3IJs6qSKY9
        eUTScjQd382eIrKVYlb36Iy62sMNOsc=
X-Google-Smtp-Source: APXvYqw2OBklHoEnWIFHijodz8xVzJR+CJ+5vQQHEW5MN5TqM6YGZa+DP5EP/9Fu368DR4vFS6RjFw==
X-Received: by 2002:a17:906:3793:: with SMTP id n19mr32128617ejc.85.1582240044426;
        Thu, 20 Feb 2020 15:07:24 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id s14sm94692edx.12.2020.02.20.15.07.24
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:07:24 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id r11so6441054wrq.10
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 15:07:24 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20496205ljk.201.1582239629960;
 Thu, 20 Feb 2020 15:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87blpt9e6m.fsf_-_@x220.int.ebiederm.org> <20200220225420.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220225420.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 15:00:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPwMTTaGtphubBXeiKitKigutddx9Fcp4Sf1sw4tpyeA@mail.gmail.com>
Message-ID: <CAHk-=whPwMTTaGtphubBXeiKitKigutddx9Fcp4Sf1sw4tpyeA@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Thu, Feb 20, 2020 at 2:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> s/no inode.*/it's a directory inode./

That actually makes my worry go away too. We don't allow aliases for
directory inodes, iirc.

So then it doesn't depend on some /proc implementation issue any more,
then it's fundamental that there's only one dentry.

            Linus
