Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A39C07E96
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Jul 2021 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CF56128B
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Jul 2021 15:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbhGOPSO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:18:14 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:35454
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbhGOPSN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Jul 2021 11:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626362120; bh=4CvhvD+YpkoeYCVkPbTAYLogsxR/Zf4NlBwQ9Vt1Ec0=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject:Reply-To; b=mcN2cMwflq3Tai3TNSQOUbAHvOL93vwm/ipZ9FMhXs/y80/Ekg3aNKoI8YEw6gB17+2Sp46sBNm0BsN+kNo3QoS8cEDDv919rFUTQYP+75sgJ92+BpRjq97aWbpoHYpyQchwAfeWxkmKXnTKc4XzvJ7cMhPNwgt53MCKLPB3codLWcBaRRelhPsXmiRE7dHNoKDKcWcEcsAsJyfRjqkbtRRZ0A0Iv6AZ8hgSmd3EPokILDJnZUFcbTS+6sY6UmaLmVS9A/+URNScyvVt9olAONu8wLaqz2lGYYIN7eeZuX7Dlc0nCQWe9tzqAxiAlqLxwo7NVqc0vOBREuYTg2cHhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626362120; bh=XnMnr1JvSZAO4RBFToBbfW4G1oBjf69MwIUMKqJw11o=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=C0XT9cpdrOhfpcxzxZ4DQYySmO5G4Jci6yviEn0ACGPaBYF5lvk/aeNv4mEwETZKvmoKtaCrS/OKJPLrAYrWm/Sv5MpkM7enlMl7WWQ6NmWUQuXQ0fs2X/a0QNE1iWL1YwdtTo1/rPhJ8qbvHuyo9AFARn1aXw+fW8MRTGg0u28BJWOl2PSAs5dPgNfhl1IFssjIovYd2cPIHLIGEwWbGrYp4AavpJdK7f9l29SKh6Ucx9DZNbQXHvM6+W4K9z/6VL5W78hDt7mF894Au4vfH0zeoIn7tSUnXNBv6xD/i/nQxiqBtkhpY8zHD7co6r8FHxBSHe07GM4SXzqslKtypw==
X-YMail-OSG: KI7wRBgVM1kt3.4PyMz7fMu4vy9lRtBlfI9uTxoeWZXJTUq1hGVwU_eExiBFcxC
 VysJzvbwGCVncFzw3J1ENZJJJ4l9EegUjz9H2Zud1VR9x_COVmUA1HZCHDtTEa5fZm4sH.n7zzpr
 nAb4n0S0IUuM.oKyjJdPd_qnXUd4Hw.AJF5oN3NSGnWihIpDo0ljz558EFbjmRsmivZXThjobJNu
 iv80at3tD3KsmkCRe0AkrkVXEKc9oqfmUF6BXQDsxoD35xBqigmj5VofFCguF8lqmGI3qkx3PUO9
 uS5FUSS1xj9HGW1IM._vQNu8t31rJOy2rIfvfpJG9x5_OuNS2iKoWq09M.9EcNQUKr_4gAeE5NhG
 dFvnPf4NApDG_GmVbsRlb.duUmY_KnEn7WtaGkNS57CJ.Jj7omw2kog_.k69GV_CywZhn8nDLOc.
 DWpQPFq2CYB.6NiQfwa5RpI.46usU7b7Fd0eGiCiaWju7DqVSpfhLsAJPVxhRFYBcNvH25ipIPw2
 YXqigcvjtbWSKdoQKeiaLm2e521_4y1cBHq8IhaC29xW4deC36.Fw_T09Xp8TnWMLa7pvYyagNh7
 JseHi3N_2V5YccSvz64a.c_jH6q8Ek5WWNEsCyxfoTuudPyL5saRNokwnNzBPFdcc9gEIg2A86YF
 ed7F4a1TGoJwHWoufdr_iZJnCPEhkzhncbcUlWJFFFNCrSHuRlvCkIu4W..mp4IiYmHXAkXMT1mz
 5L_XdYALw9zYWyKyCFGKAsMsqT4.5zcFlwtCOQiGYPlmkwm1EAuqyvRa4lIN0rfnfhPcRPJTK.1s
 EjEQrY4W3CJJ9RSTr1bnONODAt9OISmLf1eX441fBqt8gqUfVEXPeqPb2TDwNX75FLtu3Kr7QMw7
 8Z1yo4_wxR5YD8EKZocUerhA6g6VlDfNrL_sbP1m4WwYha2IctagfIb1wQ_nPu7A5LQ1jcAQtBbH
 TZEcKOT97Bb0QwTUM2g7aRqmlwNKR1ZaS50jCTNCbGpIj7pJUXQQHvmn4kCKy6dlq4cPIxj1pD.p
 vakYBQ5m0urysM61H8LckH4cLdq_U5a6FutNMRGC9k1ApPudRU4yb_NLZrx5Rk_0yI9XIdxn_qz9
 4mnF2Vcr5diLY5kwdQnC_zP.8KOg6DZlCAjcg3Xj68eFPi2XddWvBwDFSR.Mqg5y8u7BY1AKS2l9
 fndrade_ZQXcocLTTeB3UsC7fy7JTi_LNNGNoY8nI5hRvg9_3QMuwS9Np2Zou4jNxkMq59TdiMqp
 jSiohvD0.5q1unOElgi0tvhEbc49QDQr6zCifTsSwLiv7eengx0wececzNS4yYqWU1VkeJBCrMtS
 swWuNa1ptz5RZP4w7awvMSUtOFVAeg4G0izNfyMeZKXZ5ohr1ow3wv76vvQYH5zmHjfezKlkms68
 qpECm2v7l5Tc1QNOssd8U6Rjscxcr6OnyVAnyHRGVsnmw_BL1wruwz884Zs32pqeJM6Dzyj9NsDq
 rLqJXRt9f1yc0JqpLYOk1apesYOTp0dEjDxRBsdynRsiHi6n1Aw3DQSWDEi_IbAfy9NlvAh4cf6h
 Kp8XQ7sPT9MEO3NlmIh7d9xSsZHe.CdB_nQIOCU2jnhnqv7XjB7fdv9X02FkiZDjkNAeK0dgXxwG
 aMiC8pR7GaBxcpnXgDBYRPcK24sGAjYHiZAvXLpivi5vyZ474wCCktS_EBSlGlbaGuATtmhvyKP5
 uRDup4p78oCF_bYb77CoGGada6NKBUhHeYR1akazUNKgZgaoGMDPg02nuEq4nHxYTNusZUfVXyyv
 nT64uoSjLrohdVNcQMVuzm2_GjwfgMsufq88wz0nFNX678zyWSA.6HIY8Sg9RUrXKMKg9bQzS7z5
 tepgpg1dVSReFQZzw_NEO8_YseEpcFlrmNb0W.cwnZWtSx2EHlVoT5PApUxJKFVsrJiDc_FUH3Sd
 Hj4Y3GO1aBSisOdxV6r17piQc3XWo5k_WL6z_JLkup8u3YCliQnz.9QcdqCO4_sOHZQbi8CtW8bl
 btYYTEunCAYTWIL4sMUM65J_fC1rbWohfKff94gDhNbBukECm4L83_Kt0ViiuSrAHqxXa7ICc3N4
 WVQNxGQEbGI2.uwexLIph9d4kaeOTpY.vpAkWV6TPsJHirAQaqsfATPSaVcCZrnK27LFcm4H5piY
 X0haObgOpJrFS0FTqrVNv860cj20v09.yx204_if9hwgPpqarwi58aMtoMjKlaS5kCwznTmGVatM
 .Jo6KUoNGpRO_3YH5d90lcQy3SHJHfz6YJyqrDYAmw5EH28.2AZHdqRrSefb4jJaEPu6HM2E39ce
 hTTA8i0w3r4e1hD4xFgupw0p_ahDslRqFQ77v5kf9mAOByk2lyo8F6K_82jPCRWi8_yD5Sai3qsv
 K80Xgfuyf9OEW4pmiyHUXrI1hPIIq30T6fBHDdUoM7s9NImsctgCiwDhAHILB5YgTaaQbjsm12fd
 ASp4Qy2obSMvj.8cEc9OT_FPVOpTJdqJWLOTjpv4Mkh65T8eFdYdoij4aVk9vmngkD4UY1iEKBtp
 jDtVAO42uhOoMTeFFjIqbuYjBSZpJiZYye4dCE05YJOnjq_d8_gC_kAQ0cFiDsgeTp6YUQcKKbu.
 xySofxhy.RyWpuK4XgD8nU5CUsWVSPbusW2mp5VO4VGVZRLRoTJXXTv4OFDpkNtRB_NbqPjA3OFk
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 15 Jul 2021 15:15:20 +0000
Received: by kubenode507.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID caafd5e4d794c8466d7f7d628a81ecbc;
          Thu, 15 Jul 2021 15:15:14 +0000 (UTC)
