Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910563;
	b=k8a07PLHPU6ae5d2QgUQur07JdUafHTccsvpfbBAXcJOQjcrpHJUHTejOmE9smpE9LKp
	 BcCfadmyB+htOpEYm5tM+se/vlAgqACM+Y44Dck3qL8BOfYbcBhCy5HUByx25BakY+SMU
	 1w34D/KyDZmvUCCvw0IbRWGuglSAn2KOFHmtBAktHZ7ItFZ7hNKVDhktDfU6M4IbrhDOG
	 +mDb5doyTKFaKp0yJmpJxvRnRyCJI/L4aBqtmBhnQBsMGQySpzzv/vfDi8alo1P9PEooN
	 jYlIs81TVqEPcWZYNO0+ei/7A+kc0vgyqYnWMQnzBqJXyWDxi4m70m1neG4Fq61i4Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LONQGTJbPlVv8bUrZGZrkmi1u/CQDc87SSsiN9Lvx/w=;
	b=pjHVaZgd2uP5vC8LtsHScqDnIETkx1aOJEDIOLnHl9/HMfixV/qugJcXZaZExJjS+hWf
	 dXzJH2zG8q6OgJgeZ7v6EyAEZkR/YmvHXH3qCNvXTY5ki5EX8jOKDhfypL1UVneFtqrEk
	 eLw7gxTAb52k5+EDMpHdlFmme10GNuLSf2zX3J7CcnW106q/3HnhDFK+SSKwiLTLf6F8B
	 YeMuuuYWf0mHQGyAau921kVWb93pC4vPtd25DHJ/2N44YDouYnsglvqxmmIYSuLcP213J
	 PIE/6+6SOT+zdzVRXyh+AfEwqMkYhRfX2loNJWRdsk01iB9IGhBSeeiAu4gms6Jxbog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ez5OoBMK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E086606A323
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ez5OoBMK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425701F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910563;
	bh=LONQGTJbPlVv8bUrZGZrkmi1u/CQDc87SSsiN9Lvx/w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ez5OoBMK6PJd2SO6EBBKWRfb7+/y1DhYmQi1CmJNbBXh4IQb2vD8unIek//yzsCuf
	 qiB+bawZ5Z5t194b5ItMlDgApPZgu4OtrnIJhYMFz5m/nLjvIcUJfjykcZx5r4/K+w
	 2gtsHvM+yLKLG0jrvl1MdJDlfGv3bCOyvGPMK8t9ejBmuo0GGWUrINh+Q1U5pOBBQj
	 ikOxl4ydTDRmtp4sP2Q++nto1GppqylDCWcRwDw7G/MvCHxtMkz2RvGTGpZ3eMEQt/
	 BznQq16awRal7mC+aAsERkamYEvi2n6DT3+FNzh0/LQPKPmCqiXJnKRstq9AiBB1QD
	 YRaqjlRCTU45g==
Message-ID: <sashiko-outbox-218583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] landlock: Mediate CAP_SYS_ADMIN for the admin
 memory reserve
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117101157.2520463-5-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:16:02 +0000
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
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101157.2520=
463-1-mic@digikod.net?part=3D4

