Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692525;
	b=VyQ5tny4HRB4a67BmaYvYvpcBI6v1YAbGKqSMoGJ1g4O7L4LtLxQramWn3gPgo9UxhVp
	 JIo+o8ScS8fNXKFugynLG+mY2w9N6fkAZ9mTQewSvd4EOBJ2N7EuDbhVjxH5qRmtHyALY
	 1qGkeIcba3MTAvLeKwcspwQo7yojwgsTq2sFpmCb6JwKaGvXpkcm5WLqVXtEowSRuXVth
	 MHAY8q/1gd84WR9PXEvEeXZajMiRunb57QrVsbyitsq4fYWl3NJIz4g4+sPTEv3nq9AyQ
	 2rsbQeZ65ekQRhJCF8PrMWT8MTWtQP2QYk+magaAH/wuLr2lxsOasbV7NizK5KCfZgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692525;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2ZOtaHheV5P1mGTk82tnSvSNfXgcxwo8AI1wKRHDRsA=;
	b=WmSLSoP/Lmf+gVU45Oumf8SlC0jNzLg4HchV8JknJHKPsUf3WS1R7r3R2jp7KLvYjZsQ
	 ZrjTkvj5p6E4K5WFLhCFq/nmAbItXVcEt81pwoZqScYJ7jhQ23jFXYjc/36uSU1SMUJAN
	 sGV9WWsvyLaNH8tW6IBt8jDs2OV2RSUlAfqfl0OSXml7He829R0c0DNxfo7EIu5fAg6s3
	 wcuPUYri9CK4FimVN2QGZK1NA+uNC7fl3MRDWP+Ai6AiobTPZf/bWiTXZ7HOxJRTLRBp4
	 8cQzA76r5CA2YbxpZaJqHgf9BMYsO55UP9NWlGOlxmTf2p0X+30KL2HOKeZkt9DF7Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hjn3BKf3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C4606A32D
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hjn3BKf3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C4B1F00919
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692524;
	bh=2ZOtaHheV5P1mGTk82tnSvSNfXgcxwo8AI1wKRHDRsA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Hjn3BKf3U/EAeQG5t5Sv1ZbeeBnvTyUbS7LBN6ILrb8+3cEuTUT/MmOWkBLejqF7z
	 WjDKj2dvST64TwbuW9uPDnOdf0ry4AfNp/GkrnivacW/6/LVVIYxfhvbFQhoogXWJk
	 V6W7IaFkT1leBwSRgJoXNP7CrfTnqHbRV9Hxjhs/uXsBIoLVoaKz9K6f3WTzutYLaA
	 faKWshdIUSxk4ANk0OkQoCUgzg4eGlwNP1u3BliH+6mXbtS3hE1cpNfxhzo1hnQTe4
	 voTte3ZrIo81D7CoWXP7TcLP8709gwsCE6cDcnsZCXPn7lpFwIA0vDEoWTenc1BZVa
	 C0qgaezmt239A==
Message-ID: <sashiko-outbox-194776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 5/9] lsm: remove unused lockdown audit data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103082421.3033195-6-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-6-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:55:23 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Commit f5d0e5e9d72d ("selinux: remove the SELinux lockdown
> implementation") removed the only producer of LSM_AUDIT_DATA_LOCKDOWN.
> The type, the u.reason union member and the audit formatting case are now
> dead, so drop them.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D5

