Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A92580D1
	for <linux-security-module@vger.kernel.org>; Tue,  4 Nov 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269741; cv=none; b=lxj861t4sHOnfH1Dex1PNhw1gM0FJV7Fdmi5lsa8d5sezsts6hO3ZPVucSmZ7SLDsjs8Gha7xkWTWOSxOm5uChmRK8IQM4OlhknohPcpSCkkWxvGOYdjl5GXnR4kUJFCubv5HsOU+N9waGEGK9A6wpCsMhkViEYq2UnnsZ53h9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269741; c=relaxed/simple;
	bh=cW8znymWPnQ9E2lv9ObI7kU+4qQxlmHzvnjHhqI8XLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ely/DXJsMXzsZ1mw/2dJq8rNcPV3TesnBMaJjIq8k+zsKunXMsoizVXOxP0BMNaWXsQUxgk5q56GRQSLvCRRlgKYPALE1hxxr1flOTFFBu4N4IwzeBFX1bt+mGFiL8CK61nBf4XfZutwoE5ojvrgwbc9YTTQBEwk/jFkOoWmhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cbz39J3o; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cbz39J3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762269738; bh=G46ndWcyOHWFzhQ4Un6CADH/oAjGqm36Vlz0C+52OJ8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cbz39J3oT20/0UC/+UdViCZRG7CUtBM4FV6h3+2tuKHfpQimQzxAtGMc6FpzfH7UgKkltgnPHoEEh9lCDqVOtu/TcMzNHqx40yLxVXp1os24eaJbIzLOB8UHJa2rLaVxPbWUn+YKa58vkbfaaZzMsmGLpGzobUHRNx6zMODHwjajmGcIw5vm3NMpD4hRGSsnfJiNPkNoFBSn12ScJaCdDpx/SJCJ91U2ZNpYLhHBWVa1h5DHQeGtUXvETwUOFzPnjt8RkUomHVDF2FeeAfAKcV7jiZI30J9Qd118wYMhygpRB6o4peh5W6vtGOZ1Fq7IDtuXYmE3uG/wuGIMNY8cgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762269738; bh=owHwIHgOPv8ZsxfHtAYIUzuFeR6rSoWzGzzSED6kM25=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mal7arDhLJlAsjdkyYUcU0qk03umSfblTMWE8qY/Dgw6OXdodC7VP6JjBwDr63AX4xnK4RIdaGGpV8FPPMgbb8lzPSltofSXUUJt1QaxylxieS867rn1c5tqvHUvYHKai6GzN7JZMSGuabvNVfWtilLD4qd+MGz+sm6KRurwtW1MjQOhWHiJ6pHEyo1F4gs5hb2ojE2Lr0WZq0/ozCZ/haQtbglNAfBBX81AfiEajh/pK/fbcXHJX7PD2oAt1xbfapJctvT8Vy3iv13u6AxtLhwhptluaFcwVGzV71c7Y7CPSsmaf8Hg1Ufj+0nU9Q46yFYfw3OCJ1jIUT3Fama/qA==
