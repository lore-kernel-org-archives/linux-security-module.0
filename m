Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802524;
	b=i9q6PfDFXMjhzsHwQ9zS0LbSVoyy89VNNi9ZGNpoBGF5uQ9uejER48LSgsmcSyXB8Rzj
	 tvM4+xv/ece9mWOAOCiwTGPQCiYDlxQoK/PnkyzvTBNmhHedighXcgRiY/9nfKD6FZWrd
	 elccJDwC0ucoMbM8i6LsFS5DRjaVdvXtna+KfHjk/fCgq6SsbYkOfnxya8Kw10Vg10COa
	 xbvyB3tuO9tpMiFq8su7qn3fYli0zeAb1n9VkiLmRRgStZBL85b6nlBACRvzrkrnqgu/n
	 oeJOVX6SDlssgOc2pPdVhwHox0FSasbX0J13S3DWid+DAfBhixPn5Va1f9ac8xgGxmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jkNPiPZWwljmKAhJSVdWdqmb7KR5zSj4POhZiGR7pK4=;
	b=VjYz9VP4tUgouDYu2M3eUzI1NJK2Td8zfyJnyeCUKUIKtvVyNPyq8oxzUkDeVjRsUgtR
	 Oa8hvvEk0EtOopScy46rUWr32UY+p/Dak1mC/P9tnmzC5Zpauj0BUBHmsS5s9dOJ2hh1F
	 fEaocKuiK4OwLfmfff+PjO0ZJtv5OvnOVoEfMURSh1JsXkeKpDJjrlnp1jfIrJjlsFylH
	 nMebSM2uwJjncLn7TWbXkNzhv6Wwo8XjxGwcEs5T/Cv8ArAnqGgqUol358tPKouwdGRpk
	 1mbx9JxsQ3lPXNWz3tBrGsba2+snLxqde1EgPFoU72RtPf/DzspdW5TKfwfJhVsygVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rw4xBWhD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88906606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rw4xBWhD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F388D1F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802524;
	bh=jkNPiPZWwljmKAhJSVdWdqmb7KR5zSj4POhZiGR7pK4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Rw4xBWhDIwzzAvA/24xB91XKu5YU8oqQo0nUbzbodSXj83l/PVk9t4y4peOPLCDp5
	 ECmZHEJZ1puVvK0GKIqPPar9Vgn2kEhV4mIXkxFJIcO6oISoNteBFuyPW3xW2Cgjuu
	 /FhfV26SkMSqbShR+Oi9BhQ6VYRz9nRqf/XsZMWq0a/NV7FBBfTmfKIwsK3gOJqbyJ
	 oS5AbLQQX150gHMNMNUXbkg/Q+OWlJupZsI3fSug5l5OTiysI6oZjdJgKhOwNtE0+6
	 wxxtAHUClpmF0c8fTs+BCrC9YP2mqNPLAwGf5XpJkrKV1CRnBB4rfYSPTIIJBLUlqS
	 FYxKZPmRKsxsg==
Message-ID: <sashiko-outbox-197436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] block: use cred_ids_allow_ioprio()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-9-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-9-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:28:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Use the library in set_task_ioprio().
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D9

