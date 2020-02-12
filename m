Return-Path: <SRS0=6rCu=4A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B9CC352A4
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 21:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFA2217F4
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 21:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581541702;
	bh=7Sd9AozWdi6ADgVh+KdvO22gRmfmYpItxhoTBdpX8UE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YOfSVfc7vUi6h+b4Ovnv6ssjjr30pKDJ12m2PTNe+8R5c6rF8HbPU8d9uoxFsWINe
	 vF5BYwlp1KnvyQ++FBnSygP/39RtXQVkF754eri7zo/PG2NzB2uUmNTNzugXDWaKDi
	 5hDmaWAJvmW/WRONkujGCGiID7QD4MDo+8yJrVWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBLVIW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:08:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43977 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgBLVIW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Feb 2020 16:08:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so4044283edb.10
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 13:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WySKsoF25f/J4EpIF80nlYeN07mmY9MX1gph6T2llNA=;
        b=Q58W0NiVVgTX+oNnbx2yak8H3LqZJhOMXKR6Ng/loJu7bqEx0qJqJdUgYoD/Insl5V
         0bdfWlwpi7ZWdHerxvV1fP32PeO3Q+Sr+beCxumaLAw59xU5UE6TavPtsaLJeIdwxKCP
         /m8KW47+oG3MYjz8Wo+heg9mc0RztoSq3bL84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WySKsoF25f/J4EpIF80nlYeN07mmY9MX1gph6T2llNA=;
        b=KBBGrXGZv2xPXL7N9cndRvNYs/InuDD7oC/bTfaTsmN7ImBrJoo46xMCwdXNeZNh9t
         AYNRBmq9QMhp//3zSTa1fnf7JM74+fUViCb2r88Q9G0bqGglKW+Ezpo/Qc2B59gacaKf
         1gyAACZzLuEf5EdsViESIe4GPW4/3OCnU5eicQPHqXZ3h6aaJHRolNijai7369PjeRU3
         5EdcmAD9rbuT0KoKSWyTRFjh7k/p6X3VkVt9qyBC+JHGTQWhTtd88CIrIyDXY/w4Ml1T
         dVwtqctwS2mnDOUTgETvKJSCxG0XuFu3TsRPnJLN7bZdzbK3K+zzbAksvqBvTBFIzWu4
         7Afg==
X-Gm-Message-State: APjAAAUnNioTjjX9YrkUYsJH+8JBjqaNhzXlqzbmnMjWf0SFkbLgR4UU
        kfuwFBXKzxz7817wpecTqFshExUYoHs=
X-Google-Smtp-Source: APXvYqw4SC3HdiHIagIN3unxKPD1szE7nyoKag7GRtH6vEH4hlzACWjQ/qViHD9u/1EptK2iVkxz2A==
X-Received: by 2002:a50:a864:: with SMTP id j91mr12802703edc.318.1581541700431;
        Wed, 12 Feb 2020 13:08:20 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id c24sm27303eds.40.2020.02.12.13.08.20
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 13:08:20 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id y11so4115909wrt.6
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 13:08:20 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr8729073ljj.241.1581541376733;
 Wed, 12 Feb 2020 13:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200212204124.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 13:02:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
Message-ID: <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
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

On Wed, Feb 12, 2020 at 12:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Feb 12, 2020 at 08:38:33PM +0000, Al Viro wrote:
> >
> > Wait, I thought the whole point of that had been to allow multiple
> > procfs instances for the same userns?  Confused...
>
> s/userns/pidns/, sorry

Right, but we still hold the ref to it here...

[ Looks more ]

Oooh. No we don't. Exactly because we don't hold the lock, only the
rcu lifetime, the ref can go away from under us. I see what your
concern is.

Ouch, this is more painful than I expected - the code flow looked so
simple. I really wanted to avoid a new lock during process shutdown,
because that has always been somewhat painful.

            Linus
