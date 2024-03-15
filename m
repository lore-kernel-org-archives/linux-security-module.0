Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466345038
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519529; cv=none; b=lL9270aiyZUB9Fntwtl/IVgeCgizcoko6UlEjV2Qlkh/9z5nKKGx/PQ9cfQImHdpr0xO2hE//jieNOUqFoQ2/cKw3qeKkJTExpjPhCmBwEd/QcvLTqhI8brzgxP8KqwyfEPq2Qg7tVYw8LtjPX2ewYcVEvwFL5r/o/HrCLNtaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519529; c=relaxed/simple;
	bh=75AXxxQANuzDeembW/BhToPCRmkUrtvXXjBhPDOQTgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsFH2/XZtCDs12YKzczjiQJRagsuzSYu/ogVI0dVRUUozOJ6E+gIYDujg53Ysv9y0qwjlGjpiUJwE7HyXS/qWIWHZAsjqNWH4CbqHjRWbkK7lo+dsM5BmwcR1P4LTIxY0WMIQGlo2PDAPjWXeXgM6/9eseCYX7Z4cgEnEyncwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mEfY53O5; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mEfY53O5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710519525; bh=zsT01IrB7RrTFtFRFOnn/lUTXR8cW82jQrbDuhCBCzc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mEfY53O5ApM3wY51mR7fioXOsHnYaZwhBlPD4DzFf0k7SCj2svaEEHwCb8cCZo04aaZaRkqspN4rdZyaHr7znNKnp9IcPWaAfy2BIri4AGRMSYbdONu4mqaXYgyGX3r/RMraTPngLJYcnf6ESEMaNsyecYZGkRV4adGd+cwCd6jc7Yntp25jyaWiZcsZLGeiJWeEUlvPE0JhL3WfmglFip9MOo1LjmVIWAr7ietE58XfO2SQXHbAygLRk4cwvNG6K+vrd4ZiS/1Y4irICzoY72zU4M4uPgcxap2RUq2vtY5dHNckUBn1fwwqLFW6rPZ3M9ZdM/bVV4ZAuZBSC+w24Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710519525; bh=yDpDT6/7yp5jyHrfAFa90g/aeB12Ayz2ggKHNnN9CbP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OWLsf0U5jWHIKlYFO+dMjdlQUf5/9HWcVdQV5+wElAHa4+y6c5Ayb4gBvQec+upDtv6xtfpLjx67Er4vTc6aB67kez8F0aZTj0L+GHvROJj6SwbbkR5SRbU01xfBIrJNxMb1tRLtSSy9fK7Wf8Z4JRAinNEQilx/m98GGXC3HfJNICKw2t8awj6m5Ij4vtNz+kTxuFolxUxqNNRG60i/4Tk23XhsxlDFfzhbkvNYeYiAJBd/2i+CzKArYKe5yGxrjNo8dOMderLv6jeyEAXLUjUGRQcD20TlSN6graIH+/s2YkC4nSDDX4RYiNPVok0LL4YJdJa+0+w0a+94WAbNiw==
