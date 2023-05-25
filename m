Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CCAC77B7A
	for <linux-security-module@archiver.kernel.org>; Thu, 25 May 2023 17:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjEYRNq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 May 2023 13:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEYRNp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 May 2023 13:13:45 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C2B6
        for <linux-security-module@vger.kernel.org>; Thu, 25 May 2023 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685034822; bh=hs9ReKfTAT08nFeSUhxuaor94N253HxepERRtSwqFA0=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=BcSzE5+XO81tAE3FpCNABOeF6bCjaWHgycdawP5t7Li+0ODV7SvVkNIeu24taEQvOlGnbqZirKtMPKxJH9R6zds0Z3D1k+ujEtgfpqnMEBrFTc26c/JsfMfq9ACb7alA/CPs2mIa3W9B65hDBInwffVwCT2udxL5zxmIswKxCd7JnTU4QKzbwhECmDSENTXdExyZeXEGBYL0NoAoSdNal9r1XlmchY6rMsquYv1mPb86HAERatE2bG/QyPQgQEndwu4e1jYu/giw0c+KIEyaffKujREFvho2XIbz9PcQ4wEjF2guAs54bfsvtwG96h02TVy7FAcrRBU5AvIoNAyjBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685034822; bh=R7OkZVrvQjCPD/fkC291GF0AKuc8SqqQG+yu0sERzm+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZqTfns1145aPaqCFSfnG6EjF2PHYq+Aibr5KufWkGYdPrdqyh1u0c0CXep2YWuWnJxmbKTx/1On1vtEkaAVtf4QkqYQz7HTeuGmYrceg+exXFVRmnbkADlcusQOawXvuo3oalCNnZ69Dd1se+nIpCRo0JU5nVplwYbCCbGSS/64su1EfcB9RIAiJpfd9wYCG+NykU9/c2e3zdvyEvqUz1IxI9w0iQ07HmCOHrNUpcSzppik0PZAbHAx1+Cme/tEcHjZun8M/CoO/q81rDo4YRr5siUUXwYKjvytRhR+nQQr12Ubr6liTgKfojsNoFN6tf9S5A6D0oo+g8RbG+yhpMw==
