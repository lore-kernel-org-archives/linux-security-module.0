Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23441BD4FF
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905341; cv=none; b=dBH0IGBX4qxTY6KwL3F6NXO3s9ihC/2fBg76f5AnPmWKLWqfejqyoVDs/q74vB8LIcl7ZcPz92DUA48kU4zertICWzXbQaAywnYj6QE9PhrxKc06ridF+9FZVfFgCV67Xf/zIJwYXbzRcTg6BFDmlDkdF7qkevr9y1sObGJcEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905341; c=relaxed/simple;
	bh=KftTRAgd6y4LWislWzNU85aIhvTw2oH5OZBnN8OnaQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SNQbXbWCPHXs9pk7FA4WW7pLwHvTp2Z2chtYWXl8bfnd2pk+jFwhuGxGnRe8nc46WC6RgDiPrZxTWFWx8XOEAlVX0YBDgYkBdVvqiF57mwpih03xJly0yraPYeogH46AZfbFyG2uCwik6xTuaSpjO8dgku1ody9i8jBseY4jiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hRIlYj2b; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hRIlYj2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718905338; bh=S6Cl8ixpIOiZuzmkJ5oltA6AvOA4rJIrtLqc/GZKGPY=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=hRIlYj2bzc+ChUIjdz/YfJMKO5tSkUTsy5iOnqqKl2SQbcZhC7xGzNdaZKW+ccQrkvJoeZcCKefFqeGHdbhQOBv3tPxQn3v1YaKyyqRW907eSnTWERfYmFfh91GDXfnDjfBIOj3sFpnjWM6ON12bkSD8mUHQSaWqhltAQtQSaQf2B5ybwLoWEq8SmYKo8Pi908C+fDSlYv8m+W5KxwMTV3VjISVN8FLHmgA/lEtcisB0CRKxFv2HoDifP/My6occ0n8rSpKUrw3kH1vzzKl9sqSgR+rgXr5cdMNBwLLlhtmHvEW65ZJlG07zGQmjyg7EGjlFYROUJh0fNuVFngRmKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718905338; bh=sC4d48UGACumr6Cif2X5uTRqCm2m/ACIxu02bMi3NNC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EMphrvLUkLtzQA3gmV5cWTypOZB2g7aFXkYi8MtwU8DV+C7ZXZ3a67B95DcnlnHECpUykc+jphXiv9RxmzALbXpTN9gIWysNCLZhjlhpMskP92soE7z0UEejMNC0bgeaCWsztpDXoIJyTaifsTAVMNkv618EhG4A7HdLgMKILjSgQOVZrTPfenctF1ULQJ31BV7LKB4hyHeOFh4h2oRpSAsHcK/3NS2mS37NTHUOI7iJyu9oxBAhhfGFSM4lqF3GAfB9+rqkcmtnlIvCc3/G5BFSIbjHuQ/Crn+0LwI9B1ATtuYYEtF+DpK0LFViDB1OWw8a1aAQcwfo24wEefSp6w==
