Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7C0C433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Nov 2022 20:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiKNUQH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNUQG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Nov 2022 15:16:06 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CCAD80
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 12:16:04 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id v81so12631181oie.5
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ4DceovIvniI/E7qgKtkp+mPXifQZS21MtlnZ7xnPs=;
        b=KI63xJmFi3GEaRs6lSZAeHLr3CTF5DF8CLWsAwCOawP3h7eLV/aX5rkfqg7SAI7yrz
         Ytj/i10DoFbe1O9NHtwb8fhHuQ8Rl5lBNhb/5YkETrkzowz2e7tPzbnlvmC8S4Rihiqc
         0l2/lBQqKE+xGmfodZxaZss5DIaG2oPE9kNDWYb3kO0MEGrVX0FYy+m5R29ZMb/JsHCE
         sd4t5RJI0LFRECpwAguxhiHpjLHIN0VeTZV1CYEQkvhxdN2oHMdav8JAVpdFl4Ap8wN/
         /BKrHDBDbwZSObmHC5OuMKyn29KXmX0SsZxl/eU+XaTdPL5H6Ts5HGQKgJ3i0WK8Na26
         V68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZ4DceovIvniI/E7qgKtkp+mPXifQZS21MtlnZ7xnPs=;
        b=IGgp/gyJaFprSAYoSV23qpZ48BLGDhqWRjBdVa9i52dR9sU0hIL5c4D5X64X/7tOVC
         NY9YYxS1N9/e+j0oBBnR4RaBpUf7eD3AhIEXUFe2t9H/GXeIVeLVWpFY0AFqhEl4m/um
         ysD896BWf/jj3GnWJLnmjrefdoLGnt12agvGmAcXcpzWZnJ612w4+TljHgXhT+JzDyc/
         hWCpayaveSnEo93EBRdamATiRKVx+Boor6eURzr0SRwWNwQsjXRgkECM1hMsZzfJ1aVF
         5+132QnRmwCBigqRMaOdcvyw4ukT7vweH3gxbjoYs4TM0+w+x/8fwwYdYpwiAYQ+Ndo4
         F6bQ==
X-Gm-Message-State: ANoB5pku/rSZwE597smjZznZ2RuHuydFXTfvYvp+wmzq+zOt+lGsd3qd
        ZaoIF3svZDGYvU/I7nmYulskR2P7uMaf0/b7mgKnng==
X-Google-Smtp-Source: AA0mqf6NXAYFJNCUyD3mZ+1ZXmQUxVXXOwtemxrUobtj0DML/MLAUW5C9IeaYdL6bdRlxky7GuvlEVrQHrNwjleHB3k=
X-Received: by 2002:a05:6808:3011:b0:35a:7e1d:3d72 with SMTP id
 ay17-20020a056808301100b0035a7e1d3d72mr6809975oib.233.1668456963311; Mon, 14
 Nov 2022 12:16:03 -0800 (PST)
MIME-Version: 1.0
References: <00000000000061fe2205ed6300fa@google.com> <Y3KU5kwa2XGS9gyy@hoboy.vegasvil.org>
In-Reply-To: <Y3KU5kwa2XGS9gyy@hoboy.vegasvil.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Nov 2022 21:15:51 +0100
Message-ID: <CACT4Y+ZqTQ1gy7Vu8Hsy8tmXa+EC43jYaNxG40biNy3d-rmMmg@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in smack_inode_permission
To:     Richard Cochran <richardcochran@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     syzbot <syzbot+0f89bd13eaceccc0e126@syzkaller.appspotmail.com>,
        casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        paul@paul-moore.com, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 14 Nov 2022 at 20:20, Richard Cochran <richardcochran@gmail.com> wrote:
>
> On Sun, Nov 13, 2022 at 04:05:47PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    56751c56c2a2 Merge branch 'for-next/fixes' into for-kernelci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11fc8b0e880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0f89bd13eaceccc0e126
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a691fa880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1733c5b9880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/cf4668c75dea/disk-56751c56.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e1ef82e91ef7/vmlinux-56751c56.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3dabe076170f/Image-56751c56.gz.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0f89bd13eaceccc0e126@syzkaller.appspotmail.com
>
> Why was this email addressed to me?

Hi Richard,

You are listed as maintainer for the file this crash was attributed to:

$ ./scripts/get_maintainer.pl -f security/smack/smack_lsm.c
...
Richard Cochran <richardcochran@gmail.com> (maintainer:PTP HARDWARE
CLOCK SUPPORT)
...

Also see:
https://lore.kernel.org/all/Y279BqPNYAr+5OxC@sol.localdomain/
