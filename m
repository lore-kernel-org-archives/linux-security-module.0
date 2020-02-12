Return-Path: <SRS0=6rCu=4A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB573C352A4
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 19:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E302206B6
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581537414;
	bh=5BhYJKA3gORqzCNRHwgf0DsrwzjD8c/aFfBMdkZL8IE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YuJNqzZB5AM6PE3KoD/d5v4afCkBAHz2FrZ0okS9hyhlsArMRlubulclH/M7G5qt+
	 vC7n8TQeeWH3SEs4UmSoForDLC+MHs038msU5g6s082z9MYgaCZe5Z4ik+pX0hXdLk
	 5s7/Lsw5wmIJWlCmjG6m9vGOb+X/ipGGmxa+qGZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgBLT4y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:56:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38688 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLT4x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Feb 2020 14:56:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so2488111lfm.5
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHXH6o1ncLcAF0HeWBgC/IvihmP9toR2+/NwDUguxaw=;
        b=F1RTR2Mk3atysxi94JEv4Vc5seMqqx02k5CmzRHPSL9IrjapbyqOHw2Fl4dXiCvUEV
         ncTWbgP69pZD/8vVK6OQciM9WRN9WfMjKk6TsKRj9cuZUdWmWVaikWPX14ZlXYji3kdw
         CWzsabp8eT8r94ZjWLxWvcikM9+qEZil4HvcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHXH6o1ncLcAF0HeWBgC/IvihmP9toR2+/NwDUguxaw=;
        b=mO5oou0Odf3qhxYw/4Ke+NoQDJ2M/MfPVFY9Y3iLtkLen0PjMsuhLvFM9ffK4XymgF
         ekWs7a1V6yqfY7CDAWmmpXwozrELYk6x8N0BKA2X642xPcvhWLmPqqx4FJFFbRlMIDma
         XhQLFjO1oj890LKDQqcAf9JUYpobzwvahX8CDBEdNlp2q0/b4S6bIMYTRrJVOubiiXh7
         JkHtDjGld4yV612g3NF1ovE+6mHLaGXU6uIjMRrlAk8rZGGrL53tZS3wtg+trpUKaUAw
         E88HIMnGhsMrW3Ucrsfb5f5aK4lobEFAdp3DBMPCpFj8Dxq/1VkrA9d+8FkVLtMusVs4
         ZLEA==
X-Gm-Message-State: APjAAAXxaA4nZB55o2EUCz2HRf9DHbejOR/DOBSJ5gjm3hOYLEBejxZd
        bMOiogIbutyF/OLAR9zNPpkV2vMmVjw=
X-Google-Smtp-Source: APXvYqwF00HMzZIeBJ+/5BJGO0oKsU+EjGSXe7Kb1nSU3fsSTg0w9bE8HfuW57XqwttPZlxstbYxug==
X-Received: by 2002:ac2:52a5:: with SMTP id r5mr7457427lfm.19.1581537411308;
        Wed, 12 Feb 2020 11:56:51 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id t10sm84530lji.61.2020.02.12.11.56.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:56:51 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id e18so3743149ljn.12
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 11:56:50 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr7333707lfm.152.1581537014849;
 Wed, 12 Feb 2020 11:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9obipk9.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 11:49:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
Message-ID: <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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

On Wed, Feb 12, 2020 at 11:18 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> > So it's just fs_info that needs to be rcu-delayed because it contains
> > that list. Or is there something else?
>
> The fundamental dcache thing we are playing with is:
>
>         dentry = d_hash_and_lookup(proc_root, &name);
>         if (dentry) {
>                 d_invalidate(dentry);
>                 dput(dentry);
>         }

Ahh. And we can't do that part under the RCU read lock. So it's not
the freeing, it's the list traversal itself.

Fair enough.

Hmm.

I wonder if we could split up d_invalidate(). It already ends up being
two phases: first the unhashing under the d_lock, and then the
recursive shrinking of parents and children.

The recursive shrinking of the parent isn't actually interesting for
the proc shrinking case: we just looked up one child, after all. So we
only care about the d_walk of the children.

So if we only did the first part under the RCU lock, and just
collected the dentries (can we perhaps then re-use the hash list to
collect them to another list?) and then did the child d_walk
afterwards?

             Linus
