Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA1145B1D
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687626; cv=none; b=RWK1055WNRrGx/YeOUWy8S/ERW90vAkrYG/C7B6mUngMKvqT9Hs8na70gMocAlw8aKKc93TxAmGoqpnUbDGvFElKjy9OwqeDYJABe8JLfmp+ltCNX2nuboiZPKpLFbBMMG9jS6rD0EPIJEvG+aDUAKo8h5i+ZSBZXAk8uoZ7f+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687626; c=relaxed/simple;
	bh=vzLXQUg3IQH3OK+gN0nDPO2osOJfXKx1BbebPO+B4Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuGO+VecZTvHwrR1OJ56nXSyRmRciMUL0Z3HN7W2x8PFOWzI7JPN5yS8uhK09x4HntaVN0PV3rFOHBNMb9CvWXtpXaSZvOvie3FjLMP8I1FuBAjq9IIbFq1RLTmEEeVz5tEG6WByQ7jSt+IWRXoQEj+g/dU8WosF4xgzlVxi4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=roUybWse; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="roUybWse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724687616; bh=fkqRBn+f/Mb4/1jgbdencFgn7M2XbTO9vuNjNuGD1hI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=roUybWsengKeNiB+xNgHcU7Yij/guqp4LwwaF1clV2aHLfK5wzy3dOHXh75DSrNkMSgCHi3br2iNklGxmAq8nhEtKa09jYGiHLABQu4fTvvh3N9J9DhZeR8uU7FjMWC2B8+E49B0Pji8rnVFS3ecKRCHQQREd3Fxm3ooHdKb/BIWOHT/Scq0Q/hceIaCtTmMu4Ez9JjxKiyLiT56uoGVIycTXsjoa75lAieLgHTSGfX+3WUeeRuVijsSI9t2cfbt4FbtHse53PsMCKLd8iz1ZpCrCtXIzYRYn3l8xCzEPUuECYX3LLOB8Zy+TV+Vi6XZBNEq9qXmdiVSTi6F7Zkw3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724687616; bh=V9S7oELKq+2UlUFfbw0VYP03P1nSBrZG+jVqzeqFA4q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rRK/2yDSGosm0hTKfP/vrDOcar952YzOrQh2ljhk6SENQdpC0JZ3v4WuwfQYUmd/aDwJDc2VQsesCWkR9g+IqD2Mq4apTxI0Y+3OV/NFoatZRxYCCPuGXe9Mo+RtEOTblY/Dt7FjP3RGH5DoNA97L9vrXd9h5SPP/s6Xlz8UbSBtrpbc+qjbPyCrr5C9VZPe5lsqPLOavZVRQlR74iQAfLrpl4Ppke/DZIt7Nmj+3mKTL3cXbaGJWWbOK/ZnN3zZCXIstlgR7p+NzdCcyB43sRjA1ievd9Vfow8GYPmrzT7ZrFkPLJXN61t5/OfEvMLwoRWD4CDHDiuT1CbQB9e4JQ==
