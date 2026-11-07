Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093191;
	b=skUN4HDghk5G0mq2bc8g3kk6A3Cc31DV+hHuOSVviQmVgOZYVO5YTorusehJ859eV6nD
	 /HRIYlWmBJvKy4dEaet9KrrG0kPKcaM97LKiJ/zvxgk2Z2Mui0RX+lr6tdmhtLWsZ/c8F
	 fdnK30ZPzRf21otiFbRt2sxsROsVveQfMGcy58aIbEw3Zy9OMUvfb3I58lCQt5mBeI+Ef
	 3gYRbuorCnwUGCcV11EOiw05PxdExVDntm3s07kRL+36ukUxZOXX04iZzgePjYAduwUtG
	 ENeKKv4hqvSMHs8xDXtKsY9SZUlXN7yigVcwY5ajBk+EP6hWWUuIkQ4jwwQ6ZL9vyhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UdepAk6i/WmRSKNK4X+kj/qX7m8JkH4idTw5klDwJpE=;
	b=HqEnhoQWtxrJ2ll0Ym62PKONN7YRCVg3Dy5YnxsshZ6BuWAP4U8f2OeDavoyXlPD4ZNt
	 3TIhsHqF5vbuSiWlpmnVzIZYFg1Tx1QwFzeOmWF305UfSTQB9L/IfQOnlxD4KTT4HzH/c
	 3iavmn5CWcvIFOUXFx8nCCfiJwG1MFiKcCYrGoxOmP9EH6sFs/qVrgkXqqVbVQ3UCPLtb
	 Y5sTwdkm7GTV9FpEs0d9EZkLDftAfGu7I+u1KUuyP/f+L5YSFBqSNTiqczNoVDKFI9i3n
	 /Io8SMFlggd4G4bGoY40B4l3wsxobY8pPu0aaP5Glf5/ESn3AT9iLMf0BAd6GqkC7vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgVNsPDn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13973606A326
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgVNsPDn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EFA1F0089F
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794093190;
	bh=UdepAk6i/WmRSKNK4X+kj/qX7m8JkH4idTw5klDwJpE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QgVNsPDnOOSZd4hDgP27ytKP65ThS+8afOn9VFU1H77SSCKJX4Dccp0HPMXpEnJqk
	 UbojGXACoEnm3ELdRZJj/ly1y882YRUsYtqVJBNIlvsiFux1RRyrUuKyw16Fqko5Kt
	 SKms59+EpUB7p4Z5kfhyosf+Hl6zEcPInsQoyE77JD+2snRrfaJN1J2CSer8yN425I
	 r3C0LkGi1KUNhT9m0ahFQDzvFJjx+DRUbeas/wgh69zsRvDVahOrzqwMcK+Kip3yXp
	 Zx1xShutwT8DcNsoS2fKrdD9BX5dIJN8qHt9v6pJjWjChbiRiFjmt/Mo0IKwiVRBTT
	 tk9FznynbusJw==
Message-ID: <sashiko-outbox-203376@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] evm: fix TOCTOU heap OOB in protected xattr reads
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261107230514.1108379-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261107230514.1108379-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 23:13:10 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_eventinodexattrs_init_common() queries the total size of protected
> xattrs, allocates that amount, and calls evm_read_protected_xattrs()
> again to fill the buffer. This creates a TOCTOU window: if the
> protected xattr changes between the two calls to
> evm_read_protected_xattrs(), names and lengths are written without
> checking whether the data still fits in the target buffer. This can
> yield an OOB heap write that KASAN reports as:
>=20
>   BUG: KASAN: slab-out-of-bounds in evm_read_protected_xattrs+0x15e/0x280
>   Write of size 20 at addr ffff888002c59bcd by task init/62
>=20
> Reject fields that no longer fit in the target buffer. For xattr
> values, also check the length returned by the copy before accounting it.
> This also handles the case where a size of 0 is treated as a length
> query.
>=20
> Fixes: 8314b6732ae4e ("ima: Define new template fields xattrnames, xattrl=
engths and xattrvalues")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107230514.1108=
379-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

