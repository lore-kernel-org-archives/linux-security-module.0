Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAF1509BD
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566714; cv=none; b=CBl1ocQ67Xhlvk7+a69YFfqsb0X3+MmmJk4AFiJ/ctIkmTtIPU992C0yYafDEMbn6xOZoRqsfQxB14Zc8njkBKNHSSDX20JnvX/ds37wIQ905w/60t5TA6KyDUw0x7u0LGh+Tt0Vf0tS8ZXWA6r+lTMgtKif0lwdCTQrVKx7jw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566714; c=relaxed/simple;
	bh=9KOHigx9hcK7tEIFin2Kb7cqI5TXAhmtKhS1UC8pkBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHC/NgO+C+qIgbSdKmJsi0L9tfK/eWp+/f3l94XqrGlDzvKpzaj/gMcfkthHsqakybmYHqjDZVODgNQ4ew7kNMxA2eQc5ngeBfA9u2wlfLFmmkPg+bLJKiRJuoJ97bB2SzdlTDGnpfFfLO3vFwBeZ81TUrzply0nTamzsL+KEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=U0lXt/74; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U0lXt/74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720566704; bh=9KOHigx9hcK7tEIFin2Kb7cqI5TXAhmtKhS1UC8pkBM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=U0lXt/740YMn3lVgacJYICj1CpihhHCoso+EweSpSwkctMJzC/dGXaPDHyuzOeQ2PTrIuzoT5JWQnzW+gB1zXbT2JyV0WeiBegWTkbjaqhRC48/VbqhtuQDOYa3YWPZ5rIrf19bSRXIx2ITQneD7Vo57AvRQmEVLtu6Tr6b1qgFqOHr7RE8BPbdVN83PZGrmSLKYyTzqaEKIIQcdyUeU1Z/ljDJI/88647RSpxtIBK3T46sfsFgvgYe+DrC2+9OECxBun4MWx0Znoi49suMfpBc5aw4qjGcJQMoyjkVwsrKzKktGEPS8CL2yk2tsVQg3tI9g4PhbaVrn/kpHQ/H6Hw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720566704; bh=6hv7vg/jSMTeDRVngyqishzNsffeNIggxyvOiwurnUf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ACSoPS8Q3W2m8cuyFq41ie7G37xQneBOLdrY21v1cB3NdsfOOmxxrnLWqkQ4V+Sep6z34o5i7xn2nNu1LsPFSQt3Vu5reZhcp64U+cjW3M28R6HTmMYP+5T/LcRe4Up/4frWAyBPqi8PQ3BoTLQIqmY81XvKL552Gzt2Cf0UDxk37boYS/4ct0QCchl7ms1W1IMG1jXsTeQEiON/MAsCoznTzJAwBNVjPq32zcBwz/+IL/fpMQE1sngEj2LAOusjJ7r/a1Hkn1Ny9el6qsZej9XoVLR2fAihc9Q0ICsaXkR6n1ZJxYltWBU6JbVbp/XumagyBd325WUFJgSv8DgSWw==
