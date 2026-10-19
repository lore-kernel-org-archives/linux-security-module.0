Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792449427;
	b=dFKa1BxS4afsLxoX41FHT+kNOgXBQRqgdj7I1FzYgjHC0+LLNxvd+bJxEFSyW4Ai5vsn
	 XHjK+diMBfC9uFb6jvazbx1vESlIvmLC7QHrelU03fdVvQDGB0T0ToNLYmw2aWnwp/aCK
	 bAXJoyQH6xTpGkoVf50iSqHVsBOiPoWpQbWnV/sUnJNa0N1CxBfa+UReClzA9FUkCJdkj
	 T3K4nQ/r4kC9VWawsqnAM52cDkNQwmIPgtTArKr9p/SWezFZRHzb5oXm7WDcebyamlDMh
	 Nyj35DQ9Tpa4m9zKIrQ+Iwg8Nz+fMrwWYe7Th9Ai8w29Ejcp0CDOoAHLIQPffoEjhcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ty9DOdONrjbnMZKSEfb7twj3GQ6j7B5+mpXEyErqB+E=;
	b=Ihy9IMHvUQ4ccNxJDgtTzRPHrQdCIgdksBpxmrA6rKPslYUB2BqGvCDiL+1Df9hQlQsz
	 UsFdG8cUSBfF0/qorrPoQ2U3u/PTmMhfUdWwk2nYoqzX8Lau/2My5sPPZmoeeb2EpZzSL
	 vTkf+kfQlX2AVY57988mMVku3r/xthtWtLuet+12cmBPg88iTnnakv3LZiK3FcC2aYNDN
	 Nmft+W5aBgRM/dYn1X46kg9XUVABGlPoVfq3IlclfGlkN42r2j7G6NIlXsftAo7w9jv7R
	 B/bmdsrfRw7MMrYwaIAPUh06mMX/OjBgtVr/oPjkZS0AuPZMlfKbesON7BP4LiMguOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ha1Quv/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAEB606A319
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ha1Quv/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB831F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 22:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792449426;
	bh=ty9DOdONrjbnMZKSEfb7twj3GQ6j7B5+mpXEyErqB+E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ha1Quv/XZuWr/y5kMmL5LuH2YKbRgv//C+MxrBXExRt3/K2xwJzlq862j/86Z/F2S
	 kZvQ2pYdCepBLq9JWmRdM8qwr+/fK+ABsxYdLLw++1ItSKS9CjdAMTUDz9cFuxJMBs
	 Lxx0fZIlSA0k1+svTit/1HB8Kq3CRbme83cmHr9Xk0Ga4gecdgwhVcyHNURhI4bMt/
	 Y2z9FGtK0D1p4aCEPGwmYYXIXBeg4WBPJ9asKeakJYv4Dh51hllKJAzG6kxJV9qUwD
	 1s9XyFyUhJIcRZWYvJnPuieKn4PACNh+bcqGquXbx9+Uok6E9HHwyD0Um9jx0IcCgM
	 LfyTrbCH09qqg==
Message-ID: <sashiko-outbox-178326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] lsm: don't call d_path() when current->fs is NULL
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:37:05 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> When the last reference to a file is put from exit_task_work(), the task
> has already run exit_fs(), so current->fs is NULL.
>=20
> syzbot reported:
>=20
> Unable to handle kernel paging request at virtual address dfff800000000002
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>=20
> Call trace:
>  kasan_mem_to_shadow include/linux/kasan.h:65 [inline] (P)
>  kasan_byte_accessible+0xc/0x1c mm/kasan/generic.c:210 (P)
>  kasan_check_byte include/linux/kasan.h:402 [inline]
>  lock_acquire+0xa4/0x320 kernel/locking/lockdep.c:5916
>  seqcount_lockdep_reader_access include/linux/seqlock.h:73 [inline]
>  read_seqbegin+0x6c/0x144 include/linux/seqlock.h:838
> [ ... ]
>=20
> Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
> Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D975ace299d6ba2eb1cea
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019222858.1766=
-1-drifabdelmalekmohamedsaid@gmail.com?part=3D1