X-YMail-OSG: 3EpOxPsVM1mNUj.CKRL_wvcXMQ40.2IpkvgTsz30yBQk6cM6nkgb_yZTcCFDKD7
 EB4fJPQFwbtLfNooyHM4GCKeGmhBo.49at.zeBAeDGv1KspCM3Gvr.AsLmywUI7T6xLxe1OAxlVW
 _mK1WHntd8BMntDDOxTzJ.WFmmxkqMKvrkptk9WDOcAFgz407ixpDDMXNwymHR2AStDhznymDDg1
 pdCfp1uZWQwRX1qb9jNSL7irEVcZUO8GNQHt6oOiEgK7odOs.6kYXKKlLm2ZU2cPOpslPRiiuBsf
 TPrID8ObVBGfoedtbfem7h2PtCPPSXftQ6Lsv_IXuhLM3KGeBU9sxN_hTFvLJBApvs26SFOKq8Kz
 AAo48U0DvBj26.hTXIZ2JD.mCYpR5IYdMxIxWZRN8ypC4smbSxCDsDm48U1Vf8Y4bqjc1dgnTp7G
 5Zz0PKMTIwBmx08UV77Xj7vF9.J4NXwsM5aTlWZsGIeO8G.CovaM9na1K5Du0DRkWZhFv6DZ.5dW
 IAWrmBDI8mZcRg07CCtkq9Cpbf1Pn7HzWmYYbJ8x6Nd9hMkoGzpSZMnLB5Ey5e.263cQTL7A2sjC
 Zwnnbqq8s__7tAaw5BCGuKnaTyoN0lslknw_oQMvnv5NicEAVXM5mmnDPwsD0q5YKcdyO.Nh5J8j
 OGvQUYt_0rJ9HR0n.8JgP_G0ZxsP8BTuzAwlUNYRsLaZmyRzlnW4pT9omDeM0QBbYcgg9_xrI3hj
 LljqEapvMRdF6jgIy0S.YU34cwP4tH6yU1mQ2YYd5dWyIDZ00bpSmvFCdlOjwNkm3HuGQdECuTBf
 j1bDbvBvg7uYuG0ggvmMTf1RMUEiaUp2qbwfiomgBA.RSlpOjEyzOS0ghAs.wEMwcQ77EHWOnW3V
 xxzX4PuN2lSilVSgZpQeP9l4YTgv67hju02hAA2yA9NJyHucJHy8A9eW2Yb6wIBjOGgWMm.1F5Hp
 IN6q27q9QYVooBqGqbCGvAku0MLPzE0MCH7h6IGs2044VdVjvFg1jPtNzghNyEGcfRz1CqkMgOO.
 EtXuKcvN38ZxPONL76YB0oVRlqkSw_5zbCmcXrk5FCe5_.bJXuxVUhzFTzKWil7NMrY7wnzoOr4H
 rMW_qrh2jlvlC9z5AFl3Na2kVW2vTywdxRKkukl0cIsk27OZ6Xj.Nf5yPfgRFu16b.PdEUfuxzpj
 kr5hlFBNptR48ShGuXWjC805J3RAtye_JjBNGeAmH9SyGPOij7t.xJN7YJW51eVY_aKCx89PeT_T
 fzsa1WajS30Z.go_xkBwLI3cObvEaBcv6ZBSy7FEwJjb2LfWdHgRer.f7dKykeWOMcRQXR2METXf
 1oPJ9z8XO2SGYeQbjWAKfxIMczmxWgqaFU6RV0.cMhj2pum.9grSqu5J_1DEX3DgkIXjkmuHSAYk
 FxwLOi1yhNNqiiN_umK.edMA1rEmsIUhNLIeGiW9fJOVsSbTqXo_EpbTHDdoovPEPFzH3WCe8Aoe
 .IqMc5KT4CyIjg85Nb83xh30vIe1xSwRLxnKkfQjtffO5xjDHw_HMLHsd9GVOihkQd3_T3KlTQ.H
 7LHj3fWg3ZFvR0A6YmncHzCPVxoLlIv6tsYlxKRLoKe.A6yxEx_FUKsCWXO4URDUxdmnVswsSUuC
 h7wlBApoQfOArchYDMjUQPH_RHvTB06O4I.gI0lk3AQdXpPwYs1MQN_vyfapRJN_iHjM1kiDCJfB
 LoqhKnubK5aLkEsw31sj4lUkgJmAfoYjix4OP0_QEPtPkhWM.82MExaiY4yQxYvRb17H03rzYYoG
 QzXISL0Vqpf5ECToPZXGR4VqFazESsilQWeojFhJ4vq41XIzrz.6qNpaRRzd3mZ4hy2QcmK9dkPg
 HSNWomXqaK6mgB1_GgUXJHMq0k1ul57hxkVKHL1iJUdhRMPbkwi1Ubgu4CffF9aIqIAMzktELZzb
 Ke.Ob2xykz1NGicoeqcBkw5yFslgY85KDym1ADkBgOViP1AEopoYm0boHGIkAYarMIOfhf.bvcEz
 pfkSFNdXjfEkqKDiKf3Oy5uqpNy8RMEN1ZvaDsD02AUFTI2HrcIVMuDIODIZmwhrzCeoJlhJGf2P
 qaD1Ogf.l5xSqmEVnpldHuQlcH7hmvMFZA9txhjR_oJ0Vz6yDbZc1sg9LB25kqtqQ_obaOr2R.zp
 FUEmaczsHFHItG1dnWGmBBdfePvTJ3alDjkbGBQ2TqHaocq3jRW6Y_k_vd5IUdXlvuWhj8Ff9Nln
 NxaQehjMVVkQqQJWhYzZxnTp3BIN257AZyi7Onc2OJaYV0hyv9WKQltMbyLVS7Lq.FfDt4Yrwjer
 zq4P5EcID0imcD8vzbzonhugE4lyd
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7d77c22d-a5a2-45c8-a786-651590860dcf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Nov 2025 15:22:18 +0000
Received: by hermes--production-gq1-86c5846576-9kznp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b319eceaf085359051caa19a21ae3d2e;
          Tue, 04 Nov 2025 14:41:44 +0000 (UTC)
Message-ID: <5252d5ed-4e10-42c2-b0fd-071c04ce98f9@schaufler-ca.com>
Date: Tue, 4 Nov 2025 06:41:42 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] Smack: add support for lsm_config_self_policy and
 lsm_config_system_policy
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mic@digikod.net, kees@kernel.org,
 stephen.smalley.work@gmail.com, takedakn@nttdata.co.jp,
 penguin-kernel@I-love.SAKURA.ne.jp, song@kernel.org, rdunlap@infradead.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20251010132610.12001-1-maxime.belair@canonical.com>
 <20251010132610.12001-6-maxime.belair@canonical.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20251010132610.12001-6-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/10/2025 6:25 AM, Maxime Bélair wrote:
> Enable users to manage Smack policies through the new hooks
> lsm_config_self_policy and lsm_config_system_policy.
>
> lsm_config_self_policy allows adding Smack policies for the current cred.
> For now it remains restricted to CAP_MAC_ADMIN.
>
> lsm_config_system_policy allows adding globabl Smack policies. This is
> restricted to CAP_MAC_ADMIN.
>
> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>

