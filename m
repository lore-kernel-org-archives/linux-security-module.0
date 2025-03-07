Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA42417D4
	for <linux-security-module@vger.kernel.org>; Fri,  7 Mar 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370139; cv=none; b=l16gAPPb8WR44fiDBXWrpqvow0opgDz8P8jGq9zuUnFAt5bRHHJiCr2KC6nmx2UFCNcP3rYgRGXu2VOY5U80st8lJBKf5j9x+m9zvtpJzzReWVzINILnnku6XK9SzLkSblVGAv6He4XUeQBV0tHJuUYzzoGzhMuacrCvi5IgxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370139; c=relaxed/simple;
	bh=2RjB1SuV4BEFJPThxYR6nac/hEoD8h4LIU78HbsEajw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLs2SQhzQYhuGiSqZvByKas3TBZt5BS9QDtM2B3lUVq2e3QhXS4aUA1pu9xgE17G2uXDmYH5xAFqsunSHwCyhUwIU2FkhLJScHPspVmFG9cqEAHh3qThT91HYN9XpBjzh8SrLsVhAwAALSaHv9Tri/4g3JSXBMWeccCuzBv0gWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LuXE8UQH; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LuXE8UQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741370131; bh=hZ2B1+frfttyGUUpICWM5pE41SSJOQsCNIaKmHFlGys=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LuXE8UQHYWlWd664rijRRZN/jbnlDs4lgaPaR1mrVqQUgBR8uh+NQscvUtTkU9kCIOXgppr25yQAHvAnr2ikC4nAdxq7BTUVH14oq1a9OiuqKJrKU/iGf7BYWgAtwWFXY/m+iGvB4VYS1NuJKk9AKvcAOOOa4q23qIJGfRQMIdZXu6OTpZvAaa7K8AInp5cDmHuPPMndGZ1O+ihExQRky8S4MLWZMhN/TSZnUDkyv9LEYsxPE0J2ErJEMSwkQy0L8JigAq/V/745Sk2lZAK2gPOLMvHI7R0XUMcI/OS0CBZHl4Z5WOiinlAW1pRRZswf4LkItf05TYPyYxlQ7UunRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741370131; bh=KjSw8rHj27tkaDe5dHK9X5KU4HgYpPr7CEYOUhme9vG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=G4fBvCQ7SXY/LUsvnFhJxODeZ3i4Opej6HQCZRJOZu93XJlSY+KftpMgHPUsBb/3dJSduiYDIFRXwHwQ30WkTn2VIiKwcPCendEHYry5ORZDmvhg+3pJL6cuFR7P0dKbbUPbg6jwkljhCs5ViebMakhzL6ZQ3XO6SBcp90Hw0X7q4vQaQyqy3H38ybFhU6OAulBpxIwXw7QNenR5rC39wh7aXaxjWq7WeGTBcrdHiu/rDMkiWdWt9J+zCsAb2R9M8RVJ0U+QwbihIMvKhRgk9Sixs1z6/ngkj3Hfx8+KJxn5+GY24uYtwNvG3fMcf/vdPVDZ/QoPrgKWQ4jEaO9S9A==
