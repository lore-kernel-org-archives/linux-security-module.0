Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1FAD22
	for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874865; cv=none; b=SixVpzZHnsCA9xKQM+DyP23+ri2yd8Fn+3JHrqyi0Sds86OPafz9U/w9ffp6dSgHxRSXmSpACVbuUQhpWVeyxJG1CCdSibxMVOh8oFuFMNsVNNMVrLcDB5LGwUgOvsufJI6sbvW4NTBgx5JFUXGXjVLMv/9TrPKIUvuEpG8BAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874865; c=relaxed/simple;
	bh=4DDvSqSquLaDBoQJJl6Un1K0uC9esVTd9Asly0Ll9XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZebg1P9ducv22OKV8RlNPdMQZBAt1lHZxQfhV/UB6xvDwZkagGXe9C73igmjmn1rWkJF+muTOFhzgZYtwAJxlUi8sKEXazjKvQi4jIU7VSCSaVGnLDuXJgG+Axy26bkOCIBRwK0fGuGSuP9J9Ag+fYiBLNbqHZWDc6NS3Yv0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=T2emqVod; arc=none smtp.client-ip=66.163.189.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T2emqVod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707874862; bh=vBxO97bYGHmih798Yl8t2BaPT0eG9+n8+RDxmEmZvbE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=T2emqVodmgm6xLvvnMYeHVECR2hdF6ITVmm4oOwBifvlpyqdpH+JrfAlTZxNSrTdkSeUlnNXrkW+/XnMks16GHhg9Ee1CbeknF+Z0ioiAJefG7OX3c+BDcbJL1k4fp1t5PtcA6tJNzKRpILeY6XDLsszyyCkojXZKhFpcE7cR+uFtHETl0dKn+fJ57yi1pDdCfzTBmBK+/QGyy77oFhiFNvLrZ8j4IW55R+y/R7tAr52eR402h3lhHrdATEdws5hU1WrwGC3YBIZKTOHp5Td9SOcc3x8X6ppC10Z4Xsus/XFKWPZKgSOXTuwl2b45WMRmDKTQEZmwUk+0UpVNUN4bw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707874862; bh=sadmaZmaskuvQfGzu2F/+tBTk2CHRdv45u5BVEIIkCQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fvCjo+Qyk4DrQKGQHvRRzaDoLsac/KGGcvzGQzvL5/uI1a/LHfmFcm3zQpyp8Ia8PauI2qeNpHl1FI7xYP1SkDTRZWMSv457vqJvNjVMBQMWO0bnZlJtCUicRB4+vdK6bjcPNL6MzZVmEf1EuGutz91a1zkbe0Y6Qjq2LbxUlOIweVQJVZR4sriQ+7DpmAoSJ9/jD8dR+WMZW2kjHwKbuG6BJ+lS1YPLBeEMxGv2ySK1shSaNmdmE1jijMVzFkFpfnX9juTXsjCAne0OUb4He1FYNwkU1rNk54PYaMOr/ksWdpLdJdYbGJuv+tD9zIcmN2/n+ecJPCc10MpU/Nvu8Q==
