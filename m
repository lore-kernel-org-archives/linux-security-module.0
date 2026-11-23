Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394329;
	b=wAXyBOfKIPMHpCKHghxa5YGpvJdJI6QT/JeJg1q2xlPykvnICx1vGrqlU92edH093UWp
	 XTmzSPh/4ukvi6yoSayW0JdWvt6lFwvFMvIGHNJUK0cLaprIo12mSE5GAI3Cn04TzUfRY
	 YvOCi/JdfK7iz9ZzfnBxW/4wrWpv+jY8vVkLhzlyOjEalQSXVF7mtPcJYjiHmvM9QB8ax
	 Bp9BqxODcCP5m+jcYr9Eak/xyzMTWiYqTpod/1NJ5sjO5wLP30Jv0f7cqhOZIPJ79KBJE
	 TjX8phTKURbpMSMnPi7UYxjFIlZHv6tTaqkW5WZ7aGYWqbjOl48wzHlKA2uGkJ/aVmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0+O5PURfMKP4EtXRRs8yXi8q0nNsUUG/YD6E6jjlZNA=;
	b=Md9NwE4b0VEWNhh+mIlXYOM0zA1wkmPdxoZ4Q2GNIsCZqsp0iosMjayjNGvJukk8rMMM
	 2VwYI/F+udZ5+2t8B4TbGDtQywHWj8nJDYqXK5vFIJ0taCINnjc5YEtBeisIcJ+XmRRWF
	 p3QFjbL3aXXIMv+hQuMHzlUNBZth+JClAUCvkXYZfQY3g5MwukblW/K2puU8JGNDmzfTT
	 4CsoLSWsBnIfI8yeNzolsuIaxsdKk/FOgCziLuap3b24GW6zNjWuVHOX7VGvDGPloe1M8
	 M7/AJaAbPfX9BcyVDe2hcYuUCTOJNFrG7Fze7fMVEXW1sFU6F+QOgtksC/J0cRM77ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPpkol8g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2AE606A31E
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPpkol8g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D6E1F000D2
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 00:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795394329;
	bh=0+O5PURfMKP4EtXRRs8yXi8q0nNsUUG/YD6E6jjlZNA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GPpkol8gLq89b8aequYCHkVIsNWelTgMM7VLMmXU2zBRW2TH0/Iv/4lgtOwSvoxq5
	 S9J1m5nZx7bS5AywBhGx5mBn0c5ZbYCyOLitEwVfAwqVaQLLDyzgVlNIt0cSGetI2Z
	 nSe1MMxPayAjZ8xdClvtPbf1B5aQbNZrPTH9rBDyzDDEAClps7psqw6KNh9N1u6hiD
	 /GFFIylh51afCOmYYJS9rPC/YzlcQN/k3A8XWM/ykjhHf2XXcf5Z3/jgXrKO2pgrC0
	 4IR8yicsHj4cbI5mZgkN8ZoHPIZY5n3us+6KD77thV7ZnsRw/S6lFZbvyVv4C3cKRO
	 X8tzC+b2BPEdw==
Message-ID: <sashiko-outbox-228481@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261123-x25-v1-1-4432d3892f8b@gmail.com>
References: <20261123-x25-v1-1-4432d3892f8b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 00:38:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Suyuan Wang <stevewong@hust.edu.cn>
>=20
> x25_make_new() creates the socket that accept() returns by copying
> fields from the listening socket, but it never clones the listening
> socket's LSM security state -- there is no security_sk_clone(osk, sk).
> The accepted socket therefore keeps the security state that was newly
> allocated for it in x25_alloc_socket(), instead of inheriting the
> listening socket's security state.
>=20
> Other accept paths (bluetooth, tipc, vsock, iucv) call
> security_sk_clone() for this. Do the same for X.25.
>=20
> Found with a static analysis tool and checked by hand.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-x25-v1-1-4=
432d3892f8b@gmail.com?part=3D1
