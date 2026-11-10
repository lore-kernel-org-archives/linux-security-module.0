Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290301;
	b=WcBtQEWsyyVZL4vvLCZcVw9+oaI8Hg9aPH29gkoa7hWTk4E20E9WfIFlG/DWfIJ/ERzJ
	 KwYjgB5g/mNluefyIdv6YjRJdXYV0E0FIue1/V/sRjrAUAihwrNWPQRel8nMra3g392I4
	 PNwsi6W4mlCRQsOu73P0OISFjO00DhdmOsvXXnS+qIpp4HR3rNH8t3Uh+QTfKmpV5qMdP
	 60YZ34I2ehF3l9Jc8baYx2+EajI0NVLhCnM8/f+4xy9OP/HkiXT/WyVk5pa5b1QetZUK5
	 NUSqO7HFql6kBG8dMbYbG/yAvxfHXNJ55eGTJgOX8jcg/05RqjwteWZRe4g97ToUcgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290301;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6ByCSm9RST2TA5u29VJI0CFJqbmfja5WdG0kc0l85Wo=;
	b=D2ABj6FtmSjSGhcK/CFr0E/f2rZQ2waqMjcj34lw2qBM4vRO6WXXZGHuChdMuP/I6tOB
	 uNKRVnTlj0VNAX8DSBUpjjIMF0/TZQz3rkZsFw50JixVeNmqSTFT7aAi81WO8LIH2meOS
	 bj6VljDfrRSScV7k5iTs8Rgp/hAu99EJnvdCIiGuhlHpCzAKN3fDNwSiCOatUhyaq0An/
	 LERsin6kR/cPNx35rykq4kpQjoe90JnpXthPAlD6BBuxVVBaLWJvZHE+Hij60uyQhbTbZ
	 8lmwAK4ozjPkNwMeAQ9hW4wefRSZbHP0M4pJp7dwo7UEdwErcG5Wz5Nc0XINxP5I8Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5+gRK8p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF759606A321
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5+gRK8p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695B91F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 05:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290300;
	bh=6ByCSm9RST2TA5u29VJI0CFJqbmfja5WdG0kc0l85Wo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=L5+gRK8peE0ScAE1phBLW0P/tAcmxNKjWnaso33PqHe9JfxQuocqiGzUHLzzCTlSy
	 2OZFANXCg/jwpV0U0z7pbyHoYdSUH4hF2ZMKgQzFxJFBUIwZHIDJgKLrF1gUN4VxDW
	 iwQo2laSxcm6oahnxk6FY1cGgOpCZhYcCvRiyYtYP0WM4KRsxo1nXGV0Oq/JxtvGbc
	 bBpzF0J9woNELKPiJJEBKM0u+PkznKS98ZpDM5BlY+icR2s3UqDFcSK0TxqyeI2jUW
	 g1JXxRlkYY0KSfv+6leCmO2pnGWZyVIyGs5d+lw6VeDncqsTB0QvtM54MajMTX8z4H
	 aW2AOthiX/uZg==
Message-ID: <sashiko-outbox-206379@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] lib: Remove assoc_array
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110053323.2936729-4-jarkko@kernel.org>
References: <20261110053323.2936729-1-jarkko@kernel.org>
 <20261110053323.2936729-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:58:20 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> As assoc_array has no longer in-kernel users, remove assoc_array
> implementation, includes and documentation.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110053323.2936=
729-1-jarkko@kernel.org?part=3D3

