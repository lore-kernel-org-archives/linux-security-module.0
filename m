Return-Path: <SRS0=6rCu=4A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D05C352A4
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF83B2073C
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Feb 2020 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581533496;
	bh=s0rQQJgReY1pvJWTDvRS2Q9eLU7aX05/Am/N2h5REPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iVfWG7QOz3JcbAi1X5xcCJGypg6OfADB20pwnyDxVyJX+l0/S4XUbVfeh1X6ldPH/
	 cfURlmCtTDIhYQxLea/JKRsyePsCbATkNxLe8qNqtwYHjVaepOc+8i2v4UhejSRIJy
	 BkwywI+uFdn/FRxfTWF3uZyo1rcJjbcMwTU8naVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLSvg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:51:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42937 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSvf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Feb 2020 13:51:35 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so3613521edv.9
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 10:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8S2w7jKfhj8nqr2BEN6cbFr7nckGF3MBI5pTAOk2Bgk=;
        b=E/vN3AE3iyzGDOzjrhIyYOh5wyK5H3COrkDAy4Yb/0fuIwlyf50yEW7S/x5cDf9tHW
         zWbCuDLoLaAGtRSBjikTyE8yY06byotE/cGEhEbxOklsxfNCa9G0PsCjeYAs62WP1DSa
         M2BG1IabKnVo1IvqnOENDDauUUlMg+SJyMK4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8S2w7jKfhj8nqr2BEN6cbFr7nckGF3MBI5pTAOk2Bgk=;
        b=da6TYjClB4naS/BP2Tzbm0Yx53vt/0qotlT1EmmYtbcPunaaPOaZbzbV1PmvSxgA8L
         AupurjRhYg5ppHNTCrQ61HRTG2BRAfSDpN++5s7fvlCkjcAyIQwLnECDh3otNe4SktjY
         mUjjSFX/6ltkEyZK/Mqbz3ClKuSY9b7K8HoLiuu2OklD649tWvpNIa5zvNs9D0F00Cw9
         zArTV3u/GWCIfHsRP+sD4EfLxYLUGKT/jOTvwghF/j7S0IrXL+L2S1cV+W7qqMLArt5q
         9EaGqGW5o8wf/aOfjwNlgsVjmFrbAOEI+Y26zZYF/CN2NZ5n9IiWoQUC9MozConibNq5
         pzzQ==
X-Gm-Message-State: APjAAAXmbrzaHxkYM6D8Arsl2mMzJJNs7WnvCIfqz8OLnAF/kn8eB/GQ
        ntCCHuZ41NRh4EuLraTyoSU4A/ANGKc=
X-Google-Smtp-Source: APXvYqxjI8NMfUXIu4e6vvr1bopwdno/jlEyZ9iXZ1fZ3Wqonriz1r1QASSmhNYbpmIXdVYj7mzcXA==
X-Received: by 2002:a17:906:af4b:: with SMTP id ly11mr12642730ejb.220.1581533492873;
        Wed, 12 Feb 2020 10:51:32 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id u13sm100102ejz.69.2020.02.12.10.51.32
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 10:51:32 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id w15so3686154wru.4
        for <linux-security-module@vger.kernel.org>; Wed, 12 Feb 2020 10:51:32 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr8440902ljj.241.1581533122702;
 Wed, 12 Feb 2020 10:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6> <87tv3vkg1a.fsf@x220.int.ebiederm.org>
In-Reply-To: <87tv3vkg1a.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 10:45:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
Message-ID: <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
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

On Wed, Feb 12, 2020 at 7:01 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Fundamentally proc_flush_task is an optimization.  Just getting rid of
> dentries earlier.  At least at one point it was an important
> optimization because the old process dentries would just sit around
> doing nothing for anyone.

I'm pretty sure it's still important. It's very easy to generate a
_ton_ of dentries with /proc.

> I wonder if instead of invalidating specific dentries we could instead
> fire wake up a shrinker and point it at one or more instances of proc.

It shouldn't be the dentries themselves that are a freeing problem.
They're being RCU-free'd anyway because of lookup. It's the
proc_mounts list that is the problem, isn't it?

So it's just fs_info that needs to be rcu-delayed because it contains
that list. Or is there something else?

               Linus