X-YMail-OSG: jUT8g8AVM1kggEYmeFvfk.lcQIvtDPi3pe.KL8lqgSP2MNlI4nG3sjEaJvsUC6Q
 i3D7iBQAP3rb.klT_ziB0PdOrjMZkdXdDtNIrRXocMXU2B1HuMyUHiP7_fyrE1hSLerprdpXWmJ_
 T1Ih3oFo6PlZAhXYykFcax.s4u.cVENpPBh61Uj8Y3P_J.Og3Fa09EwWHP5gDAYSxojFK7f5.Uzr
 NIuP3Wff41nh2E0jtvevmFlbwpW0Wj5Uq71.9TQhXv.rJXyzjCnOEpFJKiUMNvH.CVTLzryT3NRl
 Tqgn.UC_WO.U2D7tWQyHheFFfKdiAM1INBdcbtDRsioULCf.w5a7qiVYDXXImxAoQ6YlAlpHs8CE
 Dw1HqXsWq3h5a1.bEtMeqwBpU07OBSUNTrSnZp_JznVXCL8P5FEBiH0F8i_mxObYVIFe1oh4EQNj
 nQEi1oH1GLCiCerP38zt1L0kIpOh_cjKw544ATzlcDRQ1jzjgqjEZtbUq9Xjv2w13KiZCkGUq3yE
 qSy01LOD2DQD1Hs3pBNUpP5_dO2a0X0vUOvksFFsantkxZI4IkvnwcfnKgq4TXWThETkQWXVT451
 7pkZj4hvu3J..jp6z7wTnypW.VF9_62HIyfPTHjiQmQMvDcPhG18jT6k58mVQRK7U07hWHWbGS_4
 SPvf1hpBlimLHZoMh0LA7ZnBBukviLBfFwdrmhsV968Fl75NvclUbtkclQruRBDQKSteGMjiJa0t
 dSpkpKbBKPrYz_HyeFvckD9Wdf0DLp0vEGdznIQXnDoSpfkaslELzq3ymJKZwUQVZlPTl23ufqyw
 hlMRXFt.eoBwmg1uQgx_lbtA69rCK6V17F9x3YwWwLJlsVumHAeXO1361S0BXEbQrxROm3.OOHD6
 QV3GJVDle4G.uu6dQl9nLhhml2jNY2umWaLHHrRFr.PXsqyBo3MjiH5A_ZssdQ.TVsjoBUvSbnm1
 jYAFuG6hppR2V3fufhusGhz.CdpPMl91tj5AMpB8YAvju88GVNqfKxBv2kYLGM_mspQeMilePZqj
 _CtjPu3WYYNCl1vleS2Utut5FwLFdKPRBi7qqZclQbccUI.Vm8N41DlS.QJlidSoWMcarqiWCfAx
 fMvUIrnVG0DyPkJb1jD2fZBjPsme3jezSjCakoXTnvgPS4DrMcZNeYtaPsG.KNN.IyT0J9DzGHo1
 nltoyPVbcnnWC3fJnWF3Fxt3RYNmpcUWl48RskRsPDic.DWng4DR55QRpjtxZ9KD7OX4Uee2Xy0a
 nxx8YFQs6uU_GIxr.J6wbeqFqh0K8p11Ag3lZHYQ3WyyizNcgeAslt_oR35PKFwVGt3xqddSLppR
 3eU7AgH5chW1Olc7i5rLpNuK_17tY2cMA4gWwgb5XxRPNqEuqkHPVULj8d7ldIUaaJeDMMqiOYG6
 5b2A4VQDm6SQxxgKkGHcWn2p4VXvuEd0ehzguWpDmV_zSpO_z6.DzewR3SviRSn2UtTQc1iB.IYI
 Esx6nEmstGjs18L.p80u6ki5r53kDl1zDbbhgRT8BA.kel2yDhPDNmYi_0jvVJzQpxdR5OB6G.EY
 3_pkcqIciqpFgEYGxH9LxCJYzoEEsean7eV93F1PI2nKDXuFhNYetMytNYr8p89E4fHd2Jg.e3yp
 u5wpL7uNVIyNtUJHOqDTTt5nnL5DQTBW.NycX7ZNQTv65tsCq2nzsAKtTTWaXwGX01oB4SpXEqoU
 EAl2qtoZf6EQf.mPTMpr3o_vlkinu040QEITwC8IF.xWY5c5Tikohpuujl3Mz45QSlRAHw8BaPJJ
 CEskodOtPwb7Fte3hsUTEpt0ykQBOvkvxjHpU5f24yCnevfY_oV48tXFd2lwEs_VsCE8.yekm1JS
 qNSNML.7WUIdMpxL10qbTbdcGJogV7A5CUEGfG8kWEpNzTFb4hVjCFi6W56iyHDeP5Noc8xPB53Y
 fytX7WPHsTibeO8oiO6Qmdxqme4tgAelnmpM0oJbCpLvefp8lTA8kSObeemd9ghqGVvIVWsqO80T
 ty7d8Vz8iPz9vc1h.gUBS7hBIWsoJFL7VusywfjqvgKiJh279FzzhX82yD0HkuK549ubnbcrvt9n
 XLhH.lRyFqWegDl2qTpvqdIe6zP_WtLr0azeJ1fiSQp9KOZS.BNy0jzc1wwQHccWHDk_QCOv09Lt
 4Fg5VhRumJSkrmUFZ3NsS4tgTh3jQkpaBJ0EMynlg0Z9VcP3V3MkGbhD1Xx5VSf2tPg695Ha8BVk
 zYwBvxDRg22IlY846.0mEZV8AGKuftkjD6nGpBtrdcyAbYBHniSXJi8656kneFSvgSkCZMvVJLKv
 hIvRHiVpQqeN1X5pIT7pf.Vgqku4D7m.Hq25FyfQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: dbea9ff7-c467-4336-af98-49f8a7d8c4f1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Aug 2024 15:53:36 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c5e689e62c84dd1f2aa7c31397f92338;
          Mon, 26 Aug 2024 15:53:34 +0000 (UTC)
