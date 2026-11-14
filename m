Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675537;
	b=To4pfriK2O+VxrwcO4iTzTBTcmJjkQPW3VIV41DPN1FC2rMnJjgFVbLiwL6guaGQDfn1
	 5H56DRgkfFDFMNMvZE7l0jKs3rBFYDWYb9XgftxTU8+8Anrznmb3sXW3naPmLoqjgttIa
	 BKw5uV5rAJYClTdkcL6Q+sklA3yULVewBWcvb8QmoQDn507um0nN5x8scKOVOIivyLHMb
	 tXPxwAg631ZXXS291K5IPZS+fqaDPMJSpxaHFrh/sral0zh7E/6Gifzg6MJeocPHblmIT
	 is1lK31ownqO/nt9681daqsGUn1fhchM3vMfOzhM2a3QaKiPu0PBwtfHX1hrGCONf+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2eGdT68psL4X8QsS/C8S2q5ZiOqgol/Lo1pzAOBn/PI=;
	b=Wc9Rbg+TUcDMd7WT+etb8PTWRLzyhR9Yxy88rg1qtVlZd+vTPwf01OArfdn1kn0LqxKb
	 qmxZXhPF2DVL4Gxypj/SHfLLT7W1qMgz+worK51UTFSosU7xu8qj0tioXI/XQlz6wF6JA
	 UsUBg36ANAa1Mn0ej6nkGedk6ResCXNcxnSbG8zmZP+dLs3Kg/+Y2myCPRF58Pz/+fx6I
	 JolVLbhrv19EcURURW9KWqrd7Czg9q8LLD8PK+/LCSPvcr2Uk0/abfng26NnmEmKGidxp
	 5XdcgVH3NOj4UAl6+Cgx+xbHsmfaueQ4y8ZKOacMs4sMoCVkGwgasExDhQ4PGMnjVEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiV16Oog;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F6606A329
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiV16Oog
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1102B1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794675537;
	bh=2eGdT68psL4X8QsS/C8S2q5ZiOqgol/Lo1pzAOBn/PI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CiV16OoggR+c/CtaqHZUMAbyqLT0ll7MiGoMqaaggWMHInOJAsiLai3ZFw9DQC0HH
	 MvixO2FD9nQ/ozmv4tVCZg6AjZV8kxZUUCYQdW7nwckZfcWCSx5yM7uXy052ljNmyv
	 m4MgVWi6lcBe6pNSXii4/3s2mFXsBzPxcfVvuMQU14snM6WAhzJq/1UjWAloPDkBU9
	 HEMxsUe8JdVJbQntp1k39ljHRz4qrubPC/an4ukJ7yAeWeKO3wWP9I75qO2QZ+LppR
	 1XABIsKywquS742cw+sI03YoUZurqkj7nd+NdaNfe3J4R3/zeNlynLoUDC/MI5lwBA
	 uCRllsmClgQxw==
Message-ID: <sashiko-outbox-214793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/6] s390/cert_store: Pin the user session keyring
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114164139.429814-2-jarkko@kernel.org>
References: <20261114164139.429814-1-jarkko@kernel.org>
 <20261114164139.429814-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:58:56 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The user session keyring stays alive only because the session keyring is
> pinned by current_cred().
>=20
> Pin the reference at:
>=20
> 1. find_cs_keyring()
> 2. cleanup_cs_keys()
> 3. create_cs_keyring()
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org # v6.1+
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114164139.4298=
14-1-jarkko@kernel.org?part=3D1

