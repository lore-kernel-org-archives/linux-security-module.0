Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802440;
	b=baZEAyEtvW4X55QkGT8aoik9VE9Oh2QseE0mUsyfmbxwcMjJ4+Gq0quZO/fkkNK9iuvd
	 meyTI65dG+fdqGqcL4xTFDMxm/IVG4qAMCzGL9lekBg5L2lgw9aOTw1Bye9aoq1rQE9h5
	 STHMHkTvetbWKp2CmrMutzsrn0jLf3YCS9Ph99hAVTCnnKV8GBEhAljuINyAzEFyM21tl
	 LVQZfv4Afj76+AkID1gfHTaC6zJcWsXEwpRVpTNLgXhiq184BFt9sIklk6VINZPGQXE62
	 AUIU52odiMKu6RwG5cI8pevTBs7wz96NHeNTCXHI8mOfU/KRzEWLuN1FvoNxw1IPogQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YWxqiWpcOvqqG2WFvTeIa6PNv093u+2uMM8skNoP9SE=;
	b=Fd+2GmAwxWY2rSPEEunIOscjKZaJRvvsnBvZCuu/Zd5znGa3iK9XkefAVzmV2QSku4wH
	 hU8qEhDPU+Nhrlh7AqdA4sfmvVRRMMR0B5Gk6gmYRB4YumbfJ0BXZL1+LeUpaPwVpFU7L
	 S/qiuPY+P9z7COPbco/4ViK7eQ3vIUuHHsvrJ7cJOUDqgDE9+7RaNYs+sL9gfK/BdQAHX
	 TLuZyYtgOpCF7EtVZHrmHcX4qHApcBuntb/yJwOKAfSZvuoJe+B+SRVrf4qYq7nVnFusY
	 +ER08nB3W7tADR6FL3etZFZL+TbW7kc7StfvOxSsUn7hhSvmKv8aItM8ue+BHl7nXuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7wsgMNP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B16606A31B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7wsgMNP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AB51F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802439;
	bh=YWxqiWpcOvqqG2WFvTeIa6PNv093u+2uMM8skNoP9SE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=L7wsgMNPuFx/RDvUxWX8jnNH5pIe+ALeUC+XEzF5+UvM9eZBzapRzL4Pdo/v/Sa2t
	 U2oMuffVDBXlnx5q/XJBVGwfIPszsmHd4auSHBGjr7jTJd/ielO60mShxpXVfJ7Hcg
	 TO29Q6P0E7WgQ4RZI9X/sj8tHWfIx7/sPXJYpkwU0MYYVwlBMIUxrHU0orZIlD7pNZ
	 0fGCvv1mUMNRut0IQR37Hm5YElrpC3vwATRSH1582sC5bktE07qsHpzkZ1WVxYbqWA
	 vEcmzWOwRTZ2U/f+eIRBUvc2Hxp/230V89xQ4qFBYjImkGseytapj+mu2DSG3fM7dh
	 MWI793V22s9JQ==
Message-ID: <sashiko-outbox-197428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] signal: use cred_ids_allow_signal()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-3-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-3-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:27:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> kill_ok_by_cred() and kill_as_cred_perm() have the same four comparisons
> each. Use the library.
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D3

