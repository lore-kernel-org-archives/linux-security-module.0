Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749941238
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518944; cv=none; b=E6qopogA61SBdb60I5EzaD+0hdvF1jJKl9WA89InYsAo/uRt0lu++UfgTyur7aBSUAjCstjt59JHkbuPjrRrfgHPPEg7vkNRm5a1RlnIsh9YHrp31ZPB03VPlvjsMyfHjBmLhGAi/r3QWPE6asY5OETdue4j0Mf00UXCNVRuHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518944; c=relaxed/simple;
	bh=BGscswaULa4t7iCjP8lsYQnM6lj47l2vc8ioUO7K8Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jc6BgmDJLzntwnIHdxMUE9bRGJe3QeqrV2ja1iWS2bGvCc6Uv2bMno0Ip6+m+BIIr61StgRHtaBxNlS99hlcWjVvrP0xwNr7Mc0a+fAeLnhBLuNIr+c7PKSnAffsUMUTgf24bjm2ubO0PBngTYJdrhuVKRlQp50NOkG7rsBkhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZbGJwpJi; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZbGJwpJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710518934; bh=GbBG6aUuAFZiTHfKkCNWpCqOitRbe+5Ea/mKOgdHK1M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZbGJwpJiZptXZCY9ElhkRwLK+2sxDXBLrbNESQLkHJrn/lfxJS3nBTgU8Ns1ZMUbhYbxhx25IZkT4CVaTswoAG3S3hw3qY2qen6txD9tfKXiAV7t24i7yo4RjlgwUSb2eFppQcs7X5PkLavyX40tXrmaVYIrb2Q/SUIh6L0KiZGaFC+dgmxji+mGtONGUWcz0ehVcL9TsdTxTpifOFR2n92GevUzYrDB4I55jLTZblc+eOeqsa1f5AariagjGY8IoMtO+8aRoMlHNpmo6TzKYGnjluhNCL4ryNCT0dxEM7tWuMBYqck4KnxrY+unxOyINzHTI2TkHA23eU44enQ5iw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710518934; bh=h6LRfLO0bIS3diH5Ey6+6PDlGIAZ/6wvWmtTJT4McM0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AMwQk8AxRE5xPUH6B+1lYap3sm27eH9ODJxkRREM+2erSfIYcBJqkH1ji2CtN2IEpb0+BmQWqonvnxPUgDcQ3CJ3W3KQ3NHR327Nx7RR7kFO3MnbaHcof4jXG/k/4/5DCOhYpZyNJ5Sy07XrMkcBOqf6aoEPDjNgeHIdiQsngTx6+p0dfDm/sGaYKWp4akVgNSD6BE+DsD58e1nSPqMuFdGscflmIF2uIBMb3Bb7VSmbml2MnPw2tb0Eh9aJGG/6rPlBB+WPmD0QGrm/GQeoqs7Jm2LTlVozkoI2MA1G7xRERX6E/TRtRPBUUekLOJ3tySprvQyQWO6+h7QZHs9oZg==
