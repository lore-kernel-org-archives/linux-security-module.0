Received: from sonic.asd.mail.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02F189F5C
	for <linux-security-module@vger.kernel.org>; Thu, 31 Jul 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974073; cv=none; b=np9SqRdIS/lqYSLBN2La4xmTBJ5a/WgM+2bs8jpp6cVKVKBzzHdUAUZpQiCh2CtJKWCwgKJlt5FW4istgaGrcGYdJLi/aBYdzI88Ab54itj1TJovbZV7p5/yUd8Gqd9x6az5UOQHWeJr401dqEiQS0LTxWJxt/QHb898f4qshpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974073; c=relaxed/simple;
	bh=yF70jT5zZihJChERM7/8WsqLm75Xwk4VVMdeZOCWEGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ck0iH9n4tL51zoprES5xSJzjvKDoSIZw6jzhufisJTCFQR6/5iE02FkdFOvs9UPxXlhjcq7xbJXbB4Gur+7h7Rfg/fga6D9Z07bUY5LtYN4G9hmdeWyvAxTYnpIUC9tOq3kSeUdyLvzcf1CTMJM88SoSj/Q2Xk7aUyZaISssEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qULecYV7; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qULecYV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753974063; bh=yF70jT5zZihJChERM7/8WsqLm75Xwk4VVMdeZOCWEGo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qULecYV7ZKv3DcGJP7YAKTPw1Et8pq2u80jal+2b8VOfFVJmHMCnsfXthf1JUWY4WdeUXRQV8Qe417pG6n4HvMsfd/09o/bufrfL1gzm7uxwMZXcAvhoz+eyq6kZlgf03LAqXqSGJkyDSEDSOzJv3KcB90O1aM7QPW5zbLUeLt1A1kQPuLajX9fowZghT2b0CztdHfru5fPsvyDwAccplRjvucHbjU67SzvHL1T3LEa4QWWUNJCcRY6gY9KwAawAJGMd9LzXVUeDK22+c0NEc7hXXatavty3D4vWmvdjpcEH95KdazDmiTfLwRy6ery9A2gvFpGyxiqqWyurRr9+3A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753974063; bh=gP2lmCIzQWZVtg3PpiJsfmyKf4DpqJPtggQ3WJ3ZDQm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AUcoGv6UTDQ+T9OrExnKgjrDWOJloqZC9AyOqqlWyPskm+ExbqEeOG7/S7Q1e+dgpMJdty24eaeK2jzf+kqr7R8VNHPM6kepEbd2djcxNvNkbh/E/alm07+86MGvJUC7FD9BgK7cIfcPqnh+tBxTvwiYT+3TGRAp8YW+qDCA9pZXfw7lfzw+fCpP+mf6wS4N3A4RC6bBAzd70woH2X+8D8sLn7fzaTnX1XOELJc6/umwwCF2wq+6CVQR3NbAsjKI7ae+2qv6dxAJc4GYHD7q31r+SU9XkkC8CLu9l1H9OwPj2xYuNxPJggm3dEOEhUM6j17VzJ+W0U030JADqTbGiQ==