X-YMail-OSG: wpkWnEQVM1mSTUB1u9m4CVQnKfxmgfoLThDSIoUo75cXQmadnKRU7ZUNOPEyyNk
 dnDqwlCdAY.DiUn2XnG3y4c1B0t.M_oYDeLbfk3Yrc3Y09x_T6mhlhLfvkrsA5_BAPu.Z0P2h7cg
 .snOvvJ4vCDbTLoEB62eqijRuOKeWEjKcrb72jaLPMzrlXOKjqUT8ZeqOM8FMP4O56Q9kwY0guUH
 KfB4MAepBE5lFEJ1Pxu9CuIhMdnH.ixp7WEbiT7T_PwaZsZNKef83tNKk_kADW.Y.5vJTHTyAM6w
 E47AnILzWUdBfXowYoSuDbpMBx38sp.IKgzaH99GBsxNofi5EDHUKGXM_C948yHoSkdGWXFwIRoE
 KjcVZt7znpXcK_TsBODzkJtUkUAV5.SLiBPrkwS79nAdFDOnCxbfDN_ec.GhvaXSYwpW6mLyRLvV
 7.tFnxnKAQqBozSoJfasQVsclC2z0PVieCOt6T9920c5WZ7EQ3doAVD7lRUQcCinyn376gnbaStc
 DppewunBvCzQwF4TY6vob7GTlYlHe6TLvPppnMVeykVdZ1gh9bh7FV2_Przrn4k7tRj0WhYTZOS5
 v7C2.uB5lZAYMk2V5QZ2RJueU6kEC2TvhdA83KFeQGeByOyGSQHOnor5B38mPI9xAbBJGni3qZ0w
 4uy01MJXS4RcV7.Dtkpr53ucRvWmbyBfCtdWPQYGDdtyVhtWeJahi8OpDA5z9SWC9b_9Yh3BewV4
 4cTYQgxIMo.aOWvCVdysW_na07hi_F0nFgD1FBM5hafNOsGuWQ2o_WWJaTBWnxTwDgw6M2VAg6ai
 nmtIb7Us1JssajNCgroDA296bHGj05Xz4OtMYVa1nT_p6eeNwe0Twxp_L3aBwsEHBGgfBZCk9QH6
 xSZhLOvM_A_pgsi6P1trW6Kdb5nogV55sGMV7i5tcOxESuPCEYxZgcD_i0PHsmX7PsEicECmHtaO
 0duhyAwyL11sKBpl5KVf5GqGbmLkknf6nng9u0kN_PukcJAHO4vjQPPUUaM7E4iAHCl2V.ieo4Tg
 G4K3uEcaG58GVkczl1jqQKLvuNnzUcfgeD7exBaiU_r0st2J3wAQdQ_ypagdif_jsYuUBcFTfhEL
 AV9T9D5XVJExmO_7KYTmMSYPwB3NaR9uvU16G6NdxUmKhQV5OHXXqJW67KEXqsDeO52FzSVonN.B
 BZGruf7chN4_bGNOdFprUakEXSVWm.BlfjP.HF_ZbUk3wLxM7mTC.Sakenda1nMpEE5GfGMdj_BX
 hPeO248fiR9RjprXhOGBtV48.wT.2M1h1dseyVMn0tYXq0mKGuiJpX0Dwd3OlUSAkitMr00U_UU6
 DIsEG4DQIeqayRc.mN.iEHsIvEzIBWn_lIcvRZ3C8OJ3vUBsPreEka2rNnx10qTDu9Lqj6CwE9kN
 du2ioQR0JbDCL.L2uWIpO8ZCs3FRzcOJGBAiHS.5IjWtrjqy2zFEV51p20TBcegTowQNv3w3mlkM
 NOxAX6SrAH2xqFYe1LFltxW8muotl5BbsUEC8YUnreqYXD2pD5Cg5m_TuIKp_X0r6_iNIjA3vYOD
 UJFdnyYb6PwP_GVjbxGZMUBFkcHv.ljDG0hMkXyhVW..9R3msG.PaO9ZYJfsqaEmuqSncazXULgF
 gmdZbOUv_zlPaCTDfy05FEXhWw5wcXSuf8kNPbSqDNMPvGvM.uljJpT4GjscfDUpSNW5n6auQcc5
 rDg6sPOt1DMAv0vbiBItnLu9dU0OzJ3xfi_GXhyd3Snwh09MidF1D3PolY3qv29ADORA9eAh0VET
 6zJmf5OUFw.kvVysPfyKMc_fnD5F58WwpArltZcbnL0MaZVDcUqV4p2_uo9LP_ujjtgiaGQK1h8x
 T.S9tcaBqSJQmaGGd4v8YYX1kZigU71pjbKllSchzbCi0qVEZe1_fQbVuQMQEDspVLNTRT09EUTI
 SyuzVh01L39X5D2pMfhzN5cQnhpQ_Rp6DlnrXVFP1NlWPnQnGlgbV8NbYRNlri..n72D8f86felY
 Rxp9LoqRAar54wkK4hKvOeCb1zZxPny5yLp.mPyK5DkHl9ORddo8AlnNZkUJbxkYoGxW0xTKqm8u
 JxVGoE7wrOrVZX7uYe6ACUKqGV7ggRDz5n1G8nsKqL8_mSJLQA5GQEwlltpYNw1H0nqBawabLpZ7
 DAxfnUhuudtDCBjqhMx_NDidfMpQ6KNHBbExS6OWgBfuuF1rPC2ggxyFJErc4MjoYhtkTWWTEA77
 6oo0vzIJKX4yK5vYfJ29OgX8vaYJ5gW1m6O9NMLiZimcA6BPYuRscZI4rKtRztIYZkhnwyFKQiKq
 55W_fv3QNgXVi6iQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7a2b3429-f4ca-40e4-9afa-06d48f9a48f6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Jul 2024 23:11:44 +0000
