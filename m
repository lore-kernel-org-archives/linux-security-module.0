Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805E146A74
	for <linux-security-module@vger.kernel.org>; Mon,  8 Apr 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612769; cv=none; b=J7sttnrhVK8zW1vXGSQWaF2TefP5cM2upO7wah3S4as/7dBvrhPOvfDmmn+l8E8/nogXZ1Z1Nr/bxdYYU5S6Ey0dO8Jj4buKvNPrlFXOF0v25NuorfwbgAoGMVFj19ToOlhs0ya4xglbYuD0bx6miYxj/Eh3esl5DLkAVKu9H2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612769; c=relaxed/simple;
	bh=9ABO3c0UjVjIYc013WjvRVFngW1d5iZVTdDmCrObzK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iz9nAhiT71EiVn3u7Pc0UbzL5dfgiRj2jv7LIJbAXLOCu1sjjnGb7otAkhAGXbPsmyFLHqP1kAgGmDy+zd+ZVH3steAv9I439RMCekBed3Gi9ZO5Yo6hj3MA6LfhCd0mSQRNu7sW4bbw4NX4k+pbqeVMVwh3sif0FwImZw1cAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf7jmwJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf7jmwJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1437EC43609
	for <linux-security-module@vger.kernel.org>; Mon,  8 Apr 2024 21:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712612769;
	bh=9ABO3c0UjVjIYc013WjvRVFngW1d5iZVTdDmCrObzK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xf7jmwJLDM4TrdEuQtY/sSW0Gg9St5bvMBeGArkzYmZ5ytFfHauaQ/yNYuqrztu0n
	 uXVPdzx5ZyaQvYzElhCnCf9XZjrUJnePsSEyOs2DqNTfzfqYcfe1TCHLqbRZAY9Tkm
	 Z5XQLE1r9rVcxBzCzZfd01QyYHN/5bGcdL0EGUYzAe5kpke/jQayrc4xeN+1pLTlRq
	 lHSxsqDWDLbLKaAElQl+TyMtPkFgFRPYRVwK/qSc0BUWcFpZRUH2nklp9AQHLFEigL
	 d+n4Cn24448u6/2U4HQtXnge+0tjvpK3hMCbdZCpDpK1CFTwHpbXGzRDO4RHi26uMe
	 qpyt0RtQGhNDg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d6e23253so3514528e87.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2024 14:46:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGPAQsKQyWqfdd+llxhg9jFX/xU9wksli4PvCi8rDc5ERtM7yABjfeicQph2xhFjS0EzE4DB964CoF9kRPA83rQBjUsRCGe1dhS+vMy7WEYPPY3iiK
X-Gm-Message-State: AOJu0Yx48AskmH0mXv9q7mYM/JnUmly4MXyHbGI36pFrWAYHPF7IG83h
	VJwbew/giFe8k4aGCXEVbUzOC0oW1pxwv4vy0GWlbPrzJzzUMlr5i0T1JH9OXdRc7LCuj7d0vqY
	tjIW9x82z1KLI3Bz0usUxz2d8ougRwJhP/tfT
X-Google-Smtp-Source: AGHT+IHJ+XtD7tDCkZpGl1evOjdhfWeZ4ZrpLRuPzB9DALdbIUfgBBnkIt58/Z758DfdMQoP7wzjIaY3xpjJEH4Azo0=
X-Received: by 2002:ac2:4c17:0:b0:515:d445:6c13 with SMTP id
 t23-20020ac24c17000000b00515d4456c13mr6438478lfq.32.1712612767200; Mon, 08
 Apr 2024 14:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325095653.1720123-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240325095653.1720123-1-xukuohai@huaweicloud.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 8 Apr 2024 23:45:56 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6fZ0mc+A2hJfD4+6EkasrOwy_Ygw=CMg0KZYdm8Fao7A@mail.gmail.com>
