Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953A2C761AF
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Apr 2023 15:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjDBPOt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 2 Apr 2023 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjDBPOs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 2 Apr 2023 11:14:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD17D50C
        for <linux-security-module@vger.kernel.org>; Sun,  2 Apr 2023 08:14:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-545e907790fso391796627b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 02 Apr 2023 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680448484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srtxwhfavuNLVEqBKCn0HkTlKyHJRXfd1PAURlkq5Mk=;
        b=MYlRKoZjIVEJvrRebWhj3FgQYhVKAb/y7cpWCSsNWAQ/Kkroh4+nCrEmh1ssgfrqI5
         IN3wHyxU1XyjYtV4gKmMtGNzowAWze2L8X22m23Y1PCasSarEWHz5N/4t5As59R+eGOv
         AHcEqvY9sy6gvlG3aqZST+s72xGqnwVjdLj3lTy9l6tV7DC/W91iaRVzZCfB36Y+0SzF
         Wwi6/EQ4IklUOERei0aziwqjPyXfSwya4MOy8e1M9tfZdF8Ja2o3kQC52mB4kxRWYLBe
         ryind48KuriOh1gAaysj0ZrbnOxbUJuAkeJEPVwmgRndAo4g7pGlV+vCm5v25gi3k4Ez
         Q04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680448484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srtxwhfavuNLVEqBKCn0HkTlKyHJRXfd1PAURlkq5Mk=;
        b=Z+qbK/8SdytjosuTCtwzshWvBXhjIjnZRcTc6jyCJb7yi05jOB0fWWQ9lbT95qe2CR
         hRSA0w1wQbeZCAQ0oDbRYVj06tHT3unKrHmg/LMjtf9PsmFzR6014e0UAsz06blMFvHR
         dP3YdCRtmRjoMaNPPKcVqOTLTuIh19tv/GQxI4ZlTERkJ489KXIUtd4K1ZiKkSchYxv9
         abZSZbFP9S6KW0pI/1OudMkl4xA/8MwFTcCKuHj8IgUP1QHtvvu+qwnZwX6+upWnCaGz
         p0XGamS8kTchlLH+4aWRnzifw6K/b4r1tPhpB5MAcnCMRG0iyuGyCmwQXAaTr2eciUe/
         0gjw==
X-Gm-Message-State: AAQBX9cFpDWRAc327b6bfFm1QAc8Wm9LDPTrSkHHLBRVy03Srl2L26cf
        UlBlqYrYbSKdwBx08Ys/BRHtwohucINbowqMCnA1
X-Google-Smtp-Source: AKy350YSjuNDcAkojlLSrUIjjzjLFIiJd19uP62Gr/lJkvV88NkI1CAKw68Mu9Tl8eVz3JmzAqDGaWChmc0v32j5ZgE=
X-Received: by 2002:a81:bc0c:0:b0:545:612a:c04a with SMTP id
 a12-20020a81bc0c000000b00545612ac04amr15852261ywi.8.1680448483967; Sun, 02
 Apr 2023 08:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230401214151.1243189-1-vvidic@valentin-vidic.from.hr>
