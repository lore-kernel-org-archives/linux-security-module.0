Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AB38DC72
	for <linux-security-module@vger.kernel.org>; Sat, 12 Sep 2026 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228114; cv=none; b=bSPzLQEG4IxwJc+rquCljXPLl73yKvilONkCfkZdUXAiQY3KtI88eZwDVHtz3zZt6XVYyYSgJe3dFcmK71jKHA8fmQTIt0PvF/LszgZc2kG547XdVaNz3ZkEmY/FVAEjh/F+t4m9nMGnJ+SVKuCFSxeIAgwCmkeaFcvoeWCfB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228114; c=relaxed/simple;
	bh=EGHAS28EShiEx1Qx68HBuJ+sNFt643nzMI61mTBgzuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYYJaMKkISPO1O1k3IdhTRnRvxri7b7lt6WWhDebbfhPk36QSnjjEbIOx77rCp1t3yk/tvQmKxjDwQGzymEG7X4yOt89cTNOQYCaVrdK2BB/PTYjVuoye1PoiMnePHRKx/yvcZrMxIJF+zSu1F6YR5XdT/eYkyUMUVMZ+YUy6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dTpifUqP; arc=none smtp.client-ip=66.163.184.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dTpifUqP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789228110; bh=EGHAS28EShiEx1Qx68HBuJ+sNFt643nzMI61mTBgzuE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dTpifUqPO6B+l+uNvyI3fXrp39GXqvKlUDpKQcJuy9hHLZc0u6uXG96ojuk3CdxulILqB8e8i4CIBcN0DR0FKIpr9O1gSk1Vspi94aNXbxPqbPylx6/F+qsJiLy8cnIMSIp59gijHq3C4wmZRdzz3DVniU6FfscdzwRTxLPIZMJmvsBjXJLuV4wRSclmCN8iIX/ilbEVg7vS2/bBcoTFOtJkB8p7YewkVrWJRRXKoWR0Qt5Cfmq9QYMabxZUoL3ouC1BK5fVoE2DowUUAUlDFU3kDA0pWPm/U3fXTF4y1L9Hwc2EKpEQJ+ZDuGtJy8yduEKS7NX1ksTQvxj/37U/ZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789228110; bh=Kuo77RivD71kpeau9nV3OO7TvktMF6NeCL5kwSfpQGd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fBTLBMIugSGBQyJD2jbw+Ap2a5Y0Iqxpsl+8j4htX0TfRKEUC5v4gsoTtCnlk8Klqm/hKjnPRVy8N/PHAnRKv1tfmNvmuR/xoSqfXUpmF/IR/AUaZS77/PNWkj02ozizwJES1L+OP6imltyc9Gxl60rFw5EibAYDKZiUBsPS+gISmRpqi+ypKqzWK5U93thHJEg9zL6gTv4CxuSwYD6jtghmUyq9qknQYP8kII4tu07JnPJpi/M59PbKCxhz1mgLoOk/XEolxEkBe+MPpJ2a5Nmj98KMGq0etxMVd4ZexZRg6FvKoS9HQuVu2K1HFrii3IAbpoXwEXF60uSqZalsyg==
