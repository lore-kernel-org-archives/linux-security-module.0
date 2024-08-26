Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496061991D8
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697930; cv=none; b=qZ5z7b+6277MdG1dq6zzXoqtiiACRXllqbuSuaXJfxPposu8cr54lRxfBR2BJtClZmyiPSJeQgaFGvGffvJSHtH1RZfkyaPWp53yLwqbpNHHZDhafsnA4Q5GnJcdR7/501DUnBMjip6JeCPd8rcL583uhHm3tJww4Bh1qXctWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697930; c=relaxed/simple;
	bh=ZC9GsDsM7QT6ehOTZBTlF+nTJqaJ8gwh4t2O7ZTVruE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRi2abl0BcaDFjpow3ufcVPh8DrCB8X9flkaQ2AXBnpCwNIQbdlSGuR1LxDmrvAVefHi/XL+Ank1lYlX+i8PKiOGK9qdieOJYLx+TQQv/F/7E97GLKt9cgplT7CpmUI1eyyQ164SIGsejdihGfEMpir6aqOYd59Rga8TUn5h3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pJmA4euq; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pJmA4euq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724697926; bh=Kc2uQ7CP7foGTglwsYPa/ZQ89h9jFTPJlVLvlASXRw4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pJmA4euqafTnSwYtMZgkLBADKfToBOLKYRx5SHRv1XMPRCymQKBpqjQCvhuPDkfuthNNeKr8q2PXSotBz6mzasPw0antWT+ROirpbARW5okHsZpNd/PZ1dacm6bS2rdl1c0JiEaapQX/u9Z2IHQBKcrpJRHBac9bEnsSYisw2xJDKs4Vv8fhutqlaNHAq3mw9ojTsWjytxw+ep5yV/soxlt4LGA803hOUrd8og+v07VjD48cyb70DLoDejssIb72KlkjSvEm0ZNFFPaT158Jh0VNG1HkcAgv3jMRzaMq/z93aNkXHdb0KeS0O9TjjNIsG5yc9mJ/BeE8MJahq1BVAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724697926; bh=JzNmXYIrMFMynFyIAfhPHu6XKu2NiQEuYaGYKhhyqVj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JFH6sVC+dC/g+E38Ntg3UEU3Osh1KI9ds8e4AKm335WfA1R57Svd0EYlcTer3QNLpuHVNIiMQFs5pl2iB2+hObQpbrr35f7o9NL5+SPx1WyWTst5EkFLdc8lUGrQjVksprSogriy/yBe4CQJTH7T3ror2jUyFi1uYKUiaVoSQFj0qq0xc6zRIfkDVfzvK/I45K3zc4ZYdGmBl6Db35fGKMH1iPGU1exVX394sDBocwhcANCdJezaNjFDC99gms9ErRfgWKzUrGPi7X8QCC5EULdQaLS/73xqoTUgYbXYbj2/Y5Gmxan/xf1QoGhsPmyatip2UBVGJ+W4BG4fZsjxtQ==
