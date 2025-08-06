Received: from sonic.asd.mail.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CD21FF33
	for <linux-security-module@vger.kernel.org>; Wed,  6 Aug 2025 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516146; cv=none; b=NGwsI7oaNnzD4mAFohbZatd+/LmItMM0wBep3T2G4f+Sc5joxT3L4f5lRwxHKWxAkS3QnmgzTWwkT0h/vdTBDCBl2tRU8lm3Pc/jbZznMvlXMoijiGmy2vT2EKMgsWgaI5xFh2ZxN4VsXbHHADsrRMkwAamJdG49gupuK0TJQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516146; c=relaxed/simple;
	bh=R1dbgfgeNAI0p5iT478eeqfKGM4CRQX8JJzi4ToDu5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bPoS6eyMnHGfGPljLABT5yJkb8vl3d+aWI1pPE3lgdzdK9IvnQFknkAnOP3vKPa85z25K+8DZ7eRWFcl9YojhwQyDHB7nqUXI1p92tMbRKxLkVjCqghiEPgZ74RdSkV7MGA1PR6QR0Gcp90K36PlCOc45F09eYMtyx9Izu47uhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OGEa66vz; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OGEa66vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754516143; bh=bATQnY4Gbe35C5i64O+p8qwEVNL0o6sqqOVpBCtXqU0=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=OGEa66vzKujXI7rbAM7wfVxupGy2e57T/0V94A+uhFIZB70GNfLdV6fVoCY8MPm7gMXTqUuhGkUzDJTcB3CwK87UKUgynhdkYSWBHia3PJWi36EVmRKAScNjxPxerqbBvRP9eXw11UXOlhijVclF9xO1Nqb4w/k7ZIdul1BB7T4CCp9EU7lNMWJBjBS9uxjhJlB8mezanmjwlmaeK8/k6oBxNiijoLHXDlie09InOi3Zj3sALVqOHF1jM5GwHZIQWnAHwN0yar57WZI9KcLBEatXTSO21wWArYa0PWheoQFBPcreq6doOn5Y5zAQWP3TJTrf7dsF7fX7Men4pwid2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754516143; bh=kdgG7wZWZSizaGRMEXV5lsauztvZ0FlcmYTE0LBf1oz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AlT15oOJ4sMLBVm7l7cnkl/Y5c+fWlhY5ydV70TrMs0gA1PBpY8aiMaPDzU1LoDSdFqPgWV2qkGSaY9/0PkfYYyxulvp+x2dbQefZBHska4gjwUd5jxj1bk+/NF8muOs+qcDvXbsSaMamixIIivVM6OWjFLWO9cLpPnnXZy5iKVdmNxFESIVZu+5cA1F8M9HmkNgt8hTA5tRlckDDCKTZGuVT74P/4i5c0p9KJBVM/llT7WvkfQXkRX8UgtrMHP7jsUsV6prkut3BZR11PDjEJ4QVUYv7FSFuMC5tqxb3NTk1L/eRCzQTM5aiJMo+kNZgHfhACsehsgoPvw3oSiTNQ==