Message-ID: <4403f4ce-21eb-47a1-93f1-c663a96de9bc@schaufler-ca.com>
Date: Mon, 26 Aug 2024 08:53:31 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] Add primary TSEM implementation file.
To: Greg Wettstein <greg@enjellic.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240826103728.3378-1-greg@enjellic.com>
 <20240826103728.3378-5-greg@enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240826103728.3378-5-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/26/2024 3:37 AM, Greg Wettstein wrote:
> The tsem.c file is the 'master' file in the TSEM implementation. It is
> responsible for initializing the LSM and providing the implementation of the
> security event handlers.
> ---
>  security/tsem/tsem.c | 2446 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 2446 insertions(+)
>  create mode 100644 security/tsem/tsem.c
>
> diff --git a/security/tsem/tsem.c b/security/tsem/tsem.c
> new file mode 100644
> index 000000000000..76d65b3e62b3
> --- /dev/null
> +++ b/security/tsem/tsem.c
> @@ -0,0 +1,2446 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2024 Enjellic Systems Development, LLC
> + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> + *
> + * This file is the primary implementation file for the tsem LSM.
> + *
> + * It implements initialization and setup functions that interpret
> + * kernel command-line arguments and prepares TSEM for operation.
> + *
> + * In addition it contains all of the TSEM specific security event
> + * handlers that are responsible for handling the LSM events that TSEM
> + * models.
> + *
> + * Each TSEM event handler calls the tsem_allocate_event() function to
> + * allocate a structure that will be used to describe the event.  The
> + * CELL union of this structure contains various structures that are
> + * used to hold these parameters.
> + *
> + * Since the event characterization parameters need to be retained for
> + * the lifetime of the tsem_event structure that is allocated.  In the
> + * case of internally modeled namespaces this lifespan is the lifetime
> + * of the security modeling namespace.  In the case of externally
> + * modeled namespaces, the lifespan is until the security event
> + * description is exported to an external trust orchestrator.
> + *
> + * In order to support this model, the event description structures
> + * are typically composed of a union over 'in' and 'out' structures.
> + * The 'in' structures are used to hold arguments to the event handler
> + * that may only be relevant for the duration of the call.  These
> + * values are translated into members of the 'out' structure that
> + * retain the values until the end of the lifetime of the tsem_event
> + * structure.
> + *
> + * Each TSEM event handler is responsible for allocating a tsem_event
> + * structure and populating the appropriate CELL structure with the
> + * input characteristics of the event.  The dispatch_event() function
> + * is called to handle the modeling of the event.  This function
> + * returns the permission value that is returned as the result of the
> + * LSM event handler.
> + *
> + * The dispatch_event() calls the tsem_event_init() function that is
> + * responsible for translating the input parameters into values that
> + * will be retained for the lifetime of the security event
> + * description.  The populated event description is then dispatched to
> + * either the tsem_model_event() or the tsem_export_event() for
> + * modeling by either the internal TMA or by a TMA associated with an
> + * external trust orchestrator.
> + */
> +
> + ...
> +
> +static int tsem_file_open(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event(TSEM_FILE_OPEN))
> +		return 0;
> +	if (unlikely(tsem_inode(inode)->status == TSEM_INODE_CONTROL_PLANE)) {
> +		if (capable(CAP_MAC_ADMIN))

Don't you mean CAP_MAC_OVERRIDE? CAP_MAC_ADMIN is for changes to the security
state of the system, where CAP_MAC_OVERRIDE is for access control decision
exceptions. Here (and elsewhere) you use the former in access checks.

