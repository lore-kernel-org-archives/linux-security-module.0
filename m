Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DA3043DB
	for <linux-security-module@vger.kernel.org>; Sat, 25 Apr 2026 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777144425; cv=none; b=qqTf63rtMI4Wi5sycMq2K+CZ7gbXBSXSaT8o5pWc6vb0yjAtx+DJ4HfwVqmozoBoCE3pqcYnBQ9HJbj+KM1RjxzM5JOBqbP49kEaanY6i4SDTK0umdUJCAPrCckAJbwAgJmGuswgHFHH+Qc+P+aYxCI1ymgTUZFFc82n37YYEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777144425; c=relaxed/simple;
	bh=lMrXMXy8olCCLwzC5e93h91qsaSexaMNNCe6QNtPRbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcQsfouJpIuwX27zov/F6n9MroWh9yLQkgJPvyCTYXGYeYWQSYHpfyjLv0zW+D8twLZrDLd+PPvbn9kMHP+3uueQvKFz1q3Grc0/xC4Dz62GoDYyI1mZmlarOaaEonRre6sed68xXnsUYZtvzDf4O2p5yy+rZYWY4531c9d6u3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TJ1SRsBq; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TJ1SRsBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777144415; bh=DIknXGzXdtNofU5WFn7cEG1vFCDIvrfuu0WlXNtuWrM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TJ1SRsBqf34iD8kLDiRfxSO0PC6nYsV8jfsby1s46S4n8E/RdoxcmvYf3pIkNxQJtlTvlR9F1Ext4m6MBeNPUOKl5qiwFWxGvbZx5ZXMTMVmulzkgV9rzRBri+cdnNVsaL7ZGu9nTU1+YM1rKw4T0y6JcprtCCoxQRoQLF/CKQNMVsn3LN9ow0Eu3T1+5ZITZ43A5wdmy40lGoR5Z/9nDN6SI9VfcwwDKn3s+rCR1DWbiD1WQd8PL14liFUcxLa6VAPeLheJHk3zFW9XtGWqkh37xv3/Uxzyeon8qCWuf4tVnO4yWIeZeRjmRPl4+K/AoM4C0/xIJKZxEvqRuSC8Cw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777144415; bh=Wl5rN5QsSUmtjfFTOfU3wu7FoW3G4ogpL//ZX3na27H=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EgfiJX2fFKuQeW5+YMb+cCbLdq+aGT+2MD4HfbCZF0/UDSwCsQY260w4t5tb7Mp7NnBAi3WHNHgSaDJHGIRlUlHHF5xY6Fv0/PI8eYrAhSmaFAvo8GYVSub5UvIJdVgjxeouEo38EU7NkTo2gJv4ItYrtTqo2HA4DnyU2fxyaRw9jlLDopFbg2ebyHBjKEfI/p2O3CmZDhwhgrYUrRhPoQcP5TYLbgGsSFLIyyPrI+PphraY13K9WViChJH1blmWQDBfLZfGaUXq+83jFSLb5Xzik9cXwfcrKRPA6Y5dKkPZk0vZ1a60OZun8paSrBXoTa+ntG7xv6g+AwnVTkLDAg==
