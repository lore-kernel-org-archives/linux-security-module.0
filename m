Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7188C16FF47
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jul 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800024; cv=none; b=KYds+nOnTESMx8XdRHSJaeQosJGfU1RNRorwMYardG9jd+dYwZAky80Db1UNDgxyB5cFTuyfESkIXE754lY5/KW4pFsmLJOKj60pe28tyX3c+vT7VuywtjGvP/ftAzrNcZfN8JalpiUgKeCBgWCORz0hI5ljSZUiRoyDpm38x3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800024; c=relaxed/simple;
	bh=teFvllSrR8u1LwxNwtWBUZZZcgHd4yYz/LxZF9Uqdjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eY2cPdchrn5QlTaI7mOZ4HHMQpcOwoNmaKqvEQx+WTztopgI70psgbqiKzvHTvxe9NtL9DbBB3PVY2fgGfUGYPcO8uIW4HE0ynA0KYKusdq/A5GJLNdqZhjp4UwoQkgPE27QUyx9IvB034yPzuWM1qh3mPHT9Z0PsRis9QV6y84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZFErMHLS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZFErMHLS"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6510c0c8e29so21041517b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jul 2024 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720800021; x=1721404821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnIdY8cOUw38JAafq5wFUGBK6m5NkxtUKb6vV5qaE/U=;
        b=ZFErMHLSikYIgxanXwqGiwZRjRVlpbnQAX64KyOTNLdtzCUOV0hLtWwSFcieCHVpZc
         t+T8vtu+QQFNDfV1Yn/iQ49R182Vj6A9H4e+dDzEvETq/joXfGYaxI1T3Nkw29UABlX0
         ZUMU+CVKj93W7RlsaBOrnqq3K2m01EEa1mpREqm+V7r1RuGOQFFJlXTtZA6i/Cer33O/
         LBLsYctVhG+kFlqkC2PCmPwscKk/I2Qw0FT1oRjEmn7M27Zho6YKMXLd4GX6D2kHmFh/
         PgvCAKQaBNXBml+KWcuL7MEm9If1C6ZH1UgK81OMOegNBMBjsWuyNVmMBN0HhnkJWuay
         eDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800021; x=1721404821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnIdY8cOUw38JAafq5wFUGBK6m5NkxtUKb6vV5qaE/U=;
        b=FeIJ5u6X4Yuvwkc3XjxQJ90fTMu16ebvI0WprdPPnAI3IGlz6yEpccvA0BIcwowQsW
         Xw5PBoP/oSuydSmGSZjnlrHaD33O3wUBDSHYQ0ZCEiG029SnY8ouztYGMx/eqgcwwgNE
         c5gZIG1Reg/q7yoW19dBSuiE5bVKGaLJGHa/VUZPmSmnTbCDGYnetR2vUFePiNepcXuZ
         o+66ZJmz5HvasgMyi9irulmcdSLANgRERpLXmtPgBaUCybFyZOfNEQ3mRLrvJdwGzRsy
         T1ooQncG4JxmImQ0jnN3dm1YbNC7CirfBFhR4wjXiyvmDCZd3bwoU8tATgAeX46sqEID
         om8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPM2pyDfg2Mdz1Fkk6tVoj0z8zmaoKqz4MnM8BAP06bDVr6U4sWcjBqyBUNb9qMdRHDYqU33r8gFlGMFftRkgpJ5ZUbhT8oGo2tN3kUJEMIQcGahBF
X-Gm-Message-State: AOJu0YxfeJ/a5Liy5NziQ8tjg5oKM1syO5GDx+k3hZSz8Gga99UdODgT
	iqvzdG2pvZ1J/ttikq0hNTM3zTKMNgd9x1PY4swJJud3k5PmDiaz6fZTDVcy95A6PXrKilX5cPO
	oiuDGokWBN7WotNi2MYRiVYMk7Kdp1PuY9nJp5oflmGcuvSk2I1Nu
X-Google-Smtp-Source: AGHT+IHMT0du6hnJIItX/6mTkJFxNvw+z/Qex7BmduSDlDVCO3FlfK9m+2jlZrQudmjY8vONYjC0fSXRiUdwhit5XPg=
X-Received: by 2002:a0d:eec6:0:b0:646:fe8e:f03b with SMTP id
 00721157ae682-658ee791211mr112675977b3.2.1720800021231; Fri, 12 Jul 2024
 09:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com> <CAHC9VhSBg7qf81O+mC1EDSUhZ4xR57jfY4h0P6Vy1PO++JqMBw@mail.gmail.com>
In-Reply-To: <CAHC9VhSBg7qf81O+mC1EDSUhZ4xR57jfY4h0P6Vy1PO++JqMBw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Jul 2024 12:00:09 -0400
Message-ID: <CAHC9VhQ9tevCE5MDXxqmErSayHe12XKd=VEVGyPKL0TMxwLC8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] Add return value range check for BPF LSM
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 11:56=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Thu, Jul 11, 2024 at 7:13=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.c=
om> wrote:
> >
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > LSM BPF prog returning a positive number attached to the hook
> > file_alloc_security makes kernel panic.
>
> ...
>
> > Xu Kuohai (20):
> >   lsm: Refactor return value of LSM hook vm_enough_memory
> >   lsm: Refactor return value of LSM hook inode_need_killpriv
> >   lsm: Refactor return value of LSM hook inode_getsecurity
> >   lsm: Refactor return value of LSM hook inode_listsecurity
> >   lsm: Refactor return value of LSM hook inode_copy_up_xattr
> >   lsm: Refactor return value of LSM hook getselfattr
> >   lsm: Refactor return value of LSM hook setprocattr
> >   lsm: Refactor return value of LSM hook getprocattr
> >   lsm: Refactor return value of LSM hook key_getsecurity
> >   lsm: Refactor return value of LSM hook audit_rule_match
> >   bpf, lsm: Add disabled BPF LSM hook list
> >   bpf, lsm: Enable BPF LSM prog to read/write return value parameters
> >   bpf, lsm: Add check for BPF LSM return value
> >   bpf: Prevent tail call between progs attached to different hooks
> >   bpf: Fix compare error in function retval_range_within
> >   bpf: Add a special case for bitwise AND on range [-1, 0]
> >   selftests/bpf: Avoid load failure for token_lsm.c
> >   selftests/bpf: Add return value checks for failed tests
> >   selftests/bpf: Add test for lsm tail call
> >   selftests/bpf: Add verifier tests for bpf lsm
>
> I'm not quite sure what happened, but it looks like patches 13/20
> through 20/20 did not hit the mailing lists, see lore link below; did
> you have any mail failures when sending the patchset?  Regardless, can
> you sort this out and resend the patchset?
>
> https://lore.kernel.org/all/20240711111908.3817636-1-xukuohai@huaweicloud=
.com

Oh wait, it looks like the patchset was split in lore somehow,
nevermind.  The "missing" patches are here:

https://lore.kernel.org/all/20240711113828.3818398-1-xukuohai@huaweicloud.c=
om

--=20
paul-moore.com
