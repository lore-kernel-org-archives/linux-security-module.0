Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786EC40DB4C
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884365; cv=none; b=U7caQRPNXbrKxINiS4RJvebcilvbMg2H3j5JYjgA7tUMM5xlwXc5A5hamky4LShL4cyKgD+wgp/QSDw/cBhVKRN66ruZD1HTkFt0rD3T9NYBjj5G5oiWX3muMnNQu0TE2ZLON7HniiEozdnWPqDkIK9XUKzengFus+I5dIRTUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884365; c=relaxed/simple;
	bh=+vH0T67VtYGl8ArtZDfYACkd+0q6dg/aUzNq2c1ccZ8=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ud4eGqhZAeTz0fCHvrF6X95upgQx6t6NEPKI12jOZKfujyNv8UWvHW3f8FZQBN4Uy7wT5Q7uPj12PHTu+Ae2vbu+GXsSbz3JC1hialNvoLsQBxEiSLB7Y115auUAQmrx4ED+3Z8P3SNcLXYa4byDEpagn99nQT/nHxFHW456oHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh/Elfzr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh/Elfzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFD61F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791884364;
	bh=nO5hAj0y94nKBLNC7BwE8wCssEv6wT4jw/jlviHCuwE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Mh/ElfzrQx17LW1nm19mBZFCCHtVMuUFwmxI4hpG5N8Xs3hKMvGVyNfd4GQYkaRaW
	 6JSxawBmS3i1KWG3iwdBoRIIFv1Xt5ZeJsx0lwAeGqS+NwTPbM+ghlwnk9wfbhQHmO
	 J3pae69Qxxj2sQ8Reh/aJsYBlgOSPxFQYaPqSFijODzgjEqCYnaoSkmO7N2c+J3yRC
	 59uJblzuu5RsHs3sEcn/VXYzovoTXJHadoz2g7oN/LE0Csd/JXNS4vK7zboH72BX7+
	 rZsgqWFZS3i42BoSm6AuKUHj95ilKeJLzviaBl6xk4wRu7IlOJ/zgg5SB4L2XFl5by
	 tv022NElTVJUA==
Message-ID: <sashiko-outbox-169365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] keys: Serialize ownership transfers with key
 accounting
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013090358.1178367-2-nicoyip.dev@gmail.com>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-2-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:39:23 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Protecting individual accesses to key->user does not make ownership
> transfers atomic with accounting updates. keyctl_chown_key() holds
> key->sem, but instantiation is serialized by key_construction_mutex and
> need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
> an uninstantiated key.
>=20
> The instantiated-key count can therefore be charged to the wrong owner:
>=20
>   instantiate                       keyctl_chown_key()
>   increment old->nikeys
>                                     observe KEY_IS_UNINSTANTIATED
>                                     skip the nikeys transfer
>                                     replace key->user
>   mark key instantiated
>=20
> [ ... ]
>=20
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's own=
er")
> Cc: stable@vger.kernel.org
> Assisted-by: GPT-6-Astra
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013084056.1070=
923-1-nicoyip.dev@gmail.com?part=3D2

