Return-Path: <SRS0=FLpC=6I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7254FC54FCB
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Apr 2020 22:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416F620736
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Apr 2020 22:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ryAr78Cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDXWTA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:19:00 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:44926
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbgDXWTA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Apr 2020 18:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587766739; bh=VhuXN9wU1AEcRBHiXEK3zwQDuORVA7RRtG2Y6ScWy8Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ryAr78CmUdt6CKgI2YpCF2B1VN7R6GiWRKlb6IqOz+0htUccmwjth3cjdqFXhxEDBmZJB23MyUhi8TR8BYwkSzv/L9qJTYHQkAnXkveuvrxLQyZ/6w151dmfw7M/u0EPZIqTlEm8WeYILN2o7JI0e3DF9hAj9ew33JeFnIIjLXFT2gSX5D2HGBHlxZ1eXAuJRL7Gz2v5EFgC9EjepOX/b0t11Rb5VsKG74/s5V3QrT+IEd5McNgvhsYDq+X7D2s1R3zcbspoYRFfINILjprZFtnfZWhCAeE5YVE2rPyjd1gi2aavTSACTaGS/H9rzW8cBxKlciWuIyrAl4QEAncW+Q==
X-YMail-OSG: IIA25s8VM1mA_VM.c8CNgdwWKBLfN8RsXuLK2koY7GU86hH9cpJc5sG3p1_gasi
 BDM2tktNa.RZ3zduxXjlr1Rc9UgS8hqMgXWhiDhx5iUjHvVLUF5B1G1sTdzKFlnRwKJY1n1r_78v
 xbz4OPTUkW8A4MAnqQDTSsMhQn5uMnFzvIgmTUbSu.KStNb3lfwbOd45K1Sj1kHYANIM50Ypwml1
 kdpmvHeEhg.JkWbDoYCpFbz8yT9i4V.weQ2TCBJqR14Oxt.IYYSM3miAZ4PPSaiEeokEFDZqLE4p
 V0tl2c7O9ffC5CZreK7JSF.xjUIyRCb49eh9VkNN78fK.b8EAzzgintYZivHIjoUN_30oUIa.Pgg
 WD0cmFgPq.Q1_d61asyg54iTsDaxd92VyX78FaKxj0.g.eR8Qoy4WvycgEpETkQoYCePEnUa7Zds
 q94V5S527s8C6xOEKHt7tMfMrMIm9jcFtnjeUWdU_GDmiuMylETbtM0JceTPhalceYvy5bCM3LKx
 Puf3rjQrQ68Br_4afHQ3S2uXaRB2Sdn0klTOIplsRc23qyDoLNpz33P.WuzhDW8r76FD8VipIy81
 IdRwD_J3WXjHQKGcVvg1yICF_jQ_r.c_krU_xFZnLixwCrLYhOQIrF0YGhHPxMYb7lOw0s6ya0IW
 G.pEpersMSwdmUkgQnk5QhmBanJmZRkQMWfFs80cNvxTHlJey6LJ1FAK4ooBvURbp.bwZewagOXx
 Jgp1k0tGGoG414qKoBYYh1zUnZYsrD9uU13hLr9GdjYe6RL5PFyjJzfCdvg6jS7RR_.Q5BnHJT9S
 EWN1UXd9zB0u_PpNVe3Z3Z_Ln8YPrdcWNhDbBDTZydo_rpqUdEm0ubp.5eTYIvTO1Ngm9sBvtqUV
 p7s5Cd4VfTC_zfgKZPQ9hx8h9Ctg1HgH3bjzUd5wmN_aFJhfP7j9TFMKkjJdoL77cP_rEQGd39eu
 PtEhB86S7r.aftbXFY8zSsYZYmFf4K83O5vNZx94nxilQ66ZlN.ak7M_Ne6AzxbER0EnmrACWRMV
 FP3KTzSg_.iaJ3oGlfkpQgYRKfAd33Hq3phunwgAvbLWZodtaacNBN4zNmMoYE6tODYA67wbI1Mp
 NWiPdB2H9AGU4wnxYvoNytEUWVJku9otXSgVko4kJxzQpjEnCv8leFhq0qAgba2wsknJebzjG_B8
 r35t9hFNpNmletcMqNDrP__tZmbiBhWSAnRv5TVXxQb6jgLTNK4H01fOLSYigUlVk_cmKZQelN8Y
 .0.rg4rfZ.oNjnQAklpeKE5BAmQtg_LMAUNjRkQoXIDAtAYNSFmANFs_bdKP3YiT.zaw5JU8xxJ_
 eRJPyaJmQgAmQl2Qn5ujXGtehrLC4CFHc8G7IN9chKNckXYDfqTPImZgxJtLdTbIzVhP6NMhDWtA
 y5F10dTDfSxRcN_IqnT0cF1ZZt9PSMdHUjY9gJg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Apr 2020 22:18:59 +0000
