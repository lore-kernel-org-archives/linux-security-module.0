Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694B47D446
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070121; cv=none; b=f+ttHzjmwwc2pFZ56CzURBhnf1lvcUllMiChLU5DT9/w68twj3s/k38SJzSABOchgkWSe44lfJZWXTMMe/1GMqaUgYiWyqFdwdw8CJxo7phKzArj+BMJWo72eppPnxWXix7rVShBYJraszjxtJV9NHI1piCaL2xO2GJAUfxcg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070121; c=relaxed/simple;
	bh=08kYcxaITCaU6XrzJlkXvltX4z6rYRBTqHONHcBNMSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0IeS0mCR8InIJwddSuXzB9LrTLN8ygfpqc+k9dYLIWiozAj21i2Cx+pfw+GAVgRGDN16PF5DWMh/5EZSqhpnyaSYZei7YO8VVLl++UCLielu2PR/3zRLb6uo6h6UhW87+g0riSEzdQbUlzaR+II8mYapKKI9fQ0HWtjO7SGfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=K/sQlqY1; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="K/sQlqY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787070112; bh=08kYcxaITCaU6XrzJlkXvltX4z6rYRBTqHONHcBNMSo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=K/sQlqY1oAYsUXPJJbSOJfPEsEwakqwinoHmdWobuYFL7oIvYu+kLf2D7kdmTGg3/bE64HTnmt6aQh5YF+egTl508kWDuZByJneEQYL6jsDU15Dggqj9lPfaNyw9Co8wO7UGFlPTpQICrIvHMP2NEBf8pkPMqW5T3EIheXcrkbDHOh4+FVvKUblJrJflq2/RUz2Wt4K9UQhuyfdoNX6ZdGqFf23YuTmCe61cywkSud9Coj71IBcw7rBb2PupnvIt7SMYhQuK+NQ6f9TlNxUdi7C7O2KK8dgOVJPmW0j4G6kqOQHBoqOJcWXsuXTNw3WoWML6uVG00VkwIV0cPjdFQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787070112; bh=Pv1SgrrTFSktf+DJS5h7m8JBwPE2cb4JXvylU04LUhm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PJzpP52gKU7fufDodyZTGFxNOcRkkqHxJaoqxZ2X5eIuyyOhByCi7pryHc7PlUv8i76dnzzy6VWBLuLczRasmcilKEXGg164flDeQ65McA9VezMSsprbLEtn1wqORAA+F/YuXc3NrtY7VsEgONSK0TrGBso4+a+sTiia9FMYQpYIrXTrpJHoDlO++sqpXDZG+guq7dHF9IWqBYzf5NT80oGDdnQ12NVX4i0KqMXs3qxEOhn2s4ENodZ08bAe03cn0mj31w3AJT1uKkM78/HZIqalcJxj09FCAHoRqNiZONql/6ArkvgRjJ424KuPtxk4vM7r+eveWgepB6BbHm1beg==