Subject: Re: [PATCH] Smack: Fix wrong semantics in smk_access_entry()
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210715091724.45768-1-tianjia.zhang@linux.alibaba.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ae938c7b-2f7a-27ec-7077-ceeb517ba97f@schaufler-ca.com>
Date:   Thu, 15 Jul 2021 08:15:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715091724.45768-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/15/2021 2:17 AM, Tianjia Zhang wrote:
> In the smk_access_entry() function, if no matching rule is found
> in the rust_list, a negative error code will be used to perform bit
> operations with the MAY_ enumeration value. This is semantically
> wrong. This patch fixes this issue.

Indeed, the code as written is functioning correctly by
sheer luck. I will take this patch. Thank you.

>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  security/smack/smack_access.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_acces=
s.c
> index 1f391f6a3d47..d2186e2757be 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -81,23 +81,22 @@ int log_policy =3D SMACK_AUDIT_DENIED;
>  int smk_access_entry(char *subject_label, char *object_label,
>  			struct list_head *rule_list)
>  {
> -	int may =3D -ENOENT;
>  	struct smack_rule *srp;
> =20
>  	list_for_each_entry_rcu(srp, rule_list, list) {
>  		if (srp->smk_object->smk_known =3D=3D object_label &&
>  		    srp->smk_subject->smk_known =3D=3D subject_label) {
> -			may =3D srp->smk_access;
> -			break;
> +			int may =3D srp->smk_access;
> +			/*
> +			 * MAY_WRITE implies MAY_LOCK.
> +			 */
> +			if ((may & MAY_WRITE) =3D=3D MAY_WRITE)
> +				may |=3D MAY_LOCK;
> +			return may;
>  		}
>  	}
> =20
> -	/*
> -	 * MAY_WRITE implies MAY_LOCK.
> -	 */
> -	if ((may & MAY_WRITE) =3D=3D MAY_WRITE)
> -		may |=3D MAY_LOCK;
> -	return may;
> +	return -ENOENT;
>  }
> =20
>  /**