Message-ID: <CACYkzJ6fZ0mc+A2hJfD4+6EkasrOwy_Ygw=CMg0KZYdm8Fao7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] Add check for bpf lsm return value
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Florent Revest <revest@chromium.org>, Brendan Jackman <jackmanb@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:53=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> A bpf prog returning positive number attached to file_alloc_security hook
> will make kernel panic.
>
> Here is a panic log:
>
> [  441.235774] BUG: kernel NULL pointer dereference, address: 00000000000=
009
> [  441.236748] #PF: supervisor write access in kernel mode
> [  441.237429] #PF: error_code(0x0002) - not-present page
> [  441.238119] PGD 800000000b02f067 P4D 800000000b02f067 PUD b031067 PMD =
0
> [  441.238990] Oops: 0002 [#1] PREEMPT SMP PTI
> [  441.239546] CPU: 0 PID: 347 Comm: loader Not tainted 6.8.0-rc6-gafe0cb=
f23373 #22
> [  441.240496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.15.0-0-g2dd4b4
> [  441.241933] RIP: 0010:alloc_file+0x4b/0x190
> [  441.242485] Code: 8b 04 25 c0 3c 1f 00 48 8b b0 30 0c 00 00 e8 9c fe f=
f ff 48 3d 00 f0 ff fb
> [  441.244820] RSP: 0018:ffffc90000c67c40 EFLAGS: 00010203
> [  441.245484] RAX: ffff888006a891a0 RBX: ffffffff8223bd00 RCX: 000000003=
5b08000
> [  441.246391] RDX: ffff88800b95f7b0 RSI: 00000000001fc110 RDI: f089cd0b8=
088ffff
> [  441.247294] RBP: ffffc90000c67c58 R08: 0000000000000001 R09: 000000000=
0000001
> [  441.248209] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000=
0000001
> [  441.249108] R13: ffffc90000c67c78 R14: ffffffff8223bd00 R15: fffffffff=
ffffff4
> [  441.250007] FS:  00000000005f3300(0000) GS:ffff88803ec00000(0000) knlG=
S:0000000000000000
> [  441.251053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  441.251788] CR2: 00000000000001a9 CR3: 000000000bdc4003 CR4: 000000000=
0170ef0
> [  441.252688] Call Trace:
> [  441.253011]  <TASK>
> [  441.253296]  ? __die+0x24/0x70
> [  441.253702]  ? page_fault_oops+0x15b/0x480
> [  441.254236]  ? fixup_exception+0x26/0x330
> [  441.254750]  ? exc_page_fault+0x6d/0x1c0
> [  441.255257]  ? asm_exc_page_fault+0x26/0x30
> [  441.255792]  ? alloc_file+0x4b/0x190
> [  441.256257]  alloc_file_pseudo+0x9f/0xf0
> [  441.256760]  __anon_inode_getfile+0x87/0x190
> [  441.257311]  ? lock_release+0x14e/0x3f0
> [  441.257808]  bpf_link_prime+0xe8/0x1d0
> [  441.258315]  bpf_tracing_prog_attach+0x311/0x570
> [  441.258916]  ? __pfx_bpf_lsm_file_alloc_security+0x10/0x10
> [  441.259605]  __sys_bpf+0x1bb7/0x2dc0
> [  441.260070]  __x64_sys_bpf+0x20/0x30
> [  441.260533]  do_syscall_64+0x72/0x140
> [  441.261004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [  441.261643] RIP: 0033:0x4b0349
> [  441.262045] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 4=
8 89 f8 48 89 f7 48 88
> [  441.264355] RSP: 002b:00007fff74daee38 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000141
> [  441.265293] RAX: ffffffffffffffda RBX: 00007fff74daef30 RCX: 000000000=
04b0349
> [  441.266187] RDX: 0000000000000040 RSI: 00007fff74daee50 RDI: 000000000=
000001c
> [  441.267114] RBP: 000000000000001b R08: 00000000005ef820 R09: 000000000=
0000000
> [  441.268018] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000004
> [  441.268907] R13: 0000000000000004 R14: 00000000005ef018 R15: 000000000=
04004e8
>
> The reason is that the positive number returned by bpf prog is not a
> valid errno, and could not be filtered out with IS_ERR which is used by
> the file system to check errors. As a result, the filesystem mistakenly
> uses this random positive number as file pointer, causing panic.
>
> To fix this issue, there are two schemes:
>
> 1. Modify the calling sites of file_alloc_security to take positive
>    return values as zero.
>
> 2. Make the bpf verifier to ensure no unpredicted value returned by
>    lsm bpf prog.
>
> Considering that hook file_alloc_security never returned positive number
> before bpf lsm was introduced, and other lsm hooks may have the same
> problem, scheme 2 is more reasonable.
>
> So this patch set adds lsm return value check in verifier to fix it.
>
> v2:
> fix bpf ci failure
>
> v1:
> https://lore.kernel.org/bpf/20240316122359.1073787-1-xukuohai@huaweicloud=
.com/
>
> Xu Kuohai (7):
>   bpf, lsm: Annotate lsm hook return integer with new macro LSM_RET_INT
>   bpf, lsm: Add return value range description for lsm hook
>   bpf, lsm: Add function to read lsm hook return value range
>   bpf, lsm: Check bpf lsm hook return values in verifier
>   bpf: Fix compare error in function retval_range_within
>   selftests/bpf: Avoid load failure for token_lsm.c
>   selftests/bpf: Add return value checks and corrections for failed
>     progs

This series does not apply cleanly on any of the following branches:

bpf-next
bpf
linux
linux-next
or Paul's lsm branches

There are just too many merge conflicts in the lsm_hook_defs.h file.

- KP