Received: by smtp432.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2166eff41b85c0728d73f27c26234a6e;
          Fri, 24 Apr 2020 22:18:58 +0000 (UTC)
Subject: Re: [PATCH 1/1] Smack:- Remove mutex lock "smk_lock" from inode_smack
 structure.
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>
References: <CGME20200424131638epcas5p300fec614f4a2d6aedc3de337cb3fd259@epcas5p3.samsung.com>
 <1587732920-49120-1-git-send-email-vishal.goel@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a4c51fbb-9f76-ea6e-0288-a46d5a2558bc@schaufler-ca.com>
Date:   Fri, 24 Apr 2020 15:18:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587732920-49120-1-git-send-email-vishal.goel@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15776 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/24/2020 5:55 AM, Vishal Goel wrote:
> "smk_lock" mutex is used during inode instantiation in
> smack_d_instantiate()function. It has been used to avoid
> simultaneous access on same inode security structure.
> Since smack related initialization is done only once i.e during
> inode creation. If the inode has already been instantiated then
> smack_d_instantiate() function just returns without doing
> anything.
>
> So it means mutex lock is required only during inode creation.
> But since 2 processes can't create same inodes or files
> simultaneously. Also linking or some other file operation can't
> be done simultaneously when the file is getting created since
> file lookup will fail before dentry inode linkup which is done
> after smack initialization.
> So no mutex lock is required in inode_smack structure.
>
> It will save memory as well as improve some performance.
> If 40000 inodes are created in system, it will save 1.5 MB on
> 32-bit systems & 2.8 MB on 64-bit systems.
>
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
> Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>

I am taking this for 5.8. Thank you.

> ---
>  security/smack/smack.h     | 1 -
>  security/smack/smack_lsm.c | 8 ++------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 62529f3..fd09dc8 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -109,7 +109,6 @@ struct inode_smack {
>  	struct smack_known	*smk_inode;	/* label of the fso */
>  	struct smack_known	*smk_task;	/* label of the task */
>  	struct smack_known	*smk_mmap;	/* label of the mmap domain */
> -	struct mutex		smk_lock;	/* initialization lock */
>  	int			smk_flags;	/* smack inode flags */
>  	struct rcu_head         smk_rcu;	/* for freeing inode_smack */
>  };
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 2862fc3..10c2bdd 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -317,7 +317,6 @@ static void init_inode_smack(struct inode *inode, struct smack_known *skp)
>  
>  	isp->smk_inode = skp;
>  	isp->smk_flags = 0;
> -	mutex_init(&isp->smk_lock);
>  }
>  
>  /**
> @@ -3274,13 +3273,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  
>  	isp = smack_inode(inode);
>  
> -	mutex_lock(&isp->smk_lock);
>  	/*
>  	 * If the inode is already instantiated
>  	 * take the quick way out
>  	 */
>  	if (isp->smk_flags & SMK_INODE_INSTANT)
> -		goto unlockandout;
> +		return;
>  
>  	sbp = inode->i_sb;
>  	sbsp = sbp->s_security;
> @@ -3331,7 +3329,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  			break;
>  		}
>  		isp->smk_flags |= SMK_INODE_INSTANT;
> -		goto unlockandout;
> +		return;
>  	}
>  
>  	/*
> @@ -3466,8 +3464,6 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  
>  	isp->smk_flags |= (SMK_INODE_INSTANT | transflag);
>  
> -unlockandout:
> -	mutex_unlock(&isp->smk_lock);
>  	return;
>  }
>  
