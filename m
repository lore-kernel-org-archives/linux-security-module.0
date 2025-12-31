Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6E749C
	for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767214972; cv=none; b=g1qg61l8quperzoPnPL+YtBSHO3/he5+V+8AqU9XpHBGlCZAPbegMkyIQCQ7RdnFr49K2FgaPtQONnDsBXIYHxK/VtPp9YjpCPPVc0ESFZujCWkwgc5i9I06KeR7E3xvNZauokT8RFXB5eE5Yn9t0Z7psYeOb3XHS0Lmhj9Cn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767214972; c=relaxed/simple;
	bh=7+Qr43xcZ6EQxdNYok9bkwmEVyuEO3CLjeeNpD6aNGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRifcjjcYhldkk5uSVvXgHKnHpY49cf2NN2PZU3oaaD5Rg9EKGfEjtf4Chsbq+sVhjrdo5zwiqLATXQHdx8AwYK5KY7ynk6eAuBAVCdGUqGYUr+weeoFWujQEADO4MGaISWE9i7T/HfjGhwEpqvUkVlqAP/kVJ0mzTwrZ6JuJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Rm+H6aDy; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Rm+H6aDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767214969; bh=2rbw7mOeuyNX6CpeSKlmj4QwsnaksB4HULAgn1XU6xg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Rm+H6aDyXY/WUvCdX3VHxt2DpAgEF1gmX7aE575FHmVdrpWILAzmExEJ+76I9nOkZIjIx64leIZqqFoq5YRtKvbNYhfWwiNw5JHzwteANpwejLywkIKNq4UwOJ4vAP1KaFiQbRMA9KcbovIfGE77BMe9hHVU0+2OiOTsAqxqht8ujAYSE2mrsfYvKHVCgmJVlXjHjt8Nr/h+3SjrKcryJb+60+/iBNlA9t9aqlzwjXXts/tIVIV3De0EfGhgYpYVwgadzcweddN4g31i9j2TS/72yje3Lb0zHt8huHcNocl4hmJHAI8W8sHfI2hOziAkDJXsmmVOncnHUAE3ebTwvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767214969; bh=lAWk0ha5fWZCwVbpOxuWnP7bw+2FOxzoMACGVfWtpHy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SFk3RxJz5+CZaAhm8RSR3TZHku8Pwgv5B+CPgSiQR1B3BiWX+8HGQHrref+sSPeEOmb8FiSN1rZVmo6C/JG64SV/ImMIMq2lqVog4CIxUyIDPooDK6yDb9QPUU9fAtwjQFvI4DWEan4ngw9jktBhiTwrfC8RLHyWSu/6v8fJv688cCUxOcG6ykCsdsKVjYffE9HVmTTwaIn/ou74r20DdluS3skj75fO8t8QhmGstGyA8EKtYXd+YH4yU5Zpzle2onezwCG0RdZol4sx5C1TpfuyHQQg82XMFoU1JeIxAZTVK1zbWG4IzmkwaxDXldvRHn/hWHsWXr7Y7YvKrqLQ1g==