X-YMail-OSG: 9lhrr.QVM1kLWDYqTl2QpTX_nDDPzDfPNgZ.vi3Dc_hk4Q0FRg4WbVYzvEHe6Np
 7YF7VoHTDbDAMFboa8IXNV.ruXiZ6nt.F0k0Uau0YxKHWXQkt5RfEmCJyRO5Dd_rFN372sxCPtZ.
 4lyYK9dRYZb0U4QIq4YEkBzCVdzO_wiX.wxieLJdt.n4Oxvh3XvuqDDIhQb.2AeTf3aRNr7a9hZ4
 i7Zfl7OhbjEaR8ULEhYNv_nKwk_6r0X57uZ5EJbERiTXD7fqcuXTsi0lEABEP34ccnZKCdQGhxTA
 h.yWT5gDosXa_lLLICTs0dxBhVTuvfXmhKw.CHdcvaWl2nx8Jx4kOQw.a1nNnR3ShZni2yNlq3Zn
 .4xoJKyUCsqHtNcS8ELbro2LstEHvJvMoA2433Ia8SoxyXGswM_4y8eHOaub7fQqAuAurukdldje
 FuxsmICh.RHenCMsLTsTpRXT..PzChTMX.O89dmnivd.FZk1IsKHOJ0cR05N79d3urGg3WBpD47w
 g_P4odxR8HSba8l5ZxfD4oUHSUMOMA3EpyAXT9eGFCFtV28bob6H0Y23y6mqSXx2sa21Ft8DKT9n
 f9j3wUqK3ZY2c1zj2Ag6luGupOmUsOScxgDcFCb00jcJcLqn6O4PLpI6befCLbO.QRKq_PpJWlaz
 nqDmnROODHHfZoYhapNrnWjFvoa3t7h5KGXMEMxLsbYvwAdFuxb5yxSFEiNW3VKvkIAjsLNUL3J3
 7KcCTO_WbEIdBPoXqgUQ7dRS5FOunk8CVaG4dfCTsbR6HWYiDf7Byjk1D0OkNrml_oCdNxH_ySGX
 mnj8yEA66acSjJdec3SRJBFkuNDhLbF4_hjaaOvoRdgJ1uWpo16CCU56a1dhzF.B14bwUCodDjIH
 0BV7JV8dm_MypDkJwEnaPvaxSTtF8b_E1GL5Oq0b7lgqbV5rrE_zkFhr.aWUpthjY7KptZp_qcNy
 SxApmllq.SQV7d8YLSIw9cg0o1gVcLI.o.vgd3VuX6_LifhA4IF26TsG.uDnkU6LRSP7CgUtNOzr
 fblrNSp92NqFvBYtRxwkALMSXzA5rnR_IRapDSb0aI28Ad1WwZV_fhj_kdy2TP9JTpeVtf4gEAJd
 pz5JiZqZvbw4CFrjAZYgvUNpbvEi82xtYWbuqfEtHzG9udMZ3Ube.8vJCzwDMu86bhuFQLZjYSoG
 uBUwjnFVS0NoNBz5oVI5mR3RydISSxf6JhMeFVmhAVbd4TAJlGeszD1WNaAsK.QSQmqi8iDwyZbs
 TtayeRLFG6c_QPmMNVVGgf2fQK2VqaZUdIX7EPE_fOUD_TTAAobl6TCNX88BvGliZv5Y1IMwbu55
 4gLxJ_2o2FPPOajKH95Wp5Bw85uWlerG_Ka2tEItHbz8M5SGfKh0pQVCCTpoIwewPvtfWGaQNZmn
 admsS_2XpTcF70DQQpynQ8vJ1GRoULokp5Ib0HXBAGfs8ogAKyocKrQNwH8QtDMF4LZcC9lrI3z1
 Dw3tuonirMRVpdGLEZhKDLVKWh5R8CqHjJbnYNFQ1trP9yqYoFB1YNkmsLatWgvwq_aEn3a10MsJ
 W8NgubosJAmau.G4VT753BVSe36zrDfx74Z0TcbWfhqXzpHp3CUvq6w4O_DOVQfZvXBzeWMnFs_k
 AkHvN1nwOl2fr2hUt5QiR.UZLl5QJMKn5W1XciCVA0RPnrlOjNTixQgBstA_jsjh7CS51Eh2H70R
 luysIwB5QgFcoCrCbWEz2SGJRDi.noh06XrQid8hirdZcK4HXLyPb4HBgBv6U9PFAD72dlSecqOs
 gSJQFivz.fTVjIC4qwW0WbOvf3zof6QUq9GnbraySldWanY_GYutyPz1_w9OvK44ud94_qGm_CWg
 wkZMHp9jRTF5qSOhFXD5Z35DMVzP8gtUNqxsKIEvXQKFJl.di7VnHaIDRNtGGZkaa1K5ncKbNKIB
 7hpuyCznnkYnwr.dDx4mdDIgXpYRh93IgCLK5N10iPToA60Mi01w10THSSZDxKv2f_NBk1tjFo09
 ECpNcX6_3BewkymptctGbPcsuLZR0c0_MQkEVTqQbLCCKts3lq7zKBPcISOJkYRiXRhocWpOQrwF
 LaBZ98VjifWfIGgDAgpMLryBx07wEVMcC26UbVZDmLE0NMdlLZPFfFSWe1j_dz7aqwVhBSPOvIZd
 a4KnKUwZaY7YwuV6_LNYGATRFWhPjUJD9TBdHhi1xs7eZ3yUBz0NeAuH_lrL9cD2fnHzACpEL26T
 eMAZMzum.FmfeZE_prlnVEt8yfyFZ.NV.VTlpStLYt0x.ynrAMGkQu9tp72YEyjE_t5TDPyyLaLs
 gU.47_X8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4e3e0137-0629-4f90-ae41-6e566c1d30ce
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Jun 2024 17:42:18 +0000
Received: by hermes--production-gq1-5b4c49485c-sbfr9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4ace5bbf5a99409b5fcf40f3445b5105;
          Thu, 20 Jun 2024 17:42:17 +0000 (UTC)
Message-ID: <58b1d5c8-2122-46ab-ba47-23c6d8c75e3d@schaufler-ca.com>
Date: Thu, 20 Jun 2024 10:42:16 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] smack: unix sockets: fix accept()ed socket label
To: Konstantin Andreev <andreev@swemel.ru>,
 linux-security-module@vger.kernel.org
References: <20240616224441.3379-1-andreev@swemel.ru>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240616224441.3379-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/16/2024 3:44 PM, Konstantin Andreev wrote:
> When a process accept()s connection from a unix socket
> (either stream or seqpacket)
> it gets the socket with the label of the connecting process.
>
> For example, if a connecting process has a label 'foo',
> the accept()ed socket will also have 'in' and 'out' labels 'foo',
> regardless of the label of the listener process.
>
> This is because kernel creates unix child sockets
> in the context of the connecting process.
>
> I do not see any obvious way for the listener to abuse
> alien labels coming with the new socket, but,
> to be on the safe side, it's better fix new socket labels.
>
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>

Thanks. I have taken this in Smack next.

> ---
> v2: fixed comment style
> The patch is against `next' branch at https://github.com/cschaufler/smack-next
> The patch does not hurt `Smack kernel test suite' https://github.com/smack-team/smack-testsuite.git
>
>  security/smack/smack_lsm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 56e02cc5c44d..d0d484c1599a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3846,12 +3846,18 @@ static int smack_unix_stream_connect(struct sock *sock,
>  		}
>  	}
>  
> -	/*
> -	 * Cross reference the peer labels for SO_PEERSEC.
> -	 */
>  	if (rc == 0) {
> +		/*
> +		 * Cross reference the peer labels for SO_PEERSEC.
> +		 */
>  		nsp->smk_packet = ssp->smk_out;
>  		ssp->smk_packet = osp->smk_out;
> +
> +		/*
> +		 * new/child/established socket must inherit listening socket labels
> +		 */
> +		nsp->smk_out = osp->smk_out;
> +		nsp->smk_in  = osp->smk_in;
>  	}
>  
>  	return rc;