X-YMail-OSG: ObdbLP0VM1lTANdCCOhz3Y5atfmmeTnkmcSDp.uRI6ipGn5DkYB3MnMgWL5ZNyv
 U0OFDUnxdn6ZdvBXfs6528VMN4rWgM_uadEvepI.cPdgIQ3ZMJ8ZzzIjeHL0BG0XhNQLS8AQhJYw
 PxHq6L7Y4P5HYlK6D9RykQC8raJUL_NYY6QIAmc94_pk0flJ8jKKYwEr2BaepXULj1FQBXNGP.NJ
 h.QA9oc5DQdZmYsgFF7odaA90fvnCD9ip_1amPpmvDdwtrFJhDXbCfEprLw3nXlLRj0J38V6C7XV
 ..1W.D1nL2WnvTrQGsMN2pjyWdwIdhyEpRfoeT_tcBP8gu.Ox6x6BbkklK1iQFqlUR2KSOdaEjsS
 .nmXUjH1ubndtTsKDiAn5hbGmV9EBX6aDwLBNR9We8GtGJ_LQBqU.PZkyv_e59rBgZqkhrTEBLjk
 sVGbIsI1JZzUEj5pAW86ZrtPJMHN9nsJqBYe8ydGJAFX9RvvaCPCu1RFCaYThGfBac4F7hMQYzr3
 jYohKbJmkuRGg32SMqvzPbnnJYXvTsi3QY.jVDaFI952FEFsDTU43VtbnNnSwwWgk.2JbRFmKzZd
 SxADASZxysQNFs8tfhwtlKwlRyGUOvuV8ZEhxMIOf6B81.TBNZxf3tMqxl6aPDW9GhCD5thZvIHN
 ZS_h62VRMiKMTlWe4tfpATgLyCx6a1qOu1blf3c7Idcd8gZ.i3ZP72eLmqO7Jd9ltdHIl.MVkrLQ
 unsUBe8nGJRplBsXgXF7gMwtij64nRCEJMV6NPJsDJDfs6FvWZgEJq3IY97PIsELMgkVGjNGzghD
 EpRIEroF.yWeYDjmgBcFuQKxICWfM4XAfzK4klUNoFs5qMb7iKI2x10puZsKLSEn1X19JnOc9fuz
 7nb3pOrjBfPWY3lVw1npI._4cIMupUYD5e2SLfS8bC9B.2BpufeMkl07aUOg4jtZCm7ezi5UbCM4
 Nb7Pp5AMl92jx26vuuLjvmvhrJtNjFnWgOMkpD9D0GoD0W_Chd1kDxtf89X3hn5s552nwxUoSxHH
 zO40mbWF7sbdqRfSe19HrrY3VrC6rIn1HXu2FI6l_v2zZA3IthfZrahja9vaaqjb_qKmezT0zwGt
 y.FUDP_7v3Qxb5zt8ckJNftVLazFi_O8wsWDy3ggO_jefcpyi.0igLbzaRJ28Fov1rGOcAjjcWVg
 CpkpH.cJEbidaoovgGOQi2nveyOG7E_InIQPLw1qQuZCzFAKLUZRs6BIJN1zEsE99ZilOulxAfYw
 0BELIQ5sd0DzucvjZA3Mziw_Yl98twVLl5PKDjlIJuwpR_ELgDDoMXjwkaIjZApfafSf_I7wK5a.
 dSQ3m3148KFoJjwR0HbN4bqAGrEJ2HRrOxor542096YigmbaGy3S8Kuw9eoyXvAvqQ3dZvMKMs.X
 Gwy.pD7Eskb8Hkg28llzpXlw_zGvsbR7GSZUtajfertbGg4hwL7F.Bvr5bapfJd_kRg.4XMEq99S
 w.714srLTXsYMKiNmfx4tO49Ix9pI6yOha0kW3O5AVpADvQ1kpszzpzyVDO5ORYe_E9AB_CtxsKJ
 x_5_Zp9Jf8HIXvr2OcQRTw.eYOtzBueD22ENS1ISs0FevPFBxugqfaOlejWM0ESqXZ_ePrYRRkJ6
 hUvrmC8qbk9luyFYqKUgHnbJRCk0CAULaJR9QBq_0BPLCBHwlRQmXVARTZg1PKHYaNPCeT94nzgY
 nY1D4rhhp1tfjTn6bkBy5W8fInXlq94rgyiIWSBZdEufo4FezdrPTBsL9VEqe81.ju76oxmGijr8
 dWrB18Yez9SdOWRFVKgPW40Jnv4ycJLptiWMokuhl8DmnXXinU_DskMoBKIFDpMlrmXx469JEWNE
 N5iLvSoA97UP97MlcgAipYqPWaYGZkLkXM1gW6nesYDVHaA7IPWegHR7DWhVURgVeSPAeONyA5RQ
 pN9pu2kwu2dJwOMQYu.uWt8IfLYVM5DByOoxbjnGSICaaK5CuJFBEQ34yAzomgpkdMXHgxL9O3W0
 ZAKhO5_rZY1mrYxxUTPFbfboXFy56qxiO0bMo029jDOQYwNwjoZkDYleJTHV8BNn6ADPvTtInaie
 EgLWQLry1pVj.inoPP8lpkfbIUu3m6Vnhx7hmtohlOFfBav6a0oYvjDejBSaORJJiytwavlP6l7H
 lEkn614nrvd1Iz_EIcP46g5AvN_LVtMItDU06twEUfs_nUJk55hKLGLdPs78rXSW4o1mR8iK4zh1
 0dbnHyGhnBg.qG8Ap4KSmy3jYZ5fy9MST4Cn1IPTPAMB9XpqipNN9KYwhxPcsO5PGobrcmnjeIwP
 NC0mfUY1fz.VwuMuG8kM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0d459944-998f-448b-8164-eda19d817a83
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 12 Sep 2026 15:48:30 +0000
Received: by hermes--production-gq1-678d9dd684-86v4w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4d1e64e686a8a701f35c52a78dda57f4;
          Sat, 12 Sep 2026 15:48:25 +0000 (UTC)
