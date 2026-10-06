Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126054704E;
	Tue,  6 Oct 2026 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246852; cv=none; b=CiR2n7hW8UmLePlgExquXL/7DPaTOyEG2KuARkQa5FZ04iPm4QAd9hPPkzjParnRvlIThzTishbJogo9cIOrkFucMvoH1QvjXqFpLVctgle4XL1hgYv8/kdxoYvFI7O8UiVluONWCnJYPDjwHL6DKPm8Gtz1gP+zMwxpmqe0zpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246852; c=relaxed/simple;
	bh=ao7+E/lQum6hSz937QrJc4b2AHiJ6KRiOhlYn0F480A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uvZ3SggO3WvsFwpxfYG9P75c1wGLxtB2O+CpGyVGpdHEZaE44PBJEzSY80kU+Q+yUQZH032IQ/H6JIyHx11P5KUDasNLF3rRThe2r8XH+RghBK5Vb76ENtJWnsZm7hevrYkZyhea+f9NnCfPcsOLhzj73R+h138oZ07gu0G7AZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+ApPu/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+ApPu/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05F61F000FF;
	Tue,  6 Oct 2026 00:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246851;
	bh=SPENO74RWlG83tx8JLOSvNdAdPeMQu/e5+88ynnYQ2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+ApPu/PxDE/pbD/7gBOsxpJ7xUhZPmJGLqp8VEuAj1uOVeg6hyMo/nXbFG3E5hKM
	 rhbYTi/CsAug0yAvVI9kjpMIR15vwOVhrDSJQBl9AR8Rk+WZlWs6T4BML2V/PMAgMZ
	 EJF3881vuHyOuacNtgjzxu5T5SeHwAFAr7IkFG/LC+Dep4gnWnPJOVTyrSAWpuv5ly
	 puoKr35W86mSJZqZ7dAk3l+jpq1A7TfSDJAfraUKHV5lBQuZEbxWD5zc08JZAQAP3W
	 dxtknvaJl7IG6+oiwkKTRx5C0xcwRcZdKurWUiui09ptx0S7gnxc7X0hbwGFrxKXWj
	 99KaBQRuU4oqA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 04/12] bpf: mark struct path trusted
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261006002020.2890858-5-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-5-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:34:10 +0000
Message-Id: <20261006003410.F05F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Walking a trusted struct path yields a trusted dentry - a live path
> never carries a NULL dentry - so BPF programs can use it with kfuncs
> that require trusted arguments.
>=20
> Signed-off-by: Song Liu <song@kernel.org>
> [justin: carried only the verifier.c hunk of the original patch,
>  trusted instead of trusted-or-null]
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D4