X-YMail-OSG: cjL07tgVM1nXmicf_J0tvl7Zmm4kW4e5b21Zv.7RpGKPvWuCvvcQ3wHloHfk.Y3
 Ua5yqrGMGBKpHlgr7SPbjU5uzlSTZR06b4JIyEoqktzO8Ln.AjzESnHbSeQwDddjdxu6EX74HMJc
 Qg3e6EOZtpJn7v8paqr.qwwLPk0mPnpvHPnQQpRXhfxA_jRcTV5oX9hNKLPPzzlSx7S_4XUkds9V
 NkIC7owNC7fQBYgfDc7uwQv4XXPCXcm712SO9eoRmZ18_oqSEPk7HtgJuMZ8G1xuZy._ZCzHTWR6
 YcSelQfoLnc7G84g7Fdb6vNglvg_BbowoYe91G4e1OrMswCoALbYR44.b7GtyxqBRvH76auFuImU
 9p.eT1ozdDSpsomZ7Uv9nCfLSNHHmbNy2v8ztcdnEH9pT388lz30c7tPbP3i2xlBaF9pkJiJNmMm
 sMa2uiQm0.s9Xht5Vw8jmLCYW.nXwHf5aYW5MVJ7NIBRsrcZ29f9gmIrSHqpmo_UhT62AZIDcdwX
 Vbfden.qfnD7pb.D3HJS6Xo3GyIQLseRhiXgt_.xD7_VFEGw0o5gU7uxU1JBx5y6PftJqe6A8yEd
 iGHVSlZYxudQUwablJ5upM5XzjO0o6c65JFQ_5s6_6Ab1Wofuq9.o_fQFuvecKq2_sXeQRKRdiQ9
 suQjTdrMZh0pY7lQ3lQvrUUtC3hLGr0NyGfDxFWkk_ViqQm_qUNfzYkFZyp5zItqvwWabjeUKJs.
 uz1phPPifojm1XaZM4D.Oh9TdyrTiwG7rbhlQsCQ66t3O1Got3LW8PAflsjj6DhMiii1mmTnoXfP
 d..h.tpN1I57RATIJe5cXZwA8jgFF1ZsKLCJx9wH9Bk9EcaoKGifaedCgLdcT4_mYSLpZCVkHuUT
 9bNdGcKlF6xEJ17QCRGIKaBgX0zjk8Zo6Vkp.S8YTV6C.dU.EpTZr5T.PLxyYn6jzPhIKZZsS3oQ
 VVUuKcmuU16pBIUAzFAIOKyXFQdktdHwuOjtv7rZkZwePpEtbeYU1Wc5Bf1m6aMLaKZ8.1p.SKvY
 0Z.3VzdA3RlLsDRkapasKgelOoxkAuyi4filpyVg_uWxYsDZdKq3cnSE30re3Dtn.qlqnYR_RO2b
 Fhfh4zd9.k3eBqhQRj.P6R1mY..w5vydTop0.MmdrH8EkR.oCB6i9yzW9nGsUROF_TWKNBsukeaU
 Wz_yZpGuo0CxmMqZxID.QdeDqwNxMuJ.5JCwyDp1D.43gLrwab8m9fAzDmrIjlu1.S4GK_ln0VBM
 _WPjAJksFdXWjm2Qhq8kMNgmGVopi4qhSPXNzuC54d38jKutD2rPHpWn.g6KFsp1Z8UPEhjTwpyD
 WJnqtd72od86iFenWHo9gcSmB4hbbnYpetP6H86LpUuGRplQtzdYOEE1XNIGhKeK.P0nsLKB5jNw
 ad3aVJND3dVQ_Gffj44jf92zZY9YZazihJSBYEo2AwR3_eJReekKQ9Ubf1e56U56k6FZBJ6A52ix
 NgfrCJZfJXfbUpx2Af4ZsE.uLmgNScGacT4dSJ0qSw1nm6znP0VWQmcdaeWZtUUHL22oc9H.hI59
 O1SYH8jhmYlJcNjHUblfp28AHUHAlHob9ewVN2dBtacti2WUy354G9brulfWUJ378nnZOhiXkW9G
 LWZ9kBmC6XTe6dKP_fQrz_Bsp0vIpjXV9Q4C_k58vGiCzF6VUiKkWHJm2ELfWmveiOO7QeZDs.Fd
 98s14eRYoOxyIZBhLMUYLFQGPEi_hJ3WpZXSI5xmCwg0k7xPqNgkYoJgLzu7YM0qmxlVCSkJQ8A0
 o.bYCvdxsFKpI2UyLH8d2TPtdMkStuY_MXzvE_seOCaZIQ35ziSRB.ujUB.dOP1uKGHTbFn.ZFTD
 qUUD6DGcEZ1dS1n1_6fVvd.legWDsF445cxzNOEy1SdRx.iNRIFyRZ8zMBNymAhykQpH_JboE1d5
 R5SBdMJ_Y13Ji4WDvQk72Kqlq5kkrGYwOGq2_M672fqD_ye9ikDXMgaRdhReTHG7mSzibUg351SS
 qp4rj2mj4Nq16Nj1CYXX17LisFBciW4ZjCpo7Yzrcz_Tp6JmsZk01fRPf_4QbndVh_tL2esRtpvL
 DQ4p0WIQFtzUzbQreHky6fGfQOwd1bsxo8zRUuGHfQZVLN2Yi_nyE4a06Qnl6sFWa0m.7Ogy8i1O
 DWOU.vjXF9GNEcmbdhVjj5DdZ9qpz02jHzCaBasUG_kFWWo1GrXHAhkHTgJyoCfosZUp3xZv6qEO
 VefqaBoLhcKYMb4zyFftgOjoMPlS6xqMI7W_Nt4ZFq1Y0mXoqWljBerHcc13UpU8q7GSoxyTwTwl
 ggQsR74HbpFDIpA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 76cd180e-75e0-46ce-aab8-4fd632e13bd6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 May 2023 17:13:42 +0000
Received: by hermes--production-gq1-6db989bfb-dbflh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b3f7ebd7169e40f5a3d2176e8a2b1697;
          Thu, 25 May 2023 17:13:38 +0000 (UTC)
