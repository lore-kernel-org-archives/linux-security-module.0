Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343206;
	b=XhW3E/ciG6rcjW7kbjc/ckV2Sc0Y/eU7chmGwUmkRzl+kdx08Me2onzU71zSOBNqh1Jb
	 85fx1dGsDwQK9Qi83t90r/z8zHrNVSPzdMnLtCt/bmCqWx0PQ+AGGcJfTppDhJEVIbnr/
	 5YVk21LY6xKOwB8pleNQwhbaRtJeNXA64BadsFUfcgn9D5YiQoeWJ0HyWTJ0z0cxa8zTX
	 T34jaynPCP3Bxz9N/EWlRcCAl7truFQF43HWhQNlQb3BeSQbZAbkswPAUsM8RuP2eFsq9
	 HeJUNVFzxGwpHpfY1rIunghU4wURXdvbLjpEvrIJ+K9cC9+gyNZvHrkEeIJ8KdAep7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343206;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=znExdRqIVg8iVf+1wAN1S8dwMg0p/zuIHxCk/dImyb0=;
	b=5g4RrxDfKiLG12FTtexMAWAN94WFpou/PFi/DLI8HtKOHhP+bFTPj6LypLTWy8+FSdsD
	 ZEbf0xkaEP8B0smtC79ZR8AC15MHrongtzzNVjl8S0uf43NlxBCT350biLyTNhpUtKlIG
	 TsazQ54xpdAaY3Laoj44HVWFPjZue8Pa+oLzyhBMNmBY/SSMAkTxUJSW5+1E2/KosStnT
	 E8qKJiMSGNnY5H6mvgjggF6jx/TKqLuBAB1PrX45Go0mm+3JUjPyf5KQBzhDBSnk/RA49
	 pbJb/n7J08mMBse3RY8JLwHl/xJ4LHKmo1fjd4k+J75Y9JF5SX6APnCIb/X5LSR76uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAM8+gex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698260A261B
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAM8+gex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948E21F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343206;
	bh=znExdRqIVg8iVf+1wAN1S8dwMg0p/zuIHxCk/dImyb0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mAM8+gexL52LNMMhxh1LwmC9Ge7+KvUhv1BfxyBwDHg+B8b9bj1YiDl2SXn/Ahfdu
	 V7NrRtCsbuY1u6FjsOtd285nabb3TNXSN6ahL6F4gxBAS0lrl1rqPD/bOIvevXOgbI
	 i7cRwY6ieYvWmDhkg3ehqmIJ+ng8SCKXAz44HNmVPXWDelRHagwgXEqTafZt3/QzwI
	 3R+ll74RAWMLcELSZysuQotQljzZP7RwdwAmRL4ZscKFP/UaV4gJJVpRRlDonNL71q
	 0Ajy4A0clEFYgpC0n6sVlrbLuuj6m8/7DU2dgGLrmH6GhVgVaFcC4Y9e2m/y/xHNiU
	 6aRu6VVd89vHQ==
Message-ID: <sashiko-outbox-207722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] landlock: Mediate CAP_SYS_ADMIN for the admin
 memory reserve
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110202436.2408244-5-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
 <20261110202436.2408244-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:40:05 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> With vm.overcommit_memory set to 2, __vm_enough_memory() keeps the
> vm.admin_reserve_kbytes reserve for callers whose LSMs all agree that
> they hold CAP_SYS_ADMIN.  cap_vm_enough_memory() checks it with
> cap_capable(), so a process in a domain that denies CAP_SYS_ADMIN could
> still use this reserve, which is meant to let an administrator recover
> from memory exhaustion.
>=20
> Add a Landlock vm_enough_memory hook that withholds the reserve when the
> domain denies CAP_SYS_ADMIN.  Like commoncap and SELinux, do not audit
> this check: it only selects a limit, it runs for every accounted
> mapping, and withholding the reserve can only make an allocation fail
> with -ENOMEM.  As with the previous hooks, LSMs implement their own
> policy in this hook: SELinux already checks CAP_SYS_ADMIN in its own
> vm_enough_memory hook, so making commoncap call security_capable() would
> make SELinux check it twice.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Reported-by: Ada Smith <adasmithgt@gmail.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202436.2408=
244-1-mic@digikod.net?part=3D4

