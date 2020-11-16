Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00493C388F9
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Nov 2020 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8855222447
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Nov 2020 22:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gpDdorGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgKPWbR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:31:17 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:42405
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729756AbgKPWbR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Nov 2020 17:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605565875; bh=MssB1MdVCNqazPNYFFSuB0FQG8vHLzyME6PDI5ALbKE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gpDdorGvDhcxPQ8i4P0z4a/K9P9WMCm7PmM4SzNHsaZVdL2oB/PWM/MePaRk7kD4iKpw/3nFbcRefPxMWyWeiQ/iJzoFRtIEOO0ybqusiMYqymU+rB1qvCC+1kwaNncE9NxEWIaABMsC8TQIE493r4DSV2BNdlPU3Yv6z94nbgD4x3GCiSLGAXqlzVvDiHidYsdD11tG89r8D/1IGgeuRTaJJ+tmvgMppwlBITAhxZS08WfAlqQRRLBIckxGb9eRLc87K/U8FhIcvgsZE4oYBcUZAOcPd0bgelHhWcV+OPYS20dhhJZqF+e7OCVUebcK8hgQZtAbmr2IcVSHQU1NFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605565875; bh=8egYpnoCKFQnfQTkL69NeX0axCIjcWmxAQkdiS3uoIJ=; h=Subject:To:From:Date:From:Subject; b=HitoWczk29GjC6QzYTU4rsO/WOusoALeZC1VFsvlqjgx3Fx3JhSIUBA6kx0r4VpaUSt8L4S2jkgldZoede7SiHQHHDrL3o6aVc0ML7yL22Yq0aOoj/F5gV8rM1plVYTPNpHBwR8AKiODibwFker4ZoMDFZWgL6h13fECNstp8w0WnwL0IbXUz3HBmfSL2HXWxiG30Naq/JVFkSBMnJmhfujKsILTGGJdh1hUwUPwrQq5ezLsZ+eo+CE3DBSITvS852VWVdfVAo4yXWFAvFO7Ek083PNhpW3NIz+dsmjlmkkyP9mMlCBqGFKE/saWAwt6x4r01M/8JWvDqKTiu9EZ/w==
X-YMail-OSG: yD3fjB4VM1kJFijiRklbGEDwMgx2gmTAZbkRWjHfVi41jA09zhSJQYy8zaPLvQZ
 .EZ.6rE2OMQJhee.B9TtRsM1_0GntqJLkIXroPw2Gv8Tzo4sDIal2KXSsS.lTJ8GcnOnJTU8L5XG
 uIHOmMBYAjcWpJjWXiqNvDFE582Afqbj8r1Cr0S8KGpwcdujYs7Liqb__ZjOpQU5L.mRxGu4TpAw
 663AvzPqBRXdBVmUf20FYmecXlfVs6n4kKrDyPZYLl5GQCabSybAsNESCqY.yZGqf2d8DnRHduuo
 jUpGfEzyLX3L0POWaTR5FXSrqZv9dqJi8yGs_PejazMPnSwgvnIWfd9c29qwhGDTarjjLBkNVI4b
 gZKPtBcyZ9FY5CdhtVRN2I3wAg81.RVZEcTtfLy3EsmYCm8M62BohIbOVzhUY.rBO56CjmemvG2o
 z7M6DYFtfbINvowwhmaF_OFFIvQT8Lg.SlM7OSfzCpsEDIXbDpVp4wXlq90RGPAJrYNYyhmZy1eQ
 7F_ofnh7ca2GR.bqTfzVVT7Wg2i2GIpguFQrXVcLX.1msvRN9NFPwEUZ_dVIVTqjVb1FEOeiRz81
 3NdydQ1lzUFzELeGRweV1qrZ9Hxzv2FMkAoB.cf3BEQZG_e4ZkkkEJVU79V98YCcUzB4ZBqQAwm8
 y_1dqF9z4yQxPVGq8xmS_R.I1bBu.LWuENpo7xHrjweYSToEqTQNOHx.G8Ge0yKlKa_HaSiLZMt2
 ltPEYl06.NbYDwMe723YmuMI2L4lgrN4qpHtNXsmHtfKuMWo3KgaCas2OR17N.XumI9RRZMgtbLg
 R.Aw8eiXdvzeLcAn9Z98PY7drXz_BgNkJfMpwcc13cpAqHlKbHGEcOUhIHQTBtTE4y6KBi9nzDPU
 BkFLjmfc9B5l1ArgSGlHr2QM39JhfgXj4VKecygupf_ZEfqiFFgBNi.oWm8vUYF.AvFE4omo0KkR
 4ZP2RBtgh9UjfpmuYFtkkwTTTYei.2BvWObjRaclU.6LRGUC5FHFTQq3qnk3UYC9XqJuo9zNqxtE
 _UuJr_Mi1s_DB4Kw_X9H0E62O6i6jYz1dhLLzJ9NxjrOLAGKAtANpa_N_6iZPDvZDxVsFzqPeMCI
 KXHn0qAyo800eaY8fCx8dJU70zOkOjmq6ESAZKQfxO2yA7XuVPYL2qT6wxocQDyYfETo0L1mQbRg
 _h0wvKiysP5C.jU1iucfBxU_P4y5E7ty9gjgLZbKSW6ZKTtMfAMFlIE7sCNvo2_7JD6wxL9R4IJK
 xsOSiGDRHFDywCgmaDaniwKaRXvmfzposIobld4f12ywN3TtUP64etxIotIPmYKivT222QVzPwTX
 3_8y9dWZnIbMheRCInAxMbZU4SLHI8VYNSwe_IluzQHmQmRRYsGOqSoViGyxI1UFZz1S6Mj4Mer1
 xWmkemQkr4g1zIs7bvMMf2wJnxHE3tYIAZQ_dJ0ZxF4G9r6Ia8tsCmiH5WYHoq3UiYwYUItTSgC5
 s4xqLhQXhq2lESIpDA2uBWRVGCJr9Lxey7NqrxjTTcFKgzzy7fd5RoH56KendKgF4DRDMY1C1R9l
 TFEnG5cwdOy.eRzqQM_VloYbWK5..7kDcVusi9G7eMDEKIFZj24QSGanvduZvGsY4Rgg6cGr378g
 fak1B_CVvWB4vbA2cH6CzODETlFGuxBTH.6xauCrO7pASdhT1CsOHdmAjkdNHerZqqypSgp1GaHt
 TTSo95fbzYxAmvJEQpJhY1TXdh8BaBhwAQgZAZTiH4ks2CTCrJfwPHWijv0KfrMpN7jxkZve4MJZ
 syBqKPscQAIGP..cpMR_3OnZhlhU60kvxsN4QY5Sen4Kao02ziG5rJ743VMJsC3q2OhCpLODWRfN
 NYZzN5htHM0Cw6dDN_VLq7KtPX8XXG4QrBcy9L87AOjebGVitXulORzfvle0p5kJ04ynlrpKn708
 hMKAvdEuPCRq4g0ONkMrhO2h52BdvCu6Bm3We6JFpK2SEX6uiLdVhojcD_54C07TZ_hs11Zbb0Wo
 4UyvJyWliHYtmjWNtHumU8gDSs5po0rL7HhAPMMyoxg1BrESKB.NRNwKAFcJdJg73m5Gor3qGn.H
 SCOzxAXHW3p7B.PUxvFD6IWpKHJ9kUJ83Nj9aPrSxIuInEjYDL7oBL6iu5jRJbQQ8XcSW6xUAssz
 kqoRhv_O0uXS_4frOCyZzHFHhjTgtrpD5FoMbQaS0IK_h4b4vacbKz7efFLq82SEKSzPQHfBS93o
 RgAP239hPTuTDbV8uMXPU1Q_CS7eMpiAYLA4uEKWKXVGkOiErhK7Mxhqw_G3U8SZTtSfc4M4XS0t
 IZ5dVewK2H4_NNMeu65Asrmq4tE4qcOnZ0hMaPz7JfAlP_4rq4A.i18zWEzlBogziOpAoXJrsTMB
 w7zXTtniZWQ6IoYwIITdbKErk6lvj45jLiEwjomB1aj7t.ZuNxBxxVfyOAeUYzs.MEpQx2sw33hb
 TOJnZclHxBj4n2L8.Wqof5odSRkBNCp1955KKc5RlUoX7Hfnt0E9CcP1jD_pV_XJ5pThxp.LWDjk
 dQnOKufqXTn8057HUUkFy84oOHDfT2U9oN4M6PM01JVhl9KxnuGYm99DC2II0UJe6bdcWffdbkXn
 wj1mjfoXMOwLLZCHL_otsO5UIAkPc4HAPiJB3yHmDdBfLTeRL2CElWB3lMDUTnsiASbza91jzkyV
 cBPjtiovewnk7QaGIX_t7L0gtLYwGhCbpFqrK203hNt6E9Lbdz2BIG6afSxMOg1z3COGPOOIwNsC
 JR7f5O7C0p3g68TkqPwux0D0slAt5TWlOp.VaQDsn2xV9HpvMF1_3L_uhL8ungYWurrdG9DIBWSd
 kcWd124Irnnl.J6EXXbl4kkFHP83ZGNGV6eNIjQRXmxLwuvgL4nDF.EVT7e0UBk6.CTGlBbIgvZI
 4fsEHx5j1UHP7L1xMyDdsbg2Daw4R_6jOtkfJ2yGTDFK2oFgTYYRdFu.yNEPbqyB0aDE16sTH.xm
 uYq1C_0fp8klu7eA5HsVrEhgw_1kvhSZFbnNued2meoAL7QCiH7Sa3hF9k7zzDA3EOCS.hJ3sSQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Nov 2020 22:31:15 +0000