X-YMail-OSG: n5RfPD8VM1lBels7Se786KXT0ALHiaO6.UMFQgrAs5bYMWdH51bClInHTyPJxgv
 ybNwp2JfNFCeIO9VwnLuNLxsa3Iw6NKCABRT0GIvVceWpB.ROp_ipNKKFwuUf60DIzoZAmhIqJ.P
 qxp5uw1o0GS_6Atyl0p_DaS1n7AIlrhnANtXx9iK277tu9jgq57l3BsWvUjUb_tdh9imqe9Jwhcv
 JVjqR6v20kEGfKzovRz.7cnEBhnAEQxlDZUFCymkjrCXldWJU8FqZmrCMKYiXc8gZtND0wjKIS66
 Oofjg3W0mU3p4Sb2rjWlB3UIBUZJcqnrrwEWAZb5KSm9STxLk9Yy9HypoYB9QqA5_qlX.CD3ss1k
 GC3THGbAUtXAYXK2EHTA7nmlid3RTPU9IlwuXMhQpfJGvKSlEU8QVSHurb3MJyIDRSSS1Ja66RJD
 3PTirAjN4Kqrs4UlfF5lCfMuNwpmQLyDTmNLUakIZcavSr9IP6NQwCvElhJfmQxbBoJWhz3Bxouc
 NmjPiRUrXrlvG3qdEik6_vnVuirwZcDIfD3hzN6XD2WbmpUv.Tq_1RLdZ6Yn2fnzKV_2T8sbwAsg
 l7DrTiSbUM0UQ7LnSsORkwSt3TK0olVs7ANVzizs7Xf0EkSxDRfrAwPvduIQLkDBC03On1HsM0Ot
 o9_rS.t2zgOwnFHE_t9phB0xnZKPN4yp3SGSO4q0N.Oex3lzmNZzFI.StwYMMS9OdnXmsjOfRieS
 UzuLtNiQgka572vkW9Ia544iK3D9KMmxXJ1zzJlYBExWqizHNZ_D6LvpT4ZAuBc5mRM4p.VXoy78
 leIam0U73j9fdfT5wCz4uA2knQp98AX8IQUgYVsPb4Cc4Qdtb9zRjN9DPsYjfY6T0gflD_DutbI7
 s7BDDo7_Eb4HTzgzkmdWTayN2E4s2SCCW6PtUOIeCc1zxY.yxY85KlDgw.coq58t0QM01Yc0vf2Z
 M169J7cxwUGHfMbvoLlPOq8lkCtSdDM9R0BoZ9sdZemUm9wuGNZHYI6zrZbdnFPdxV.Ybm5_T0Tj
 lcAeqSddZhT9K6sYpqoloN_ROCkRx8fz6KGe1EENjkJxWwubm0hNPKNQCJQ57E_BhHgoFVbI9D7w
 veSLy5sY3uN.MMIOe8Tzd1ks1wJ_lru6hIOCYgTkTppK8DsNNuGG3tvuVd8waQdFvIXRSM5Synw_
 81wyBU8LAtHTNU.SkcgOf7lPuOBOGwSMHwWoDWrY6DJrylYArTPLYFLx8TeFocSSZsxXjSLnT7C_
 zkvzeBvUUcNXusogJ4oM6vmBWVmT25Ven7ZLD_bBfFJxELB6qba6szLYYyH518qPZG5SdLign9rV
 2jKRVmNf9f4gjvLsmIFbQ.S8pj6wcLYFOgpaaJqooJP90WW3WAp85fnKBA9pdVhQaC0._QPqnh6P
 tUWRG4YIo3diNqrT4oCHN7g6EF3SE.QeCINkE9Wd_SjWyH5kLLG5HpyT7v4agaxAvt2atb3eERMh
 YhP_o4PW23XY1_LX6jIoBkLK.ArEjjhXLjb5FSBPgZiVVtM0Yu7S1hvhxjSlHiTh157xD4cPlAuM
 YSWgm8lU7P8yQUxIlOnY2EteBNUjxl.d7guTOCMiwmc8gAOc4Ap5mT8kfPSInaQayGw8bZ0Ziezq
 EuxucnKNTRXW7hYnFSosAESKjp_EYLUcDCTSyvxzT.GV47V35dTuUURnW.36wMlYt.2hjhJvK.JL
 czFw31Neuon7vpnQl85ZgtztUknGbBYkF41MhFxTaFw4uQZhzS_98le6dFeQ3a6txKkiT06KM1L5
 IwzOaIQaHfV0xvf0it79PihjnrqaZ0T4y.Mc6tDsCX60hh4IEehTb_IRmBRlA8seMEm4ESCQf8pE
 JRVaqZnm1emyWIAIvmIZYD9VKMMoOSaeQjKF7ugf88P71633Ov4Ts9.NBJ9GVpPEDzAuEkT34hac
 0yjGOH5NnmDYK_HNOJyEPatp64UFyK1pa.EhHMLLg6OZXP70z4uaVV9xkNMj1jRMp.q632UqT91p
 2qOP_GasF6W6yJcUnTY8dJUfTjFt81TsxavAz6MVCVQ8qBYVnWR6CoAGEuVBPL.HwfLL_u.POslN
 hJwIDgtjmHLxdFyhXtH60jKk3C8GEzrtblf_9oXLWd2NlKnAanTqZTrV_jMlNT62w2OriNwqLeG_
 wuUE5XC_dudafJegIV90QPop._r9ETD_wrAGnYapNu1eo2h0n1Z5VHg8M9m2FWgwK8Xvq0AfN4RX
 n30BT9887WC_4xnGpd1UU8PuQkntz7O2HKaK9gEVticzhOiZT47NpWneYrHhrdQGUP6e13VeZSXm
 YOm1Yn48-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: dc2a6d6a-076f-44cb-9ef5-eee6dd989141
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Mar 2024 16:08:54 +0000
Received: by hermes--production-gq1-5c57879fdf-8lthq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c110e33d5ab83fffc47a7e7dd5e54a14;
          Fri, 15 Mar 2024 16:08:48 +0000 (UTC)
Message-ID: <7956284d-5687-465d-bbcc-d45435dac42e@schaufler-ca.com>
Date: Fri, 15 Mar 2024 09:08:47 -0700
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
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240315150208.GA307433@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/15/2024 8:02 AM, Serge E. Hallyn wrote:
> On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
>> Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
>> way to quickly determine the minimum size of the buffer needed to for
>> the syscall to return all of the LSM attributes to the caller.
>> Unfortunately we/I broke that behavior in commit d7cf3412a9f6
>> ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
>> such that it returned an error to the caller; this patch restores the
>> original desired behavior of using the NULL buffer as a quick way to
>> correctly size the attribute buffer.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/security.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/security.c b/security/security.c
>> index 5b2e0a15377d..7e118858b545 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block *sb)
>>   * @id: LSM id
>>   * @flags: LSM defined flags
>>   *
>> - * Fill all of the fields in a userspace lsm_ctx structure.
>> + * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx is NULL
>> + * simply calculate the required size to output via @utc_len and return
>> + * success.
>>   *
>>   * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
>>   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
>> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>>  		goto out;
>>  	}
>>  
>> +	/* no buffer - return success/0 and set @uctx_len to the req size */
>> +	if (!uctx)
>> +		goto out;
> If the user just passes in *uctx_len=0, then they will get -E2BIG
> but still will get the length in *uctx_len.

Yes.

> To use it this new way, they have to first set *uctx_len to a
> value larger than nctx_len could possibly be, else they'll...
> still get -E2BIG.

Not sure I understand the problem. A return of 0 or E2BIG gets the
caller the size. 

> So I'm not sure this patch has value.
>
>>  	nctx = kzalloc(nctx_len, GFP_KERNEL);
>>  	if (nctx == NULL) {
>>  		rc = -ENOMEM;
>> -- 
>> 2.44.0
>>
