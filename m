Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC18635D
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996153; cv=none; b=cfEO/Xfp+3uYA6RFACFgAZnRzPL7XLcK0n4QncNXaSV4jSjgzbpMxLdsN02Dwdk2M0ahUj1JiLhXASNlZIsSmR7yC80vg1Zk2rYnKS7ITiyYKicgvI7C+D4sR1nnST2ALQplUyQOK77Dr4WFoBHNlmUOo9QMxiYVe7xd3i6Wxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996153; c=relaxed/simple;
	bh=JBMPuHJf2HFvyvd9IDQ7y4064h46xG8bh5nGzz/0yK0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iGfFZI2Gu4mEniuQ5p80dLQC09SaPymxbyo4/rBt5HEDNJ3fh4U4TYkvIF1svdUAK7hcQe6eA+dOaJNNkyjPrtgk1K007VH8741FN7VuxbIv1Pj7CUTBDlJnMVFKj/1jzW1hzskTVjF+dvYtugszzlpTqAoSbz01KG9NuEkNmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMn1dTzE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMn1dTzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4091F000FF
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996151;
	bh=cW3v7tBc+DbZyExytzF25PJU+1Vy4NgnoNdA9GnMlCo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oMn1dTzEZeqphasyqbMAhzdxIUVA3wWYBdp/eVOHPmrfIMh8SYfrr6+by/bKBDxXw
	 phrOQp9YiQk4hLKd2+hMdtdnWfYQ5GW/zjrBBcs5u6P/ta2tItEX/78NLRaOcxMB8Z
	 J3nSsHVLJ+0B76446TKUZuQr9IhgFSK0LIH+KdiRRN34arV0Afy7ZfysIxJjQUhDis
	 xSygdwjg9sMcokkwHrGiIUMgxAJe1ZC6nroD2oZKt0+uCP1ICz2TID3wrnwLbjnWhP
	 9l0CjYN7FBVCCZXt9xSDWUU+P4M/9DzaJiJi8WjoZxIT5ycqeApStBhoM67mgJDSeJ
	 /dPIF9x1KU39w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] ipe: update the project and test suite links
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261003025135.3666767-7-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
 <20261003025135.3666767-7-wufan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:55:51 +0000
Message-Id: <20261003025551.9E4091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] docs: missing test suite link update in zh_CN ipe.rst translation
--

commit 74b3b0aa8d1b1dfdacaa4326fe2dba8c20c146af
Author: Fan Wu <wufan@kernel.org>

ipe: update the project and test suite links

This commit updates the IPE project website and integration tests repository
links in the documentation. It points the developer documentation to the new
test suite repository.

[ ... ]

> diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.=
rst
> index 5eb3e6265fbde..4490aed5918a6 100644
> --- a/Documentation/security/ipe.rst
> +++ b/Documentation/security/ipe.rst
> @@ -442,5 +442,5 @@ IPE has KUnit Tests for the policy parser. Recommende=
d kunitconfig::
>    CONFIG_SECURITY_IPE_KUNIT_TEST=3Dy
> =20
>  In addition, IPE has a python based integration
> -`test suite <https://github.com/microsoft/ipe/tree/test-suite>`_ that
> +`test suite <https://github.com/Integrity-Policy-Enforcement/ci>`_ that

[Severity: Low]
Is the translated Chinese documentation missing this update?

Looking at Documentation/translations/zh_CN/security/ipe.rst, it still
points to the old repository:

=E6=AD=A4=E5=A4=96=EF=BC=8CIPE =E5=85=B7=E6=9C=89=E4=B8=80=E4=B8=AA=E5=9F=
=BA=E4=BA=8E Python =E7=9A=84=E9=9B=86=E6=88=90
`=E6=B5=8B=E8=AF=95=E5=A5=97=E4=BB=B6 <https://github.com/microsoft/ipe/tre=
e/test-suite>`_
=E5=8F=AF=E4=BB=A5=E6=B5=8B=E8=AF=95=E7=94=A8=E6=88=B7=E7=95=8C=E9=9D=A2=E5=
=92=8C=E5=BC=BA=E5=88=B6=E6=89=A7=E8=A1=8C=E5=8A=9F=E8=83=BD=E3=80=82

Should this file also be updated to use the new Integrity-Policy-Enforcemen=
t/ci
link?

>  can test both user interfaces and enforcement functionalities.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003025135.3666=
767-1-wufan@kernel.org?part=3D6
