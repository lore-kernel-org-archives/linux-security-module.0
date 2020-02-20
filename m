Return-Path: <SRS0=0oss=4I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4C1C11D24
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 22:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C2B207FD
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582238325;
	bh=mzPiCbr8XYsvkRVHCAOzgYnZ6/GsVqT7alkkqsg2qmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ty8OrQqgHaZjCHbmqGW+a74NINSbRDLxmcx+/kcSCahnMfBW9jzRlfgNwrRLMwLsT
	 uvoZ64vl1MCmxlONkif7VimvBrxhpRoX5a7KgvYnqxSbEnDu2QqGv7OUvEOl45E2Zm
	 PfzExAovi5AhGcprh5ar5/uYaPws3qD0SfseKjYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgBTWip (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:38:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45609 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgBTWip (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Feb 2020 17:38:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so35612760edw.12
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrNmlOpMVxzFXh2A2oJzXRWZK2fGDe1+SPIAN4gWybk=;
        b=QiMLUGsRq9HWg+G+gXiEaS3g8vcEPOTXS0nkdYQXIsCA2EjphiI1+TGu1HVJ3od+BY
         4nIUXqbNSwvfL1zzmPatevn6ccupRjp+aZGa5eL8bOeMqUiv7Bg7Hz5IKilERFOA99sS
         jMLLQ3OrRmjEMgFi9TJzZnDfd0rXWYetgu1bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrNmlOpMVxzFXh2A2oJzXRWZK2fGDe1+SPIAN4gWybk=;
        b=Br/WF4U0jl5Cw4+C1GcF83SuKBkPPKrOPXkcBlLpM6FHvXNlK9Jvb2iMZg7sQFeb+w
         pKdwEzGG2IovS1zsT6P4X66lGc9VNGZeS1o4E5ZLGNu32FDRbLRqzcZI338meyFKwxml
         blEiHGSd5sYwYKhgs1NNTtaQaJbdHGDkgraYE38FxcEYpYHKHq4P+XMByiOUCm1PDClV
         t0ozegB7qVrU/2WVqirE+N0RY+hJWYXJsXmNg5DJzYFGRPt2CGxMTgvs2ooDhVkjpF6T
         azMvrSGaZXCvIPlgATe0sZM7kj/R7F3LmObf96Vwo/u8jD6DGFOC5qF6XN41MNlsnr/D
         bIPA==
X-Gm-Message-State: APjAAAUsQRpoAXO47rvVjBhRkQgy6qBC9NkoSTSvX8Mxt3tRJCVPkFt1
        8+dstFIlqZXNMdHG2x+OkTWfWJUizz0=
X-Google-Smtp-Source: APXvYqyqq2M16F0MyjG2Lsqm3xabrNyrStVdWw1nMLhcGNWXNPmcvfKrjl9CAgqge8Y8Pr0voh41Xg==
X-Received: by 2002:aa7:c2cb:: with SMTP id m11mr31567606edp.89.1582238321779;
        Thu, 20 Feb 2020 14:38:41 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id k6sm86236edi.68.2020.02.20.14.38.41
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:38:41 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id dc19so35601857edb.10
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2020 14:38:41 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr19716647ljj.241.1582238006401;
 Thu, 20 Feb 2020 14:33:26 -0800 (PST)
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
 <87h7zl9e7u.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87h7zl9e7u.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:33:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wht3ZWRaYs8QBXuftfuiFGOTjjZ9zj3-Dz7dkiBhJNBrQ@mail.gmail.com>
Message-ID: <CAHk-=wht3ZWRaYs8QBXuftfuiFGOTjjZ9zj3-Dz7dkiBhJNBrQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] proc: Mov rcu_read_(lock|unlock) in proc_prune_siblings_dcache
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
> Don't make it look like rcu_read_lock is held over the entire loop
> instead just take the rcu_read_lock over the part of the loop that
> matters.  This makes the intent of the code a little clearer.

No, this is horrid.

Maybe it makes the intent clearer, but it also causes that "continue"
case to unlock and relock immediately.

And maybe that case never triggers, and that's ok. But then it needs a
big comment about it.

              Linus
