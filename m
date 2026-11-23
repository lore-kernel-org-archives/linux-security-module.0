Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432845;
	b=0A9uL+NBrp77/KPZJBOE6z9/vI5yvvQDvzdNN4zfD4NrbXAmHBtybzAxo0xIW4LYEZZS
	 VL8DbNV3fKO1Jym56BsE4JR1Dx+7w5Dxb3VwTBADkP8qGdTIY1vcTEOHPvInbucwmX/sF
	 x/6Gx/+kMFuRgGBTQ7nQP54t9fQqk5BLqnQ1EPt6CQEJuWzfsE3HTFLsBqIPhhzBnVCvD
	 ZEK1RpFMzriXKW/GNmkqFbh9Wkl3+cFOaT2f9ktlprrfn5cGBXE87SFTBLqBy+VntTHpP
	 V+qgTLvSbrHMFTZ2UjlpqeBEmfoVvTt+LCkcMWwgtepulLxUHgWPCpMn9bPo6PQYo7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432845;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XDkePBeYvIHUwQieMEsiRfQDLS/dRlkK5XLfCwP34L0=;
	b=GTUtswm1Iwl6p3t/I0rIfG0/KyEs92oZhw/iQ+vWwukuIw8MLEQb+lurG568esIJw1Tu
	 yAuhTbzbAmnScuiP2ae0HiuSX3LQ73FaEedoZe6Hg8Me/F2mR5t1clXzKlpFBSMc6IKtz
	 DbektxOAFnLyamcZm+vz+ue2uRRhqr9Qt1p1iLEBP6clbyEYP1JEb+q1X11nJjCxUaKRp
	 AmZEm2UOnjtEAF4hQu328/MmQlHTsQ35dqfSDKJ3WoZrqaCjW8x6ySxRcWTRpVpLAc/4I
	 5Q04LWGo2EL0L8CBKxlO3eAsPMhyxnz4eN1bPOLaJru1rhLwlxZZmoGP55uvv8PQVMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cswzJtxo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486AA606A33D
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cswzJtxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C931F000D1
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795432845;
	bh=XDkePBeYvIHUwQieMEsiRfQDLS/dRlkK5XLfCwP34L0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cswzJtxoqkhn0ujtftY/s6OszIzFOoQE4ViW4WnHpVkDiWMQx/Wt0dPkuhH8ha4m1
	 aJmLoirUVUxojFxFspEkJWCqgv6I8cJmGb1oow2QdIu7tAgANpKjTcNoYhqn2p9Ic+
	 ejqxPhOstD9G4UaIMvOEDoqIiI5L72UOXZEPyz91Ea7G84RD2ilpNcpk0I80TU3l/w
	 QWCQiGpNpZvx71rTV1Hqk5vHq3LgucJTjGCzuYNedGlvK2zvZnt1zoVkQ0MbrAIABd
	 z9prfXB4IH6ND6wVQ4j645Pm2DQvKIof1y9z8eWWTcQnVCwUMw2uppO5+ZxM2GEjbD
	 VwJIV/PnjofPQ==
Message-ID: <sashiko-outbox-229106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: key iint mutex lockdep class per filesystem type
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261123111452.237422-1-ngocthang2710.1999@gmail.com>
References: <20261123111452.237422-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 11:20:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> syzbot reports a circular locking dependency between the iint mutex,
> a 9p inode's i_rwsem and the sb_writers of the cachefiles backing fs:
>=20
>   sb_writers#12 --> &ima_iint_mutex_key[depth] --> &sb->s_type->i_mutex_k=
ey#25
>=20
> The three edges are:
>=20
>   backing fs O_TRUNC open:  sb_writers(backing) -> iint(backing inode)
>   9p open + IMA hash:       iint(9p inode)      -> i_rwsem(9p inode)
>   9p truncate/writeback:    i_rwsem(9p inode)   -> sb_writers(backing)
>=20
> The last one is inherent to netfs: it writes to its cachefiles backing
> file under its own inode lock. The cycle only closes because the iint
> mutex is keyed by s_stack_depth alone, so the 9p and backing fs iints,
> both at depth 0, share one lockdep class. They are different inodes
> and nothing waits on a netfs iint while holding the backing fs's
> sb_writers, so this is a false positive.
>=20
> Key the iint mutex per filesystem type as well as depth, as is done for
> i_rwsem with s_type->i_mutex_key. The overlayfs case covered by the
> depth annotation is unchanged.
>=20
> Fixes: e044374a8a0a ("ima: annotate iint mutex to avoid lockdep false pos=
itive warnings")
> Reported-by: syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ddeb8af81d91415fabac1
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123111452.2374=
22-1-ngocthang2710.1999@gmail.com?part=3D1
