Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785772;
	b=RQG5i8o4x2/8N2MNqfCbk3WOxu26rxqESlCVdBhM9z5RjPaMAsyrflMwuVVW8+0JpuEF
	 uymmYDvinw3qvrFJ8YKsCzyF5MdRzl4IjpK0PfGwN5wJPksY8NYWtwsNfoVTNi63r/Q4y
	 vVgf2BdIrJdgkfcGMDcTv2D8roAmGmkfwraHAojHsTilh94maWPZhE6Y+etiHP3E3+hkT
	 mpg+ROPkkYX0l7Ux6579evgnb2+7cYVc37C/izZ4tHhhmEhUo4kzzI8X0VhP5dZGRLj3M
	 SRNq7AUL7K9QwKAxz+h14MWiPptiBbJKEUZ/z/5kLkIwhi25YHo+JUb5iMh7Kx35S7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785772;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sL5yvuHGsnYSKt7xSu0vNsDFpAHGkhQmvgSyjWM0sUA=;
	b=cBrt4BH+UFzMvbHeXM0e+bQESBIeN01Y0PsLlbA56raiB/JYkHm/YFAvx8Np48Y+BKgH
	 3dq/0JqRD2UtZ+Yz+y2oPjWaS1m2y9GZOl8TBepVktRgoH5hrtPrYKyFKr2r/JNpZpgws
	 1SjXIQYBc9q1RLP1B0I/+e0c34ycWETHnVa3QcdFMYeIEjM6JehPhgLRXreC/QMfEEtZA
	 scDbnsFkVBiUzate/HMmwAIycE28UJKj62gGUrlBQtGvvsjaj3bh2b4ByQvMRnrfS/r05
	 33WdWI2LgAwTmYbegl+I90hLYDr0neMrxb31OfhmpljiWm9Pjhk9yGjVzqDYQXcT0Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0hTXmVB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3D606A31F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0hTXmVB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA121F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 23:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785772;
	bh=sL5yvuHGsnYSKt7xSu0vNsDFpAHGkhQmvgSyjWM0sUA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=E0hTXmVBkwFRvFjChbIixtPE5B37QghveOkm8PRlA6qVkMzy6akJDBbLWPhHkCSiU
	 fsTtOXgwAmcgMv0P5oPPU77JF7JZyrCJ//HAERQxz6r80oxkknsAmwgX0+KAu9HiZW
	 Sjhbf00ftdyqr3hICW+yDywmZQ0RyoUhQuEYGyMv4Va+7SG0/Fzbc8cya8H9YDJHVS
	 NE/XYeZZuf+3LIOtbj1IcsTS9yIqQzQK9LIu3t19CvjqctJWQRTpzOCkOnC2M2M+eM
	 9W5zG7adNk/B4LW0amtzHhadkUzKNmpozBwdzhmia0shYJ6fNIBvfLGMSNgPU2oxVc
	 6asDgVcmbciug==
Message-ID: <sashiko-outbox-215906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] KEYS: trusted: Remove dead branch from
 tpm2_unseal_cmd
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115233156.1485238-4-jarkko@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
 <20261115233156.1485238-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 23:36:11 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> TPM2_Unseal requires TPM2_ST_SESSIONS, and tpm2_unseal_cmd() always does
> set up either password or HMAC session.
>=20
> Remove the branch in tpm2_unseal_cmd() conditionally setting
> TPM2_ST_NO_SESSIONS. It is faulty but luckily it is never exercised at
> run-time, and thus does not cause regressions.
>=20
> Reviewed-by: Jonathan McDowell <noodles@meta.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115233156.1485=
238-1-jarkko@kernel.org?part=3D3