In-Reply-To: <20230401214151.1243189-1-vvidic@valentin-vidic.from.hr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 2 Apr 2023 11:14:33 -0400
Message-ID: <CAHC9VhT6VXwybScqsnYHHtbHNPoWMVQJzQ7VAccm2MWZEz+5Dw@mail.gmail.com>
Subject: Re: [PATCH] security, lsm: security_old_inode_init_security() Handle
 multi LSM registration
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Apr 1, 2023 at 5:42=E2=80=AFPM Valentin Vidic
<vvidic@valentin-vidic.from.hr> wrote:
>
> Copying files to an ocfs2 filesystem causes a crash with NULL pointer
> dereference in strlen.
>
> [   27.386786] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [   27.386818] #PF: supervisor read access in kernel mode
> [   27.386832] #PF: error_code(0x0000) - not-present page
> [   27.386844] PGD 0 P4D 0=3D20
> [   27.386855] Oops: 0000 [#1] PREEMPT SMP PTI
> [   27.386867] CPU: 0 PID: 1792 Comm: cp Not tainted 6.1.0-5-amd64 #1  De=
bian 6.1.12-1
> [   27.386887] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.14.0-2 04/01/2014
> [   27.386904] RIP: 0010:strlen+0x0/0x20
> [   27.386928] Code: b6 07 38 d0 74 14 48 83 c7 01 84 c0 74 05 48 39 f7 7=
5 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 <=
80> 3f 00 74 14 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 cc
> [   27.386966] RSP: 0018:ffffa33340e4fbc0 EFLAGS: 00010202
> [   27.386980] RAX: ffff8b578c3b1800 RBX: 0000000000000001 RCX: 000000000=
0000000
> [   27.386996] RDX: 0000000000000100 RSI: ffff8b57843d86e8 RDI: 000000000=
0000000
> [   27.387012] RBP: ffff8b57849ca608 R08: ffffa33340e4fc7c R09: ffffa3334=
0e4fc84
> [   27.387027] R10: ffff8b578f1e6000 R11: ffffa33340e4fc80 R12: ffffa3334=
0e4fcb8
> [   27.387043] R13: ffffa33340e4fc84 R14: 00000000000041c0 R15: ffffa3334=
0e4fc7c
> [   27.387059] FS:  00007f7b36d50500(0000) GS:ffff8b57bec00000(0000) knlG=
S:0000000000000000
> [   27.387077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   27.387091] CR2: 0000000000000000 CR3: 000000003cfe2003 CR4: 000000000=
0370ef0
> [   27.387111] Call Trace:
> [   27.387130]  <TASK>
> [   27.387141]  ocfs2_calc_xattr_init+0x7d/0x330 [ocfs2]
> [   27.387382]  ocfs2_mknod+0x471/0x1020 [ocfs2]
> [   27.387471]  ? preempt_count_add+0x6a/0xa0
> [   27.387487]  ? _raw_spin_lock+0x13/0x40
> [   27.387506]  ocfs2_mkdir+0x44/0x130 [ocfs2]
> [   27.387583]  ? security_inode_mkdir+0x3e/0x70
> [   27.387598]  vfs_mkdir+0x9c/0x140
> [   27.387617]  do_mkdirat+0x142/0x170
> [   27.387631]  __x64_sys_mkdirat+0x47/0x80
> [   27.387643]  do_syscall_64+0x58/0xc0
> [   27.387659]  ? vfs_fstatat+0x5b/0x70
> [   27.387671]  ? __do_sys_newfstatat+0x3f/0x80
> [   27.387684]  ? fpregs_assert_state_consistent+0x22/0x50
> [   27.387698]  ? exit_to_user_mode_prepare+0x3c/0x1c0
> [   27.387712]  ? syscall_exit_to_user_mode+0x17/0x40
> [   27.387726]  ? do_syscall_64+0x67/0xc0
> [   27.387738]  ? exit_to_user_mode_prepare+0x3c/0x1c0
> [   27.387752]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Similar to security_dentry_init_security fix in 7f5056b9e7b, the problem
> is that ocfs2 checks the return code from security_old_inode_init_securit=
y
> and if the return code is 0, it assumes everything is fine and continues
> to call strlen(name), which crashes.
>
> Typically SELinux LSM returns 0 and sets name to "security.selinux" and
> it is not a problem. Or if SELinux is not compiled in or disabled, it
> returns -EOPNOTSUP and ocfs2 deals with it.
>
> However if BPF LSM is enabled, it registeres every hook and returns the
> default return value, in this case 0.
>
> This patch copies the behaviour of security_dentry_init_security() to
> allow only one LSM to initialize security context (or return the default
> value of -EOPNOTSUP).
>
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  security/security.c           | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)

Hi Valentin,

Thanks for the problem report and a patch.  It's always good to get
bug reports, and it's even better when they come with a patch :)

If you have the time, could you try a patch we have queued up in the
lsm/next branch?  We are in the process of removing
security_old_inode_init_security() and transitioning all the callers
over to security_inode_init_security(), and I believe the ocfs2 patch
for this should solve the problem you are seeing, can you test it on
your system and let us know?

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/patch/?id=
=3Dde3004c874e740304cc4f4a83d6200acb511bbda

--=20
paul-moore.com