X-YMail-OSG: uZtSw6sVM1ng1ExWmGGkTNmyQ7LnVYGeoOmi_p.qNk4Smvu58qLLmLidVriBrfU
 .jzT7QI26sF.qER7txbiSwdJVS4Wj6YiI3Lzc018gb7gy8saOJkeSFu_GUZCSRyiaoPidOdDoXvL
 mbwwgkWMd0Oc1Sx.1wC1ls9Hky22jS4PY_mCVRkO1jdZobBUNDsTc5V240ftRma3AxHhFN4Hslv9
 amDJIR36NrbZT_Yz1vImgnokPeRQsCqoT1Vxfgr8VJSyfB.OzFhfDSWAUCDfaUbyyMM_X224JYJi
 lXjFaWf8WpohWi1fnKbc2rulFD9wDbApMpQSYrO7XH8AcvVgOxFFe7nUgX3.mykud9rWyDPxr_DL
 30Ici6MCtHMAarig7_tSDqQD5f0TbAxnhv.CoWI1MOsYJCRGIZ0jld75kkf6X.ZDVtb2ldGD7S09
 byHjniUQuk_doIRQ5VNsA8WWoX6bNPCmn5K3una5tYUVh8VDCiayYvn7D1MHGYDcCrdb72E6WETD
 oWf0zcjw.Qug7ywta4ZVK82glx0Ijlvf4lMyFoBqHFv0f5Zi9Lph0D_j5AvqSojPrzNrU4QHxPF4
 714V8bviAM.MNS3V0Dh5m.q4_iTf8aJXM3UxwOIRqix7EgGQAz3tA5MJVelFXMnCi4c1y9helFcs
 5YCqlqHYBVn12XJCOG4JBmrhottRwTYbYHhkikmtn0.z_gTc_bRwtpuADLCONQkhhhxvbMGu42.Q
 lMYrtrsyRwyFdrfqxB4AvlIZwaxRJ.QCxyd8SXqXJ9n2giZ9SUpFNSfj2k7aY5wzE_mOEEMFvVR.
 8HzGI2wAcuSq3UwFK0W1B5WzQ9Duj2JYjmonbq6JOeAnhkaRsG4aaF.MUK6TZTjKBOTXn6oMycCj
 4FWRLrW2.cOAAFg_lZveJWy32fHhevPbmA2a8lpRWsvaMu36s9YlzPtbPfk4XnHIn.LgKWlZWVhN
 RIe0TO7gM0Ecxvxj6kLMEeTtb6JrlSEzhkf_jvcvyxOtgLIEzGOtRdFF2.GnTXtA_fK0syivwuoo
 bLTPh_SCySVT7O3ketvONj.GJ9fFX0sryK1b2fgBi3.z.O9FKjiZp0fh4JBlI.HzT9_j6DEUnv.H
 IEtRqx5oXdWorIwT5LsLCdO56Q4lngnxNSD2rNz3_4yB7X6A6Z40qvedL9p7ptvSGhbafflw94AB
 rHVybMD6PkcHbyl5IAmzKOSM43lz05OP71Ec2nL8oJTZVO3UDwcQaB1cL_0iWe7RcRL5Mi7VX5lU
 4EgSdL4ByHf.Jdph5hEfZuk3YzeIbcPPAFqU3I6x9WVqne3jX02Vrc8.esUtyUk6ZofhIRig8HYk
 rzoZnd9ZvLbJoYPHEv5HtVwKnP7BQOusQ1S_x4uqUqc0yWm9yy7Bgshv3RLFBwP3YHDclrLLUCLG
 W070GiWuMjrfzR0gPRcY4hC2txEmQbIT3rhKqEzVzDsf0zVFcZ.qd.fdiarFe2n6dOVwQ7Q9mmjv
 FbEXd41E0VuvxUayIo8n2h7WrVRvnVJelOSF4bqQ9pYd8cGO.Hj9xMW47Ap8qJceAglqNe6pDwqw
 vEk_wkheWIUx5sz3Sugaidk5.GJ8xDnlQmiiArERJdBaBGU1WTfYwqCFTRAyU6i2yCwEZ50KBx_L
 yvmkmUZRz8P3S4jYwqnHcS3VwKubER1OINhsmLpV2WeABumb8L_ieVrtoxkSrrEUOhBSJ50xUNN9
 2gghUqAeQ0M_QAUVvMKe0vPYLLuCMGhiZDvz4SgzYUHDJpN99TUhRry0Gms.y2.P7n1jolomksHh
 OGNa1.GLTZMAjIf5_cVyCZ5P8UI2sJYAEjI6QybncTmNdgTDclNoEMohNPVx1LYUL8lK_ATNxRLK
 7gvANOM6KAsoPoE_1ye9UxYLdzTn7yizn5mi1l1dofJWsUO_nGxs4S6DVJC6y1l.lmZhBUPUpgnI
 4b5SrdEwsVP9jizcD0U6gXQyB0PSyKF5s6TWrhWXzn9E3YAeMHFq7dGNPc2YBWUjIrlH3pAmwCJ7
 AMliOu417s3rICBgHC8abMZMIZTy7rC_uwoU1rUO1UoOIB6qhCwiwTllrQWLh7Rr_g.77Vz.4Sb7
 BfSMIxnpgFDy8HxDMYNk3CN0rtwwu_YDOqMhcLJn4OINTRakV7xlV7Z7PglxoJlEMhKXnmWWhiX6
 beP4a9iSgGYkhr6S6rprdvuZubxCjdxVTTreHEW7mShhIwFO56YH5g.KnEo0zRBrbYYpmHvpdgmq
 ul6yuBjnNnYLKEpzosONhJKD9JceRbz08gP2ENhXAuqM2N5FRicrxxSaWkj4Ys5ZKkzC4hhJ9iAi
 OUDiddxQHtHI-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3baa9904-de4b-4ee3-9efb-82502f0ddcd1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Aug 2025 21:35:43 +0000
Received: by hermes--production-gq1-74d64bb7d7-w6q4t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14fd28e34360ecb6eaaef070cafb6951;
          Wed, 06 Aug 2025 21:35:39 +0000 (UTC)
Message-ID: <08325274-13d1-4fa8-a165-9d6dbd6fc692@schaufler-ca.com>
Date: Wed, 6 Aug 2025 14:35:36 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: use lsm_blob_alloc() in lsm_bdev_alloc()
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
References: <20250806212552.240730-2-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250806212552.240730-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/6/2025 2:25 PM, Paul Moore wrote:
> Convert the lsm_bdev_alloc() function to use the lsm_blob_alloc() helper
> like all of the other LSM security blob allocators.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index ad163f06bf7a..a88ebfca3224 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -823,16 +823,8 @@ static int lsm_msg_msg_alloc(struct msg_msg *mp)
>   */
>  static int lsm_bdev_alloc(struct block_device *bdev)
>  {
> -	if (blob_sizes.lbs_bdev == 0) {
> -		bdev->bd_security = NULL;
> -		return 0;
> -	}
> -
> -	bdev->bd_security = kzalloc(blob_sizes.lbs_bdev, GFP_KERNEL);
> -	if (!bdev->bd_security)
> -		return -ENOMEM;
> -
> -	return 0;
> +	return lsm_blob_alloc(&bdev->bd_security, blob_sizes.lbs_bdev,
> +			      GFP_KERNEL);
>  }
>  
>  /**
