Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3F390214
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250893; cv=none; b=WrT/ZUIC1SLhs0ksJ2hwyPG4zGnT5Mq37FDcY0ep7B8BSExA+n2LOI3eiktD+JIzc+OUE2NwVfHw6eZCERunBUKq6/MHU3FjbQssqpNf5eGiWHpKNuwL01vtUH3hZamm/IuNGFKZuoc0wc7j/YH8CKM12uG+BQcQUat0aNE1K+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250893; c=relaxed/simple;
	bh=ZBFOxevXYmnFQdCJOyMsfmO5xtV9c77bNesRuHODgck=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U9h8nXDivIm1lec3MoGDPpmefXp6qyy76JJ9Fwgov/WlM13QLmZ2k1svPcOusLUHym+hR8emIA8n9VkARMDtH3bUrqsVeB3CCkSHDQoff3MEBfzY4m3XYjePHhaWSU45k1kQdBXzhR3l9S+NZWlo5IAQOXESkIDob5hwsY58yk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isRCr02w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isRCr02w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8BD1F000C6
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792250891;
	bh=5ESwFadwwmcjw10Dxp8y3Awb1eadDyTSsJQAXXL/3aM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=isRCr02wLejs5/IB+wVX+d3B6xPjHHQxJ0CR4E5C7D7dCWpjvhduPo9TiWIqNkR0j
	 WZpJtVYHxj5LLY1ltTD/HtlyeuP22XngeCTHaqwi6mnCJxHPPUBbLBdaXNJqcX8rxq
	 NpXKlyqc/8taRVPWb24tbc8T3jqkri6fIjkmCzkhzyk8hxRAXLR41fqqMwGtcCQhTM
	 w6dKWfZ3vBlEptGxQxqDXQSdDOOvZ3DQG0NkPuq9MhobJAHmjIr3vsczt1aIYd27Qv
	 QIMIoF1laEqqzHBmdvjZSVetrz9G7Rlg8iTmESWpzjFWb3EBRRxA9qxaRQht6lZRh4
	 1vT2i6b9QuN+w==
Message-ID: <sashiko-outbox-175584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] keys: big_key: Remove the redundant quota
 reservation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017152123.1200429-1-4ncienth@gmail.com>
References: <20261016040004.324286-1-4ncienth@gmail.com>
 <atK0MnGM2h9IH6FD@kernel.org> <atK186hMPBhYyPCN@kernel.org>
 <20261017152123.1200429-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 15:28:10 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> A big_key is charged a fixed 16 bytes of key quota, regardless of its
> payload size.  big_key_update() nevertheless reserves the new raw payload
> length before destroying the old payload, and generic_key_instantiate()
> then reserves the fixed quota length.
>=20
> For an update shorter than 16 bytes, the first reservation temporarily
> returns quota.  Another key operation by the same user can consume that
> quota before generic_key_instantiate() reserves it again.  If the second
> reservation fails, the key remains positive after its old payload has been
> destroyed.  Reading a buffer-backed key or revoking a shmem-backed key th=
en
> dereferences a NULL payload pointer.
>=20
> On a KASAN build, reading a buffer-backed key reports:
>=20
>   BUG: KASAN: null-ptr-deref in big_key_read+0x110/0x310
> [ ... ]
>=20
> Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017152123.1200=
429-1-4ncienth@gmail.com?part=3D1

