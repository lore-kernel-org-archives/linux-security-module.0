Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758895;
	b=WNq85MK1NJKZmfCvXzriTwMn+IAsXHzC9MacE99eocAwNTOMVo44P4sLJfkJp7veqQ6M
	 yFr8fTr1PC7uprY47x7zL60a9qmiMzAfBcY/H/rRhAA2pEc2HgWFqElMyYqiq4aEpg6rK
	 eGuq+LmorYN7y4cRhqj+zboaz+vCMvAMgSAMcToJ2h3+lMbdxmraO7VwaMtbP4vwALRBm
	 UvcL5I6HDxqIAQuLfbklfJyN7aKY+TChQMZfk1QdMnkILYXAP46JfTEoOR3UsT5jilLsm
	 44LdIFvwtAT9x6ixv6ynzpTyr7ThRdlsBtrY9FIuEA28yYQVQGC7zTgeCWFGBuYs+qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758895;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vlcAbWT5dS/YW97pnU6HVjvU4J7z8U2/lUgd+JCSEqw=;
	b=OXwKEHk1ZlYtPwvrMzPBd4hqo1Kjk5tuBrDBU+s5lwuXPh4+F1GJ9DGVN8uEFyM7ZBwl
	 Pcy/vkk3+WHibMvbKi7+E6C6239iNsyzZAE/E5WrrMFY1vhOjhhutv1fyEYLHJRbGIHJW
	 RDM2DLQn7FU87bkChhteShLSAHLFroR0F/kdF9SzV3o2l9rX9BIlcslnq9S2pkdZrzKHN
	 +uP9bpv6w/ev76jcli8TZhobavZBVrLfG3cPeYw9GAnH+P/gjV2w0/Y472SWFQLYWqmmV
	 KjRH+qM+c14LLuF3z15EAvcFjMCyKh+tSOzrLUBbTzh8KscCyXshQKi8CDCMi180oxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KLUF/NWk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57F606A31B
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLUF/NWk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7D41F01825
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792758895;
	bh=vlcAbWT5dS/YW97pnU6HVjvU4J7z8U2/lUgd+JCSEqw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KLUF/NWkZnJ27R1VXRpe4njdloAUJ+/67U1yxIeRLFvZnyvsvDXUMqV/9OObyfxY2
	 OsLdg6fmBG07jnP1kMPd8HX/AUOkgAQaj+28m28QvW2heLUaJ9GhqgZBcjMyzS0gJe
	 Hcvf+uPmpfqLzU0SoVwPWXesjp1kwbmayBTjOwqyvloFoS6mQgG+g4h2zQpObNhaTd
	 YAG9UUN1QufA75y+Nj2i8oxlxkKuPTJf6pqQMa18QhSCG8pOfflpqWay/iiT7bHsSD
	 fJGWsWqiuHDLIQuF1d6d+QZaEvgixMeYj2HkMzX9+MZb9pl9Nnw0WfYzA41WNQq8Wt
	 2MQbjUd84QpLQ==
Message-ID: <sashiko-outbox-182776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] KEYS: Verify the key identity in
 __key_unlink_begin
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261023120953.1206778-4-jarkko@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
 <20261023120953.1206778-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:34:54 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> When two keys have identical type and description, linking the second key
> replaces the first in a keyring. However, attempting to unlink the first
> key (no longer in the keyring) unlinks the second key.
>=20
> This happens because __key_unlink_begin() calls assoc_array_delete() with
> &key->index_key, matching only on type and description rather than the
> key's identity.
>=20
> Example:
>=20
>   keyctl new_session >/dev/null
>   keyctl newring ring_a @s
>   keyctl newring ring_b @s
>   A=3D$(keyctl add user A ss %:ring_a)
>   B=3D$(keyctl add user A qq %:ring_b)
> [ ... ]
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/r/20261020174325.2229448-4-jarkko@kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023120953.1206=
778-1-jarkko@kernel.org?part=3D3