Received: by smtp406.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 02ff2210146a9f6ff86b5e921c0b99d9;
          Mon, 16 Nov 2020 22:31:11 +0000 (UTC)
Subject: Re: [PATCH] security/smack: remove unused varible 'rc'
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1604817942-3755-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6fbd7b38-ac0b-571f-fec6-4a807d2eaef7@schaufler-ca.com>
Date:   Mon, 16 Nov 2020 14:31:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <1604817942-3755-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/7/2020 10:45 PM, Alex Shi wrote:
> This varible isn't used and can be removed to avoid a gcc warning:
> security/smack/smack_lsm.c:3873:6: warning: variable ‘rc’ set but not
> used [-Wunused-but-set-variable]
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com> 
> Cc: James Morris <jmorris@namei.org> 
> Cc: "Serge E. Hallyn" <serge@hallyn.com> 
> Cc: linux-security-module@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 

I will take this through the Smack tree. Thank you.

> ---
>  security/smack/smack_lsm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 5c90b9fa4d40..9994fcfafd70 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3870,7 +3870,6 @@ static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
>  	struct netlbl_lsm_secattr secattr;
>  	struct socket_smack *ssp = NULL;
>  	struct smack_known *skp = NULL;
> -	int rc;
>  
>  	netlbl_secattr_init(&secattr);
>  
> @@ -3880,7 +3879,7 @@ static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
>  	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
>  		skp = smack_from_secattr(&secattr, ssp);
>  		if (secattr.flags & NETLBL_SECATTR_CACHEABLE)
> -			rc = netlbl_cache_add(skb, family, &skp->smk_netlabel);
> +			netlbl_cache_add(skb, family, &skp->smk_netlabel);
>  	}
>  
>  	netlbl_secattr_destroy(&secattr);
