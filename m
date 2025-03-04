Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8427811B
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109810; cv=none; b=XTm5pGLndJxrN0OYXr8+mz1zWqWFVGEyF/Hv7ONJ7TsExTIqHiC2YIQnhRqE+IkILU+/OXYHPwO/Vjj9N9SyreBB94Mt/4g1vgy58IQfEWU1Fea4pMKnSOY+e9I+offIBYOnnhsrt6gNsGyXMuXKwAzPnuHSyUsSZutlNrXsOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109810; c=relaxed/simple;
	bh=s0t9eoZ0UhrtcNtAyJ1l8+SLWcnjMKPt1rsr1i/fWFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0fCFC4HrfFGDB5ygcOPlR1fAPDv7QUcVD16AYEYpxf7GpOhzxyjEfbv7Pk92GhfUpmngTaQIz67OxmjVpayMIkc8viAkpa8tJfA+EtnNCs0FHxLfqCa/CZpcLY2HwWAyj4WuJcE2SLJupLsMxgriaIqSm/4PIp8IfcAD7WcES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dhx0STSc; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dhx0STSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741109801; bh=q8mQTeBqOlBQmnAfR6SxuXY4R++1kfQAA3Mj2DPK9us=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dhx0STSc6wlgdxRjv6xqRVlxutu48in418fSHOTSmbbJfvm+Sw9V9jT8LaxqGoOi7pPpTcOK8d7Iaaxud0MZVt0PC4d2Azcfh0zdnaHtDn9CLHNdo2NFhllGaRmgloNGjmyzPAAfGz3XLJIORw8VdsLGz6BlsaJ/RbIyC/ZRSIyZs9HXUfmuAqQpb8WI7yW2xgtjijzvMUBjT+HF9bAT6+5d6vdGujfB7uZIvHnfGjf6hoZpjE3+u0EekCubdoaOav3SC075BWB9NPGRIvUgJj/DrPGvnkvIY7Q+0zNrQSBdLxCmsFzX3nnT6EdeHTKH/R+ZT5lG/k8ExzXFZLtOqg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741109801; bh=7gPyjyMjpXtuornAcDU8XfzlQZVeOiXSyOFfmL3tr9w=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FN4+0E62QeFlvDlw43hbeLh0mCKfofVnE4RxqF1MyKXOWVjYtqkFf9o2sYZUtaOpneGgkeuKcYqVBv5OpoTTW1IEMDEstL/+FuX+5XKnSf/UAvCvIcuc7Jvm54mk4eAjgHhvTEJ5rdOrsyEqsGQHYSMFtLV4CBUzWGK2NlTHK7mV8iUP0SvZjWn0E7thoTDY3ieQQMOzb/DYIMjf6WE6DNOsxwYl9M8ZPELbnoRkMq0UdCAwK9dyeV4h0DZzb2Y8bsjf4n49tybGHhO9bSfslqWZ0myA9CVnPLq62/kqBGAagjO6U0gvCM9Ngv9diqQ14UneRDtLE8UeBhbp4KY34Q==
