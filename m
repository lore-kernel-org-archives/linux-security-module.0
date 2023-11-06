Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103DEC4167D
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Nov 2023 22:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjKFWyD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Nov 2023 17:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjKFWyC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 17:54:02 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27421D73
        for <linux-security-module@vger.kernel.org>; Mon,  6 Nov 2023 14:54:00 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so5294759276.2
        for <linux-security-module@vger.kernel.org>; Mon, 06 Nov 2023 14:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699311239; x=1699916039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNKybQWPnk2Ce8tjd4ygA9PCEAcyMepwChQ21Wxo49Q=;
        b=eS+gVTHOwbaUhdRE2dcKKt55Br7rVqShiRidyy+yAC/sib5+Y6z+jJw/7zz3H/A/iD
         nZC/jSSLjzpON8CNt/CNCVYA94y7GJHmvfJ4reO1gV8DgSPqQuB7jclC9+ea7bA1dhTz
         2Wu3MXwztn6JtVVxfUMNOgf+OGd0YOcoe1SCn/FlLa9qNPeg5dT5BD052XoKfYBTevGn
         r8uVAGE1GxzFO2UveSBXaRrEQozSOi/tWLKONU1bxpCjxNAn2JsRs4KrP3nrV+mAGnpJ
         E0ITzg0NO59aaBfWzLapGQnFpcLhZa+ktVAnw8QLqh1wRqMdtIVXNet9NOds6NmUXXI+
         V0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311239; x=1699916039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNKybQWPnk2Ce8tjd4ygA9PCEAcyMepwChQ21Wxo49Q=;
        b=FM0PzZz+rLdRruHKAQyCmIPBKyUE9YIXBpBAIosS2C/61d+2k6OeO1ReCzAvRIEwPH
         x2triWqWCTkeAGv6EK5GtDOD7T/XP9h8GdAH8f66xSUHTwSoqMqphRdgEuoSoSl4KjxJ
         aR7g+iAu4fSdhbHJYQdeDp6LyPd4iOMRSTcF71tcwIJH/ayKO7b5NyalRwdEnvUmKJIy
         NtQj9Un84g8ZK6lBbTJ07y3UOazsZWNZgyl05AZsQnwlN4iHQmD6Dh05qB8SMcoKO1W5
         Z8GsVnzPxoTWMNkS3dWVVQa9Nun+rHQTJhI8fnz7YydAiD8ELXJpmq/BKbjIVlsAzH20
         d/xg==
X-Gm-Message-State: AOJu0YwqcT4nKGAMQ6eIMM2CRD0DdIXbrK6gK3JGPDET+chUAzEEujxl
        qXxmwQIhfBWUJnXxkfXURDWr1qaMsOa4cmC762u9
X-Google-Smtp-Source: AGHT+IHZtlkskeIKbm+EW0uQZXkwuE4jHHoiiwhdcK0HgQeq6o4GqdUA6KYYEVVg4c/cz32HA+X7WbYUN1vLqa6WKCE=
X-Received: by 2002:a25:d186:0:b0:d9a:3bf1:35e9 with SMTP id
 i128-20020a25d186000000b00d9a3bf135e9mr30012463ybg.3.1699311239327; Mon, 06
 Nov 2023 14:53:59 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cfe6f305ee84ff1f@google.com> <000000000000a8d8e7060977b741@google.com>
In-Reply-To: <000000000000a8d8e7060977b741@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Nov 2023 17:53:48 -0500
Message-ID: <CAHC9VhTFs=AHtsdzas-XXq2-Ub4V9Tbkcp4_HBspmGaARzWanw@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
To:     syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com,
        syzkaller@googlegroups.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 6, 2023 at 3:34=E2=80=AFAM syzbot
<syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> Author: Roberto Sassu <roberto.sassu@huawei.com>
> Date:   Fri Mar 31 12:32:18 2023 +0000
>
>     reiserfs: Add security prefix to xattr name in reiserfs_security_writ=
e()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14d0b78768=
0000
> start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kern=
e..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D16d0b78768=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12d0b78768000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D93ac5233c1382=
49e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc319bb5b1014113=
a92cf
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D113f3717680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D154985ef68000=
0
>
> Reported-by: syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com
> Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reis=
erfs_security_write()")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Hi Roberto,

I know you were looking at this over the summer[1], did you ever find
a resolution to this?  If not, what do you think of just dropping
security xattr support on reiserfs?  Normally that wouldn't be
something we could consider, but given the likelihood that this hadn't
been working in *years* (if ever), and reiserfs is deprecated, I think
this is a viable option if there isn't an obvious fix.

[1] https://lore.kernel.org/linux-security-module/CAHC9VhTM0a7jnhxpCyonepcf=
WbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com/

--=20
paul-moore.com
