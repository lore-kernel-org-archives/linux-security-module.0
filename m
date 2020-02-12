Return-Path: <SRS0=6rCu=4A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1335DC352A4
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 20:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEF92173E
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581539728;
	bh=iOg40SPFaflkL01eQ3QKOZ5KkBFX3OXuFa2Vt/XxJmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sqHPPgBaf5jjFkhMAbspMCfJrrnZ7S95voGAKBs0gInHNLZM4glifYhC9E3oA+MQf
	 KprTJgwxpt0cc4ZcKpz9RQ9lbBLlfZCzzyi8S9zQT+RQaGpcxhtl65VF8f6UJAWJNl
	 rkIGyPFFunEw3keV9EU3huh+PUtqn6Dc+iJhDwbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBLUf1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:35:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33382 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLUf1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Feb 2020 15:35:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so2591205lfl.0
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 12:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqyVLATGO6MwZ1NPxpHKDD7nGLBCP8OMxbpMcz0c8xI=;
        b=IgiKGasrvpx5KEqTjK3uSOaiUPZJr6oQaxEeiUKRSC7Mzut+kfrtuMYf7JfgJYo2j9
         r6YHIpl0Oomh/U1TMzjQtQYQDvEFopln06zrn/G9JdYxAN1cr+G4MM7V+yIgIdgHmkT5
         mB2IAKAHrGr3Dq04+09yh6iga9CCs4Dv6Lzfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqyVLATGO6MwZ1NPxpHKDD7nGLBCP8OMxbpMcz0c8xI=;
        b=iWbkkvlhfqppJQ6VdXBhqNHawTIji1Y+/umMjRzyG5lJA5HZTadRi1oVsedD5uR5lN
         6xx0RQhZnMz2KThB73J7EpROemubtRB8zEYAp/bCDpYZtxdjAnuWqgpFCeB74Yi/kmDE
         +fWP9AxwoYSUF96ZyVHHgDDZaagof9CogXMZ62Eupys13wMuIJidkut5Tsq2wtFE4h95
         3PmRaucIrI/Z1WE+fr364b931Y2QZsfqaNZXzf3iy3BvUDbe1YdxqbB3+D9o/OWkcaGK
         rcMLzDemfueOSWsrRO/BOblas1zZigC5EFMNSLdrzVuDcmODrz0ipvTAnFWsv/vPyUnY
         ITYg==
X-Gm-Message-State: APjAAAWo1sXk3LiAN+WLTl2cPlE5A4Yil2u/ZVJ8EPn/Qx4JPQOI8/mZ
        yoU29Ejkp4JUv1amJ0XDEiN9o/ERsBM=
X-Google-Smtp-Source: APXvYqxN2L0DWRLwxbqHZs+6nEP6NgHnD95JLHhM2t3DRMjkNL+tvi+TwLRD8VyyR5wHS/BCZ/ryYg==
X-Received: by 2002:a19:f00d:: with SMTP id p13mr7451739lfc.37.1581539723504;
        Wed, 12 Feb 2020 12:35:23 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d4sm103709lfn.42.2020.02.12.12.35.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:35:21 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id q8so3921064ljb.2
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 12:35:21 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr9321452ljj.265.1581539720898;
 Wed, 12 Feb 2020 12:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk>
In-Reply-To: <20200212200335.GO23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 12:35:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Message-ID: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
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

On Wed, Feb 12, 2020 at 12:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What's to prevent racing with fs shutdown while you are doing the second part?

I was thinking that only the proc_flush_task() code would do this.

And that holds a ref to the vfsmount through upid->ns.

So I wasn't suggesting doing this in general - just splitting up the
implementation of d_invalidate() so that proc_flush_task_mnt() could
delay the complex part to after having traversed the RCU-protected
list.

But hey - I missed this part of the problem originally, so maybe I'm
just missing something else this time. Wouldn't be the first time.

               Linus