X-YMail-OSG: DRYtj9oVM1miwiZz8hFQA3b9TWrKUCnhUeoE5.iA1Bzgez51hIIkXD_zrCY_M2E
 sGwA5fOIn0PWHIzXKa1hpfzWlnA7DteIdo8561dnPc6hD_a4AUsK5mZXuVUPgQGAKBRWjQ.Wc5RJ
 glGqQOb5WThx9zaR1ndpHCuTA_R6pj9QhhumMtQD80L61V6ZazRjRkU3Qh_je0kOg4uNllMfFH8B
 JeHmzZvYV0PQt8FwS37WP54VNqh0PCh06KDMYhxin_48PLNYyJ1hVDg624bYhaA1V78iVeo0FZav
 mE_knjFtJvuOSPUyuTbSLSjKhEqJwjxyodD7qRUSDJwOpWwOzPPRKDA5NWaXSseVjUfjTdErQgyn
 3ZnL0wRO_9w1RUZwlAiMglOgn9cw9VEH719isgnRpwXb53nOf.IehC71ZySWUtAM4wpQwDJ_6F6.
 pvJXU3hN_CGUwLZ0y37ACYTSUaybvQqbXpHp_.QkcZsCZy_sKALbWltFntNt7WYAIaGXYqZzvBzz
 hbwMjgH.lRGnNm9jL7WLiHjkpSDu2vAhC8J28PbqJnb18fWoo0M2aa2Cmbc4u5A9ugMbv49UJNWF
 kXS5RmirkBRpJwB0FQIsv1ZI9mmn2.HJSTb36UjG2lqwKnNSsWCY8Aui4Ns3WmorvE6wFOl1kjJ5
 pgkkKep5Z2IV5Bz.U9SeNlMvetY0DnBGNGsJOLtN1jVzd.3dONktNZvkhtNXXtUmO2tFmX9te7Eq
 RM9vu96Y1yd3EKhmzTcx0ow9XGedVHL6ioMNHBa6lO7_eU2SvxezqMHEdVazYhLTJWQiWWje6OdO
 XHWuOP47dyZRA74M0i5qwiPBNKS.nTcMqN0Vvv2XX1KXvsPnbXnKrydOuRWIwOt.dzh42UMv6fSY
 VRGFYs1L_g8GBd4KOthDs8uS37AL2Rag.wosTuR086JzMik1VykN4mnRb1XdLFe17LWNN8xfwPsz
 4fTSXqmpzsc9qK24TDuIlirEn2hDDZp_4Z1E1bTHBrYQfDaZaKpk9o4w8r70op_2wq.M42xN3k9G
 OyDO1ZfWLNlA2xPiZmYUSD1IajGFSLxpYXGPJ9RMX9Hh87X.DIWcSnPWto8ukHZrnpUYv5uL3h5L
 h9PEQ2RowQMLSzIf7wH_RzWuDTKjb.F57EpoPsWRspf1QmWShUG88FjbwhTRI49hlUQhOZELgCjF
 eDya6oabFYFgXPICtrE6h_7Rrhdaq9Ev8W4LjaNo6HRXZpZXtdfpSYlhF4rC.BXUkAkKZVRIKcO2
 AY3sNdLpr66MeMB0XbbKkLRv7uky1808lVHAGz_LPJ9nlbuV.alI._s5dC27tYWi0P13VFZoRGTQ
 ugIruFpZHDqRV7smx.5QHAgyHqStkHtKZkVRhrDNcKxxvZxrbswG1C9oMUKPbJLSx9axylQZBJhE
 .5DK6AbJmw3XrS.B5FGbezLt5jgKMjkN2Hxpi5fpyGUGOH8AH3R3S4gu5STNrePw8ikOHi71yu_8
 nd_htiRCSTcJNiwmgEmmwRyhLz5R4AQaYzXD9t3aOGJ89SJmRQvPrq3mMWmXr.hQ2P6W.lm3HjkU
 zaNsrG_kSDo_NJVN6cERcfZR0JlHkGYOgY27bwbR.O3OTkiEomEh3HqT4vu8LvACanF_yXetw3sF
 JsEFZiRwVSuIHO0bZ9iEsgAxWwEobeGpXglHCXdEwQ_ZdGhSZkf7HC4HZzxpljrABG04161J041o
 POsK_maBiIqtQPJ0DFdg5.dLY2SZKKTa_zZSvBwR0AWaRmkZkFOwuPnr799cL7VOCuluAY878rvC
 r0k0Era7fFVzakXq6Q9GA3z2ynVO2OizCKBDcygajd4misVQTneY5nB1hybhq0AB6ONf5y9PUPBa
 i4UjU.rtgtKvwcFiTWaNgH4XdxMyNqKeKk08SQSCX.50Hog13gObzu7s6boQrZMBrNeLRXN7yrvf
 6xDLVKwcNrwSPUwmQAa.MoK9EUDVTzTtxi9np6fgz5NwKc9G.qzecWdblqUbUtLiZ22KMHcRZsXs
 _uswVpli2qvRuWK.ZV0lFae2ca7nISPw6Q4zHvbbwA4GVhTpO11ecdX0Ozy4O3rz1cdNbm9Zog7y
 GlYmY8qnQ23s0h0BM_g7OzbbJ.tK3WYuNGpRycb7BJlwLMkKLUspgsMjF3pmyG55inea4SyaVJ57
 DQODlntJnH09aYyX44oqqjcwpk6dnUD.kRK.MpvL_wyL8CBInkWiAD_0v3i2crv98sLw0TF4DvHA
 ae9iV98nFpW2L1VKUDc1dzdGzzxQ0EOSJBhR7z0bnxDA4CgQ1svrZmdBDxs6aFcsMcRendXrr1Ou
 l_9lJyVCo
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0658679d-9e3f-4efb-b4d6-d48bbfc938f6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 17:55:31 +0000
Received: by hermes--production-gq1-7d5f4447dd-42bnt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7bc0e0d08629c94b72d0eeccf55bed8d;
          Fri, 07 Mar 2025 17:45:20 +0000 (UTC)