X-YMail-OSG: sBQjSPAVM1lOqDmWLtZkjrhVYNi6s89TS4djAEYGwaX6rOUynq6iksnZ0J6wPR6
 eK39OHHp5wx5uEk3ug7Gex6IqZacomm_pGZfwBgQdlP15q0Y.AsrIgKoG6l09GmA2Tvi2AQM6vfk
 rwTzShYU_IiB3BU2kKfUL_ESP3wwAq7Ymsdz4EY3vJy12lh9j0FVBFaGD7y1ojqm7Hncp0fFwZ8T
 0ITR7XW37mZhKRUmpv1UVCmujf0MfHf2yiYhJ1USn_2Zlh9_.inDFr9yiVroqa4FeyIB0vbgo19c
 5p8AcY0hjPRD_2Sqpc.kBHPCAghHyKra_2W4uPPNjivTPVqu752g44Vsiyhkrd2N4.uMWJAdeaGi
 YxwPL1fgDTi9ETi4RowRT_SJUH5q9GeTWFKT2Qx9tabBRdO7.0boLioM9bXwgoa_6bkxy0qGgbgF
 xAhcH5B6IIZJ7cX7JCDbZDEsYd2dNBmhe5cBbUkB..g7Z7jlPnmSGqYpgo9N7Z0n3ps94C_csAAY
 5PsuU8fUGOB92zGAvO3aFzvb80X.8FOykeoFc_7TKBKDTF8B3_gOZrBqsUkBJxbmGaC7kKiNm0Qr
 JgUx2i6rmoF1KscwwxVtMFo_c8AVhFjCLuK733.ZND7NP_2b27FC.7gAgZYQiO9O5Q6yflxb.pzW
 4YiKyD4NPvBsMindgYMJR8r9biJyzt_SU3i9Tlawo6_VmqqtvjgLO.10eM793_46SZO1xNnPzFBM
 .6weCm3VMXba8LJHW48snefGSbN4kHjdCfFoGXbvXFVvNjSQbSCzSNCHFD7wm2aCKKdzfbhBp6Hn
 Q3tFXEoDjhCR9Lh4FrTVn_IUxiinisiy.ubN8pXHwVbeq_pL7Av4rA6I65bZCRaHiacwg2WvwU8U
 gKCxVawEfHOr5KCkinu6VuZIw2KD1h3hRnDefiYgd10V.OSXVpWcgRU82TUVMRzuY2mjSMvg2C_u
 ks7IXNoWq.tI_wEVh4CBycOL.xwqw7sG13dzu4GQyxza1tLpbQYHL0GL4CGPjKhfpgl2xMYs0YdM
 5sTgi3p7xpMFtuv92QUcUogIOZlZ8HHpWL035gttWnd1NeR6DgKttNK.ZW4jjsoWiJSWXSXZpCvb
 7YIEC98jKFu71IrXB91TWxrRO0K.plERoLDb5TeKezCqdkw_zgvcBDgPh0ZdYbhnOo47PCHnfAvs
 lAe0mYhFGY.KPWsPvOSSEv.NdTe7BXmlgpV2wFurayMLGRIeDHW7gm4ykFLcSQp.IAaTES_iDuTu
 I9jLTzReTcfEn4WMhj5HcVjq5A04AZqJu4XynQuYWpGKXmYe8nL6yQ068nLa8WBVnJVmuvOwGaxJ
 rRR6_ZpOon.68M2Zyk.nTznKmuk.Z7kaLJNrPIBGVD6JPGm1D3QOFRbS48dzqRm2jIUhe3wvGzsa
 b0_VFuMIqIVtny0uMC5GBMW8HIaHzJ44UKt62Osm4swmg5uxe7p5U1fOpATEKErwNA77Xz1GPJW7
 c_BBCzI5KGrUG9zHO8S9RKm5Th_hoaCqWrmetg7BFjGo_G4w2CqljZ4BMuTvjW6ljJfgbYKFY.xo
 FRDv6h6.Z6HqVCHMeWBvAnSXeRYymgiC4BlblgQlZVxZWiRJtTnOybILOY4m7Mvp5kXNtMnq4SC6
 L0EADweueozU8v.nPi_.ZYuzkZjK6vMyBV.Ze_zrYwpC0p7psMoQbBwMZIjxNPg921MVS5RUmdsW
 eJFPph6AoEnXbiFFIDz_CSwsu6UIPIKludwdc1ehXy1AczgiUDq.ZIC8I_SlIynf1tOVW7wSc9y5
 5E4h9FzDA9kE_KRvp4NJefjhYrCPYhBJTAn334PS11.aVNOgGyThrox0QLrElyR6.s4bSp4MJG6P
 M9dXxh9uGqsuePPABFa6hycrdZaUsNBSxkhbwMPQdngP8Af81TKzuo1gOZhn3ezfBUhHZ.2UAv5u
 eKH4jP51GOHDDw_zs_MQy5cZZ.qC.eCU6eXwqu43INh25Nn5vBMmYxMNi1Kn.eisZg8GQ9LP5nDC
 KpiddAM._Wyq2vbfkWSujnnjlcKwkVPblzf_hAx6rMBRYwtnFKCCSTDLEZEcluY.FIasAJPKLiDt
 9WubOvZaKCq0Ae4Uu5g5nsX8mD_xn2lZsn78OWkQS7lvlq.NfNQN5jqsLevlqvTBoayNGxLV.5UW
 mHTEFaEM0kMfo7H2P.C2LZWIkmdCVwYngQn6o52RwU.dLTsAbjYi4NuG8kgQovTKxhn2FEDcY_0j
 B46MxGR8uQ23DbKAWC9s7vHoCX6s5nrISXu2fPhAzbLG5R1Cr04KPc0xj720_wqTUsty0pGNg66d
 GNRrLLR0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: da28cc69-edf9-4aaf-9dab-9294087797a8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Mar 2024 16:18:45 +0000
