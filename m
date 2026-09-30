Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7350B8A1
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777673; cv=none; b=UzbVWDh0pYFsDh8G4qbVOcEGnBrXUnu1P8+x3HKRfMADw0KllhX2+mF28t0ngJUCDR9n0NUYW+W73JVv26/NaJyUpeh08fdn6lFjoMPeWFiocdSb9+Qgiep/E1fZ9La9ZMBDxMJZeCFRXXpTjNh66MaB/yRzFUXnwXOvMEahjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777673; c=relaxed/simple;
	bh=QwaRqQixjCjR/KBtKjRJ69Xrl2T0rPnRE4D5j+7+x4w=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kOikJjeu5fu85W4/ScZpbd+S/2oaVLfXEXtVxFKNXkKqnL12E4cJefBFYVpgvAWUS7+0bUvPTbQeqKmjsUiMcidI5l/vTJzg/ErrQF+AUmCJ3x1AvS7Lf7rexOPR/NesmJS/RGw6NcAealwUZ3Ra4qQ1j64lOZruHcWxooPpWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozOq0OKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozOq0OKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082B21F00893
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790777663;
	bh=RcbH0g1TfohRBgmiu3yn9g3olLCqa9ySy4Ia6FAIUd0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ozOq0OKZ32vSSnvm2sRrPlgraUegxnxbYqgUC3FisFEWzh7hk2BtUDwS0oX15PnFW
	 bLlM3VR1nXLsMZpjUZa8VandOlKCz2AHvVLg5qAyJ3YOxFULBDAKHpRXrwpArmX2sh
	 BctY5tvZfg0znty6Uk4MzpUDySH+RB8oaKgZGzAVot3BucF04ei9FBtfMgoh05H36s
	 cqN9POU2QljdIPoAC7AMLLrNbM/tSE0p3jg4q2p+1eifHNxjTK3D16q/aNhKo4kR03
	 1wifzZUztVdWxPzDo919tjmisVxdtlW+Xo85411f1YcfnmvZWEfYdf2cmJgiz+CWNC
	 nQFvSK1XiXxig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] cipso: adjust cached option offsets when removing
 CIPSO
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260930140400.2955466-1-4ncienth@gmail.com>
References: <20260930140400.2955466-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:14:22 +0000
Message-Id: <20260930141423.082B21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> cipso_v4_skbuff_delattr() shifts every IPv4 option after CIPSO left by
> cipso_len, but leaves the cached srr, rr, ts and router_alert offsets at
> their old locations.
>=20
> With a valid eight-byte CIPSO option followed by a seven-byte RR option,
> RR moves from offset 28 to 20 while opt->rr remains 28.  The stale offset
> then points into packet payload, letting the sender control both the
> length and bytes copied by __ip_options_echo().  Setting the length to
> 255 produced this condensed KASAN result:
>=20
>   BUG: KASAN: stack-out-of-bounds in __ip_options_echo
>   Write of size 255
>   Call Trace:
>    __ip_options_echo
>    run_cipso_stale_offset [net_candidate_probe]
> [ ... ]
>=20
> Fixes: 89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove =
the CIPSO options")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930140400.2955=
466-1-4ncienth@gmail.com?part=3D1

