Received: from sonic309-22.consmr.mail.bf2.yahoo.com (sonic309-22.consmr.mail.bf2.yahoo.com [74.6.129.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C05A50
	for <linux-security-module@vger.kernel.org>; Sun,  3 Nov 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730657138; cv=none; b=U2E8FnVJSLFiiiMZQza/wEcLN+ti26HRw6Qi+p5NMOIVFSlJruBiTd3YZvx58GTrPJZ5HUS5ONO/7dHd4laYWqPZzyyGYhbPUhFX2sHmQjrq07OHDaPURtxXDB8CY6SY9MKpk6TK9tSrD3BUEXLxRHBMoFCd6TjfZSNhVmE/fM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730657138; c=relaxed/simple;
	bh=pelEEfOrB7hEkejcec19oMTOOnGst28dNX8DZ1GHHb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=WueOtSB1Ms+POci/kZNE50KPjY4DDWBHoU+9HBqOWBWtQkFnZvZM4+ZZyHP5OS997nOuxOJAtfqgFqp3jb1bdmz/hF2FR82+arvFk5j3kwKbxqceHybEJqefwRYYcG5jYoYz83b6aO9KbadM7r5UG+feXQJSInogZKkReMg0qnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=q/HpVKJL; arc=none smtp.client-ip=74.6.129.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q/HpVKJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730657129; bh=2kngMITuglQ9sBgo4Qfi5m7PE7ezvZEy4un1Ew2tbu0=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=q/HpVKJLeni/RJCYUWFawrhnBJGjUR9pN49wweB9mx1KTGMT5h0cxw8iItlyhDiQaEw8UFBvHbKuL4VatJ9zP9k1VS7LooWOlGVzqs6+ORozwn0/ZMYTCq0vrkicTRsTfrCi+QE6Coa4C8TGvyCAKwvEKS1AKKOFdAQF1qJgCPcX4j1Ro9C7wKz2r9KxFtbqhSxwjkqiE9icGoymSThdYjm6t04hvJszvuk+ltxZSr4DWXYV9vT8woxWwIJdkLIMF+Q0IZ4IUqdaJ2zfLRotSr/gierGr6pevOTzDPxYg4TJfIQvLIeap53IWeHI0sN5ednkyVfwKC5pdXBhfYDNGg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730657129; bh=z4+6ii8Lgyx3tNAi9MzhdEd9R290ILWxVVkf/C7M+A8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XV4jkb08I4ZW4BCrI+tSoVojdCbpeK9Ps7Ysmh7osLTEbuGVY/QmmUUxrLKEYFM1m9aRVCKMnOR7wPI/ZSuPmkQDDn3oa/Bm4DgpZKrvEdnV77odY2d21QZf1LN5z3T6kybLkYFUj3j45Wgbzs953zGiqO17Va9cMNwGO/WYOU0yuNGD87Ba+SCEe+e1d0spZduTB8HoEkQhgGik6JMGszBR3JfzT+cxpT/Gn6YZmihWRVT7c3mR7ungr4d7/d/yNy8eifckLgNb2mpdRxPzJFYA+tDGoAjmc3F0Mwps4CrX7sDeuwPU4oI5YIbNLiLTtLR668hA8R9K2XRu2FpeNg==
X-YMail-OSG: WqUtrUgVM1mjxOfDzq86ULIG7Ep1Wf40G7TBGROOvKJcezRaeiLZ3UMrFpya5qX
 6LM5eMPS45h77L2GB2ejgCL2d2CWLqqM156G4YyfMlRzlJcEuHX8koUnaPl_y31cw_51OCCv_NKz
 ACoWfukHjEeH1tH2eV20._aJsztdBsLUzxC6QjqDDzBBIOoub6.QO_KeLSdd.vPpjnMfHF59cBcI
 KECB_xvZ6SwbCPylwChmcF1AkiPopSthr9a9ozYrIdTcVPkPffm0N1LO0gQ9kgnf5XjvYldLvcgF
 MY3B8QLo3SEvZ7uiNpuCA_a7iRxKLOdp02uQxFa1GhkKtQ.JUkw7jAZ6Ni5M5cQRtuM4BeEMhB2h
 xQdIujvTNtRh.QA0r6PDcR0j_VpQjcapDxx2ynpWDRILg_peRvZoBED1.C3isTNJQXUljuOEA9uI
 azYmnJK0.2MhWfwiSK0xDvo0QuxiObCpR.Sbknw8P.m3HImiY03wXakUAQemLYq.eEesf0mOrJ3o
 MS6SJIIb_9Bb1DEgdB71xvWEe0stiP2senlSmw6ZX.m53_ZM039.d0DKdu09zoU7o0eSMYervfx3
 fd4ld609Xdd91PcT_rPTC3VPbs30hPQMVsAGqMYgtDlOoCxEog5Xa2c783R.89k_hVOwK2jKaeHJ
 lixO3WLTliM_SF4HUXGilkxbu.swy_i1wmjz5fBXtlEeCO6g4CCLGTpqV1pRxqUNhfY2.sKV0gLO
 dKYc_4QfWqrdI2UiAHw_d_j.NZ3Mwp2h3xRYEntwXGAXwEZsSWdKugUhk6yhL_8UxZA.lAwAAg0q
 0g4e.pkt7764yMlcxFlz1FyxKSois7LUDXjhPpEqiGIHBEF_nxHEHrH.GeNMFi6L5pzclQx385UE
 SsqKnUuD.14OpTCq.PRCUgLRovid4AghkdxAtisvfELvBO8QdYBSeEDGqKgts_rcO027qSGuIz6e
 4xyx8mf9m7wypPUlHlOijZ9O8yf1mgBC0DYRA83s.hQ7IbSCa.Q.osi5jmaaxw1u4aeR8IuqF6Fx
 _GFwI1EFTdcbfg2jVEs2kSOvuemC5dgs5z6D2lDSSDkGE098KzplToEjHq7iZk1UUP_x8OgFIosc
 X.rl6Ns955aTCKY5csuUTlG9ch7xvvWnJFmKlvSm3jLyqV5KfG_bcFL.pBBhvBeWcb5ET78jFaqs
 mcFw7dVZ1vYlkb_GwHKN6.QpZxBuznDFyJ5gzhaT0x_DcGfMJnc8IyENqMdzcjberDj_oJD.ctGg
 VWDqs_pVSvKBqwBMKy_8g6NMieMqK298_fACNn2QYPOTe1JMIunVffZatuaAmnCxZqGDDfEXydoW
 prFyujUOt2l_IhbyKEbc0YhwRMB1LPS142O3Rci4mLwxkd0tNj_PRhNPHnpy_SrmgDUpYZeSLTJK
 4_z1FhPHNTiRQlPf19OJiWQ2it6.c4iDFztv9OH6TvINIQ9VukXkMfiNEmA2oifN6_pGGlME46NO
 5Fa0HFhd8zaVW3iVXpX_crePo6jwxRgBoCxFvFEiUq.5mQgveetx37E6OCq6hrej1YPX6FClqAyn
 fFNjxiRW6vDGpQ0GKZehi5TNVbYdp6twdr9geZ7BYRbN74Ub2vdeV..yYgwFgASiwQg3i6MCqjvq
 eQGDO8YNUIyJePXZORNXt8fDWdnlQdieTItxevLDi624W26nzHUwNnuzFJtj70hTtonyCiuO8tgz
 aS0oBDnVzBSQTkTh3hleIpSRrACuRbk52grvNw_hkXJdhA4ABH.HcboAIAcO2TsNnvFi5hmSmxpx
 Qpt7UD6BP.WAfaDzc_CrP1ZY.PsHnlmvio.2yMVAfg63TR10ZiJQOyJ5jrQTsT3SxWjPnuvSiSxp
 YqzuLW39Hp.DHyL86HtVZ2v1MjRN85aL3nWfJ9Q2EvTFGOrXFPsyMoWa0loEpoB0.lzNlYGxjaBD
 dRgdJpjY2qrHo7tS1XEHOq76gUoJTkXaCEXUDhjYriZwd3xI8EZJfqm8bSzvtX04Y8MwoJuiCt0D
 PRpzdCrMxIE2LTNkRaMrrHkZz283LtBNB59.ManW09WYw7Y6CX45gJo.5EWnh_jK1RHJgrjpc1pB
 yvmXWKsvt2GAukeAR3iHT7kAjdBsQQ86pavzZRmMnFkxXPdl0sETzbJk1YkTYG1w6Mvy5s4m083d
 OJdcgmS6T_Ugewx2ZDkvU1QS0X_3j99j.N9qPSQMcVZlbpXziL1765KKCmsk33dOhqFoqlkadUZ9
 gkv_y0iaQrXomtT8.yoI_5LdhXtLt0Q1wkZrBDfZhTpry8odj1Od.0XfxBYaA6WZUnIGrLpoAIW5
 J3yG5FDWHyQtxzoSi7I90pg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 422a7b09-8814-474d-b702-3133c9a361a5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Sun, 3 Nov 2024 18:05:29 +0000
Received: by hermes--production-gq1-5dd4b47f46-xsxj6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a76fbeaf1dac9317728098bd9cf61ad8;
          Sun, 03 Nov 2024 18:05:25 +0000 (UTC)
Message-ID: <19daad51-99dc-4f1c-a142-3a19553dea82@schaufler-ca.com>
Date: Sun, 3 Nov 2024 10:05:23 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: fix the smack_lsmprop_to_secctx() kdoc
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
References: <20241101165243.159021-2-paul@paul-moore.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241101165243.159021-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/1/2024 9:52 AM, Paul Moore wrote:
> Trivial kdoc fix to correct a fixup omission when converting to the
> lsm_context struct in the LSM and Smack.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411011723.I59qZ7Ke-lkp@intel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schauflercasey@schaufler-ca.com>

> ---
>  security/smack/smack_lsm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index c9ec4d93fb13..55a556f17ade 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4851,8 +4851,7 @@ static int smack_secid_to_secctx(u32 secid, struct lsm_context *cp)
>  /**
>   * smack_lsmprop_to_secctx - return the smack label
>   * @prop: includes incoming Smack data
> - * @secdata: destination
> - * @seclen: how long it is
> + * @cp: destination
>   *
>   * Exists for audit code.
>   */