Received: by hermes--production-gq1-5c57879fdf-6xjwd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ec0a6a57a15b5ebdb4c7ec6a674f301;
          Fri, 15 Mar 2024 16:18:40 +0000 (UTC)
Message-ID: <736c7fd6-1ce2-448f-8fd1-45f057f2241d@schaufler-ca.com>
Date: Fri, 15 Mar 2024 09:18:39 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
Content-Language: en-US
To: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240314022202.599471-2-paul@paul-moore.com>
 <20240315150208.GA307433@mail.hallyn.com>
 <CAHC9VhRWbiPSrLKaykFJ80p-orvxhifxMvN+emygF6Q2y=hf_A@mail.gmail.com>
 <20240315155503.GA308713@mail.hallyn.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240315155503.GA308713@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/15/2024 8:55 AM, Serge E. Hallyn wrote:
> On Fri, Mar 15, 2024 at 11:18:38AM -0400, Paul Moore wrote:
>> On Fri, Mar 15, 2024 at 11:02 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>>> On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
>>>> Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
>>>> way to quickly determine the minimum size of the buffer needed to for
>>>> the syscall to return all of the LSM attributes to the caller.
>>>> Unfortunately we/I broke that behavior in commit d7cf3412a9f6
>>>> ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
>>>> such that it returned an error to the caller; this patch restores the
>>>> original desired behavior of using the NULL buffer as a quick way to
>>>> correctly size the attribute buffer.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>> ---
>>>>  security/security.c | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/security/security.c b/security/security.c
>>>> index 5b2e0a15377d..7e118858b545 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block *sb)
>>>>   * @id: LSM id
>>>>   * @flags: LSM defined flags
>>>>   *
>>>> - * Fill all of the fields in a userspace lsm_ctx structure.
>>>> + * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx is NULL
>>>> + * simply calculate the required size to output via @utc_len and return
>>>> + * success.
>>>>   *
>>>>   * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
>>>>   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
>>>> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>>>>               goto out;
>>>>       }
>>>>
>>>> +     /* no buffer - return success/0 and set @uctx_len to the req size */
>>>> +     if (!uctx)
>>>> +             goto out;
>>> If the user just passes in *uctx_len=0, then they will get -E2BIG
>>> but still will get the length in *uctx_len.
>> Right, which is the desired behavior, this patch allows userspace to
>> not have to worry about supplying a buffer if they just want to check
>> the required size, regardless of the value passed in @uctx_len.
> To be clear - I was saying that is the behavior before your patch.
>
> (If I'm not wrong)
>
> This patch changes behavior as follows:
>
> Before this patch, there was one way for the user to query the required
> size: send in a length of 0, get back E2BIG and check the *uctx_len you
> had passed in for the required value.
>
> After this patch, there are two ways - one resulting in -E2BIG as before,
> and one requiring uctx_len to be set to a large value *and* uctx to be
> NULL, getting rc=0 and taking that to mean look at the new uctx_len value.
>
>>> To use it this new way, they have to first set *uctx_len to a
>>> value larger than nctx_len could possibly be, else they'll...
>>> still get -E2BIG.
>> True.
>>
>>> So I'm not sure this patch has value.
>> Oh, but it resolves a kselftest failure in a released kernel, that's
>> worth a *lot* in my mind.
> Sorry, you didn't mention the test in the commit message.  Which testcase?

tools/testing/selftests/lsm/lsm_get_self_attr_test.c

>
> -serge
>
