Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A65C6FA8E
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 20:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCBUYH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUYG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 15:24:06 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DC0158AF
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 12:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677788644; bh=nUImwNYd0wX0eF6UoAAvxbLGkgLm3N138R5EUXOF/iE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BLThOOg6CcjmAJ+/9zY+TQljp+8uf89FkItcO9SP9gaU0qcXVLeKIRKO2bfTAN1p63dGIiHXEg2THS3otJORepFjEnssin5mfp9oyEXO23jdP73Lyf56lUdSPQyHU9zYMQPxI1XyjJF/pL1G9GUqy7o/RfrGrgtiYM6ufw3uHTD+VMfCRB2KEu2lHXLt5rGMQBXzCOljOll25vwkH1GCfe6uuKblvG6Ht0nDhgxlhvmejUDosQJJfc5NXZIcaM18nHfG807aE8w3IHDRZOiLEHNau9lnTojKqR3zwy/ZwDyHEu7toYl76tgLRNVtBkJtqZROx+Oc16yM8BBkSWUTEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677788644; bh=Domk5VDcnvqiNnzdiF6q7ZwGoX64ha1oLYT4iZikZhb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XRFwcKFj6U+/pbI6G4eU+leXwvfO0JoK9YxM1w7/JMa4HzOGs7yp6mhpJr03tm8z1Ctmw2nJveluT9jlaHAWrahSmrGvOnhPkHdhdJA6wgjIy1PNC8hzGbXvRWObPpK6+JXC3ZZOP2dEx8TtRIbhCkRzd1FGQVLJh2hL0M1VUenZ1jFXNCm/unriTB14RYuK1rmPUSzMmG1FDhSSG4urAqrQvODRkVC3YgLDKBFrf05aNKYERygaq5AbKloabU+4u0jl0mVphyvvO9gYvn1cImmMFYFiugCqLIB4HeyJ9tM5/uDEAFc/avK9m5xEajJIUSINz4mFb0YtM0FuE9DqXA==
X-YMail-OSG: la3S3hMVM1lYQYvowalDFc6adxe1wBkHWu65ob1iCugbPvG2eKjaIFpzx5F0Z.B
 RP9TXykMXHfk03Wxj4vmeVkdq1KlPwoXc6vWraFlDnanJxgelQFyIJdyn.4YsLhlDKvQcHiKUzv7
 9jhJQb45xEljvX3mjsq.J9GbZKvp7QdX9_IgRCsXdMLvkU6hmSnzg82kydCpQsRc6NGyYsb34kH3
 pF8q7fvjoDQ9zkKTSkuZdItX1sHlHp.GcOQ0xkyKPqwJZ.NwIs5G3w5ASRUqGDBdeGiAn436uLAG
 cPThbrkddSSdZ7zAbMwSiea50IxkEK_sHY4tPd1x6oGY.6.kxxMOIYkp.SPOLBncYzz8Gf7pISxU
 _fXegHPgiJrZFs6zX36TYkir5xNj1xbJfCJNk7rIEFMt_7ReKG1YPS1MsclgUaNU0BdZHfce.Kj0
 lhQcJlj9jIVauCwjvChaXlY8EWAm.lScrn3Mf3lodiwoYQLRH5209iVFqWZUB4nRyi4qtrdA.DSu
 weUwfutThVLwgct6KR3ynqp.Eq6oJjxdpgFEyOk33iSRA59aA1HpmtjPhvZnHscY7moGmRFrvSU1
 IVNTIGQgUQY.Bf7b6P.9Br_L.mq1ZXoDfMPuDjev6E6atWrzEwvuBzKfW1xhtB8i882t0_SHSj8j
 7t2M1QPniMpdd8NicHQnq1W4iUv0jwxXvs5PJTnvkn1O5lF_odvk7y_JCysJIeAE_d.CfzhcvsCH
 rRMs4QpeP1FpNoX7o3rutiabV1PuTDki9dGwn_xumbcyR8zdfnaX1DQKCqneMa1gNIvOhEtDuN4P
 eIVyovEfy.qc_9HyIfEyg4TgloW2ZR2PYPb9DOy6WApfvKhTqKPoZO8diVsAXTm8uOHvE1YM2Rcm
 WE6H71qI0TkMwauDfaZUakKZoQmA1DAHo5TUHrzezAdcyC1ll8N3a9LtZcg59LllePXP8ZCO10.I
 .38VdrN4IYKEssGuE8._EGx4LuaLcmfDVxKi4cEPUubXPOK9ZDzYEuCSp91oDs1A20TnvGSb35zY
 BOXet_6caTK9rYEtftqqSq9M2pYDdSCqOwojR1v7qLU8SRcBKnk3ZAVIVSxQIKL.UrXAVSmjrjGD
 qUxbCr1aNQ3ZYuNHTpSU05Kx6Hga9Jhzzpw1ewNqsbwZ7xtZwc0U1Ip0XZ27gs95JzW8PMk9ODCy
 lunpSB_SUaVXDmVPhEkddm82_lZVfT0r0mqHlUAu2hcZ3IX.WnLE73yXRSfx9xxqbD6MKJJ5XENK
 mACQ9u8g1pabq7BMsAArTJozTIs1CEsWpBGPe9uc7PsP8eUP1ddkwc610zfJWGhNLfZ_ixKZ4BQF
 FcojyfsCrgciy.lWxYJSRE6jnwUWjccIRZxreSYp2QmNk.ckl3irMy1Aeki1F14KnO8p2_8TAhCN
 _yTPBO5j9sH9qusonX0WuhuEx0nRYzOn7fb43ZduWc8rwxnyAINZI.UY6IbJXuLUN93i4QEOguND
 lutUhnaDubp_FBaHTPYzPwpDN_wECjDOQaoDtBrsG2MpSSO0OqEa55JRcj.y.yikV26KBlau4tOp
 aIt9pA.nHYSVhsVKgUaJzIPCk_HALpGoAcombsZJrzi08I_dKWOaq.C0xsfn2XEMDcSeijbeR6SG
 Hfdd5WzwN1S6tbUVmhac7tbsRcWxnd.WDDaHkjCgo8CvXuGVYZifNsEg4Z6fRVSu0Z7Ep5lmuHh2
 vcu7HQ5aw4PrUwp89MyKPRWhBiMh6DNJaUmnhRb_r9SYrrXkYXVT029dYS7aTzjiYU920Ynwy_af
 IBIvBIXKNysDEYx81qAvSizoJNte5szuAuAbwh6yLE4Qtb3tnP.GwOwSQh6nFfczfxZr6uacCfiI
 3iQSqzBbVQxC3S2WrofGMP8vxYMIkihAYO6lzlzxb7.9uwCKNPJk5GHT5YBmup3cVDTEcG.301Gy
 Ja2ih0ofNfTKrRToV0JQQ57phhx4w1O5wMg4r2yKRChV7VRg9C.2Z8T2_HGU8MQHiEQqHWujpcq8
 jrmF2s_LtXMWMfYNqHmX0rykLN2PIv22L3R1E4XEhgbu9HlosFMehTgo.A63M9QD.5KYi.7BfhjX
 8h8nRXEjpXb5eLh3OjbU2JTQwKopEgJgDly4zD.ltPMVPNTVJPS4cLhCQjJZH6EiPu6IVS9P2lZw
 RMLb1Tf5SyyGjfsSnp4IIyNrPOyE1xP9sAiMUxd9tmlrzJ6auQC.1czV9RRXPuLLqHBav3Q9JbdP
 ZeiibmdpDGaP6Z7LsrQ6ZDRe1D9vZyOev
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Mar 2023 20:24:04 +0000
Received: by hermes--production-bf1-777648578f-lk5ld (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 22b9abc0b188502aed624d3f5a141c53;
          Thu, 02 Mar 2023 20:24:02 +0000 (UTC)
Message-ID: <c57a0046-57de-8f89-a4e2-ecde97859504@schaufler-ca.com>
Date:   Thu, 2 Mar 2023 12:24:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     enlightened@chromium.org, mic@digikod.net
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, casey@schaufler-ca.com
References: <20230302185257.850681-1-enlightened@chromium.org>
 <20230302185257.850681-2-enlightened@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230302185257.850681-2-enlightened@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/2/2023 10:52 AM, enlightened@chromium.org wrote:
> From: Shervin Oloumi <enlightened@chromium.org>
>
> Adds a new getprocattr hook function to the Landlock LSM, which tracks
> the landlocked state of the process. This is invoked when user-space
> reads /proc/[pid]/attr/current to determine whether a given process is
> sand-boxed using Landlock.
>
> Adds a new directory for landlock under the process attribute
> filesystem, and defines "current" as a read-only process attribute entry
> for landlock.

Do not reuse current. Create a new name or, better yet, a landlock
subdirectory.

>
> Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
> ---
>  fs/proc/base.c         | 11 +++++++++++
>  security/landlock/fs.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..3ab29a965911 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2851,6 +2851,13 @@ static const struct pid_entry apparmor_attr_dir_stuff[] = {
>  LSM_DIR_OPS(apparmor);
>  #endif
>  
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +static const struct pid_entry landlock_attr_dir_stuff[] = {
> +       ATTR("landlock", "current", 0444),
> +};
> +LSM_DIR_OPS(landlock);
> +#endif
> +
>  static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "current",		0666),
>  	ATTR(NULL, "prev",		0444),
> @@ -2866,6 +2873,10 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	DIR("apparmor",			0555,
>  	    proc_apparmor_attr_dir_inode_ops, proc_apparmor_attr_dir_ops),
>  #endif
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +       DIR("landlock",                  0555,
> +	    proc_landlock_attr_dir_inode_ops, proc_landlock_attr_dir_ops),
> +#endif
>  };
>  
>  static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index adcea0fe7e68..179ba22ce0fc 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1280,6 +1280,37 @@ static int hook_file_truncate(struct file *const file)
>  	return -EACCES;
>  }
>  
> +/* process attribute interfaces */
> +
> +/**
> + * landlock_getprocattr - Landlock process attribute getter
> + * @p: the object task
> + * @name: the name of the attribute in /proc/.../attr
> + * @value: where to put the result
> + *
> + * Writes the status of landlock to value
> + *
> + * Returns the length of the result inside value
> + */
> +static int landlock_getprocattr(struct task_struct *task, const char *name,
> +				char **value)
> +{
> +	char *val;
> +	int slen;
> +
> +	if (strcmp(name, "current") != 0)
> +		return -EINVAL;
> +
> +	if (landlocked(task))
> +		val = "landlocked:1";
> +	else
> +		val = "landlocked:0";
> +
> +	slen = strlen(val);
> +	*value = val;
> +	return slen;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>  
> @@ -1302,6 +1333,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>  	LSM_HOOK_INIT(file_open, hook_file_open),
>  	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> +
> +	LSM_HOOK_INIT(getprocattr, landlock_getprocattr),
>  };
>  
>  __init void landlock_add_fs_hooks(void)
