Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792835746;
	b=dfC/jRijm/T+jGVz8KIc84hEcK+h2tg/xfdlD0OALRTspqJPYwAIdHXoEXULfJDLibRg
	 H1/LVrVn0gDexycDqHJGZ2OqT28CE9uhUaLBvNGNDgiyHIpWeABogYUnBTkquUpNfpZxE
	 ftg73tdn8yDelXLrU28YiOzxFIBQcWeeaoJBoGv8XrwxUBxYvO8savR0X0nEoCtxdU2Ri
	 8D5K7OKI+XLNhvl03bc/PONEsZG+y6EjBlHTRtW2SRi9bdRtiV9x6MfVBfLR6PZLo0fGH
	 FwXI6wMKnwHbOxxv0pgHYdJdEYv2eIUo4Rn9hGwfBCD5eBKm5T2d26XbwQ9FbMBP/FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5pVa5FZXojjnvXSJgDWQbZisDaIP05flZEbBDPL6J9c=;
	b=r8zbxEQAy5qJHQQ5Q2EUn7mJ2vpL2lzZXIBMJZxCNXBXULP6lm07683JCcuxx3NvyXI6
	 MzW5O9V49/IVMHx1xf3aKmV90xEe4nlp4pY3525MTth5AtIjCJBz6vdXL2QlIQk84vmPa
	 gWENF29HiMqGmiZP/aSw0maXbMkVLUbv3PcyzQdB0A/oBrHDInE2qcXLx2Ii8HIRaMCSl
	 abAsWJc+a1cuJlBaTd5+MW/MfXdOi+iiPVgDBlZQy6ZHh33vlgIXYnmybTtRYAWbcy1On
	 Uu0P+NHokz0n79JVYD9UtZ1jN/X8cmSFZ3U10/rh8ZsPq1xmaiNTmQFU5Qq66mu4PZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k66+yscn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D6606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k66+yscn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8021F01825
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 09:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792835745;
	bh=5pVa5FZXojjnvXSJgDWQbZisDaIP05flZEbBDPL6J9c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=k66+yscng7LfR19JVYzsjhRKL4QctcwmQmFjO3lqfdppYrPG3J0xhCkRg2zOWoF2c
	 /Vw63h8LHtWqeuBCgWp0bJdQmyKmNmWEedm9NmPUyDjXgPu7Ka25KsFvZbjoxnl7yP
	 ojknetLfwfZ7nkdUwLZnzqxLiSl72ViNsnevm0JUNqyDmmkoo5BVy888rfSny1ojOI
	 xLE4qrVVyzAMlNCNRsP9BITFcxBbQfyTgRb9uRcKKzSJHCHk5PcSIfTHSG1vqXBHoG
	 3H6nEE5Ri3C5/wHdzQuwAw4QUWCE+IHvHB106xrssL8mEsEIZ/ldyQSEQUWlrHcNxf
	 xdQX0pUvyNq5A==
Message-ID: <sashiko-outbox-183635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] ima: audit failure to supply detached data for
 modsig
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261024093918.2929374-3-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261024093918.2929374-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261024093918.2929374-3-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 09:55:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_collect_measurement() discards a modsig when detached data cannot be
> supplied, but the reason is lost.
>=20
> Return the pkcs7_supply_detached_data() error from ima_collect_modsig()
> and emit a separate failed-modsig audit record. Keep ordinary collection
> errors on their existing audit path so both causes are reported when they
> happen together.
>=20
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024093918.2929=
374-1-Jeremy.Jean@oss.cyber.gouv.fr?part=3D2

