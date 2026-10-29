Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312309;
	b=y68Kmg1KukR+c95Eis7cWQ0LhIrQoIL8+FWeKj1b7lNT5Uqa99s37ZOTgF9hreQnHsd+
	 FW4B1x+/bZ1kDOCEsPehzRDPkbnwXRTiok2+lpSz3Sq/tVaq9OT+/mX/6+Btzjwv85efg
	 ynPEtSLOHZIDlcDUWVoKp8159FYqLnD7IhoBlN43D1d83adGYcJSBQSDwSmOl885Oa+sE
	 vjiQU+/i72gjmo8O6vZBMwVvaTySPnXZsn9xTSLWXQsfTnkk0nHSSE73TTixD13A/tiKq
	 AqNgOw6mYFTJH3aLrlQ6nEMZZQlvZ4B1R9wf2f/9N/nn6pZROBmAolmaGJlSQ8ZX7lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lwmtQqn7O5/KZ9XTn6YWWb1+BkGo6/iaDw+973oLD/Y=;
	b=jfUOzgcTIAcANbzAQEZp6emx4X/yVNBZGvAQhDVrzAnvH7fHftHIDSoOeEuOTjy7KoOY
	 mmLnTNGat7nAAHRTEcK2i9z1LntupwOBxjdCQ7k6wjJ/zuy/rihKP5sY2cl7VDXdUC+NP
	 jFrzwxoxi/vesFwXq8CqvrImJ9zJ4741flHixotof5FAOGj3zvZbTI2PhK/ULS8KppRE0
	 O+mKuFxEC+2xlBk8OCk6eQXuMZTVINDXSY75wnZyZnyb8IpfK5UD5HhYF40fSWPnXbAij
	 BYb03ciQ1NS2AdS2ebFRRsAE2VyzgPIidAaWFX01CziQ3HNxBjmsIJ3uIDyyA6hT3xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuDHzCHA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA3D606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuDHzCHA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42B71F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312309;
	bh=lwmtQqn7O5/KZ9XTn6YWWb1+BkGo6/iaDw+973oLD/Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CuDHzCHA5zdp/aaXns2s97q8FeYuZ4ttue0XCc8zcD7bPmrSfWnv59MfNZydflMtJ
	 eeu6H5tlGC7kfEs2ImxUNWP+6aQEuR53LPGCyU2RKAg3OmGWdLjcwnWgF/GEPSwlXw
	 NVP3xDE8AfyPq8d0ixHjTUTY/lZd0UQ+VuSG/R+lmmyv9IvFJHvVxz/lw0Hp4ac41C
	 uRiHxzkyYJiWCqG7J/KOXYo2ZBS2I87hwxKzNWLx6b/0M4gdlm1KhkBNsUXNzgfBPD
	 edYh59hFCbe2gUbKnW7KrnDZ2KSM2bepc/SZKqs6Q0i6GMcFTUc+g2vtmaayRfaMUV
	 cFBB8VhtczdlQ==
Message-ID: <sashiko-outbox-190066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] selftests/net: add test suite for
 CLONE_NEWNET_LOOPBACK
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028221705.3915340-6-halg@google.com>
References: <20261028221705.3915340-1-halg@google.com>
 <20261028221705.3915340-6-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:18:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add tests in tools/testing/selftests/net to validate
> CLONE_NEWNET_LOOPBACK and UNSHARE_NEWNET_LOOPBACK behavior.
>=20
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028221705.3915=
340-1-halg@google.com?part=3D5

