Return-Path: <SRS0=iK7v=36=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8113EC3B186
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Feb 2020 19:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CE020870
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Feb 2020 19:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJTXN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:23:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35746 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTXN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Feb 2020 14:23:13 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Ee6-00AWd4-KS; Mon, 10 Feb 2020 19:23:02 +0000
Date:   Mon, 10 Feb 2020 19:23:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
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
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs
 instances
Message-ID: <20200210192302.GI23230@ZenIV.linux.org.uk>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <CAHk-=wh05FniF0xJYqcFrmGeCvOJUqR0UL4jTC-_LvpsfNCkNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh05FniF0xJYqcFrmGeCvOJUqR0UL4jTC-_LvpsfNCkNw@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 10, 2020 at 09:46:26AM -0800, Linus Torvalds wrote:
> On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> >
> > This allows to flush dcache entries of a task on multiple procfs mounts
> > per pid namespace.
> >
> > The RCU lock is used because the number of reads at the task exit time
> > is much larger than the number of procfs mounts.
> 
> Ok, this looks better to me than the previous version.
> 
> But that may be the "pee-in-the-snow" effect, and I _really_ want
> others to take a good look at the whole series.
> 
> The right people seem to be cc'd, but this is pretty core, and /proc
> has a tendency to cause interesting issues because of how it's
> involved in a lot of areas indirectly.
> 
> Al, Oleg, Andy, Eric?

Will check tonight (ears-deep in sorting out the old branches right now)