X-YMail-OSG: dvG5IIsVM1l5JL.GvmPJFQPUyZ3lBXoSrkD6GzAzceoSSuHF1uL9zUysXhDhRsG
 7cHVzzszcM9jFCD7LV4DPR1uItzSnMJnV_NbB0Z03TBCahyRKhdUwYTTHNgf.bkVMAYp_VKr499w
 LjuqqNj7_YAo8626JzqA6ktJ1g2OMutWmw.wTg.qCFKljOXInfOd3e22v7lWeTRwAh7R9Yk9e9JE
 fLkWkX7kr1GYp5amxRfCtu5z9UI7BD1dX40VLqoEqLgbO8z9C1UJTRMKKjxPR.JIWTyl326ALyhW
 IQw8ZDWLTxFL6ZLhd0QSmgs2ReQDJBWdhueNYDKODWj4Pjbt3CUHJzetyo87xDUYR0zlw73YmulS
 XzNLUU5CKLJOyKB_ZoFL6wlZIwJEIERCAPtEV9TpHqNiwv6ECcZJSRRlP_tSEO9T3s9.gkkxygbw
 9bXN.XaWsSxt2OsIY8N0Ank6MPGwXnJgdN.BBdbMIjh7OKU_g.tsbMosl2eXpZJy2vh_Dh40Avvn
 d.AYFM5lpykS4KSPYrUTqldP.MSS8fwncrJKRVc.TuIs8YUYwycEyrN7A4C8PU_WnZMFEZl53L5R
 pe.Pzou0qtrZ0UUe6qIh_smwGIgM0FYzEDO_eFkPmJoHFClnW0K1UCvN0IdzH.TpqRAElZO7.jgB
 CxAE.QH_MZQ.8mAORhzlb4bDEI2Bgm7qEotGzivN2fbLRSoEVTvjZdjA4.VAKTnfduS.ug616ywG
 rzVBKxvBCCeXBKcgBWW.jMzvW90Fou1b8QNoYmmW3_zfuR2aR.pKLbzfC.6KcCU_9KivSgKshodB
 3brAhTIeTyDL0WDkzSuW7WMgVFzljmT4CQGWqcDl7GjVR0LYiVZN5YMGrLq2HHbFJL.AXNCwOYAn
 yRtSn.p74MExlrkZKtZvd_XDxxerfWMMPgdmBUenLE_xmdXt1WOJdjqSLOzUkySy1o6HAVHYc6xm
 VUuxIXCsEqRfPnBnrTHjfOrsewk0x2WuVeS_4o2dcnna8BxFX2Zmlq4wtfxVSIkjaX9Ov2lLMl34
 AU2xqIs_DGgsnvZZUcbWstaKXmdztcKFRRYJMyY3LMlRS1.Uaxq_3x0.ZvsEKPCR3VgXUBgdGdT2
 s7ib30nh47fhPcXmVcjb._cDzak.y6QR.R2QNza91gQ28bFqm4JkO2NsnUzJa2IeoPnha2MWVaIr
 _z9w7Sfm_7f_NMnWdA6_sicRVbDYAf1G_4JeNEi2k.ME2vHNkLcUF5oC86sBdVk5w4KaJ06mbiAP
 Kptf3X.3GB2nkTINWNdJNFV04BTV3IbqZXsA1t5lhqjTOZOsMriJzK6BXGGhl1hGbRdOxtDaNo5q
 I7f_r_j1bUdU5RRqkv4ALxAZatK3TW0m_qpi1a9_E1UYYKHq8_6LOzxBy4IyFJj_oU45gvVqG294
 ReZGLFAu253tuVZNH99G45Hq2A.1f5c26hhCMQf6tELglSzgpRsZEkHYU4yvQ2R3a_YjXA3HTzrK
 6X4T0.A7E6_sPsEG4i2N9Vrla7kz_.Ku0ztx6I1bxYAzKU2sqRDHIwMTwC0EVHzY1Tv6pPYR.zZk
 C0zqjVasrlfcozoX2Larcf3uIwf6XggTy77csXLWF6Pcfhj68uBmQLtWAmKUwLrg_xSEhcAVLKBX
 AlqYaQfePlubTP9wpQa89a9FLp6BcbwKzyj0RK4I3MiADAguHy3aURPlAvYy2SjPzzUCgD6p4n61
 nFEE2rPZzQOZDdLmv_lOxOxAY9vVG1LWVtxuFzsy1ifEUWPYPCN7tjN1SPGxB1Ag8ibU9BDpCP4J
 ppvaXKCAxPMiS.PMtvx0VGq1xgZ6brjqErwpA_ateYuFAeUEgDv9qB8flmPyzPTkX5DIekoh2EFw
 BN0GIgJjRGNi35qGIde3WhQl41laH9DhBVLe_MxDlV11C._Hwe5Y3Uld9HA1EIMlpFBh0z0qwbp1
 eUYO4U0zSClCHUwfGnlpWD5vw.9a8l8Boet04q5D63ozsxCCIQANRg6U1whMOrhVyMPrZybEyS5s
 KVftUIdyP8MSL7ebUvcmCEZGqcdV3167i0XjArmtGxpyh.PECn0QGs32ci13EHxVyEQC97PxUBB4
 bJv0IAPahL99PzCvfGjMXA3cRqSpOwYSkkfTMAddIR1ONLUKP8l1jhV9pks6MJ6zRze0ZPqdbNeR
 IZdjV0pCQEU7phGHLlJVDlMYiavNzDPz4g15fGoWm4f1vF8XSIStFh5hRnOJef93U1jdZswOhg70
 fzSXXiKwir7QPQIQM9OW7XYILRjZW5JazN4wL1sqdzs5_NdExvjg._81ddzlRb8ITbALDywEdP0Y
 o4Dt0GlADIEVxyhbT0gonzzhBt22vmu4rncQaFi8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3cadb405-1809-4cf8-88a9-263408b2c9e2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Aug 2024 18:45:26 +0000
Received: by hermes--production-gq1-5d95dc458-sd55t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 481558c8b78ffef3d116ce14db60dcf5;
          Mon, 26 Aug 2024 18:45:24 +0000 (UTC)