X-YMail-OSG: jpawwTwVM1kuUgKJlOkv2R6AUsI9gfE0Jes_HCHioUGE9kC177U2gLP0fSCksLx
 DB9YX.ZMNdlY2Dq4fi0ZftMjv34CRMV5KXdehdfbJy7N2u6f8F3mg5UlhNnqNznDWUrajCednaVe
 AG7EX0PdKnmejfUg_Bzs6G9xuXrGxVzsUg9icNFvKSoaa2Ku16naqUbmtDfCewJaiEEy2wgWv0.w
 Gcq86wSuf3ueLRAtMmPyuIGd.pX9VsmIPkMLyhVFIl741pLTKToAGMtLTrxHpJ4jcBwqb62zXVy1
 ngQ9uRNm88ggWEg4BiAVtWZwlPSj9mOERqnZOYbLxMqu8vrHxoYr_zfSovgYlZiFG0tQHkcwwSD4
 6HGH0xrQpZaYdr_rLp.b2iZEVl08pWj2vgsCe.JfNRfMCq21ixuK71XV0JnsX4_1JCPfp71spD2b
 oI0nb7X3v9LH1ohdnaAXSySPwBxXnGtMTv939ll0LS7dZ46GzXAigE9G8mpOw6xhGt4JE03DH8hz
 dLLfesVEcbkbMHwEtvKlQS8lub_czYY7au2JXpnREtaKwlvMM0wKOVAm.dkFHt1jWyZdHuUhF8MV
 n_RERsOSlaMfV5.XP0O4Zv8L85PF0vnS.rijGsgw9g8sKEy4vljF7rXs94KVKAWLU4hbgugIJ5tD
 vZlEEgbYH2CW7CSWChSTO0v18J7735QJyrmq8e3rStsUmsfOzcpSFC6c7yxrQJ0nyN8psDhU_3q1
 qbH5MYr9GwUzvv4cJBAdQw92Ovsp7.u8wd2dHKrDTZVuHBH3QJxYYjbc9xHAKckx8r0aQ5bDaq2_
 zelsHIY.c1vV2BNTJUQPz5fvVoGbDmY9xlq4FyJ2MDriKozVKc4XZu96ep1kSSO5LyplB3rP03Gn
 ujWOLOXmmfSlT_TTUdUg46LXyQFpY6vT7fl4PZkDakkq2y.MAn5Y_CKWWQJ7AAftr9UlZBW9dXs7
 72zWCSZF2e072ja0wEhTrok97KbcO1Qn2clfHyEjzgcKH76YKUlUqeWKlC34VysbkvUtq9lCJBRy
 Aqk4B_5Y5FGsIC1mq.nxQMYEgjkdC8cFNRCmGFcsKyTy59nwB1ha4wyr5zmkH4DEguIZc_JHvsBP
 acB.j3vSnmDAFTEexjLZO3JH30RqvZ4GDLI7n66qOX4EApC2nMkICPTtVnSccfdGAjRB6sXn3vuF
 XskAdjFwGnwyMnjpHfRikyESwvUB0vbMQAeRiVEqsSzI7opwCoIX4sQRmSsIiVJdANb_jSzzNCtq
 eE3yJGa0md4Cq8VvAjSwZeH_o3sYbXwvQY5FFK5ImZYPlMDKerk.g3aFzH6D4dc0fnxduT45gWL_
 .AQjX7Bi7XQOjUAyBZLNWoXkWr4n5ErS2a7vQddPRnFr1tyeC4S0HjEHviFL60kiqNpLuILbnHmE
 Z3IvsQs76N2SVYsNsrOMuaBoeTc5mmE_ebv7QL3hv3UqKAJK4lQQcc4ZPDGGEUOaw0Qg59KLtgLV
 0.bItaaC3yCWmVciQOCC6dpcQ8niB.S8OL5bf8avx3AtGcm.6PCsekUSTjgHjlfP9vKZx69fS7I1
 HK99J8oh4vn4qF0onYJY_9cA7BOPOFw81VuyUEkrWaRmx6tD0giznxFavTYxp3TYt6No2bPOILyv
 I4lwMXtUV5HS3Io4l_QfNKjIaghhCICjTVfSKIt4b7b3dd3.J.EPHPeWOaiA0tT4xoareH8afrPf
 BuCYLt1mvTM7dzdUl6mXZJ7f1.i3MrjCNtjF_frFKnOt0iBQITREIeWScvntGcGd62hL0vJD6LSJ
 vcfRBXhkSzyx5sL5s37TL0fPYbVyZpKPlusk6qML8nm5Oz3mB6IpdJpFRCIotFnSnQ7GTiKi_23R
 j2eqUIMITQ6hy4Eay0NF_ySOmTrGTNvhC6NXNgEDRjWrzMYFD95jvFW8CQ5rTlYhdclRx5u0Rf_Z
 2qhPoLsd968NVadtouHUvZ1LwPWTq0v2_uE4BmuyYUwNdbJa4Xr_xnmCRuouvPLP2VSnDmsC6bDs
 EPLmMkEnAp4neY9hqytekTk6jsTMBhLliHkbxinfP3f20KjHFsjRfNNZ4pxAyjuhTNeaNUHby65o
 _tAXOwr6KfzFvguqVJsKTIX_DFh8qtUqvBj7OyRIAm6esBN1AdZ4imNfqnAgNiPvxBfS6jsCpejt
 mLKFZSFj8hB8r5qSKNi85b1_v1HzgrHGl1ALI4LWDP1zhM7XmYJl5RGgh8I.zUpUI3MVcW9KUXvF
 Bj6H5OcZv13MzDYlaPr2gU4b2eis7cw0SHGbKuHVa5K1eXbe3In9yX_tehmfxFPTv1IrqQ.LQ9Z_
 av1ZXb3FpIw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8e22cdd9-7907-4569-b1b6-415e48df5f63
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 Dec 2025 21:02:49 +0000
Received: by hermes--production-gq1-54bf57fc64-jfb2x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 786b7a4fa7e1ead6ceddb72afae85494;
          Wed, 31 Dec 2025 20:52:37 +0000 (UTC)
Message-ID: <20cd2e18-75c9-4466-b52f-6aafb72f7264@schaufler-ca.com>
Date: Wed, 31 Dec 2025 12:52:35 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: /smack/doi must be > 0
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250930121602.138337-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250930121602.138337-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/30/2025 5:16 AM, Konstantin Andreev wrote:
> /smack/doi allows writing and keeping negative doi values.
> Correct values are 0 < doi <= (max 32-bit positive integer)
>
> (2008-02-04, Casey Schaufler)
> Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")
>
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>

Added to smack-next for 6.20. Thank you.

> ---
> The patch applies on top of smack/next, commit 6ddd169d0288 ("smack: fix
> kernel-doc warnings for smk_import_valid_label()")
>
>  security/smack/smackfs.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index b1e5e62f5cbd..316c2ea401e8 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -141,7 +141,7 @@ struct smack_parsed_rule {
>  	int			smk_access2;
>  };
>  
> -static int smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
> +static u32 smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
>  
>  /*
>   * Values for parsing cipso rules
> @@ -1562,7 +1562,7 @@ static ssize_t smk_read_doi(struct file *filp, char __user *buf,
>  	if (*ppos != 0)
>  		return 0;
>  
> -	sprintf(temp, "%d", smk_cipso_doi_value);
> +	sprintf(temp, "%lu", (unsigned long)smk_cipso_doi_value);
>  	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
>  
>  	return rc;
> @@ -1581,7 +1581,7 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
>  			     size_t count, loff_t *ppos)
>  {
>  	char temp[80];
> -	int i;
> +	unsigned long u;
>  
>  	if (!smack_privileged(CAP_MAC_ADMIN))
>  		return -EPERM;
> @@ -1594,10 +1594,12 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
>  
>  	temp[count] = '\0';
>  
> -	if (sscanf(temp, "%d", &i) != 1)
> +	if (kstrtoul(temp, 10, &u))
>  		return -EINVAL;
>  
> -	smk_cipso_doi_value = i;
> +	if (u == CIPSO_V4_DOI_UNKNOWN || u > U32_MAX)
> +		return -EINVAL;
> +	smk_cipso_doi_value = u;
>  
>  	smk_cipso_doi();
>  