X-YMail-OSG: HfvcoZgVM1ki3y_4yxzOigsPq6lpUGl95H2IQG.AEE2bpqDPbUEEveSHBxrCzTV
 MwQf5vxglMY8Ni3MxvbLRgwH5cZR6WREwSuQis2_U5_K563rm9ISCryg_WGC1zDOY5OnKndpc.QS
 dz2g.0zbHNlYTGM35rnrIzxfl5t5luYxjtjbwisPRRn3bB50J7BEsui9ai4t4sW6zxVFQ6qbCuKO
 L0RzJSKgJvNv1n38Re1x9DU6DNkf7oW3dYYHP9yZoPLZ0YyDgEM1Rm8Xag2HTI6OKNxDGJsRn44R
 fxyL4i4Aue_rYSQSg.q8NHdNK6.3xrv7zGKxRlN7DahkQLAH86BD7WnWmw99MmX5bRiLSYhc5H0k
 923X0KMmyW8FF6knw0Uf0HSiH7AgIuXMpz4.Z2IC82rerCMSwHVPRhBVfQOKfPWgJCergb2YeNAx
 GHPvkz8oXxhtyV6bYAjQuJ3eHBEmyG62jMELx5iXY9sqNop4geYxXci98sIEqfQ1SQKmMezKM47G
 Osrr9tb1GyXseXZePwCiZXQDO7MNewKpSZrGgrqSClhgMoW3_B78O.VcFc5dLxJ31IoEelwJdCnm
 PpESrWA7FaFS1QUotsQyw6PkXojEQiX_UpunlYGTGMLAj3GfKZyUC2UZ_rhUOyiYFWcoWsEzD0HC
 eKprd_PGshRUqOVvWRk3sM7VW1FMoRoxDGUzbJd9ehC5F7Cdh4KnOrvyuaPPAFVNEikAK5wJ68Uq
 AiS9v0.Rt.InfvzgUCWiwKhZxYWDzu_Vwo.pdLyHwIjU0sqHGOZnGMqD7xkZNhtAzlL3_5Hw4vqm
 jq.7bfwX7OodGCup7ht_MlPSAm4AGoo_Dtgw_nAih0L1ftNINDYuQsA4wXzuZ.2qEbqBfelJuwMN
 2OrrpIP_gokTUkQc4qVPHhKAWIidXQEa6PBtvLgu0W.PxiwmokKcmRqlPis4UIvawR2nPMwJpT8l
 GsLHiiqRL1Rc1fHuhBERYT8TVaQdY6cA77ulVWMck2KR_IXQ8wKgkzO.jM.VqSvOjdbboEY0_Tw4
 f1acIaGD7x8bemaaKRwZbr8GhYzO.4AWS3.A3HV9AluQvfmYj4OMjqbBqt1dVZPBdiwFRMdiwVcp
 0F27RuxsdUuxw4TfLl5Vxde8H9ZQ1jJrF00mwsZFRuKcG.Vjr_vrcRhBT5eZoMBgJsnzbHOwRqq.
 bO0.5ySXoCFsz4HJL2ojroSi1zhFDdBBd7h.1yPJEtl9JqHyK7XHNq7p23Q0SyDDqklRfO647Kap
 Pja.y14eo1e2tbn0JWuUjX_YNMWcVOqoWBewQrdLKEFLaq521tMj2Yewb0pf9rrnBVwE06pi.3SV
 4CFI1jrkIV.A99qKHgeeMofELPaI_6XyIFNyY5oKgmzAAN2cF0oXgMI_59gs2m.Vpnw7kirJuCss
 2S5PaS86oc96x70kAhuCXwHiuwxNqXT4NPh_4uKRphZpMO5gMLmy8QbzTUlZ86vSQSODiItW2VfC
 mgMm_8lj5xqfMS3m_tKLVTtFMHHF801bbIEHu2fGiU4J2P3uM30ACRkvCLEwZgdveTQa1tCLhyzX
 zW5xauAjA8WJNTEjoY4pJdM3sFbk8EhrSXNoIFm_s.QdrwWd1TriYQnzgdSAbvokczkFnwTMEvjn
 UY_kWu_4uYH9ZeGGxb7mUallrpRPgs9pXWhTIkJj_0GtFdCmj39oUwDFtZxoivLSuvfr3nV3_ulf
 SFMoxWAqpy5lYi4WLns_YYAYi5rq8jdTkzAHeWumdx0wmBQyPOjvutqsZb_OwFTjh2VURGHEER6L
 MvwT1Qs3V84aRFRzHQ.Ysho0R4CIDmfDFmWprDzo3HhETSGmoKodrNstY.aSOv.I1pHB6ZBvn8_.
 gHUSLLYvhfQrrs.Jtct1DB8KpvtOFax8yqGixRKrYx.6.SZTlfwL0Xx_NPr2kt62uIewfamoVFqS
 9reZ4pAjFQssQK72mzdnddyRXPdB2GJ3wrPtbdtntLyv7X4FIWu4u3gexIK7UqgtgDD_QLoXcoEd
 lWoGfCq0qzp.a7C5aXU8yQ18rUpobWtOrV1griSnuFefhQ.jiVmVvPQXRKMjFJqbWhAn523naylc
 bWh6rVm717E9yEOnpMypxVMJwN4n7RKFJWAqUOQ3QFH4gI.u8xZE0bEgZb9AaIrNyG7pa.EvZ4ip
 1i9sCq20Cn4WKAlF4nPcr8aL.nz3FLvgKoVpSBOZ5cD8N8cLMMNyaYNZ.sMvIMc8dPOQ6ybYs3Vd
 LxMh90dzTM.it7k2PZjmeaXHicfKqKHfmVca09Do.ol8lnO9aNfEjEVaOc5rON71Y.brrwyemCz2
 dBnlLqQyERhNMKpc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8b95bc7b-b260-44f9-b6a1-9753808c2201
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Jul 2025 15:01:03 +0000
Received: by hermes--production-gq1-74d64bb7d7-74ntb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID da4533f52ef555abea23905bd1b25012;
          Thu, 31 Jul 2025 15:00:57 +0000 (UTC)