Message-ID: <cfb03ccf-8d55-0290-0333-aa85dcc71a4f@schaufler-ca.com>
Date:   Thu, 25 May 2023 10:13:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] lsm: fix a number of misspellings
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
References: <20230525031953.105125-1-paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230525031953.105125-1-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/24/2023 8:19 PM, Paul Moore wrote:
> A random collection of spelling fixes for source files in the LSM
> layer.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/commoncap.c     | 20 ++++++++++----------
>  security/device_cgroup.c |  2 +-
>  security/lsm_audit.c     |  2 +-
>  security/security.c      |  4 ++--
>  4 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 0b3fc2f3afe7..ab5742ab4362 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -314,7 +314,7 @@ int cap_inode_need_killpriv(struct dentry *dentry)
>   * the vfsmount must be passed through @idmap. This function will then
>   * take care to map the inode according to @idmap before checking
>   * permissions. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply passs @nop_mnt_idmap.
> + * performed on the raw inode simply pass @nop_mnt_idmap.
>   *
>   * Return: 0 if successful, -ve on error.
>   */
> @@ -522,7 +522,7 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
>   * the vfsmount must be passed through @idmap. This function will then
>   * take care to map the inode according to @idmap before checking
>   * permissions. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply passs @nop_mnt_idmap.
> + * performed on the raw inode simply pass @nop_mnt_idmap.
>   *
>   * Return: On success, return the new size; on error, return < 0.
>   */
> @@ -630,7 +630,7 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
>   * the vfsmount must be passed through @idmap. This function will then
>   * take care to map the inode according to @idmap before checking
>   * permissions. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply passs @nop_mnt_idmap.
> + * performed on the raw inode simply pass @nop_mnt_idmap.
>   */
>  int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  			   const struct dentry *dentry,
> @@ -1133,7 +1133,7 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
>  		break;
>  
>  	case LSM_SETID_FS:
> -		/* juggle the capabilties to follow FSUID changes, unless
> +		/* juggle the capabilities to follow FSUID changes, unless
>  		 * otherwise suppressed
>  		 *
>  		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
> @@ -1184,10 +1184,10 @@ static int cap_safe_nice(struct task_struct *p)
>  }
>  
>  /**
> - * cap_task_setscheduler - Detemine if scheduler policy change is permitted
> + * cap_task_setscheduler - Determine if scheduler policy change is permitted
>   * @p: The task to affect
>   *
> - * Detemine if the requested scheduler policy change is permitted for the
> + * Determine if the requested scheduler policy change is permitted for the
>   * specified task.
>   *
>   * Return: 0 if permission is granted, -ve if denied.
> @@ -1198,11 +1198,11 @@ int cap_task_setscheduler(struct task_struct *p)
>  }
>  
>  /**
> - * cap_task_setioprio - Detemine if I/O priority change is permitted
> + * cap_task_setioprio - Determine if I/O priority change is permitted
>   * @p: The task to affect
>   * @ioprio: The I/O priority to set
>   *
> - * Detemine if the requested I/O priority change is permitted for the specified
> + * Determine if the requested I/O priority change is permitted for the specified
>   * task.
>   *
>   * Return: 0 if permission is granted, -ve if denied.
> @@ -1213,11 +1213,11 @@ int cap_task_setioprio(struct task_struct *p, int ioprio)
>  }
>  
>  /**
> - * cap_task_setnice - Detemine if task priority change is permitted
> + * cap_task_setnice - Determine if task priority change is permitted
>   * @p: The task to affect
>   * @nice: The nice value to set
>   *
> - * Detemine if the requested task priority change is permitted for the
> + * Determine if the requested task priority change is permitted for the
>   * specified task.
>   *
>   * Return: 0 if permission is granted, -ve if denied.
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index 7507d14eacc7..41fca6487ca3 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -421,7 +421,7 @@ static bool verify_new_ex(struct dev_cgroup *dev_cgroup,
>  		} else {
>  			/*
>  			 * new exception in the child will add more devices
> -			 * that can be acessed, so it can't match any of
> +			 * that can be accessed, so it can't match any of
>  			 * parent's exceptions, even slightly
>  			 */ 
>  			match = match_exception_partial(&dev_cgroup->exceptions,
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 368e77ca43c4..849e832719e2 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -200,7 +200,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>  	char comm[sizeof(current->comm)];
>  
>  	/*
> -	 * To keep stack sizes in check force programers to notice if they
> +	 * To keep stack sizes in check force programmers to notice if they
>  	 * start making this union too large!  See struct lsm_network_audit
>  	 * as an example of how to deal with large data.
>  	 */
> diff --git a/security/security.c b/security/security.c
> index d5ff7ff45b77..ee4f1cc4902e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2491,7 +2491,7 @@ int security_inode_copy_up_xattr(const char *name)
>  	/*
>  	 * The implementation can return 0 (accept the xattr), 1 (discard the
>  	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
> -	 * any other error code incase of an error.
> +	 * any other error code in case of an error.
>  	 */
>  	hlist_for_each_entry(hp,
>  			     &security_hook_heads.inode_copy_up_xattr, list) {
> @@ -4676,7 +4676,7 @@ EXPORT_SYMBOL(security_sctp_assoc_established);
>   * @subnet_prefix: subnet prefix of the port
>   * @pkey: IB pkey
>   *
> - * Check permission to access a pkey when modifing a QP.
> + * Check permission to access a pkey when modifying a QP.
>   *
>   * Return: Returns 0 if permission is granted.
>   */