X-YMail-OSG: QDoeHSsVM1llHnSnd_ELAm4j1N_IToBb0NkE_Fvlu2UMjtXRnAouc8LFfyG3B.L
 PtybOOUBtmyt8npD2IszWomPv04sjfIhU1JB8p3p8qzP.LnzhZNPq1cgo7P5In4hYfMKLNxKuYLZ
 mP.YdMgzTzWyGiTmD65FBN2759GvC9E8QYjmcCeKFuoaBBeCb28Pum5GlD9xlGO5imG_ctS4m4Ib
 ggyAW4PMxR1y7eWnMCtNlBpkfMxJ8Hf9EqNUcivsS6rKzrR1Lul1kiXg03SFtEwY7VyViRxSPPwc
 tHLzmDBidZOlX0BOWImTLe45T3Ak8RQEbrqDb5bw.dLXmJWnPEBRfmAKusPhT.CWmG5X934yIz3D
 iRoSWBjB9lpUgTrVNUlDvaFtsFJxAUjIPQqwEsBQaH.JB91nex1eZpdz1KDg7RhEtACuhsg9Ne.Z
 JSgjsaqK6hRbj364lTyQtWsqks6LP6BMHH264Mz9JC2ZAvFRDEVAHbsW7ssgEZmT86StG3gQPA86
 7ZsqfXitXC1mEIHKwRm5qVed.hf5YCG1gk..PdPh4IrxyjofmFAwHo8ZBTdpmbGLaSrFq39gdylx
 hAAhs8a0SxrmwveCqJ_z3KoVtX5j5m7iaVfAqm4Q4OUCXVl6NhTqgsKLRs7qpgpXXHw72lFSGzwB
 4dttTVpbOQbHF5sytpdm.degUuaX8MkUVhN8BFf6xsQS_2i5o65bw288dAanp2n.2ILOLClFmjvS
 y9aATExlGtniNxa2fGUFeE1h.tvRircTnHzmSUOI1eVvYPCqJM.YjMBM08mYFzfUu.WKqUvjehUf
 s8NDMcrVUdBa0vyecRsaBS9gBlAIlkv2ftZDb3RoPdZQ1wKJ1THrJ33.MaASy83FLjVW5FJGtpR0
 AzUXCqF9YG5kSfCRWtu49UwOh1GWGEqWCPgx1KuljFh48XPMt.ZUMZsBVpwCbMx2C4ERiex5RFsl
 s_cs2O6nDEuxLAm56kdC7N55Q5DVyL_p8nZZzodrXLvnR8t_Mn1fCWhVzYE48Lir6r2NoFm93RHy
 aIHtDqcYXgocySHjLa77Rr6ppyorCqA5iIz7g82BUSZ2A_NrwtogZ1GUzPmeR3g4yeU_6SfS4KSk
 Ak14bXqXiotYXeDO3F1UFUOpeiVjEYGDB5tpHmVVqXVMybSTT_rJBeQo4Q9xazDlwzMEeBu7Eh2H
 7GeBnwhYoOpMEqJIEWLufq23oWvhhB8rUjoO4i5BGMU48WIZXXFwq50AJSjvhrNY8qnDYT9RKmb4
 v5gOYthyKLTSAyGw2Is1CY0kPOS78LfO9IbCpf1No3TgiH6pzcP2_666MsWoywXFVg6Z3d7Vr.jd
 i.l7qi5ykwgL0uZ5M0LlE8FlGBn6O6Z34k_ifA6A1d.1SXqTAVEAiS9xvAqkz6y6ayWlqyhmqU6K
 OEJtcn87LDqVPPArFqti1yuuR8ijIlvzP5J_Wg8VwwpCSmuJKPWz9ehM5okteHmnPhFXLH5elGWD
 _5BmVD4qyjvLsv8PERNzgd9FdkiwJMurlJidAbkAf0ES0drn4vrBUAYw9N9mtVGac_ubeOysV.Wc
 k6UPeIy2v4TjGZbcM3LGkCwHrICq.k3BqFw0FImqwS24Uo_KRqxgFDog9P.OZfL6aJJTkG23PxER
 VgR6lFQ3XbhY1vYEz0Lrpqb.mjVXO7L_fTE15_jt2va7frG.B2f_89a2D4AfJISyo6rnFk6K99jU
 kPF7AQ1e9iKUMgObCKET9t.IUhD4faoJ0iRBnG2UlJgnR292gQNKz87eK2sRi0W8qHahM2_JMorp
 9mXrl6jmsOJKEAWvQ7HrtmXKkrYKHP_SX2n.RcdLjUa8k6tem98HXJqyvvkPVe7wgDR7IG_P.FYw
 lVs9iRcz_DxKhGSzv1S3DllWh0XIMvuw9Tjqll4wWezSlKwXgctYLwXge1IFJdCoXqGnoXXnHPTu
 BO68OqXRSO6qUGnOuqY4LIfxoe6ED0RtpqV.UNbdyfe2blWfweuW08VAmbE_XGhU8PU8pmM.OogN
 apSjMvLr6ccM_sTM_oXglpM5l39UoVqh1ZjCRB6YE5cgFgPXRXf7RE3VaKQM0sVt2dQP0gi_ptrv
 rltp1O5692Lk009zCPRo7OH7JFmI2i67HSLWygsTesiFCNKSCxG.BDusAGeSqPj4BNIGvGkDrUho
 DeHVRUtR5EIEJ4zm6d6rWrbNZqKShRCXLb6I8vyDNffoQnGb09VywbuEzSkZGClHuQ9o88SgUDl2
 2bOoMK1._R4qqwdpnfWGh.tvyNqKG8_d35HiqaI_eQNVF9F_OwUYqtfw9p_Gis_usDFuXCyZD6vQ
 DGT_14MiDOJsU
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 52ce4b3c-3fa0-42b7-84ac-90f377d9f70a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Aug 2026 16:21:52 +0000
Received: by hermes--production-gq1-678d9dd684-94j85 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 86e59a4b97672551aa7f4d0bfadc3a05;
          Tue, 18 Aug 2026 16:11:31 +0000 (UTC)
