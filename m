Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187815;
	b=ECfSdWQDkoPjW4bB3HKHHMVW5lJQnHNlzgfGhZigeVTR6mrWeqjpXNQR4hSLwhrmstnu
	 a8zOZ5mZ2kFGc++k72C6CWZTyMazPTjhV49l3mpRiZLJTYG028jcvZ+knJrbpdSa41ewT
	 +0oPc34s/l1C974+8aRQ3AoXNmw7JkHozgCEO0tOZMYdRYU+Nu2R6LIVy/3G0RKFzmQhG
	 IzInLgESNB+G7bnxZOiZuIf+0Tb3jOHtj+OHHNGWL3VFroPMp3BmxH7eeEy5H/ij6dIlc
	 055yovbyKQ52e7vJ110SmrBN28WSVAAhYussVrB75DNjq55NVg9Jbcl6/14oarrf+vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187815;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XR3iKVmVXEjHEufPWT9HQpadMzRYQFDWaJpi2+oHl7g=;
	b=A7++SjXSXHe663Qd63VzXHp0ETUqMei5XzAqy/NeOuFCtqioBn/wSZHcel6wj8j47LmS
	 SqjdnK16LKmITo8WFsc0R8UaoJlCDzjPdSC8tFvYEF0GdyX33WopvXV8xWHiSPdcLfc6J
	 oPztPf90XH1AHgC3SeBtyj1dDtlIzbdEtuCgFTxxOkkhq4VT48h/JnhCyccXJBhv8ty8B
	 c+fi958Q40b+9odPJIrOwRYIKRd9B1uJMXveqYJXtEVKu9YAZ5Ru8gFrwRMhpnSPloQxJ
	 +UqrHLYd4EgtpNc++fWa7IK8NuSFs2hG5ZVUTRcqAAX8ZIN6vJR2EM5bLaH5+I+onVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIDL9kks;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF21606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIDL9kks
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6891F01825
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187815;
	bh=XR3iKVmVXEjHEufPWT9HQpadMzRYQFDWaJpi2+oHl7g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JIDL9kks3B8Iky6pCp5avY50BGKbqYqt4a8bcdgGlFTrgCn9ir7R0QkbnPx95Edaj
	 DqouqB/TIW1sYL15g/IfTLjz1Z5kiAN3AORfpGsem5Ptj3oagSs6Db7wXTfirXhLZm
	 3cVoFjaKQUkh5HBeZthCReWE+05Lr0BoCbvDn0bWDLv68eY6Sg4wLvbs2LIzOarcG4
	 g0RSg/v3x8kRQ1geQCzU4Y1e7YL94HFowbGlX91xBfQ2TrCm23RUftQ1dqV1sTHdM6
	 5vPjz4LPPbmbEk9cucjFG/CA/EMjLPTuHnWhZn0cfz1Egi0IIyZ+92orpfLvsQjfZu
	 tlg6fSEllMQvA==
Message-ID: <sashiko-outbox-187837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:43:34 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> CONFIG_MSEAL_SYSTEM_MAPPINGS seals each process' system mappings when
> they are created. As it is today this can only be toggled at build time,
> so hosts that need sealing and hosts running software which moves or
> unmaps these mappings end up with separate kernels. This is not ideal
> since it adds more complexity of deployment, it would be great to be
> able to have one kernel which can configurably do both.
>=20
> So, to improve this, let's add mseal_system_mappings=3D so that this can
> be chosen at boot.
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793094611.gi=
t.chris@chrisdown.name?part=3D1