X-YMail-OSG: .qV_KIwVM1k4HnjOtnnQU2lfj8grZEeGmE6IWuZjsqz_uSq5WevALkgUkla5ZvR
 v6ic6SlBNeWtj0_OgRgKn.M8jfXG0ItbCiL70hOKPK3fWbtoUotNJEGi01WMVghRt2s6y96ok4gr
 _pZjU38.dhKI16tGNCPpM52eab_jYjJmfCRsM8ah_jF5uma.j4gfntkjPxe3WZQpPF_6IEjO5cM3
 tujPwesqnJgPGg3X146zXS7ipAsSO9sP0_t0NUuRhtm_bAAfbP2QRWWQVhIV0qrnwa8NkN_to4g9
 uUX1YVv2IMUXKicer85XHZdJsqpYoLmgFO0rE_VUPtXPhMA2GgIjryd4dQLiO74.kNzqzV_nARJn
 qX9PMNTkYV8Yrzo7N9MPorgJa06xGi2vUP7pqlAt90TgbZDoa40Cg1X3lTMc_zP4JWxCXxeHFBTF
 RNUlmuVzNYbqSDB6hadhHhPAB4ccpkTtjrnTtPpl7WXDExcIDq4YvoByFgdnMHC6K5RHNvKz0rq8
 Cs6n7FZmNkeILJsvW7QoigK_yjel1EvQsSoUG54olbiZXcJBp.yy7yohtZytNDlA0SAHdHYYtNz9
 vAz9UiGfFeGySUEI1Idpa49vZjIY27ff4BM23MXiHv7rM9t5SGew6YbWcfeIH95uV50zzLT9Fgl9
 OMMZd5z1F.4xjkXg1tu68wBLpHmKCpmIxK6h.iMuVR42lWUoTRf1lXNdq0YAGmI3TwxU2POm7zkM
 CIzjhpMXEnAVfRI5qoSiAsWcR0nt00uzvjY0Uy7ru4VXkY3VrmvyUoJdoeUQhPQLzLK2qvzP5Xl5
 9N5fdupUyIVA4bisgRprAQyEMzmHA9gbH4SFSW76GRSRWkOeVtOaFlkF1P._NHv2OZEp.BmFq3As
 6MfHAppJRMa7qwKWoNllPeDFA8yEZ8LRU75uxOMcReRjXgJwAnz6zaV4sjNkKIrrbQG_zWbeb7d_
 l4ONJG7UFn9TvoL2kwDLo.Sw4aTUBBCL1PSZeptnqc1frhe4KwH4n9jUpoLGSSUOPcofX9DdeSGA
 Np1vTNJ4q561VQrnrC.v1aaO0A3xW7H72OhfrG.QbaY2l3P5JJEE9Igde0ZfrWUTElXVfUW8WE3o
 eFPP22AC4luAH0JikSrkhYvm0C6CaKLeWalUzZJ1eBCi63BSB.GpmVyN42QhD.i0ksUGEbTXIcHJ
 oJahzb93C3KtV_tZwUz32oSDp0QRSKtcxNXTkVv2cZzeUGKRqi.kiKyzhKANsA9zyOJx2tO05i5p
 gJW4kB8a.gRY6zlzYr4TwGhV3LTmoHyv6n2nnQacw6R36VTvRSuYW314.qQvdPaAVqBc0o8TmQZ6
 LrvhPSorGSVWY4fFLcl3wUwVlxAPNrTc6LHN7iEkr5Nob2WzIrYo0Ppqs.eS3FGpx4cYWIDd0Ihc
 75bE6kIQrPqVES3u2i34Pc5A42._YNH9I19faiNufGtsoHWFRdL5HxVsH92UlunQzVJybkNvL2yT
 Hnl0q0Kd46ElHUStOdtzeGa.apq8lUPWY8GEYtRLEnBKDYV9KocO3ouIddPPJZ1L.BrEegJ07Gjl
 Tmhd3_9QBIRQtbxt4O48wPBzsCr1MrbIknTl119RW9ZUy6ffbGHkwBbssZmmPNF6EgJWb..Crc6p
 KCWDDeh4PKGwEiGaaGZpkF46SUw8sH3QuePSw7iPHJmZnZLUqaw3PEqfw0.sANJgXpkrLjhpedqL
 HUiuqQDStYt5oCcr4lc2eKnr1bvYWVxlgZrrGTKMjG2BBESuzq9BOmNj866pAyFhV9Wh14IugxAe
 GKiQFJFjLOZzPW4eQzFRz.A15ba2boOZaNdU4ovGvHb7LUTE38VORaJOBPgmsO.SzD2zD.xz2up4
 tHJeYnr8A0ymMjQLEn10REvzveRmuepxqFGRQeh0WMq1u6h4gYMImfTR5kP0tEXQyYKv4KtZr2tz
 8UWmcwdR7UPkRjt1Ea_O5E48m7EsP31hQetSdh4bm3Bm9IrFy46V59I_KHTWK2ibxlhpddX9btSk
 ljMFsP5TIVfU1j4Tf40SvRMAtBtTtm3LExOelrGti0mAXJHccrkgP7YmqTPhMm5NHs9nqaEiA3zd
 qNHypL4mlw04Z8L_ox4lzUqC8djK.o_sRajSA5r0Zv73K4PjMLUC.4glLH_AkveKGKVqj50wpFZ.
 xh1IYAbam.8RK.1xJU7870t7gXh3xOeRtuTa87ZNKHwzzolBJ.3w1jXfchcpJ9xrtDrfypMbjX_n
 BRwoxOpye9qdGwNdxfL8_VW8s1YiecKiahTWS0SOEBKsgNbHLTISOUDogl5gVkyIb0TIH7kg4sc0
 t6Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4c09bafd-5542-47d5-99d5-ad913ee05831
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 Feb 2024 01:41:02 +0000
Received: by hermes--production-gq1-5c57879fdf-jv4v7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0499111b6ceae17ed31c9b646ab937ec;
          Wed, 14 Feb 2024 01:40:59 +0000 (UTC)
