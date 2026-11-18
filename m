Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978582;
	b=tTa7ZgLKBzmSm1bYP+0TcBYA05KGT5qUvCEh5TsMWKSQ9V3UGc0trknPce1msphsMcz+
	 cm2P19025kpELB2J8cKL816XYvdybbxmyx/f9Wxp/QM1hi0OZ3KXZVFGMmyKibPNGVeHB
	 mOWoPrnBKVuW4d9rJx5Ybdt2npZO28hvWI0Nm6JBXbRp4hMrwRzQu3KFd5O1bK/hNQ3U4
	 jNBCpFfChUFkGiub/tNs4Cezhe8O2KZgjyolLwUxD+F5PsfsgFl+YzEIThfBB7lMFrVmW
	 jshtzzw1m7YVeFpf4YBzpqAeh34Zqfqa+WADdUodpshO1gf93GQOwkpt/nxQoMhNgwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RFWLzJTa1F1qj6O6yJKnNQF1mekp8KXdHDa7LRiolFM=;
	b=hCZSFuhxHAV3zvP2ybu7gdpnAuo8mwmjGL0xzRI1kddSEn1MIEGepMyaCdahhdsWQF4z
	 FzYK8FAgphPmIlR1qgcECqVRFUDDqc3WhIsUX3ouhlOkV7aIRskr6dq+BWOJK/mo4RDT+
	 CbuCSMaJv1nEVTCVgDv9JM2rscplMLbiz+2tgmf+kvNYURhD9eWcLiNLZWx5gdFjdlIaa
	 LWFSMtZy/ka7KiAIU7GNGI7nU2zOmcZVmxVipVmdAsMz2GBliAlfDny5ynqzFU7AIpe5x
	 nKR8Nstz0+tGOj4+skLHDOeAbBQk4kWqFI8wD98mbwvnXqrjTNpmeAwFmAn57gcRpYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVZ5eKDK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7A606A32A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVZ5eKDK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B9F1F000C5
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978582;
	bh=RFWLzJTa1F1qj6O6yJKnNQF1mekp8KXdHDa7LRiolFM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QVZ5eKDKVssmgtpaM0d7ELjQQIKt+AxeEjzjVTMiOx9ceIOHXH0pH5dwpAWShBIo7
	 rSBE/FgGzU3O3bTq59TcggTCuMu5nO5Wr3dt3b0LZsiENQLdS4c4XpvOz081LQpUVT
	 OwFvr64xqpPPj746srzLT3BuIGWN9nIiCil64PklH2U/3XAYvoEdWmuI05QbpdXkEK
	 QqSc8N/fJvv7JawhmRqrSOTlkWgqB8KJDuaFjaHjyH052sudRk7vFbrLa9yh+0se0C
	 ipIpfA5xGwKaxXWNshJ1hrLiOKhKT4Xcf8l1z0SHih93TrKKRI9ZXPDgVMDSjeq/MK
	 EpgwfB3V6prtw==
Message-ID: <sashiko-outbox-220137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/13] rootns: Add core infrastructure for root
 namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117050841.3289652-3-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Linux namespaces can be created and entered individually, but userspace
> orchestrators lack a single kernel object that binds a namespace set, a
> root mount, and an init process behind a pollable file descriptor.
>=20
> Add struct rootns, its lifecycle states, reference counting, uAPI
> creation flags, and anonymous inode file operations under CONFIG_ROOTNS.
> Drop active and passive namespace references on final release, send
> SIGKILL to the rootns init thread group on close when
> ROOTNS_KILL_ON_CLOSE is set, and report EPOLLHUP from poll() once the
> rootns reaches ROOTNS_DEAD.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D2

