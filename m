Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117009;
	b=EEQDIgwjUD5j9acR2wEDOdLr8ztW5uFfC8WuIWX9n+qZsNsCdnBci37ZM67PspDk7Fyk
	 D4ugeVlt/kWufqEj0z6i4cuVf7dQ/VQgYyn9x2OAI3OWLJEuAx0dzkt1GdrwtkWSx31hg
	 ptWe+pmdlYoMm7+uqXWc7sxXNVxj5uNSDLyjgReKCrq9/2CuJxYq9qTczMvHJHHnH5d10
	 juahKJBPpAq2xRl97px9M7lKw/W/FBU/iJyHvbU7jlrZRiRps2y5Dkt2mSg8OEUf9y9WF
	 OE9PZ4IsCmMlkoMkFLtbysO30P716ECnnmZNJ+cIN6ul9TZHOOTYMCxRqtfbNoKUJlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BGE/asKsLGtC5xxb1w2wz/dDicsrs8co3+29pHyRmWU=;
	b=Upzcw47uvlq2P7ADIRfyE4W/OL2FNb1FGtlJuSA1yZaPElUgxtUeTXATOtrO8xUfQVjW
	 0i52d5zSklWrpPkaxw3e9C6ePNtL356wxHRXwtJRyQzpgx9kYjddRWn8RGJC4B1hxz4U7
	 DeTrt0frv+YojNeWcuVnbiUlr2gkAjJOUIKpWapK1WQfXja6nYAJ21DelYsZYMRN029hx
	 8M7xXWvelkjlXbNgeJHS4Cf19TTmc3vhfYGhAdCX6KwnsoI7lBqpcBzWUrtvSJTZygkB3
	 Rl4oaGsgmbyYAABTf8xmqShfzrzAxOI4PwrhTH68Wh/QvY6MuzCkPO2x+N4u4WJzyGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfESuB4p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8E606A330
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfESuB4p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5111F000C7
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117009;
	bh=BGE/asKsLGtC5xxb1w2wz/dDicsrs8co3+29pHyRmWU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mfESuB4pRz6hdi8SiDC5tLtUM5aW4whnSmAG2ICBFUgALj36y+BMlp9egBKR1DGK7
	 LXQb1YGm1pvfkbVkoy9d5ezj3c13S9y5LgWpG/f+4cdNYuOImi2v1oVLrkPi/YxPED
	 ifmMNXx0k4d1JYVwfjMnCw1JZpOSr7/3ELuNu22cFkTQJJPUTyYw4pycGZVrUVXNfs
	 lSU3d3T3yknVIUTqd6VdfGDUGTEOb/D0I5H9yRMybPNfSeIsiL0y6K/Al/yMmMOSqN
	 DSuXn4NWMrA7XPnkSoqs/YUJ5wUjPPIoVl6udjqJu/49DlINHQiHAEErucvyz8jU0j
	 JcdUz9q0uGyCQ==
Message-ID: <sashiko-outbox-223944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 02/13] rootns: Add core infrastructure for root
 namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118193539.240065-3-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:36:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Linux namespaces can be created and entered individually, but userspace
> orchestrators lack a single kernel object that binds a full detached
> namespace set and an init process behind a pollable file descriptor.
>=20
> Add struct rootns, its lifecycle states, reference counting, uAPI
> creation flags, ROOTNS_GET_NSFD ioctl, and anonymous inode file
> operations under CONFIG_ROOTNS. Drop active and passive namespace
> references on final release, send SIGKILL to the rootns init thread
> group on close when ROOTNS_KILL_ON_CLOSE is set, report EPOLLHUP from
> poll() once the rootns reaches ROOTNS_DEAD, and allow holders with
> CAP_SYS_ADMIN in the rootns user namespace to open member nsfs fds.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D2

