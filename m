Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D033C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Dec 2021 21:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhLQVrk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Dec 2021 16:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhLQVrj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Dec 2021 16:47:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52188C06173F
        for <linux-security-module@vger.kernel.org>; Fri, 17 Dec 2021 13:47:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bm14so76709edb.5
        for <linux-security-module@vger.kernel.org>; Fri, 17 Dec 2021 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YVjp7krYySQqC7CQqhrlLalS/tCzUZljrfIOgYw9c8=;
        b=ds0Or9hUQyHWLCwuDzWn0BKOyesMRrRWFAKar1GQ2Glri5544c68TYGrWEXROYpOzL
         3HFDKHjNGSZ9FTZxNFcCLsbmtVOfzMJBKlb4ukSA7MWWGzaKNuseZyUbLT1hCeuSu72c
         t3oVGGJ/WmgNaZQxKCKLDJRhLacQipu6zfyGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YVjp7krYySQqC7CQqhrlLalS/tCzUZljrfIOgYw9c8=;
        b=oFNZ2FpxAJKS1/nRsZcaaABVhtMuB9aRXNRB1XvaZ9shnbmqLJgWAMXF/UeQHPqJhG
         NRri6fTSTPWbwxQ4ThxFrmsHmzlHbH9hCykNCl9obUog2jH8SwA4aBb6myqOu9X1GBli
         OSbHBx8VktH7W8sil/Z/Ei15KFlpHuo55gUWD+lmDbly8wpkuimJN9lYWhdpLjwPlaXB
         X1MjcVx4MS8qBfBs75RFED2Kji5SAceKFq4YdtabCfbkq2zj2ZCYPkJmUdwcyWadQsk4
         5d8ZPdDXn1xzlfC5hbpvgPspQXBqE7LYHWE/xRraDNW6k2D7hVfpv8yeKfrft//zCto/
         TICg==
X-Gm-Message-State: AOAM532FRjoJiiSJJl5hrkQsF9qLobghVtWos+o2D1o9y5wCpOvzyu6E
        fjej9736wyLXtlVu0/vidbW9MBUN6dUjhzMYnUA=
X-Google-Smtp-Source: ABdhPJyWgCUCOjJKh2Ah5cyoSQwc7Xffgn3Hx35TJID2sTEtxGnXFVN9hRV07+Acf1nXPQsuSNCBOQ==
X-Received: by 2002:a05:6402:2888:: with SMTP id eg8mr4480613edb.383.1639777657681;
        Fri, 17 Dec 2021 13:47:37 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id hq29sm3191699ejc.224.2021.12.17.13.47.36
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 13:47:37 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id j9so6593855wrc.0
        for <linux-security-module@vger.kernel.org>; Fri, 17 Dec 2021 13:47:36 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr3990177wrp.442.1639777656558;
 Fri, 17 Dec 2021 13:47:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
 <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com> <CAN-5tyEKGQu1Y=o8KfsX3q9NkP4XZRos5stwmrT=ZV1hr1fWrQ@mail.gmail.com>
In-Reply-To: <CAN-5tyEKGQu1Y=o8KfsX3q9NkP4XZRos5stwmrT=ZV1hr1fWrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 13:47:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiDT0aZO6UFnb9sW4rfuxp4xfPTSydnifVgL6H8b5Rb4Q@mail.gmail.com>
Message-ID: <CAHk-=wiDT0aZO6UFnb9sW4rfuxp4xfPTSydnifVgL6H8b5Rb4Q@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.16 (#3)
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 17, 2021 at 1:08 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Can you please elaborate on what is problematic with the two patches
> you've highlighted.

Commit ec1ade6a0448 ("nfs: account for selinux security context when
deciding to share superblock") adds the call to
security_sb_mnt_opts_compat() from the nfs_compare_mount_options()
function.

But nfs_compare_mount_options() is called from nfs_compare_super(),
which is used as the the "test" callback function for the "sget_fc()"
call:

        s = sget_fc(fc, compare_super, nfs_set_super);

and sget_fc() traverses all the mounted filesystems of this type -
while holding the superblock lock that protects that list.

So nfs_compare_super() may not sleep. It's called while holding a very
core low-level lock, and it really is supposed to only do a "test".
Not some complex operation that may do dynamic memory allocations and
sleep.

Yet that is exactly what security_sb_mnt_opts_compat() does, as done
in 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an
existing mount").

So those two patches are completely broken.

Now, commit cc274ae7763d ("selinux: fix sleeping function called from
invalid context") that I just merged "fixes" this by making the
allocations in parse_sid() be GFP_NOWAIT.

That is a *HORRIBLE* fix. It's a horrible fix because

 (a) GFP_NOWAIT can fail very easily, causing the mount to randomly
fail for non-obvious reasons.

 (b) even when it doesn't fail, you really shouldn't do things like
this under a very core spinlock.

Also, the original place - nfs_compare_mount_options() is called over
and over for each mount, so you're parsing those same mount options
over and over again. So not only was this sequence buggy, it's really
not very smart to begin with.

That's why I say that a much better approach would have been to parse
the mount options _once_ at the beginning, saving them off in some
temporary supoerblock (or whatever - anything that can hold those
pre-parsed mount options), and then have the "test" callback literally
just check those parsed options.

That's not necessarily the only way to go about this - there are
probably other approaches too, I didn't really think too much about
this. But those two commits on their own are buggy, and the fix is
somewhat problematic too.

                     Linus