Apologies for the late review. I see that Paul has suggested the set
wait until the LSM namespace discussions have moved forward.

> ---
>  security/smack/smack.h     |  8 +++++
>  security/smack/smack_lsm.c | 73 ++++++++++++++++++++++++++++++++++++++
>  security/smack/smackfs.c   |  2 +-
>  3 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index bf6a6ed3946c..3e3d30dfdcf7 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -275,6 +275,14 @@ struct smk_audit_info {
>  #endif
>  };
>  
> +/*
> + * This function is in smackfs.c
> + */
> +ssize_t smk_write_rules_list(struct file *file, const char __user *buf,
> +			     size_t count, loff_t *ppos,
> +			     struct list_head *rule_list,
> +			     struct mutex *rule_lock, int format);
> +
>  /*
>   * These functions are in smack_access.c
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 99833168604e..bf4bb2242768 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5027,6 +5027,76 @@ static int smack_uring_cmd(struct io_uring_cmd *ioucmd)
>  
>  #endif /* CONFIG_IO_URING */
>  
> +/**
> + * smack_lsm_config_system_policy - Configure a system smack policy

Smack prefers to say "rule set" instead of "policy". Smack policy
doesn't change, but the allowed exceptions to the policy (rules)
are mutable.

> + * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
> + * @buf: User-supplied buffer in the form "<fmt><policy>"
> + *        <fmt> is the 1-byte format of <policy>
> + *        <policy> is the policy to load
> + * @size: size of @buf
> + * @flags: reserved for future use; must be zero
> + *
> + * Returns: number of written rules on success, negative value on error
> + */
> +static int smack_lsm_config_system_policy(u32 op, void __user *buf, size_t size,
> +					  u32 flags)
> +{
> +	loff_t pos = 0;
> +	u8 fmt;
> +
> +	if (op != LSM_POLICY_LOAD || flags)
> +		return -EOPNOTSUPP;
> +
> +	if (size < 2)
> +		return -EINVAL;

There should be a max check as well.

> +
> +	if (get_user(fmt, (uint8_t *)buf))
> +		return -EFAULT;
> +
> +	return smk_write_rules_list(NULL, buf + 1, size - 1, &pos, NULL, NULL, fmt);
> +}
> +
> +/**
> + * smack_lsm_config_self_policy - Configure a smack policy for the current cred
> + * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
> + * @buf: User-supplied buffer in the form "<fmt><policy>"
> + *        <fmt> is the 1-byte format of <policy>
> + *        <policy> is the policy to load
> + * @size: size of @buf
> + * @flags: reserved for future use; must be zero
> + *
> + * Returns: number of written rules on success, negative value on error
> + */
> +static int smack_lsm_config_self_policy(u32 op, void __user *buf, size_t size,
> +					u32 flags)
> +{
> +	loff_t pos = 0;
> +	u8 fmt;
> +	struct task_smack *tsp;
> +
> +	if (op != LSM_POLICY_LOAD || flags)
> +		return -EOPNOTSUPP;
> +
> +	if (size < 2)
> +		return -EINVAL;
> +
> +	if (get_user(fmt, (uint8_t *)buf))
> +		return -EFAULT;
> +	/**
> +	 * smk_write_rules_list could be used to gain privileges.
> +	 * This function is thus restricted to CAP_MAC_ADMIN.
> +	 * TODO: Ensure that the new rule does not give extra privileges
> +	 * before dropping this CAP_MAC_ADMIN check.
> +	 */
> +	if (!capable(CAP_MAC_ADMIN))
> +		return -EPERM;
> +
> +
> +	tsp = smack_cred(current_cred());
> +	return smk_write_rules_list(NULL, buf + 1, size - 1, &pos, &tsp->smk_rules,
> +				    &tsp->smk_rules_lock, fmt);
> +}
> +
>  struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>  	.lbs_cred = sizeof(struct task_smack),
>  	.lbs_file = sizeof(struct smack_known *),
> @@ -5203,6 +5273,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(uring_sqpoll, smack_uring_sqpoll),
>  	LSM_HOOK_INIT(uring_cmd, smack_uring_cmd),
>  #endif
> +	LSM_HOOK_INIT(lsm_config_self_policy, smack_lsm_config_self_policy),
> +	LSM_HOOK_INIT(lsm_config_system_policy, smack_lsm_config_system_policy),
> +
>  };
>  
>  
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 90a67e410808..ed1814588d56 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -441,7 +441,7 @@ static ssize_t smk_parse_long_rule(char *data, struct smack_parsed_rule *rule,
>   *	"subject<whitespace>object<whitespace>
>   *	 acc_enable<whitespace>acc_disable[<whitespace>...]"
>   */
> -static ssize_t smk_write_rules_list(struct file *file, const char __user *buf,
> +ssize_t smk_write_rules_list(struct file *file, const char __user *buf,
>  					size_t count, loff_t *ppos,
>  					struct list_head *rule_list,
>  					struct mutex *rule_lock, int format)