Message-ID: <16acf93c-e07c-41db-9237-c8cf39debf05@schaufler-ca.com>
Date: Tue, 13 Feb 2024 17:40:57 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: use default hook return value in
 call_int_hook()
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240130125659.1709410-1-omosnace@redhat.com>
 <21d56533-84bc-4be5-af05-a40072fc9e8e@schaufler-ca.com>
 <CAHC9VhQP12oA-ySchqQOBp+wfLkQvMsQ_7yoSFh1koGtoTe5RA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQP12oA-ySchqQOBp+wfLkQvMsQ_7yoSFh1koGtoTe5RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22077 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/13/2024 3:14 PM, Paul Moore wrote:
> On Tue, Jan 30, 2024 at 11:47 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/30/2024 4:56 AM, Ondrej Mosnacek wrote:
> ..
>
>>> @@ -2629,21 +2603,15 @@ EXPORT_SYMBOL(security_inode_copy_up);
>>>   */
>>>  int security_inode_copy_up_xattr(const char *name)
>>>  {
>>> -     struct security_hook_list *hp;
>>> -     int rc;
>>> -
>>>       /*
>>>        * The implementation can return 0 (accept the xattr), 1 (discard the
>>>        * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
>>>        * any other error code in case of an error.
>>>        */
>>> -     hlist_for_each_entry(hp,
>>> -                          &security_hook_heads.inode_copy_up_xattr, list) {
>>> -             rc = hp->hook.inode_copy_up_xattr(name);
>>> -             if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
>>> -                     return rc;
>>> -     }
>>> +     int rc = call_int_hook(inode_copy_up_xattr, name);
>> I think this is the only place call_int_hook() is used in a
>> declaration. Maybe break it up into:
>>
>>         int rc;
>>
>>         rc = call_int_hook(inode_copy_up_xattr, name);
>>
>> Not a big deal, I won't fuss over it, but it might make the next mass
>> overhaul a touch simpler.
> I'm not sure I care too much about that, but as you say it's pretty
> trivial, I can make the change during the merge if Ondrej is okay with
> it.
>
>> Even more trivial: use ret instead of rc.
> If I'm going to be nitpicky I tend to prefer "rc" over "ret" these
> days for return values, and using a very crude metric (below) it looks
> like we have more instances of "rc" than "ret" in security.c ...
>
> % git show-ref HEAD
> 7e90b5c295ec1e47c8ad865429f046970c549a66 refs/remotes/linus/HEAD
> % grep "int rc" security/security.c | wc -l
> 28
> % grep "int ret" security/security.c | wc -l
> 16

I also generally prefer rc over ret. I only suggested using ret
because hooks that have the form of this one usually use ret, and
it seemed we might keep some hobgoblin at bay. I withdraw the suggestion.