Message-ID: <a0f4bdcb-dc21-4255-abbe-9f557046e7f7@schaufler-ca.com>
Date: Mon, 26 Aug 2024 11:45:22 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] LSM: Add lsmblob_to_secctx hook
To: Georgia Garcia <georgia.garcia@canonical.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20240825190048.13289-1-casey@schaufler-ca.com>
 <20240825190048.13289-4-casey@schaufler-ca.com>
 <dbd5431588de920097637e25b66ea5481675cd47.camel@canonical.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <dbd5431588de920097637e25b66ea5481675cd47.camel@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/26/2024 10:43 AM, Georgia Garcia wrote:
> Hi Casey
>
> On Sun, 2024-08-25 at 12:00 -0700, Casey Schaufler wrote:
>> Add a new hook security_lsmblob_to_secctx() and its LSM specific
>> implementations. The LSM specific code will use the lsmblob element
>> allocated for that module. This allows for the possibility that more
>> than one module may be called upon to translate a secid to a string,
>> as can occur in the audit code.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hook_defs.h     |  2 ++
>>  include/linux/security.h          | 11 +++++++++-
>>  security/apparmor/include/secid.h |  2 ++
>>  security/apparmor/lsm.c           |  1 +
>>  security/apparmor/secid.c         | 36 +++++++++++++++++++++++++++++++
>>  security/security.c               | 30 ++++++++++++++++++++++++++
>>  security/selinux/hooks.c          | 16 ++++++++++++--
>>  security/smack/smack_lsm.c        | 31 +++++++++++++++++++++-----
>>  8 files changed, 121 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 1d3bdf71109e..3e5f6baa7b9f 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -291,6 +291,8 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
>>  LSM_HOOK(int, 0, ismaclabel, const char *name)
>>  LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
>>  	 u32 *seclen)
>> +LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
>> +	 char **secdata, u32 *seclen)
>>  LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
>>  LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
>>  LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index c0ed2119a622..457fafc32fb0 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -520,6 +520,8 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
>>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>>  int security_ismaclabel(const char *name);
>>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
>> +int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
>> +			       u32 *seclen);
>>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
>>  void security_release_secctx(char *secdata, u32 seclen);
>>  void security_inode_invalidate_secctx(struct inode *inode);
>> @@ -1461,7 +1463,14 @@ static inline int security_ismaclabel(const char *name)
>>  	return 0;
>>  }
>>  
>> -static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>> +static inline int security_secid_to_secctx(u32 secid, char **secdata,
>> +					   u32 *seclen)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int security_lsmblob_to_secctx(struct lsmblob *blob,
>> +					     char **secdata, u32 *seclen)
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
>> index a912a5d5d04f..816a425e2023 100644
>> --- a/security/apparmor/include/secid.h
>> +++ b/security/apparmor/include/secid.h
>> @@ -26,6 +26,8 @@ extern int apparmor_display_secid_mode;
>>  
>>  struct aa_label *aa_secid_to_label(u32 secid);
>>  int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
>> +int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
>> +			       u32 *seclen);
>>  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
>>  void apparmor_release_secctx(char *secdata, u32 seclen);
>>  
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 808060f9effb..050d103f5ca5 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1532,6 +1532,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
>>  #endif
>>  
>>  	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
>> +	LSM_HOOK_INIT(lsmblob_to_secctx, apparmor_lsmblob_to_secctx),
>>  	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
>>  	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
>>  
>> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
>> index 83d3d1e6d9dc..3c389e5810cd 100644
>> --- a/security/apparmor/secid.c
>> +++ b/security/apparmor/secid.c
>> @@ -90,6 +90,42 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>>  	return 0;
>>  }
>>  
>> +int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
>> +			       u32 *seclen)
>> +{
>> +	/* TODO: cache secctx and ref count so we don't have to recreate */
>> +	struct aa_label *label;
>> +	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT;
>> +	int len;
>> +
>> +	AA_BUG(!seclen);
>> +
>> +	/* scaffolding */
>> +	if (!blob->apparmor.label && blob->scaffold.secid)
>> +		label = aa_secid_to_label(blob->scaffold.secid);
>> +	else
>> +		label = blob->apparmor.label;
>> +
> It would improve maintainability if the rest of the function was
> refactored into label_to_secctx(...), for example, so it could be
> shared by apparmor_secid_to_secctx and apparmor_lsmblob_to_secctx.

All uses of scaffold.secid disappear by patch 13/13 of this set.
This code, being temporary and short lived, would not benefit much
from being maintainable.

>
>> +	if (!label)
>> +		return -EINVAL;
>> +
>> +	if (apparmor_display_secid_mode)
>> +		flags |= FLAG_SHOW_MODE;
>> +
>> +	if (secdata)
>> +		len = aa_label_asxprint(secdata, root_ns, label,
>> +					flags, GFP_ATOMIC);
>> +	else
>> +		len = aa_label_snxprint(NULL, 0, root_ns, label, flags);
>> +
>> +	if (len < 0)
>> +		return -ENOMEM;
>> +
>> +	*seclen = len;
>> +
>> +	return 0;
>> +}
>> +
>>  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>>  {
>>  	struct aa_label *label;
>> diff --git a/security/security.c b/security/security.c
>> index 64a6d6bbd1f4..bb541a3be410 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -4192,6 +4192,36 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>>  }
>>  EXPORT_SYMBOL(security_secid_to_secctx);
>>  
>> +/**
>> + * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
>> + * @blob: lsm specific information
>> + * @secdata: secctx
>> + * @seclen: secctx length
>> + *
>> + * Convert a @blob entry to security context.  If @secdata is NULL the
>> + * length of the result will be returned in @seclen, but no @secdata
>> + * will be returned.  This does mean that the length could change between
>> + * calls to check the length and the next call which actually allocates
>> + * and returns the @secdata.
>> + *
>> + * Return: Return 0 on success, error on failure.
>> + */
>> +int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
>> +			       u32 *seclen)
>> +{
>> +	struct security_hook_list *hp;
>> +	int rc;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>> +		rc = hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
>> +		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
>> +			return rc;
>> +	}
>> +
>> +	return LSM_RET_DEFAULT(secid_to_secctx);
>> +}
>> +EXPORT_SYMBOL(security_lsmblob_to_secctx);
>> +
>>  /**
>>   * security_secctx_to_secid() - Convert a secctx to a secid
>>   * @secdata: secctx
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 55c78c318ccd..102489e6d579 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6610,8 +6610,19 @@ static int selinux_ismaclabel(const char *name)
>>  
>>  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>>  {
>> -	return security_sid_to_context(secid,
>> -				       secdata, seclen);
>> +	return security_sid_to_context(secid, secdata, seclen);
>> +}
>> +
>> +static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
>> +				     u32 *seclen)
>> +{
>> +	u32 secid = blob->selinux.secid;
>> +
>> +	/* scaffolding */
>> +	if (!secid)
>> +		secid = blob->scaffold.secid;
>> +
>> +	return security_sid_to_context(secid, secdata, seclen);
>>  }
>>  
>>  static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>> @@ -7388,6 +7399,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>>  	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
>>  	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
>>  	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
>> +	LSM_HOOK_INIT(lsmblob_to_secctx, selinux_lsmblob_to_secctx),
>>  	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>>  	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
>>  	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 52d5ef986db8..5d74d8590862 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -4787,7 +4787,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
>>  static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>>  				  void *vrule)
>>  {
>> -	struct smack_known *skp;
>> +	struct smack_known *skp = blob->smack.skp;
>>  	char *rule = vrule;
>>  
>>  	if (unlikely(!rule)) {
>> @@ -4799,10 +4799,8 @@ static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>>  		return 0;
>>  
>>  	/* scaffolding */
>> -	if (!blob->smack.skp && blob->scaffold.secid)
>> +	if (!skp && blob->scaffold.secid)
>>  		skp = smack_from_secid(blob->scaffold.secid);
>> -	else
>> -		skp = blob->smack.skp;
>>  
>>  	/*
>>  	 * No need to do string comparisons. If a match occurs,
>> @@ -4833,7 +4831,6 @@ static int smack_ismaclabel(const char *name)
>>  	return (strcmp(name, XATTR_SMACK_SUFFIX) == 0);
>>  }
>>  
>> -
>>  /**
>>   * smack_secid_to_secctx - return the smack label for a secid
>>   * @secid: incoming integer
>> @@ -4852,6 +4849,29 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * smack_lsmblob_to_secctx - return the smack label
>> + * @blob: includes incoming Smack data
>> + * @secdata: destination
>> + * @seclen: how long it is
>> + *
>> + * Exists for audit code.
>> + */
>> +static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
>> +				   u32 *seclen)
>> +{
>> +	struct smack_known *skp = blob->smack.skp;
>> +
>> +	/* scaffolding */
>> +	if (!skp && blob->scaffold.secid)
>> +		skp = smack_from_secid(blob->scaffold.secid);
>> +
>> +	if (secdata)
>> +		*secdata = skp->smk_known;
>> +	*seclen = strlen(skp->smk_known);
>> +	return 0;
>> +}
>> +
>>  /**
>>   * smack_secctx_to_secid - return the secid for a smack label
>>   * @secdata: smack label
>> @@ -5208,6 +5228,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>>  
>>  	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
>>  	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
>> +	LSM_HOOK_INIT(lsmblob_to_secctx, smack_lsmblob_to_secctx),
>>  	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
>>  	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
>>  	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
