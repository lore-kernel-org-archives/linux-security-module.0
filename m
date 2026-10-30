Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394370;
	b=ly401m1Jl3/YMAEPdm628NZdPJW5V5NnPIe72YH2KqFq+eTXIhU+GffqSR6fJjWpetZ6
	 690+0+8rTFi1z+edoT+6K8/uxePr2owYZMi09anNyuEnbHVMZ2diKsx/clOH9sLaf8zNB
	 2oWU1w1CgNMAbIAPRgmnh1ejr20WQOFDa/ODMCp674QyjT+rEu1NzLhCgUfvBqcvf57kf
	 sqo+eg5EEGql7uyqVstB1JEaBAThly2sZNY35mS867tF3TumWlIPZO+dk/H7zUm86oLo9
	 +JC0poBQdS2m+szq1Zaa9BzlRHD6vjDscGiES7pr1pfS3Ku03hX30X6XIGOcfrPOl7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mAbXKJe6bhrVVxkk9zEp/7L3/chfp2MExGSJRHnD3/s=;
	b=iA9rOIaY00MaKPDkXCTdGyLHwe5ywTVAqjlow8HzuJGvCTt0fPxdhW1nUfKaR1cGD+Gu
	 v77RHkTta5HGnzOpfnkxLEUl9u5cqqGxjclfhJ8MqdVfAfDkhAMlVrwz+/x37KcztflMi
	 /gpyVF7nkWE8BE7aG37S7zkJot17WQU8rbPra0+/Osd5d/bSku/FzPOdFk47UhXsYKEj6
	 nMxJSk7WTCSkczyA+TJFcahYh6GjYl1Brxx+GCDG7clFxPNoaG71bAJDxlRUCR+OtmF5B
	 B8KwznVZ3/uEY5TbZQYj+ED2XaZoq+GaFIyWq4EkVsvpvL/WlPLX/pun4VrcwJ5qlNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlZZ5TkQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FE1606A31A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlZZ5TkQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BDF1F000C1
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793394370;
	bh=mAbXKJe6bhrVVxkk9zEp/7L3/chfp2MExGSJRHnD3/s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KlZZ5TkQl0fLS3O3JEOZR8eYy3C8Uug60RwYr7g8IqQuwt+EFGqzRvfK907O/HO7e
	 JywXix41+D3Tt2Tp4+CbQkw8vewy9xMMoBKoE/XH+U2AGbto0sL/JGtz0JL9A80EKD
	 Av4GOQHksCiNIW9OB7dR6j1zjNIgj3Ria2tWGFver7b9Ltqj2rPo4InKdL0ltk2Q0t
	 9HTe8JvXRKELig4qMAOKNArtWdT1J+rTS12yAtmnIGhFJZdqwXWGSfvfB/RHWmLNyf
	 E94yL1mS8mQdF6bqCr/zhse0yHKL32kWDVyV0JssHOsPcZKxjAhEaTx3tCAs+yBm+Z
	 qAc1E9KWgReSQ==
Message-ID: <sashiko-outbox-191511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261030205412.3138975-1-jarkko@kernel.org>
References: <20261030205412.3138975-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:06:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
>=20
> Resolve the problem by processing in chunks:
>=20
> 1. Declare a static variable key_gc_work, which owns the garbage collecti=
on
>    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> 2. Define KEY_GC_CHUNK_SIZE, set to 64 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeati=
ng
>    the RCU grace period. Drain the graveyard before advancing key-type
>    reaping.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
> [ ... ]
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their key=
type is removed")
> Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc15de43f1e7fffbb7b9b
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-=
test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030205412.3138=
975-1-jarkko@kernel.org?part=3D1