X-YMail-OSG: Gt0yWqsVM1mncP.DFpW1W7BwCihKz8sO8m41YYmKGYaADTaPbrKXPojkoD7MSVL
 C_jiyN1yGbgpz8bx16mMvaL7gHgey.zBeGWfkajixjiJbrBccV97utkMDsRrJWmzD3WgC4opohYa
 YlIHoGeVkKwg5Q_hX1PAKzjf0Gsq8VLk0pJuNozh1atwNX4p4EwNECgeO2q93Au8QxEBz7uvt8lG
 _IgVbSG29URzcIeFM5R6bDfg02pmOskRuMeyeyCsxrQL7X0kG2r8mNoEZxCBTucabXhZoQssozy_
 3JeGSuKNHdrLnNl2cbNVkyTFCFGPLz69lfUNNTWwVIVtG8s6A8vxz3ld1u9N86gXcAdMBDYWu4hX
 IqZIKz3S47wDGt_aCbqq6OQ.jbKQ10cCUm0vg_g1rlQ4NxFosYZrenPM47F6oyU2vZx1.2X0.xBY
 evqhD8FW3zWM4yOkpT4BlmXcai2rBFL2axLaeHcLfQWYv8eMp93CQfKBon7aVZVeF6kjqcr0lRcJ
 30txdONGPQ8n73FGp7cKINZQUj5Os9rs8JCCICyulsbrS69ocyZHOedUyMlorc84sSUpeUwqlAnn
 NfL1D3rMjOrus5OYuqJ.WxX.0es7GWMtbIBSiKivDckCTdALiCY6IzWsBmER_kXIHP49Jjhru5D_
 TJvtOal5So3wjlYFsgj9daRmqAgo1v6m2AVpszoilgPTKvy96PUaOOACzXV6dto9oR8ZZW.j6Igm
 AKCaz3.f3aPVe0YXQ5_5uLtbOoL0QTfQbX..jlFTBstUCInlucCU.GluVKrhTVLGxiTRXUNaNX2O
 0WgwKu7c.aaBoFyWrci5q9niuLMO7KrxlaVTmDSXVWwFH3OvfT03hObPACtsvFIfcQctLKgpojYs
 U0u66UPEOKk2nqrlh77APDSLEKc6Zfbem7OHLDirGfShBRSmTR438kVLcYzyTijAYzjbJQLtOxLM
 KfMkYk5IaYYPOczXHPANul0_kEGqFAjDVuxsLXdrDy1rTYvAyl9CWP7Y0aBZc5_7fcRQlpFMSvBI
 bnJrP_JbS2AGnDOzIEemoUN6LIemlC0qc3E8ht2EHLA.lODwQYK4ELjB3VGgeWxy_.ZZDv4akavZ
 lwvGmbrDlHnSFwI_JCHdaovlwjKZAYKf4oBjpFRXRhb1SxPn5GpKsSrAT6DyfMUJR1LiMkcx6K_s
 3sPXHVdw_TvWJKQuQTyTJ8nnCbOrtPx7kTcAcaWnrTjIRKmkoiFTFAmj0kHDJRUS2S00Tjluxog2
 w1dEIvNMc4tCGNt3WO00AhfiQHkZ48.Xwgk8sUVGar2z6CQy.Rkf8YOx1JqRcIqVYvNBNk2qLx7.
 9qUfxa3YB9F.81i76l34pG1B9XBauNz7dPYo3NWEZK5aXkLEU8zmBAcc2r_h9JOni7mOgzopDX_0
 ms66KLuPRZq9Qb_0vA.8bGRkyHB_t_Ec0U9s1fSWVQiizSzfuECDjVF8MgJRAcXQ15fSTX6qrOqx
 efZS7Kx_QyAumUDWkL4WlU70mXt0vtiEEQjgqkNlvYlVwE10A2PjupozJp2GVtdynks4TzrYP.a7
 GrpkZ.5z41trA.OzLj9tuPfv1txuD9V6vTYzPafu65KhtjYckDMiSbrWethWlBaKuJhu87mIrbf3
 gIf41TLHDtEaMLIoOJsbynCuccoSCvWSP9GulplaLL8TNTAdOyzQxI7mqDxkMU9PLJrTQo8m4uga
 AnZyvmZumzpoj4O4g.Ls6RhTDDqGyUCbZPcRuOmcuMfqM.Y5uQyV4877b_Z7KRCWxIHCyayxJE6V
 6aqUNgSYbcpwcfHcOpOIJNP9XAjX3dMOXQhtxIN8Ig70YWeynh8g1I58hgDIUBevxPxljHzKxm1r
 AZEMm1kNolbIyhc_JXmEY1nbioc1B1iu2AzmHHjihtBNNjKzhAIZlaJJHZC5qdOGGTcoTp2Br_xx
 of.GbgN.v0qw.Jn_UodtLbq.AChPNhPzxMIzi5oq.6sjnTZFxA6j7AQj6Je1EiHFPKUTJUc_r4mV
 FV.5FYCD_x777kgIMdPxhgffIfa9GOTOE7f0NEYgadCW_sO501dYWDAx8yrI2w1XxhoZhtQTrKjK
 x9wqLGVBX__nddAeBWJwH9mb5ER_Gdr7RXwy0UO2S56v0y5vJNrdYXapG_5BAGl8PM.CM_4mp2IT
 ueAtjVxmkiFK1vqiLMXrBmsQdpSs7R85u79Jeb_kpdL7_jhChk3tJSgghc1NfNLhQ6C5qzUkqWh6
 u8v5RpaVs_7VAIUa.O72nNkfnEifyVT_Hj7nStAtkILdsonnCRWRFcxANlccSZUXcbkCwM2SYP9B
 U7AQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7c81906e-b640-4282-a50b-4ae4f4bafd5a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sat, 25 Apr 2026 19:13:35 +0000
Received: by hermes--production-gq1-7bb7df5c46-m46kc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b575ac569491ec103e006785316081f3;
          Sat, 25 Apr 2026 19:03:14 +0000 (UTC)
Message-ID: <e36a2618-4674-42a7-932e-40ac9f03b7c0@schaufler-ca.com>
Date: Sat, 25 Apr 2026 12:03:13 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] LSM: Reserve use of secmarks
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260225192143.14448-4-casey@schaufler-ca.com>
 <8fa09781ac340398fb2b914bf29d9dcb@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <8fa09781ac340398fb2b914bf29d9dcb@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/23/2026 6:19 PM, Paul Moore wrote:
