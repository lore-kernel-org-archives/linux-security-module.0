Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229F49C4A0
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302308; cv=none; b=ie9TRMVETTU6h7ial5o+56hGX10A4IZiIuZ9duv6ZtJ8iQGXqO56cFnDaFTN7bmjedPbIb3kk/fU+ebypzy88YCvFX6LdZzsHoZft0YzqY28knT0b0UKBiidlEAbKtS8SY6ZKFQ0D8Nxv171Wd/J5ZL7RInyuXNzZXI25kU9nA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302308; c=relaxed/simple;
	bh=BuoV8gzUiN2JQkfCVrLZf5PlwNrc4PyAcwGZcGWtW6Y=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CYzO4uBQx9Fo2mVQE+4d1z12WbAJbon9aA7fgJ5zJkmLJRBJiNecDdcSDRXLOpRh3cpfZxBw3WeZTXqteB6o4Jh/yi8lpBmmolIvJHhAXvdryuBHYQkFDSZI50gZ21w4u8btUqDTQIpTpIIqZHwluKE1cG/ByF/d1nes7MTnqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsRwy884; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsRwy884"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E451F0089B
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302307;
	bh=dVHT0VScW17cLJL/MzriT3nwARI8eFD2RsjoxyBK7M4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MsRwy884gZ54j5SlZjqw6Yw8M6t3KkT0YEyfQ+QWcRsu3SjgjMGk57MsvpvcWDNn1
	 jOUW9DclDClZASSF5sVmLACuO7dlCgVG614tT71k6CwdnEG7tSbJ4CQp1RU+x2LobD
	 bgXhcS2ipLDX5rRHekdn0U3vMappFoh4eqfT3UduWFf1yjB6mItwdJqrtck6tRg/4a
	 2RwMXPDXf0fw3XKPJebBleNJcGH53eWT5vPOPTkacKLDtgPCB2GNWSbmjwBa1SOcGg
	 kdrxq2y2tlpPa/i4CpKufDu2UmMEs574IaXzIApRjdV8TB13AZO0lI6o3mtxqnNc7n
	 ITzqHfqvpKweg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] cred: record how far up CAP_SETFCAP reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261006-b4-setfcap-userns-v1-1-f47e7ed66072@toxicpanda.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <20261006-b4-setfcap-userns-v1-1-f47e7ed66072@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:58:26 +0000
Message-Id: <20261006155826.E3E451F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cred: use-after-put of user_ns in userns_install()
--

commit 4646fadaf7eaab13c361fe3e2861493a87f5e140
Author: Josef Bacik <josef@toxicpanda.com>

cred: record how far up CAP_SETFCAP reaches

This patch introduces cred->setfcap_level to track how far up the user
namespace hierarchy a CAP_SETFCAP capability extends. It sets this value
in set_cred_user_ns() when entering a new user namespace.

> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 1b23d819d3983..6b45df3a8d826 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -44,6 +44,9 @@ static void dec_user_namespaces(struct ucounts *ucounts)
> =20
>  static void set_cred_user_ns(struct cred *cred, struct user_namespace *u=
ser_ns)
>  {
> +	/* The last chance to see what we can do outside of the new namespace. =
*/
> +	cred->setfcap_level =3D cap_setfcap_level(cred, user_ns->parent);
> +

[Severity: Low]
Could this result in a logical use-after-put of cred->user_ns when called
from userns_install()?

Looking at userns_install() in kernel/user_namespace.c, the reference to
cred->user_ns is relinquished right before calling set_cred_user_ns():

userns_install() {
    ...
	put_user_ns(cred->user_ns);
	set_cred_user_ns(cred, get_user_ns(user_ns));
    ...
}

Inside the newly added call to cap_setfcap_level(), the provided cred
object is dereferenced. Specifically, cap_setfcap_level() checks
cap_capable(), which inspects cred->user_ns, and later uses
cred->user_ns->level as a fallback.

While the object is independently kept alive by current->real_cred->user_ns
during the setns system call, does this pattern violate object lifecycle
semantics by relying on a logically dropped pointer?

Should the reference to cred->user_ns be saved to a temporary variable and
put only after set_cred_user_ns returns?

>  	/* Start with the same capabilities as init but useless for doing
>  	 * anything as the capabilities are bound to the new user namespace.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-setfcap=
-userns-v1-0-f47e7ed66072@toxicpanda.com?part=3D1