Message-ID: <2ad83890-f96c-4848-8820-78455d56caa2@schaufler-ca.com>
Date: Fri, 7 Mar 2025 09:45:19 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] smack: fix bug: unprivileged task can create labels
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250306224317.416365-1-andreev@swemel.ru>
 <20250306224317.416365-2-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250306224317.416365-2-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23435 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/6/2025 2:43 PM, Konstantin Andreev wrote:
> If an unprivileged task is allowed to relabel itself
> (/smack/relabel-self is not empty),
> it can freely create new labels by writing their
> names into own /proc/PID/attr/smack/current
>
> This occurs because do_setattr() imports
> the provided label in advance,
> before checking "relabel-self" list.
>
> This change ensures that the "relabel-self" list
> is checked before importing the label.
>
> Fixes: 38416e53936e ("Smack: limited capability for changing process label")
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---
>  security/smack/smack_lsm.c | 41 +++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 99833168604e..95a614ae4c9c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3732,8 +3732,8 @@ static int do_setattr(u64 attr, void *value, size_t size)
>  	struct task_smack *tsp = smack_cred(current_cred());
>  	struct cred *new;
>  	struct smack_known *skp;
> -	struct smack_known_list_elem *sklep;
> -	int rc;
> +	char *labelstr;
> +	int rc = 0;
>  
>  	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
>  		return -EPERM;
> @@ -3744,28 +3744,41 @@ static int do_setattr(u64 attr, void *value, size_t size)
>  	if (attr != LSM_ATTR_CURRENT)
>  		return -EOPNOTSUPP;
>  
> -	skp = smk_import_entry(value, size);
> -	if (IS_ERR(skp))
> -		return PTR_ERR(skp);
> +	labelstr = smk_parse_smack(value, size);
> +	if (IS_ERR(labelstr))
> +		return PTR_ERR(labelstr);
>  
>  	/*
>  	 * No process is ever allowed the web ("@") label
>  	 * and the star ("*") label.
>  	 */
> -	if (skp == &smack_known_web || skp == &smack_known_star)
> -		return -EINVAL;
> +	if (labelstr[1] == '\0' /* '@', '*' */) {
> +		const char c = labelstr[0];
> +
> +		if (c == *smack_known_web .smk_known ||

No space before ".smk_known". I can fix this if/when I take the patch.

> +		    c == *smack_known_star.smk_known) {
> +			rc = -EPERM;
> +			goto free_labelstr;
> +		}
> +	}
>  
>  	if (!smack_privileged(CAP_MAC_ADMIN)) {
> -		rc = -EPERM;
> +		const struct smack_known_list_elem *sklep;
>  		list_for_each_entry(sklep, &tsp->smk_relabel, list)
> -			if (sklep->smk_label == skp) {
> -				rc = 0;
> -				break;
> -			}
> -		if (rc)
> -			return rc;
> +			if (strcmp(sklep->smk_label->smk_known, labelstr) == 0)
> +				goto free_labelstr;
> +		rc = -EPERM;
>  	}
>  
> +free_labelstr:
> +	kfree(labelstr);
> +	if (rc)
> +		return -EPERM;
> +
> +	skp = smk_import_entry(value, size);
> +	if (IS_ERR(skp))
> +		return PTR_ERR(skp);
> +
>  	new = prepare_creds();
>  	if (new == NULL)
>  		return -ENOMEM;