Message-ID: <5c4492df-e58c-4df3-b996-4ad5c54e3d2f@schaufler-ca.com>
Date: Sat, 12 Sep 2026 08:48:25 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] smack: preserve low-integrity labels on copy via
 whitelist
To: Tang Peter <Peter_Towne@hotmail.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "gaolong@yhkylin.cn" <gaolong@yhkylin.cn>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <TY0PR06MB4957733568F7DBD502775B5B81AE2@TY0PR06MB4957.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <TY0PR06MB4957733568F7DBD502775B5B81AE2@TY0PR06MB4957.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26525 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/25/2026 8:33 PM, Tang Peter wrote:
> Subject: [RFC PATCH] smack: preserve low-integrity labels on copy via whitelist

I haven't been ignoring this, sorry for the delay.
I can't say that I like it all that much, but I can see where it
could have value. It's not all that weirder than the relabel-self
behavior. So, if you put it under a configuration option, say
CONFIG_SECURITY_SMACK_COPYWHITELIST which would default to "no"
I will have another look. I'm not promising I'll take it at this
point, but I will look even more closely.

>
> Hi Casey,
>
> I did try SMACK64EXEC, and it works for a dedicated copy tool. But two
> cases on this device fall outside it:
>
>   1. The application itself reads USB content. A Qt app opens files on
>      the stick directly (to import / preview) and later writes its own
>      files. It isn't a cp_usbarea-style tool, so its output inherits the
>      app's process label, not USB_Area — the provenance is lost through
>      normal, legitimate use, not through a copy command.
>
>   2. An attacker won't use my cp_usbarea. If untrusted code reads the
>      USB file and writes its own file directly, SMACK64EXEC doesn't get
>      in the way — the copy tool only constrains the paths that
>      voluntarily use it.
>
> So SMACK64EXEC constrains the "compliant" path, but this device also has
> non-compliant paths (the app's own reads, and arbitrary writes). That's
> what pushed me toward a whitelist enforced in the kernel on every read
> rather than only when someone uses the right tool.
>
> Here is the implementation, rebased onto current mainline and
> build-tested against 7.2.0. Compared with the earlier /lib/ path-filter
> version, two things changed:
>
>   1. The gate is a label whitelist, not a path prefix. Only labels added
>      to /smack/preserve-whitelist are ever preserved, so the /lib/ and
>      /usr/lib/ filter is gone: a shared-library label is simply not on
>      the whitelist and can never pollute the slot.
>
>   2. The record is taken only after a passing MAY_READ check, so a
>      process that cannot read a file cannot create a file bearing its
>      label (which would widen the write-down further).
>
> The mechanism in short:
>
>   - smack_file_open(): after a passing read check, a regular file opened
>     O_RDONLY whose label is whitelisted records it in
>     task_smack::smk_preserve.
>
>   - smack_inode_init_security(): if no transmutation applies and a
>     preserve label is recorded, use it for the new inode and clear it.
>     TRANSMUTE still takes priority.
>
>   - One-shot slot: consumed on create, cleared on fork and exec.
>
>   - /smack/preserve-whitelist is the single source of truth; an empty
>     list is the lock-free fast path in smack_file_open().
>
> I understand none of this removes the write-down primitive — it only
> narrows the target to the whitelisted channel labels. That is a
> deliberate device-side tradeoff for our deployment, where the only
> subject able to read the sensitive label is the trusted admin and the
> operator performing the copies has no read access to it, so the
> cross-sequence laundering you described is not reachable here. I am not
> asking to merge this; I'd value your read on whether the implementation
> has problems I've missed, and on whether there is a way to get the
> "enforced on every read" property without the write-down at all.
>
> The patch is a single commit, 235 insertions over four files, checkpatch
> clean apart from the symbolic-permission warning (kept to match the rest
> of smackfs).
>
> Regards,
> Tang Pengke
>
> ---
>  security/smack/smack.h        | 22 +++++++++
>  security/smack/smack_access.c | 75 ++++++++++++++++++++++++++++
>  security/smack/smack_lsm.c    | 45 +++++++++++++++++
>  security/smack/smackfs.c      | 93 +++++++++++++++++++++++++++++++++++
>  4 files changed, 235 insertions(+)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 9b9eb262f..0b0a2ba42 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -73,6 +73,23 @@ struct smack_known {
>       struct mutex                  smk_rules_lock;   /* lock for rules */
>  };
>  
> +/*
> + * An entry in the preserve whitelist.
> + *
> + * The whitelist is the single source of truth for which labels are
> + * preservable.  Its emptiness is the fast path in smack_file_open(),
> + * and membership is tested by walking the list.
> + *
> + * Only untrusted-channel / low-integrity labels should be added, so a
> + * process can only ever preserve a low label and never a system trusted
> + * label (which would be a write-down primitive and let shared-library
> + * loads pollute the record).
> + */
> +struct smk_preserve_wl {
> +     struct list_head        list;
> +     struct smack_known            *skp;
> +};
> +
>  /*
>   * Maximum number of bytes for the levels in a CIPSO IP option.
>   * Why 23? CIPSO is constrained to 30, so a 32 byte buffer is
> @@ -121,6 +138,7 @@ struct task_smack {
>       struct smack_known      *smk_task;  /* label for access control */
>       struct smack_known      *smk_forked;      /* label when forked */
>       struct smack_known      *smk_transmuted;/* label when transmuted */
> +     struct smack_known      *smk_preserve;    /* label to inherit on next create */
>       struct list_head  smk_rules;  /* per task access rules */
>       struct mutex            smk_rules_lock;   /* lock for the rules */
>       struct list_head  smk_relabel;      /* transit allowed labels */
> @@ -312,6 +330,8 @@ bool smack_privileged(int cap);
>  bool smack_privileged_cred(int cap, const struct cred *cred);
>  void smk_destroy_label_list(struct list_head *list);
>  int smack_populate_secattr(struct smack_known *skp);
> +bool smk_preserve_allowed(struct smack_known *skp);
> +void smk_preserve_set(struct smack_known *skp, bool on);
>  
>  /*
>   * Shared data.
> @@ -326,6 +346,8 @@ extern struct smack_known *smack_unconfined;
>  #endif
>  extern int smack_ptrace_rule;
>  extern struct lsm_blob_sizes smack_blob_sizes;
> +extern struct list_head smk_preserve_wl;
> +extern struct mutex smk_preserve_wl_lock;
>  
>  extern struct smack_known smack_known_floor;
>  extern struct smack_known smack_known_hat;
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index 350b88d58..961d47545 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -53,6 +53,81 @@ static u32 smack_next_secid = 10;
>  int log_policy = SMACK_AUDIT_DENIED;
>  #endif /* CONFIG_AUDIT */
>  
> +/*
> + * Preserve whitelist: only labels on this list are preserved on copy.
> + *
> + * The list is the single source of truth for "which labels are
> + * preservable". It also lets smack_file_open() take a plain
> + * list_empty() fast path.
> + *
> + * Only untrusted-channel / low-integrity labels should be added, so
> + * that a process can only ever preserve a low label -- never a system
> + * trusted or sensitive label -- which would otherwise be a write-down
> + * primitive (and would let shared-library loads pollute the record).
> + *
> + * Entries hold raw smack_known pointers. SMACK global labels are never
> + * freed at runtime (smk_destroy_label_list frees list elements, not the
> + * label objects), so these pointers stay valid for the life of the
> + * system.
> + */
> +LIST_HEAD(smk_preserve_wl);
> +DEFINE_MUTEX(smk_preserve_wl_lock);
> +
> +bool smk_preserve_allowed(struct smack_known *skp)
> +{
> +     struct smk_preserve_wl *e;
> +
> +     mutex_lock(&smk_preserve_wl_lock);
> +     list_for_each_entry(e, &smk_preserve_wl, list) {
> +           if (e->skp == skp) {
> +                 mutex_unlock(&smk_preserve_wl_lock);
> +                 return true;
> +           }
> +     }
> +     mutex_unlock(&smk_preserve_wl_lock);
> +     return false;
> +}
> +
> +/*
> + * Add or remove a label from the preserve whitelist.
> + *
> + * The sysfs interface (preserve-whitelist) calls this with on=true for
> + * a plain label, and on=false for a label prefixed with '-'.
> + */
> +void smk_preserve_set(struct smack_known *skp, bool on)
> +{
> +     struct smk_preserve_wl *e, *new = NULL;
> +
> +     if (on) {
> +           new = kzalloc_obj(*new, GFP_KERNEL);
> +           if (!new)
> +                 return;
> +           new->skp = skp;
> +     }
> +
> +     mutex_lock(&smk_preserve_wl_lock);
> +     if (on) {
> +           list_for_each_entry(e, &smk_preserve_wl, list) {
> +                 if (e->skp == skp) {
> +                       kfree(new);
> +                       new = NULL;
> +                       break;
> +                 }
> +           }
> +           if (new)
> +                 list_add_tail(&new->list, &smk_preserve_wl);
> +     } else {
> +           list_for_each_entry(e, &smk_preserve_wl, list) {
> +                 if (e->skp == skp) {
> +                       list_del(&e->list);
> +                       kfree(e);
> +                       break;
> +                 }
> +           }
> +     }
> +     mutex_unlock(&smk_preserve_wl_lock);
> +}
> +
>  /**
>   * smk_access_entry - look up matching access rule
>   * @subject_label: a pointer to the subject's Smack label
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index ff115068c..b2a702668 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -325,6 +325,7 @@ static void init_task_smack(struct task_smack *tsp, struct smack_known *task,
>  {
>       tsp->smk_task = task;
>       tsp->smk_forked = forked;
> +     tsp->smk_preserve = NULL;
>       INIT_LIST_HEAD(&tsp->smk_rules);
>       INIT_LIST_HEAD(&tsp->smk_relabel);
>       mutex_init(&tsp->smk_rules_lock);
> @@ -906,6 +907,8 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
>       struct superblock_smack *sbsp;
>       int rc;
>  
> +     bsp->smk_preserve = NULL;
> +
>       isp = smack_inode(inode);
>       if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
>             return 0;
> @@ -1066,6 +1069,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>             }
>       }
>  
> +     /*
> +      * If a whitelisted label was recorded on file open and no
> +      * transmutation applies, inherit it so the new file keeps the
> +      * source's (low-integrity) label across the copy.
> +      */
> +     if (!trans_cred && tsp->smk_preserve != NULL &&
> +         !(trans_rule && smk_inode_transmutable(dir))) {
> +           issp->smk_inode = tsp->smk_preserve;
> +           tsp->smk_preserve = NULL;
> +     }
> +
>       if (rc == 0)
>             if (xattr_dupval(xattrs, xattr_count,
>                       XATTR_SMACK_SUFFIX,
> @@ -2068,6 +2082,37 @@ static int smack_file_open(struct file *file)
>       smk_ad_setfield_u_fs_path(&ad, file->f_path);
>       rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
>       rc = smk_bu_credfile(file->f_cred, file, MAY_READ, rc);
> +     if (rc)
> +           return rc;
> +
> +     /*
> +      * Record a whitelisted label after a successful read check so the
> +      * next file create (smack_inode_init_security) can inherit it.
> +      *
> +      * The record must happen only after the read check passes;
> +      * otherwise a process without read access to the source could
> +      * create a file with that label without ever reading it, which
> +      * would be a write-down primitive.
> +      *
> +      * The whitelist must only hold untrusted-channel / low-integrity
> +      * labels (peripheral, network, serial, and other external
> +      * sources), never system trusted labels (system binaries, shared
> +      * libraries, etc.) -- otherwise shared-library loads would pollute
> +      * the record.  Because of this constraint no library path
> +      * filtering is needed here: the whitelist check already excludes
> +      * every non-whitelisted file, including shared libraries.
> +      *
> +      * The whitelist is read-only after configuration, so the
> +      * list_empty() fast path needs no locking.
> +      */
> +     if (!list_empty(&smk_preserve_wl) &&
> +         (file->f_flags & O_ACCMODE) == O_RDONLY &&
> +         S_ISREG(inode->i_mode)) {
> +           struct smack_known *skp = smk_of_inode(inode);
> +
> +           if (smk_preserve_allowed(skp))
> +                 tsp->smk_preserve = skp;
> +     }
>  
>       return rc;
>  }
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 6e62dcb36..568c40ffc 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -62,6 +62,7 @@ enum smk_inos {
>       SMK_NET6ADDR      = 23, /* single label IPv6 hosts */
>  #endif /* CONFIG_IPV6 */
>       SMK_RELABEL_SELF = 24, /* relabel possible without CAP_MAC_ADMIN */
> +     SMK_PRESERVE_WL   = 25, /* preserve whitelist labels */
>  };
>  
>  /*
> @@ -2867,6 +2868,95 @@ static const struct file_operations smk_ptrace_ops = {
>       .llseek           = default_llseek,
>  };
>  
> +/*
> + * Seq_file operations for /smack/preserve-whitelist.
> + * Iterates the whitelist and shows each preservable label.
> + */
> +static void *preserve_wl_seq_start(struct seq_file *s, loff_t *pos)
> +{
> +     mutex_lock(&smk_preserve_wl_lock);
> +     return seq_list_start(&smk_preserve_wl, *pos);
> +}
> +
> +static void *preserve_wl_seq_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +     return seq_list_next(v, &smk_preserve_wl, pos);
> +}
> +
> +static void preserve_wl_seq_stop(struct seq_file *s, void *v)
> +{
> +     mutex_unlock(&smk_preserve_wl_lock);
> +}
> +
> +static int preserve_wl_seq_show(struct seq_file *s, void *v)
> +{
> +     struct smk_preserve_wl *e = list_entry(v, struct smk_preserve_wl, list);
> +
> +     seq_printf(s, "%s\n", e->skp->smk_known);
> +     return 0;
> +}
> +
> +static const struct seq_operations preserve_wl_seq_ops = {
> +     .start = preserve_wl_seq_start,
> +     .next  = preserve_wl_seq_next,
> +     .stop  = preserve_wl_seq_stop,
> +     .show  = preserve_wl_seq_show,
> +};
> +
> +static int smk_open_preserve_wl(struct inode *inode, struct file *file)
> +{
> +     return seq_open(file, &preserve_wl_seq_ops);
> +}
> +
> +static ssize_t smk_write_preserve_wl(struct file *file, const char __user *buf,
> +                            size_t count, loff_t *ppos)
> +{
> +     struct smack_known *skp;
> +     char *data, *label;
> +     bool on = true;
> +
> +     if (!smack_privileged(CAP_MAC_ADMIN))
> +           return -EPERM;
> +
> +     data = memdup_user_nul(buf, count);
> +     if (IS_ERR(data))
> +           return PTR_ERR(data);
> +
> +     label = strim(data);
> +     if (!label[0]) {
> +           kfree(data);
> +           return -EINVAL;
> +     }
> +
> +     /* A leading '-' removes the label (same convention as revoke-subject). */
> +     if (label[0] == '-') {
> +           on = false;
> +           label = strim(label + 1);
> +           if (!label[0]) {
> +                 kfree(data);
> +                 return -EINVAL;
> +           }
> +     }
> +
> +     skp = smk_find_entry(label);
> +     if (!skp) {
> +           kfree(data);
> +           return -ENOENT;
> +     }
> +
> +     smk_preserve_set(skp, on);
> +     kfree(data);
> +     return count;
> +}
> +
> +static const struct file_operations smk_preserve_wl_ops = {
> +     .open       = smk_open_preserve_wl,
> +     .read       = seq_read,
> +     .write            = smk_write_preserve_wl,
> +     .llseek           = seq_lseek,
> +     .release    = seq_release,
> +};
> +
>  /**
>   * smk_fill_super - fill the smackfs superblock
>   * @sb: the empty superblock
> @@ -2933,6 +3023,9 @@ static int smk_fill_super(struct super_block *sb, struct fs_context *fc)
>             [SMK_RELABEL_SELF] = {
>                   "relabel-self", &smk_relabel_self_ops,
>                         S_IRUGO|S_IWUGO},
> +           [SMK_PRESERVE_WL] = {
> +                 "preserve-whitelist", &smk_preserve_wl_ops,
> +                       S_IRUGO|S_IWUSR},
>             /* last one */
>                   {""}
>       };
> -- 
> 2.43.0