Message-ID: <9dc21c28-1a4b-4d88-a67c-7b5050cdf0b8@schaufler-ca.com>
Date: Thu, 31 Jul 2025 08:00:54 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: simplify security_inode_copy_up_xattr()
To: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>,
 Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com>
 <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com>
 <CAHC9VhQAVvvXUoFu7xnh0uBhmvgYinP=AhiC4y17JJ02M9s5Nw@mail.gmail.com>
 <2aa4da27-28fc-46e0-8d1a-d9e63b03d502@linux.alibaba.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <2aa4da27-28fc-46e0-8d1a-d9e63b03d502@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/31/2025 4:59 AM, tianjia.zhang wrote:
>
>
> On 7/29/25 11:09 PM, Paul Moore wrote:
>> On Tue, Jul 29, 2025 at 10:43 AM Casey Schaufler
>> <casey@schaufler-ca.com> wrote:
>>> On 7/29/2025 2:09 AM, Tianjia Zhang wrote:
>>>> The implementation of function security_inode_copy_up_xattr can be
>>>> simplified to directly call call_int_hook().
>>>>
>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>> ---
>>>>   security/security.c | 8 +-------
>>>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>>>
>>>> diff --git a/security/security.c b/security/security.c
>>>> index 596d41818577..a5c2e5a8009f 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -2774,13 +2774,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
>>>>    */
>>>>   int security_inode_copy_up_xattr(struct dentry *src, const char
>>>> *name)
>>>>   {
>>>> -     int rc;
>>>> -
>>>> -     rc = call_int_hook(inode_copy_up_xattr, src, name);
>>>> -     if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
>>>> -             return rc;
>>>> -
>>>> -     return LSM_RET_DEFAULT(inode_copy_up_xattr);
>>>> +     return call_int_hook(inode_copy_up_xattr, src, name);
>>>
>>> Both the existing code and the proposed change are incorrect.
>>> If two LSMs supply the hook, and the first does not recognize
>>> the attribute, the second, which might recognize the attribute,
>>> will not be called. As SELinux and EVM both supply this hook
>>> there may be a real problem here.
>>
>> It appears that Smack also supplies a inode_copy_up_xattr() callback
>> via smack_inode_copy_up_xattr().
>>
>> Someone should double check this logic, but looking at it very
>> quickly, it would appear that LSM framework should run the individual
>> LSM callbacks in order so long as they return -EOPNOTSUPP, if they do
>> not return -EOPNOTSUPP, the return value should be returned to the
>> caller without executing any further callbacks.  As a default return
>> value, or if all of the LSM callbacks succeed with -EOPNOTSUPP, the
>> hook should return -EOPNOTSUPP.
>>
>> Tianjia Zhang, would you be able to develop and test a patch for this?
>>
>
> I carefully checked the logic of security_inode_copy_up_xattr(). I think
> there is no problem with the current code. The default return value of
> inode_copy_up_xattr LSM is -EOPNOTSUPP. Therefore, when -EOPNOTSUPP is
> returned in the LSM callback, the next callback function will be called
> in a loop. When an LSM module recognizes the attribute name that needs
> to be ignored, it will return -ECANCELED to indicate
> security_inode_copy_up_xattr() to jump out of the loop and ignore the
> copy of this attribute in overlayfs.
>
> Currently, the SELinux, EVM, and Smack that supply inode_copy_up_xattr
> callback all return -ECANCELED after recognizing the extended attribute
> name they are concerned about, to indicate overlayfs to discard the
> copy_up operation of this attribute. I think this is in line with
> expectations.

I looked at the code more carefully and I think you're right.
My objection was based on the behavior of a much earlier version
of call_int_hook(). With that, I think your proposed change is
reasonable.

>
> Tianjia,
> Cheers