Received: by hermes--production-gq1-5b4c49485c-55gxp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11ec6f255827471673a04d7d73759fc0;
          Tue, 09 Jul 2024 23:11:38 +0000 (UTC)
Message-ID: <26b5dc4a-18b2-4a1f-a57b-bed8bc4c4a8d@schaufler-ca.com>
Date: Tue, 9 Jul 2024 16:11:36 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] LSM: Infrastructure management of the dev_tun blob
To: John Johansen <john.johansen@canonical.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20240708213957.20519-1-casey@schaufler-ca.com>
 <20240708213957.20519-5-casey@schaufler-ca.com>
 <1395c0b7-a785-4767-af81-1ff30bc80bde@canonical.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1395c0b7-a785-4767-af81-1ff30bc80bde@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/9/2024 4:01 PM, John Johansen wrote:
> On 7/8/24 14:39, Casey Schaufler wrote:
>> Move management of the dev_tun security blob out of the individual
>> security modules and into the LSM infrastructure.  The security modules
>> tell the infrastructure how much space they require at initialization.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>
> one issue below, besides Paul's point the rest of it looks good
>
>> ---
>>   include/linux/lsm_hook_defs.h     |  2 +-
>>   include/linux/lsm_hooks.h         |  1 +
>>   security/security.c               | 11 ++++++++++-
>>   security/selinux/hooks.c          | 22 ++++++----------------
>>   security/selinux/include/objsec.h |  6 ++++++
>>   5 files changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h
>> b/include/linux/lsm_hook_defs.h
>> index 44488b1ab9a9..601e3092a7ed 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -352,7 +352,7 @@ LSM_HOOK(void, LSM_RET_VOID,
>> secmark_refcount_inc, void)
>>   LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
>>   LSM_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct
>> request_sock *req,
>>        struct flowi_common *flic)
>> -LSM_HOOK(int, 0, tun_dev_alloc_security, void **security)
>> +LSM_HOOK(int, 0, tun_dev_alloc_security, void *security)
>>   LSM_HOOK(void, LSM_RET_VOID, tun_dev_free_security, void *security)
>>   LSM_HOOK(int, 0, tun_dev_create, void)
>>   LSM_HOOK(int, 0, tun_dev_attach_queue, void *security)
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 7233bc0737be..0ff14ff128c8 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -80,6 +80,7 @@ struct lsm_blob_sizes {
>>       int    lbs_msg_msg;
>>       int    lbs_task;
>>       int    lbs_xattr_count; /* number of xattr slots in new_xattrs
>> array */
>> +    int    lbs_tun_dev;
>>   };
>>     /**
>> diff --git a/security/security.c b/security/security.c
>> index 438ec6708eb3..2c9d075f5f92 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -234,6 +234,7 @@ static void __init lsm_set_blob_sizes(struct
>> lsm_blob_sizes *needed)
>>       lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>>       lsm_set_blob_size(&needed->lbs_superblock,
>> &blob_sizes.lbs_superblock);
>>       lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
>> +    lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
>>       lsm_set_blob_size(&needed->lbs_xattr_count,
>>                 &blob_sizes.lbs_xattr_count);
>>   }
>> @@ -412,6 +413,7 @@ static void __init ordered_lsm_init(void)
>>       init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>>       init_debug("superblock blob size = %d\n",
>> blob_sizes.lbs_superblock);
>>       init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>> +    init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
>>       init_debug("xattr slots          = %d\n",
>> blob_sizes.lbs_xattr_count);
>>         /*
>> @@ -4851,7 +4853,13 @@ EXPORT_SYMBOL(security_secmark_refcount_dec);
>>    */
>>   int security_tun_dev_alloc_security(void **security)
>>   {
>> -    return call_int_hook(tun_dev_alloc_security, security);
>> +    int rc;
>> +
>> +    rc = lsm_blob_alloc(security, blob_sizes.lbs_tun_dev, GFP_KERNEL);
>> +    if (rc)
>> +        return rc;
>> +
>> +    return call_int_hook(tun_dev_alloc_security, *security);
>
> we either need to free the blob here or make a change to tun_net_init.
>
> if security_tun_dev_alloc fails it is not calling the corresponding
> security_tun_dev_free_security()

Yes indeed, I missed that one. Fix in v2.

>
>>   }
>>   EXPORT_SYMBOL(security_tun_dev_alloc_security);
>>   @@ -4864,6 +4872,7 @@ EXPORT_SYMBOL(security_tun_dev_alloc_security);
>>   void security_tun_dev_free_security(void *security)
>>   {
>>       call_void_hook(tun_dev_free_security, security);
>> +    kfree(security);
>>   }
>>   EXPORT_SYMBOL(security_tun_dev_free_security);
>>   diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index b3de2e941ef7..7f1d8358922a 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -5573,24 +5573,14 @@ static void selinux_req_classify_flow(const
>> struct request_sock *req,
>>       flic->flowic_secid = req->secid;
>>   }
>>   -static int selinux_tun_dev_alloc_security(void **security)
>> +static int selinux_tun_dev_alloc_security(void *security)
>>   {
>> -    struct tun_security_struct *tunsec;
>> +    struct tun_security_struct *tunsec = selinux_tun_dev(security);
>>   -    tunsec = kzalloc(sizeof(*tunsec), GFP_KERNEL);
>> -    if (!tunsec)
>> -        return -ENOMEM;
>>       tunsec->sid = current_sid();
>> -
>> -    *security = tunsec;
>>       return 0;
>>   }
>>   -static void selinux_tun_dev_free_security(void *security)
>> -{
>> -    kfree(security);
>> -}
>> -
>>   static int selinux_tun_dev_create(void)
>>   {
>>       u32 sid = current_sid();
>> @@ -5608,7 +5598,7 @@ static int selinux_tun_dev_create(void)
>>     static int selinux_tun_dev_attach_queue(void *security)
>>   {
>> -    struct tun_security_struct *tunsec = security;
>> +    struct tun_security_struct *tunsec = selinux_tun_dev(security);
>>         return avc_has_perm(current_sid(), tunsec->sid,
>> SECCLASS_TUN_SOCKET,
>>                   TUN_SOCKET__ATTACH_QUEUE, NULL);
>> @@ -5616,7 +5606,7 @@ static int selinux_tun_dev_attach_queue(void
>> *security)
>>     static int selinux_tun_dev_attach(struct sock *sk, void *security)
>>   {
>> -    struct tun_security_struct *tunsec = security;
>> +    struct tun_security_struct *tunsec = selinux_tun_dev(security);
>>       struct sk_security_struct *sksec = selinux_sock(sk);
>>         /* we don't currently perform any NetLabel based labeling
>> here and it
>> @@ -5634,7 +5624,7 @@ static int selinux_tun_dev_attach(struct sock
>> *sk, void *security)
>>     static int selinux_tun_dev_open(void *security)
>>   {
>> -    struct tun_security_struct *tunsec = security;
>> +    struct tun_security_struct *tunsec = selinux_tun_dev(security);
>>       u32 sid = current_sid();
>>       int err;
>>   @@ -6975,6 +6965,7 @@ struct lsm_blob_sizes selinux_blob_sizes
>> __ro_after_init = {
>>       .lbs_sock = sizeof(struct sk_security_struct),
>>       .lbs_superblock = sizeof(struct superblock_security_struct),
>>       .lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
>> +    .lbs_tun_dev = sizeof(struct tun_security_struct),
>>   };
>>     #ifdef CONFIG_PERF_EVENTS
>> @@ -7285,7 +7276,6 @@ static struct security_hook_list
>> selinux_hooks[] __ro_after_init = {
>>       LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
>>       LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
>>       LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
>> -    LSM_HOOK_INIT(tun_dev_free_security,
>> selinux_tun_dev_free_security),
>>       LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
>>       LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
>>       LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
>> diff --git a/security/selinux/include/objsec.h
>> b/security/selinux/include/objsec.h
>> index 83b9443d6919..461c6985977d 100644
>> --- a/security/selinux/include/objsec.h
>> +++ b/security/selinux/include/objsec.h
>> @@ -207,4 +207,10 @@ static inline struct sk_security_struct
>> *selinux_sock(const struct sock *sock)
>>       return sock->sk_security + selinux_blob_sizes.lbs_sock;
>>   }
>>   +static inline struct tun_security_struct *
>> +selinux_tun_dev(void *security)
>> +{
>> +    return security + selinux_blob_sizes.lbs_tun_dev;
>> +}
>> +
>>   #endif /* _SELINUX_OBJSEC_H_ */
>
>
