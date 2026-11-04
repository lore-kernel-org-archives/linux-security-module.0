Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802668;
	b=lYq+3ZR0Ipn3OkppuwzhmF2KZ0CRNaURoGjwbAbxET3ydaTBbxs376upuxRfiq6jTdro
	 BkR8t/0g1lViJfPskfEn+Mc5xJwvIixSnbrSbnRNkVUbERLMootEVAUgnqBKgwz6uIREL
	 dEeNWqnZhqfx2mx/9MTp+HpD/r7mFq1Hzjlnlk/Bk9/zj2buKuZijLICBbE1+uBT/6zSe
	 7YF/UPtE0y/hjt4lgFuVAnWtsNmhlDr3JvFOWhziRQ85xR+mf49iwDM49VURjU7eov+Hl
	 SttMxtV/0qeYR7OUGyZZqKxCeruC7aTjm7SOupb9MTfQbvpoFpE58uLO0i3wSHysp/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802668;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4+G+c04OWXuay+j5aRtdWiglYQKmeXYWP+1mn+mv73o=;
	b=PJ+4O5uzpJFVO71EADRks31sbkfUjnyqE7UTkjlFCrfS+z0wOZ7XNfBVoClgFYrksbmV
	 8It7kNgPziNAu8BMa4HJbAVK6cWuJPO5vBicnDcA/fCdx4i2nFWwNH2A3z0aS3uim/InF
	 kxqTOvQFLD17PauCHCPGlQ9nwAexz8+ODzgipCjM2ien2bie7S746OJ1vOJFX0nC1UZJh
	 oseMD2fhdKYBCFh7j5R4dO5reXzb2WTOPJ1Af1wgvEbIf0ncKQhaQAej8nqH1v1Irz35Z
	 lGo7OLwrfX/e1zS6wkYQVnKNC8POeOVoZSp8VBKq1gvyP0mifRUSAHEsO0Lxu4QryoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQk52Wlo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88462606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQk52Wlo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7691F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802668;
	bh=4+G+c04OWXuay+j5aRtdWiglYQKmeXYWP+1mn+mv73o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OQk52WloYcRIf/3agBwj7vtewJcOfIIyTXw/sx4lSmsLzHx9o4A4N4aEvdm9DS///
	 qKJ3OlZyhwmsXP8AWA+ZO2lqNuwNmh5PQcb/1RNpSaI4rcPKVL+xLRk2neiTLFdil8
	 eTSIPBClQ681nwdTs/4HGR9OEb8DPCx5d7UDvkOpCYbXmNJPWUranznSOf6QbecILj
	 8Ab04bjDiZTF/+g665/XwZD19W7FeCWnr3H+Iugm5+9xYi5/ZM0oICDT8PmqQOOo7X
	 nwT3CPvrXlC6rbRlOO5M9mER4IUqaIHt/pSk31hzxRGLIFnuZNFoxjSV0IaaU/Xpjz
	 0V4pVWAaJCHdQ==
Message-ID: <sashiko-outbox-197443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] fcntl: use cred_ids_allow_sigio()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-4-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-4-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:31:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> sigio_perm() has the four comparisons of kill_ok_by_cred(), and lets euid
> 0 signal anybody. Use the library.
>=20
> The library compares credentials. F_SETOWN only copies the uid and the
> euid of the caller into struct fown_struct, so keep a reference on its
> credentials instead, as struct file does for whoever opened it. That makes
> the sender of a SIGIO a credential like the sender of any other signal.
>=20
> F_GETOWNER_UIDS goes on reporting uid 0 for a file whose owner was never
> set.
>=20
> The credentials now stay around until the owner is set again or the file
> is released. Clearing the owner leaves them alone, as it left the two ids
> alone, so that F_GETOWNER_UIDS goes on reporting them. Who may be
> signalled does not change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D4

