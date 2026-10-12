Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050D363C5F
	for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775510; cv=none; b=jK0DAKZcPdHCzx5t/8d6JzMGDzU3V0pHQtpFG6y/srdoN8a8fyzJzFbvrq8VUDEhffHjPD2pFC9JAZ60VFrjHFjo6jpnh+eawbGpzqs1QUir/VeUmVeHLeUdBNbmtu05hOR1W2M0yiUvvLZ/PipA6lsZ9VYy4vt9vGs/4/U1+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775510; c=relaxed/simple;
	bh=0cqNpMWh3zGTxu21ne0uMPqmTk6DeokmhpgyFH/6p+c=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZRY/6Rbei+kB9bWzGnTFbWb2nv53QTrSJ9BolEdw5XOu7TzFJI5dQkj/nyItHBruBCtBAe7rDp8r5A6JG+zsC5sMO2u/NeZph5IglWN8AGvmr8/iBH3g6ibB4AInj9SSgpWBi4OmnGteqi6OXYD7Nq5q4ZOfVVEMG5i3Wm0HcDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEzkOoMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEzkOoMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D931F0089B
	for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 03:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791775509;
	bh=ynPf7mpaYl7dZuokOE+N98b4Q/OPCoD8/KSEVx0PbLA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aEzkOoMUGQqtCekEMFw1JusIxFVjPAaBOv5YZxk2j3PQddqLqAuxqkx5GGNBMHt4K
	 eS4q0EXTDD6WxKV+GFq5FuCTyvhPch7VprhkdQvfSzBamBIOkcSoede1v2/N4CsacH
	 MoJdmlAE77W7J/VKzIWjjCBCe9D0w7IW5p6EGXYMD0Oi/srZ6o2zLNSGtGavjqOaTt
	 25CLk9OGohEUvQZnhAza/cqGAU0HRzi9agl7anVbpYaDCSKVJAv4/aI1OuWyuZ4h27
	 4a3tR9WvGA/Qr0vjy3aWreQU1qKviF4gIzv9JF2IkYcYChBQ/JNKOyPW8YXBsGasm8
	 bpvyRNg/4MMnQ==
Message-ID: <sashiko-outbox-167576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: Protect user key quota access during
 instantiation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 03:25:08 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The owner account must remain alive throughout payload quota
> reservation. The user key type calls generic_key_instantiate(), which
> dereferences key->user in key_payload_reserve(), without holding
> key->sem. The construction mutex excludes other instantiators but does
> not exclude keyctl_chown_key().
>=20
> A kernel caller can allocate an in-quota user key, retain its reference
> and instantiate it with a nonempty payload after publishing its serial.
> A concurrent task with Setattr permission and CAP_SYS_ADMIN can chown
> the still-uninstantiated key through KEY_LOOKUP_PARTIAL. If the key
> holds the last reference to its non-root account, instantiation has no
> authorization key, and the new owner has sufficient quota, this ordering
> is possible:
>=20
>   Instantiator                       Chown task
> [ ... ]
>     BUG: KASAN: slab-use-after-free in key_payload_reserve+0x54d/0x560
>=20
>=20
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's own=
er")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-key-management-o=
bjects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com?part=3D1