Message-ID: <d0cf31df-05e6-4d77-b6a0-ce6c2c7c009d@schaufler-ca.com>
Date: Tue, 18 Aug 2026 09:11:25 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] smack: add file label preserve mechanism
To: Tang Peter <Peter_Towne@hotmail.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <TY0PR06MB49571F55B361203419222EDA81A62@TY0PR06MB4957.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <TY0PR06MB49571F55B361203419222EDA81A62@TY0PR06MB4957.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26254 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/18/2026 1:05 AM, Tang Peter wrote:
> Subject: [RFC PATCH 0/3] smack: add file label preserve mechanism
>
> Hi Casey,
>
> I'm working on an embedded Linux device (MIPS, BusyBox) that uses SMACK
> for mandatory access control, and I ran into a problem that I think is
> worth your opinion on.
>
> Problem
> -------
> When a user copies a file with BusyBox cp, the destination file inherits
> the *process* label rather than the *source* file's label.

This is the correct and expected behavior. A process that creates
a new file has the opportunity to put whatever data it desires in it,
so the new file has to have the process label, regardless of any labeling
of the source information.

Cases like this are why Smack has transmuting labels. Without more information
about the specifics of your directory hierarchy and labeling strategy it's
hard to offer specific advice, but if what you have is a limited set of files
that require label preservation you should be able to use that mechanism.

>  On desktop or
> server systems this is solved in userspace -- GNU cp has
> --preserve=context, and SELinux has restorecond. But on an embedded
> device with BusyBox, neither is available, and the result is that the
> source file's label (e.g. an untrusted "USB" label) is silently lost
> after the copy, which breaks both access control and audit tracing.
>
> Proposed mechanism
> ------------------
> An opt-in "preserve" feature controlled via /sys/fs/smackfs/preserve
> (default off):
>
>   1. smack_file_open(): when a regular file is opened O_RDONLY,
>      record its label into task_smack::smk_preserve. Shared library
>      loads under /lib/ and /usr/lib/ are skipped (path-prefix filter)
>      so ld.so does not pollute the preserve slot.
>
>   2. smack_inode_init_security(): if smk_preserve is set, use it as
>      the new inode's label and clear it. TRANSMUTE still takes
>      priority, so existing transmuting-directory behaviour is unchanged.
>
>   3. The slot is one-shot: cleared on use, on fork (cred_prepare),
>      and on exec (bprm_creds_for_exec), so it only applies to a
>      "read then create" sequence within a single process.
>
> This makes `cp a b`, `cat a > b`, and similar BusyBox workflows keep
> the source label without any userspace changes.

I have an evil program "ecp", which uses this mechanism. ecp opens a
file labeled "_", and creates a new executable file /bin/xyzzy. It then
opens a file labeled "somethingelse", which contains a malicious program.
/bin/xyzzy is filled with the malicious program. Now, processes that
have no access to somethingelse are exposed to the malicious program.

You could restrict smk_preserve to programs with CAP_MAC_ADMIN, but
such a process could relabel the file directly, rendering the mechanism
unnecessary.

