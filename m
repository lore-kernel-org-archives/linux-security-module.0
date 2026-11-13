Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582416;
	b=ffCT2jpy+yuK2alWgg5riJpFU4SkWlkCssaKVoYuZeEtBW0OAfiutfpwiUksBp0qP0e/
	 y4Ec13Tw7iOf/A9ryE6MkJEOjPmJgSP9TzTErLUwPxfzrsoAtwrpWoz0J1mk/HgN26B0L
	 +tkZNUnhwJdtGV865K3J67g0X4aKJzo8HGQis+7eKwsdKn83GxN546vXHbQancpeZBscp
	 CsOFudoNK/rCVDkWRfxkbtwxUKFmQQItux+nAZgt3OupBE83vz0BcyBio0jnMoWmJ39nn
	 mYrs9ZzzS/kNgmFsSpcwi9s7d9pfi5ahF9g3HP5fyeQmlGh5dPRkgqZ/6XzWGA18joA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hu9Z8e2EaHMUsN4paiwOh44+FDR7l6uCcfcO9w3OY9Q=;
	b=jVT4ZrCzCTbDGjQoziWoaMciDgGVuakNRrkghK/QGZryzQLeIpFofHd/roQ2+G+ou3bV
	 qE1VYQ6Fa0dgVlPV1DD9lPX7GHHRA8AGfUcgRqjQehd/+AXjy49iEgFSaw1ZzBCUlMYuI
	 ySnB4/rySsb0luulGL6jq+QZarnSJ+ZtpLX6zM4xx2M85rAJr4I1HBoZdXx6gf7eS5EnW
	 +il5U56hQnolXVF9MB0TE/FTbacmROlnkQKQInK/OpPmF0V80LEEdSMLHL0xMOOvJfipv
	 ZwXdm7b70wyxohgab4e7tif2WWJyvJYRk5rbMTN6FVJIrhq2A9R3gozrz66NKsxuy9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="et/fY0Cg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AF606A883
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et/fY0Cg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70A31F000C4
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582415;
	bh=hu9Z8e2EaHMUsN4paiwOh44+FDR7l6uCcfcO9w3OY9Q=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=et/fY0Cg0MsfRHar808lvLJNXcRmF+iJHaT3tpZnKHB6Hjb/kfdMsxfUbwddCwHBu
	 CeA5Sm6SARKSwKmQW7pYMMKw37ltg5FVl7Ld2W69QgjNNdtQkMMhT/R4obdg7rEUrj
	 QOH4fW3ZQ40quTA3s0SQ1CNKYfurrCmnaGgkKPC1hGbWj4UJuk3nmB1AD27mp9dYfT
	 qq24MgxfvvmhRYFf4xBelgZe9HjB7Q47UQEnVz9WGEHf+575m4n3qc6L8I0C53T5wm
	 sIIWIajolTLfQJ8Hm+Fos7JJyBggRHE8nTuYYKXQkugnfKMZdFxA974hFca8DDXQwL
	 zQ+mF/0GKPz0A==
Message-ID: <sashiko-outbox-213054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] ima: fix races when deleting measurement list
 records
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113145610.1826692-1-liuwb@xiaopeng.com>
References: <20261113145610.1826692-1-liuwb@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:06:55 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Without this patch, ima_queue_delete_partial() looks up the queue entry
> at which the measurement list has to be cut without holding
> ima_extend_list_mutex, and only takes the mutex afterwards for
> __list_cut_position().  The comment above the cut justifies this with
> "ima_fs.c enforces single-writer exclusion".
>=20
> That exclusion only covers cross-process opens and is only enforced at
> open() and release() time.  ima_measure_lock() registers measure_writer
> at open() time and even lets the same task open the file again by
> incrementing measure_writer_extra_writes, while
> _ima_measurements_write() never checks the caller's identity.  A
> privileged task can therefore open several descriptors for the
> measurement list and use them concurrently from its own threads.  Each
> open() creates a separate struct file, so the f_pos_lock taken by
> fdget_pos() serializes neither these writers nor their readers.
> [ ... ]
> Fixes: e9b491e27bf6 ("ima: Add support for staging measurements with prom=
pt")
> Fixes: fcb0318a2969 ("ima: Support staging and deleting N measurements re=
cords")
> Cc: stable@vger.kernel.org # v7.2+
> Reviewed-by: Lin Qiaojie <linqj@xiaopeng.com>
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145610.1826=
692-1-liuwb@xiaopeng.com?part=3D1

