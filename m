Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667069;
	b=zooHvzA0/RSPhF3uDYIpcbhiVFie2maUU/ebzhCVSYS6pn5IhYTQPImg3xYDhfucNzmB
	 gxsP/qIJIo2uonrgG9tM3sUiH37rm0e8UQNrv/UW8IFWpi48t8h652AQckEBGtiLs9Pqp
	 VDbb/rt2LWG1BN+V9ND528tXwAzTvaySn8clzAiLLQmf1jM5FKVL4ECE9UZ5PRbFMf9Q8
	 MoUwoq2bWoMWgPUhGKgLNRnE9G6lGn7z9RX9C5CCZXpDJMwOz1S0gnGLYWa3kPQVYpjCR
	 4xNuuOpu52eBPf/Ei2yZJJx8iXp6R1i9QCE6FxMD4mKbtwjzJ/ESCtu+uCMoyc5/ziA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667069;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 X-Developer-Signature:X-Developer-Key:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Sqn9pseG7wRt4prvWukIecAYEmcXIrVRVsz6R735o78=;
	b=PdjqQkcKGe3JXxZZi8NT1v0tcpuqCm1fLfUzqEiwXB4Y2T3hdn7gh0s4MQSf3GlEWVkJ
	 cjByZDBQotipSsHg+3iJ50+OYaYUbr7LosE0kPLk3VG+tEM7o8Doq6GXs2dOWo/J3S7yB
	 voGIPGyQnLGsCCKEFcDOKmBgJo6xNssPvsHshN6uDCH7mvhRt0qK6qkIjGZkN6Gd3Naee
	 pV91In+5dUwh1fZ0iL1wZwPdhoqS7EEE/9NXIM+HKqYLH+Ala34JNC34jyCAcuUbnk2yg
	 IDdyf2CkOaW4CT3KrYZ7e1sQYMYrN9wInHEqIPGk6AyuBWA692W0OfDBnP0AUFLgQug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCltXfs1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D4606A31D;
	Thu, 22 Oct 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCltXfs1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934A91F000C1;
	Thu, 22 Oct 2026 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792667068;
	bh=Sqn9pseG7wRt4prvWukIecAYEmcXIrVRVsz6R735o78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JCltXfs1xsMt71gpnd06T4OWPy8EuDYL40dHQzuKXKwIk0tSzLJKBs1OltLYiIV8c
	 WVH27s9EO33SpNqa06TGeLmxjZYDkp9mCGSWvVvFPwh5/YGWm1bvbIlRqQqQ4Kz3ku
	 NZyQzTVJtNyzbhxOqqfG3ChU8Oc7uPv/BZzWK1KwpIiijEVRowAOVG8YiMIFoJJLpt
	 cvJ+Qro8rt4KT4jH1iTeZU1sDoRF/OE5Cp+XbOOQouOOzqDayaOrHav4ZC7dp1Iyqm
	 rUdgpqAu1Fpcy/Xtvb6LeK95FZatN+Ch09dQT614SssEyfQkRnOVZO+V/AzBQAt+yD
	 W+E21PP4/BRMg==
Date: Thu, 22 Oct 2026 13:04:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	David Windsor <dwindsor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] BPF changes for 7.4
Message-ID: <20261022-hartgesotten-zwanzig-zugleich-f6b59ab28bbd@brauner>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4907; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u5ogV05odBsfhXHVH49I8N7WQ8PGeyx0Bca4hqE4eyE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdfB7xeXXslnJW+y9XXp/8GnPElkElJ4nx9+WPddysN
 Re31TuzdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEagsjw5u4jzcurrl2Ufa7
 xsae8L/9s0/Jeq/LP3Ar9l7AMpetDY6MDJtlGB/Y7Kp/JvM0JSl+dTeva4TPx+8PnZXiM2s8+pZ
 m8gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
 <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com>
 <DMAVQ90EWW3Q.44GJKDHWOSFC@gmail.com>
 <CAHC9VhQz1aam-P+xh8CT=3V9fNtdrcFSZ6VEOWUGx1cKWV+WYQ@mail.gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhQz1aam-P+xh8CT=3V9fNtdrcFSZ6VEOWUGx1cKWV+WYQ@mail.gmail.com>

On Wed, Oct 21, 2026 at 09:26:56PM -0400, Paul Moore wrote:
> "... just as the maintenence of bpf_fs_funcs.c falls to the VFS." is
> the rest of that sentence.  We're not asking for a type of
> cross-subsystem relationship without precedent.

I love how I always end up in the middle of this somehow. I'm really
trying to be sympathetic to both sides.

> As discussed previously, the kfunc in question isn't really a VFS
> kfunc it's a LSM kfunc populating LSM managed buffers and calling into
> LSM private APIs.

It takes a name in the security.bpf. namespace checks it against
XATTR_NAME_MAX and XATTR_SIZE_MAX, copies the value and fills a struct
xattr that the filesystem's ->initxattrs() callback writes into the
inode it is in the middle of creating.

The LSM part is lsm_get_xattr_slot(), a static inline that hands out the
next entry of an array.

The one problem the series ran into was ocfs2 keeping the name pointer
around after the callback. Which is very much a filesystem contract and
it got sorted out with the ocfs2 maintainers. This is a decent hint
where this code belongs imho.

> One might question the placement of some of the other BPF kfuncs
> located in bpf_fs_kfuncs.c as the file is conditionally built based on
> CONFIG_BPF_LSM as opposed to CONFIG_BPF_SYSCALL or some other generic
> BPF Kconfig knob, but there is no sense in worrying about that until
> we settle this.

The CONFIG_BPF_LSM gate is historical. binfmt_misc BPF programs use
the file as well. It says nothing about who owns the file though.

My view is this:

The lsm framework doesn't own code in other subsystems because it calls
an lsm helper. The same way the vfs doesn't own the lsms simply because
the majority of them live on vfs objects.

I do understand the worry I guess. bpf lsm programs let people build
policy that never shows up on the Lsm list, and kfuncs are ways to build
that policy. For me that's a good thing because it moves a bunch of code
out of the kernel. I understand that it's also something that feels
uncomfortable. It does for me too because I keep worrying "what if we
expose some really broken thing that burns the house down"? But hey, 50%
of kernel development is constant change and 50% is shepherding people
away from the abyss...

-- 