> On Feb 25, 2026 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Use of "exclusive" LSM hooks are limited to the first LSM registering
>> them. These hooks include those use to process network secmarks.
>> The hooks required to process secmarks are flagged with LSM_FLAG_EXCLUSIVE
>> in their definitions. This includes secid_to_secctx and secctx_to_secid,
>> which are used by netfilter.
>>
>> The various LSMs that use secmarks are updated to detect whether
>> they are providing exclusive hooks, and to eschew the use of secmarks
>> if they are not.
>>
>> SELinux has a peculiar behavior in that it may decide that it
>> must have network controls, but only after policy is loaded.
>> This patch includes a warning should policy capability alwaysnetwork
>> be set when another LSM holds the exclusive hooks. It has been
>> suggested that SELinux would consider this a fatal condition, in
>> which case a panic might be a favored, if draconian, option.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hook_defs.h    | 12 +++++------
>>  include/linux/security.h         |  1 +
>>  security/apparmor/lsm.c          | 24 ++++++++++++++++------
>>  security/security.c              | 15 ++++++++++++++
>>  security/selinux/hooks.c         | 35 ++++++++++++++++++++++++--------
>>  security/selinux/ss/services.c   |  3 +++
>>  security/smack/smack_lsm.c       |  6 ++++--
>>  security/smack/smack_netfilter.c |  6 ++++++
>>  8 files changed, 80 insertions(+), 22 deletions(-)
> ..
>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index e3c137a1b30a..638436b9b748 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -326,6 +326,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>>  extern int security_init(void);
>>  extern int early_security_init(void);
>>  extern u64 lsm_name_to_attr(const char *name);
>> +extern u32 lsm_secmark_from_skb(struct sk_buff *skb, const u64 lsmid);
>>  
>>  /* Security operations */
>>  int security_binder_set_context_mgr(const struct cred *mgr);
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index a87cd60ed206..2ce0d9a73973 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1511,9 +1511,11 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
>>  static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>>  {
>>  	struct aa_sk_ctx *ctx = aa_sock(sk);
>> +	u32 secmark;
>>  	int error;
>>  
>> -	if (!skb->secmark)
>> +	secmark = lsm_secmark_from_skb(skb, LSM_ID_APPARMOR);
>> +	if (!secmark)
>>  		return 0;
>>  
>>  	/*
> ..
>
>> diff --git a/security/security.c b/security/security.c
>> index 25e7cfc96f20..754b16004677 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -4509,6 +4509,21 @@ void security_inet_conn_established(struct sock *sk,
>>  }
>>  EXPORT_SYMBOL(security_inet_conn_established);
>>  
>> +/**
>> + * lsm_secmark_from_skb - secid for the specified LSM from the packet
>> + * @skb: the packet
>> + * @lsm: which LSM is asking
>> + *
>> + * If the specified LSM has use of the secmark, return its value.
>> + * Otherwise, return the invalid secid 0.
>> + */
>> +u32 lsm_secmark_from_skb(struct sk_buff *skb, const u64 lsmid)
>> +{
>> +	if (lsmid == lsm_exclusive_hooks)
>> +		return skb->secmark;
>> +	return 0;
>> +}
> Ooof.  Not a fan.  A better way to handle this would be to like I
> mentioned in my comments on patch 2/3: have the LSM detect that it lost
> the LSM_FLAG_EXCLUSIVE battle at callback registration time and do
> whatever adjustments are necessary at init time.  In a number of cases I
> believe that simply not registering the callback will be sufficient.

In no case (AppArmor, Smack, SELinux) will that be sufficient. All
access skb->secmark directly. The hooks that use the secmark also use
other mechanisms (e.g. netlabel) to obtain security attributes.

> If the only way to solve this is via runtime checks like this,
> unfortunately my answer is going to be "no".

OK. I hear you.

> .. and of course the proper way to solve this for secmark is to just
> do the idr/xarray conversion for secmarks so every LSM can have their
> own secmark.  Yes, it does require some work, but to be honest I think
> you've spent more time avoiding that work then it would be to just do
> it.  I'm growing increasing inclined to simply state that this is the
> only solution I'm going to accept.

Thank you for the clarity. If you happen to have a preferred example of
how idr/xarray is used I expect that we can reduce the review cycle of
such an implementation.

... Or, if there's someone out there who's itching to get involved and
eager to tackle a moderately complicated integration effort, I'd happily
outline the pain points.

>
> --
> paul-moore.com

With that I think this RFC has been useful in that the LSM define flag
scheme might be useful in the future, but doesn't address the task at
hand.

