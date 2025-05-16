Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5174C08
	for <linux-security-module@vger.kernel.org>; Fri, 16 May 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406310; cv=none; b=PL/REiR88ewctvsys9wMu1zFm1Qx9spY84oULWEV67C8s1XJFyfZh5gmBWrAnGZcVXposEBdDHlgA3gZdNaRH5iiFVrSF1LvJ46jCfixy65A9uX33+QTO6498w1UwdyIhUZoeSAr+L8mTG2Il/RyStj+4EQKiod4So9xMPNmhIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406310; c=relaxed/simple;
	bh=x4z2xCYwo9fPX793BRjCTj4nqlE0ZVIMCsmio1DpU7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rC8jko5MDQ4f0llyBBHt+CfKUUiAdDInJZH/teEwTRk4tXJZCzY1CINsDrwCeOqXQDdtIuI8zZgIhHFa/L1M54kUaT1FVoZKOpXQk1jkRgXigZM/CzPmy1SwFpbGoWfDv6Oav4TuZ99x+EtYs2eGq9rgb0cFPpURtJhU14cn/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ylGodoks; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ylGodoks"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so9865a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 16 May 2025 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747406305; x=1748011105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sUYusB+kyJ76xlLEHH5qRi/bk9NwvxZ5fkLN1rm8tM=;
        b=ylGodoks6gEtouvpWiK2FouRrMpwv2Eh1sJF33X1TF2ipa209I7hRwmNWjpOXHpEPo
         07w2HZyHsUgkM9T7xqmbPEwZpj/qdWAPQvxYqKuwTiTaUY4AR3LFNgbbiC/KYqQg3Q/a
         3+LPt3qRDwMWan6jgP+oLaCspe2RCg3JULoj4ezt1niCXv7xYEywUqtO1ONlsOj8qvRb
         zb0R+Mk921gYpg+E2LZkK9P9VjI/V6Vk6CA9CrDzP60gY8Iu39XFnqQuyaKj2QwJHsWR
         QYQYXhdFlr2+gshcB9eHxm6mliW/f4Ik35K8CHx45fEdoq9USw0tbNtG7GrGww7QKvPj
         7Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406305; x=1748011105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sUYusB+kyJ76xlLEHH5qRi/bk9NwvxZ5fkLN1rm8tM=;
        b=rDkXsBcdoa6RSV4L2KLkKhLjn4yQCG/7CMC/1qvaws5NxySDh8SjRvGEK7PCIMmsUr
         5Se37kUS2X5OrKrEnskhOQiP3ub6uu1LUszRbBfOCKF7yFuYZVR3kiz4ydG2VEBzWAJG
         MgH/vxcbn0rmIBebOa6guyxcpapsvBgfRn3nPbwZmsY6SJoERG3Qe6cgSeojLnOdN0Ne
         qP0iPhUfPLmWtNmuImO+dYzQ74/CwbODO0Fzfgo86DkqHufriFfif9YlMBprBlUCniwe
         /N+/o5bc4s4M1zjHI8cf2m1IVr+/ktZOJNq3LQtArWp0ZfNdg4UCd98ujmNhm+G/Fpni
         ertQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXemvWbSYAyXJBfip5+OH5IlJj5scNZEHlMo/FGFmN4DzPudvaN6FJIP1nLyDaZncUWLVHzY6qftSdeSUKoDVtugstRuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWScpHSBlCpCBSgGhRBsrwDE7J3Pc0vFHpDuz17cY1f/zp4At
	taeMOJAJKf8HwOEYagsnYIH4ud/yzrKvFYxV2I2DS8zH0JUCrdMaRFUyPoAwdALY5MyNrG28HUb
	ps/GbN1frunjtMc0wf0s4r/aYKQwPhef1tFTWqmGW
X-Gm-Gg: ASbGnctZba+oYmBuzjGAEBAXXLuH1PqSPNEv2RB7uphFv1R6E8QH1f1z3YZqmDZFAka
	PgloHz6kBPVD+KFKJuYLD5tTaK6jxpmiVqCLYttbGWdM7yRdU52d+3B2yYTOFuG2Ohrz+5XvQPd
	bstVGqtJUB3zMUkR7R3dloXWSjbCmfJMdJcvDBe/xfgjv3hJW+LVECxM6oHeU69nQAimdbSWM=
X-Google-Smtp-Source: AGHT+IHjVPydHL7cpnwkAmy+wB0lfXFTh8aEtdxrJqk903N82gHmcHf1UJhj/sj7jHSEWrx43rmp+OotJ5wNqgsIi3c=
X-Received: by 2002:a50:c049:0:b0:5fd:28:c3f6 with SMTP id 4fb4d7f45d1cf-5ffc9dbe5b8mr231155a12.4.1747406305152;
 Fri, 16 May 2025 07:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org> <20250516-work-coredump-socket-v8-5-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-5-664f3caf2516@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 16:37:49 +0200
X-Gm-Features: AX0GCFsuzCC3CmbLLxfWpRPaI0gyUSqgeVs70kejvwFPyqgeFolUzQNjXbEK5Yo
Message-ID: <CAG48ez2ewzKuVoUQp=nyMiVS9euPts3fKaexwXMGhVefQXqoig@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 1:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
> mask flag. This adds the @coredump_mask field to struct pidfd_info.
>
> When a task coredumps the kernel will provide the following information
> to userspace in @coredump_mask:
>
> * PIDFD_COREDUMPED is raised if the task did actually coredump.
> * PIDFD_COREDUMP_SKIP is raised if the task skipped coredumping (e.g.,
>   undumpable).
> * PIDFD_COREDUMP_USER is raised if this is a regular coredump and
>   doesn't need special care by the coredump server.
> * PIDFD_COREDUMP_ROOT is raised if the generated coredump should be
>   treated as sensitive and the coredump server should restrict to the
>   generated coredump to sufficiently privileged users.
>
> The kernel guarantees that by the time the connection is made the all
> PIDFD_INFO_COREDUMP info is available.
>
> Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

Thanks for clarifying the comments!