>
> Questions
> ---------
> - Does this approach make sense for SMACK, or is there an existing /
>   preferred way to solve this that I've missed?
> - Any concerns about the one-shot slot semantics, or the /lib/ filter?
>
> Thanks,
> Tang Pengke
>
> ---
>  security/smack/smack.h     |  2 ++
>  security/smack/smack_lsm.c | 45
> +++++++++++++++++++++++++++++++++++++++++----
>  security/smack/smackfs.c   | 50
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 4 deletions(-)
>
>
> From: Tang Pengke <peter_towne@hotmail.com>
> Subject: [RFC PATCH 1/3] smack: add smk_preserve field to task_smack
>
> Add a smk_preserve pointer to struct task_smack for recording
> the label of the last file opened read-only. Also declare the
> global smack_preserve toggle variable.
>
> Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> ---
>  security/smack/smack.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 8ad30955e15..c6eea57cf52 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -124,6 +124,7 @@ struct task_smack {
>       struct list_head  smk_rules;  /* per task access rules */
>       struct mutex            smk_rules_lock;   /* lock for the rules */
>       struct list_head  smk_relabel;      /* transit allowed labels */
> +     struct smack_known      *smk_preserve;    /* label to preserve
> on create */
>  };
>  
>  #define    SMK_INODE_INSTANT 0x01  /* inode is instantiated */
> @@ -325,6 +326,7 @@ extern struct smack_known *smack_unconfined;
>  #endif
>  extern int smack_ptrace_rule;
> +extern int smack_preserve;
>  extern struct lsm_blob_sizes smack_blob_sizes;
>  
>  extern struct smack_known smack_known_floor;
>
>
> From: Tang Pengke <peter_towne@hotmail.com>
> Subject: [RFC PATCH 2/3] smack: implement file label preserve mechanism
>
> When smack_preserve is enabled, opening a regular file read-only
> records its label in task_smack::smk_preserve. On the next file
> creation (smack_inode_init_security), that label is applied to the
> new inode -- unless TRANSMUTE takes priority.
>
> The preserve is one-shot:
>   - Consumed immediately on new inode creation
>   - Cleared on fork (smack_cred_prepare)
>   - Cleared on exec (smack_bprm_creds_for_exec)
>
> Shared library loads under /lib/ and /usr/lib/ are explicitly
> excluded from recording, so ld.so does not pollute the preserve
> label during exec. Non-regular files (directories, devices) are
> also skipped.
>
> This enables tools like cp and 'cat > file' to create files that
> retain the source file's label, without requiring any userspace
> changes. The feature is disabled by default (preserve=0).
>
> Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> ---
>  security/smack/smack_lsm.c | 45
> +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 11f238e94..951c79d9e 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -935,6 +935,7 @@ static int smack_bprm_creds_for_exec(struct
> linux_binprm *bprm)
>             return -EPERM;
>  
>       bsp->smk_task = isp->smk_task;
> +     bsp->smk_preserve = NULL;
>       bprm->per_clear |= PER_CLEAR_ON_SETID;
>  
>       /* Decide if this is a secure exec. */
> @@ -1066,6 +1067,15 @@ static int smack_inode_init_security(struct
> inode *inode, struct inode *dir,
>             }
>       }
>  
> +     /*
> +      * If a preserve label was recorded on file open, use it
> +      * for the new inode (unless TRANSMUTE already applied above).
> +      */
> +     if (tsp->smk_preserve != NULL) {
> +           issp->smk_inode = tsp->smk_preserve;
> +           tsp->smk_preserve = NULL;
> +     }
> +
>       if (rc == 0)
>             if (xattr_dupval(xattrs, xattr_count,
>                       XATTR_SMACK_SUFFIX,
> @@ -2064,6 +2074,27 @@ static int smack_file_open(struct file *file)
>       struct smk_audit_info ad;
>       int rc;
>  
> +     if (smack_preserve && (file->f_flags & O_ACCMODE) == O_RDONLY) {
> +           char *buf;
> +           const char *path;
> +
> +           if (!S_ISREG(inode->i_mode))
> +                 goto skip_preserve;
> +
> +           buf = kmalloc(PATH_MAX, GFP_KERNEL);
> +           if (!buf)
> +                 goto skip_preserve;
> +
> +           path = dentry_path_raw(file->f_path.dentry, buf, PATH_MAX);
> +           if (!IS_ERR(path) &&
> +               strncmp(path, "/lib/", 5) != 0 &&
> +               strncmp(path, "/usr/lib/", 9) != 0)
> +                 tsp->smk_preserve = smk_of_inode(inode);
> +
> +           kfree(buf);
> +     }
> +skip_preserve:
> +
>       smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
>       smk_ad_setfield_u_fs_path(&ad, file->f_path);
>       rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
> @@ -2129,6 +2160,7 @@ static int smack_cred_prepare(struct cred *new,
> const struct cred *old,
>       int rc;
>  
>       init_task_smack(new_tsp, old_tsp->smk_task, old_tsp->smk_task);
> +     new_tsp->smk_preserve = NULL;
>  
>       rc = smk_copy_rules(&new_tsp->smk_rules, &old_tsp->smk_rules, gfp);
>       if (rc != 0)
>
>
> From: Tang Pengke <peter_towne@hotmail.com>
> Subject: [RFC PATCH 3/3] smack: add /sys/fs/smackfs/preserve interface
>
> Expose the smack_preserve toggle via smackfs. Reading returns '0'
> or '1'. Writing '0' or '1' toggles the feature (requires
> CAP_MAC_ADMIN). Default is disabled (0) so existing systems are
> unaffected.
>
> Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> ---
>  security/smack/smackfs.c | 50
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a3a55a25360..8379ef73cf2 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -62,6 +62,7 @@ enum smk_inos {
>       SMK_NET6ADDR      = 23, /* single label IPv6 hosts */
>  #endif /* CONFIG_IPV6 */
>       SMK_RELABEL_SELF = 24, /* relabel possible without CAP_MAC_ADMIN */
> +     SMK_PRESERVE      = 25, /* label preserve on copy */
>  };
>  
>  /*
> @@ -2047,6 +2048,53 @@ static ssize_t smk_write_onlycap(struct file
> *file, const char __user *buf,
>       return rc;
>  }
>  
> +int smack_preserve;
> +
> +static ssize_t smk_read_preserve(struct file *filp, char __user *buf,
> +                         size_t cn, loff_t *ppos)
> +{
> +     char val[2];
> +
> +     if (*ppos != 0)
> +           return 0;
> +
> +     val[0] = smack_preserve ? '1' : '0';
> +     val[1] = '\n';
> +
> +     return simple_read_from_buffer(buf, cn, ppos, val, 2);
> +}
> +
> +static ssize_t smk_write_preserve(struct file *file, const char
> __user *buf,
> +                          size_t count, loff_t *ppos)
> +{
> +     char data;
> +
> +     if (!smack_privileged(CAP_MAC_ADMIN))
> +           return -EPERM;
> +
> +     if (*ppos != 0)
> +           return -EINVAL;
> +
> +     if (copy_from_user(&data, buf, 1) != 0)
> +           return -EFAULT;
> +
> +     if (data == '0')
> +           smack_preserve = 0;
> +     else if (data == '1')
> +           smack_preserve = 1;
> +     else
> +           return -EINVAL;
> +
> +     return count;
> +}
> +
> +static const struct file_operations smk_preserve_ops = {
> +     .read       = smk_read_preserve,
> +     .write            = smk_write_preserve,
> +     .llseek           = default_llseek,
> +};
> +
>  static const struct file_operations smk_onlycap_ops = {
>       .open       = smk_open_onlycap,
>       .read       = seq_read,
> @@ -2933,6 +2981,8 @@ static int smk_fill_super(struct super_block
> *sb, struct fs_context *fc)
>             [SMK_RELABEL_SELF] = {
>                   "relabel-self", &smk_relabel_self_ops,
>                         S_IRUGO|S_IWUGO},
> +           [SMK_PRESERVE] = {
> +                 "preserve", &smk_preserve_ops, S_IRUGO|S_IWUSR},
>             /* last one */
>                   {""}
>       };