X-YMail-OSG: q7ijfEsVM1nPMrPeTh.AtTN2gnR9YAQgrH17qWDnbIaeFpeQ55ZCBQOL8xwN8RK
 41ut25ZFqhjdxV61AZuZ6soDnwOX0uElw0XfsgZRerl93WBSlnxmDGo17jHf3YoGkD47.a.CseqC
 HZHNbQ9Qc8QPwXTaV2U3S_mSqaAAbGMf.bEOlQIzUAQYo2utpCjTibrERGcSVIQPB6zz3a5dYVok
 rNKEBtZwH6gzrGOVETemFpoFCkO1FefJ.Qo5aOYQ5oA1wAB3oqC.YDlZyegww6sKySigJP3qHkdK
 CahyK7Y1I53J9ii9i1HflYTm0B9lIsCqiqWinsCLP7xZsxxdRs_uTD5.aVXFsIuCHg4zkHkB3sAQ
 Alp96Joe1NkAhc9F_o7XUAM1h95a05uw0OjGf3POvOkNyCBICWcnGUIuG0CIFu1zUsVdNRHUzuxA
 qxloE3bg890uvXxBJiwpuw8mtcIwkmPMT8JFaBl6eabZmKrLqck5ZgaD3gyI5uQnj7YT1Wx4iz6h
 qOBVfOKBk4Ha1PssKvbL9lDxpmwbUJnbGuq1t3z2_lsurF3KfbX64ZEZpsAU1DybScQkaBQJGpts
 T1E2eLFDN49fhV_WQLgwDj1TBgCHO2pDXXp4d0mK1bLh6yOc6aQywm0d.50HFhUiKXmIVQaNdkoQ
 08KZIMZaXQlS_uAocVdBfTUFI3_4FO7q6fjabWYGGzCCNrbNnxcO50LCdzgQ1Ujx4oYUqURsTXDX
 Na8d4KoYNdnoGJihmLkS_SzSjQGx2I7Z5fOc7Zs6SitnAkUSLDwcolyeyBgZW3vqV4F5YHgGg7EP
 WujezmrlCNzPJh6HL6IMe6vhuguOMV6Qh83.tTBqD6ykselIrC1aiyIlfgaXb4NAT9AxTho76Y4q
 NdkKrYqjNPDzDHSdgIoe1pJjE1mcmje0lDnrbH518Y5EsMgOYrhQhdRwQhxnLD9adeHDjPIgo9.q
 dnhnc.l9ws.CTgScfnFwPTqvnRlBc0ju1BCjinVj8kWrBGjPJoG.b8xJoY7S3sWVRz5RLJflZqrq
 l.KCBqUUce_aviNNx7.8RaK4KXOT8G5OzefgkSaAoQcgNZL_c7hHmq1SbUm5_xTNoXPYz0wAkoVZ
 63bsC6tpSrth5cwy9srPCT.NnuthHSwpEkpflHFwYB6Kbu61QApU6j2mOzahcizrxmgRZAxKTUSo
 RHgdo34Jj7oC19VkvEeNJ3wNp5hOOj12ig9mDtBtP4FP4e.2vmPeut78BSx3xIQVdMMB0SlvPWYz
 LdYAyq6Mwd2_Na428n_RR4IRsIsh27xrI2gVSzC40O8RsuKuYY9GYsL5GRHRBvO6MIbnv5J7orgn
 JC244SgNNF7bhuk2dQo.EQP9vFPNAaKM_na.zsB5e4mkyTJmljs9DNh1M6.OjemWSqLxRAiHB1XM
 O2824ZyhWJn6tTtTfAoBcGe_ZLYNA0w1JhgwcT7.iBeG3stDcfn0zy9oQwCLCrhhIcuvYKAZH5Y2
 ivPQOa6mqDNTlt1KzGV0FVsKICHeiBVva2A.QqMdUoc4tBBpTuIqqMR6Z9MX44FwrhPjU4eqwvWe
 05xK9kV.gfga.R8az6ygnYeTx8eMvTJ0L3ZIlbKLNN.XmEh8mYvvg.mcoMZffsNQleqAzUF4BNfR
 PQt_5jBOvQlN9DME_OisGq.A_nmv5f53QiDoPigLn9DTmGCzH5VTauknXk5am2eSdyNn93w2szrt
 l3cUwoLd_t_BisdcvBVa7_E4oE1MD5cRGQXmZ.2NcLy1817AOHLRrzhUsLlXU6gpNbowlbbHYuO.
 qfzPeq0n12Xzswdyc0XqEkG0hObGCwKTdfCYuFXWLBM5ZyCH9K3LHFBSpU6nfQJDl2yv8nnspwxz
 SCGZwAVdMRCTTpZt5M7CiIA47ZtMg7htLCo4KTOZXNO8s4AbpgnMfOG0Pca1dzlIYchMNroP3pPl
 _cknQjHcdolHp.THENlrtGV4.9rpz3PneLhzoORzQZKcJHKjpdwF5FeGW.XmVBdg.4Fgwf50GKQq
 ENkvFZ9CjfW3Wg7OsRtz3C3euQVhlexsrh45koZoOGNCwcsDAQ3czj9DKfvoj31UzgjzlZwuKI6P
 j4VZPqbZTvu7GBZxLqqgwdYuyaxgS6ddRAmaKK5blpTt6nfWxnp1xqP5mBCNzgblnhWyzkQ1d7Ks
 24d7dWf3OzFcecMdvtsrsLvKp.yysrOlur14N2w6xC50Vefkf3D_hyUP6DfolxUxHUSRp.1uWfaP
 1Ao249BNULnJ56BRQOQYHbYW_E2fV6NQSGoviU52gejE0si_YNyybcaHt8Nk.wz7Bh.Jo4YZpFuJ
 bIR.OaMbkFmeejmw9gEtL8F8MgGBI
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 988bdb84-7027-48f7-82c0-0bfd78b2cd66
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Mar 2025 17:36:41 +0000
Received: by hermes--production-gq1-7d5f4447dd-bx5bp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1dc123c7904c3395b899a662df8993c7;
          Tue, 04 Mar 2025 17:36:38 +0000 (UTC)
Message-ID: <35e0dab4-dc24-4d73-a267-183c73548d62@schaufler-ca.com>
Date: Tue, 4 Mar 2025 09:36:38 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: rust: reword "destroy" -> "release" in SecurityCtx
To: Alice Ryhl <aliceryhl@google.com>, Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/4/2025 2:31 AM, Alice Ryhl wrote:
> What happens inside the individual LSMs for a given LSM hook can vary
> quite a bit, so it is best to use the terminology "release" instead of
> "destroy" or "free".
>
> Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
> This patch is based on top of:
> https://lore.kernel.org/all/20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com/
> ---
>  rust/kernel/security.rs | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 24321105052648e150f2875bcfa5ef29f4249516..0c63e9e7e564b7d9d85865e5415dd0464e9a9098 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -16,7 +16,7 @@
>  /// # Invariants
>  ///
>  /// The `ctx` field corresponds to a valid security context as returned by a successful call to
> -/// `security_secid_to_secctx`, that has not yet been destroyed by `security_release_secctx`.
> +/// `security_secid_to_secctx`, that has not yet been released by `security_release_secctx`.
>  pub struct SecurityCtx {
>      ctx: bindings::lsm_context,
>  }
> @@ -67,9 +67,8 @@ pub fn as_bytes(&self) -> &[u8] {
>  impl Drop for SecurityCtx {
>      #[inline]
>      fn drop(&mut self) {
> -        // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
> -        // call to `security_secid_to_secctx` and has not yet been destroyed by
> -        // `security_release_secctx`.
> +        // SAFETY: By the invariant of `Self`, this releases an lsm context that came from a
> +        // successful call to `security_secid_to_secctx` and has not yet been released.
>          unsafe { bindings::security_release_secctx(&mut self.ctx) };
>      }
>  }
>
> ---
> base-commit: 93f60f16db02f7b52985338f37679095231b6383
> change-id: 20250304-secctx-reword-release-e26ac4ee7e0b
>
> Best regards,
