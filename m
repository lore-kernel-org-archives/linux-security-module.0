Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5501C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Nov 2023 20:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjKJUXf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Nov 2023 15:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKJUXf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Nov 2023 15:23:35 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9179AD64
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699647809; bh=FgjNztkVcZZOmT+0/XsvuVgof8d2g1r2FD0YEwEXChw=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=kcfAeAFnrXM1OStZGsHWb/HGKyYXjN0e4uEH/WR4KPJotuI181QO46mf6O8Hb1ms7cL84h7wuJYK/l2stUsm1NNGxcgVHGtE41XWfYMpVCeu0Ib8Nq9yEJbf+iByyOEMIXbafAuaw8BMn5UBMpK5twNxWN5fphHGPkQLYZQk/3m+gU18hMTZApiVQzfbmIPaxHmW3QDhTHhZ6Pp11WXmOFWOOXj2qc7ChG7TV8qRmx+x09ZZlBWXoHRzT4b7A3C9oo4cuGOAJYJrJhwjzZbWXIMbLLU5JAW7Gxb4TYpmcL9auf935JBDyuYqB4ANl4YqI3E0Gw3qA5CXrmuj93uMRQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699647809; bh=zOtNRbnCFoc2zJNlOmj8yEU5sHREinfH96zZYBXHB6s=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BC0wzaZm9iI+BR+MjkA5zWkK7/+87OCVWplV/A0sqMCVBM/MpYUklVTKh+X3rDbd9yw88jW/ampGNfAGoPkxUyP1pP6p31TP8Q2vl6mw4cSIDatAG9Ro6ryKiPIJXWSNOyeVAf1Fv1DNR64pRoKLkQJRUcDJlg1NMeWCOsqWI2kYoYfobgA4lSVRM2Rr+xhgubkq7ILd/JUfvff/gCqCrXwa4RkEO8ccePR6yTy3z+eO0ImJQJGdo20sQFpg+6zspagsZm8ywJuCw2sdEG992z07bBHYhWiIjrrgbZQVmrJ3zN/BP/FAAf8GxfuZL8+2zasW6M3L22YZQSNdNnrY6A==
X-YMail-OSG: ODEhGzwVM1kVRLkt_WlLSRDYtTaPugfuTFvredoJDatqehxjl9LnquhdVqs7uDh
 pZ_SWeKw6W_N9b6YIhPX_phLolAvPAi3B6H5FDaBk.g1p1QmMFYssVUVrCRYn0TquaDXZI7L1GdK
 36TjZyD24.yyC9eu5yUx2uxDBWziIO.fWMx_jsxA4tr11nhc3iZ8_07Ga4YtP7YzZ.5MQ2YlskqF
 iBxff9HOhCeG0nZI2xQSp76cBgBSdCxrX7YAflzAuNLRcqHZQNpfiscX7tcJMEmdZxiaanD5qVhg
 XkVAtUOF1oXYAFBLUp2c_.7MdNWQv8TvPzryAE9Eo7hZx8BD_jo5o5tRjCVHOwbce.pDpqdzfF9i
 sCF.lphvn6FuSMXJxmFenAcM3b8zm4tIP.TE.a_6pieAEUzk6JG3e_oLvIvU2YijMMW3rZd7K..g
 5OqJpHKBe2EmAS1zgeQOMmzkPk94RyRhw.jPInf3vB660Wzv.CGT8L0Wb6okp1AfzQGfJsF4YG_P
 _tG1_V3z5lM.ptACM_nUDInWlWi_8WyGJVOTSldCGEDC4GDkVtT7E5GlAXZqzsOZaVTAorxgWUw0
 QUQfq7.O3CTDIEwfWXC.GIK.4ktHbKQhjCx24oRYJ.jfMMWgduOMAOhSYp_CHe8JqBBLD4o7FPj3
 53Ffh43F5WzOdVoq8nrPzEPTNm1V.JmKR_u39gvWhHYi.O8QXch5P9CoVEcW9iW49Kb.W4EkpbPx
 Sj0z5RigoZf8..Xed3frM_NDbS56zLjgSSqB2aXEOnSYc1T1MxLlJI5ncAaXHldGUA1U6ywFyWZ_
 r3PqSMCCS2j9TtGMoVLvbg74qwXAWqFWCQ7s0wKhphJpH0CGKS93OTHUSR5xl7D3XkWPHS1vQwWz
 cFCP2hSZYKAqM8uqxXzLbnt3AOJQ7UefyRSsnC1NSEPaGeQJXkHUWomLj92oyaPACZ3fTQU7rHY_
 poTFcxOeNm5nn0cUsk9VVZBnx5hDlO2fUiU0XJ.C2zFW4ZT8XvNvLWL7L_Ui.BMK1nNffHWozylP
 z6aO.rSEjfBj_3w_lv3L1quXYerqrNnuwLazfp.xuEOCrtPBGs9iCW0PMK7a00g7NXoWGOM1b862
 6E6ALuMVMbJsWmPSo5vvMK24g3yaZ26iPqBGSGXIWLi4t4uXFwAtjNL4dQ5Ie0._0JFlE4Yfs0Lo
 mp24OgviM4GAYMmOThdNWx1lSCJXT1Iaro5WGqNO7Ctvqex36AfWsX4wPqZLA3NdVMfYrUyQ1Qkf
 uNQM_CTy6hg6abWyAtHoip94yxUWwV6Y_FIOda9fzLM8P1Cq0cTe4d4wEdut9wPM8xJPY43uQ_jQ
 T8wKxnuCprzDdD8td3p9EnbFHv97KWFoSlkAFsZ0WFsWbwnLslaxy46ByGlzvNsFV67OtF8lv5.C
 HdqwiPnSmWFhh4UptFJe1WhsNfscZgetO8UOBEyBO9zUw1EDJ1h7ivASb9hT2bf3rscxDj73jHae
 uj5mncfxkWliSmFwmJrhi8WDh4IUj3bgPxw7xpt.SVw2B9AnMxs4RW3TWpR1PGjfimrCppq.Ym1F
 kv9fPot_5cMQ2WkC1nKIuz_sffAacCcldB6C_7AnVN6hPnK3T9hBB.eVS51BlD8urBl_HHemaIjv
 exlcrDr18uUiRKoT1loobbbqUK7bvOeuUh9c.gHroJ9_wjDFzMxkpcMlqOO_DIXO_U7upvBC1UZJ
 CO7kWrvCybqGEv1cKsJ7XGvzEwf6fMg66CaJQCCn41e2MbQa5nX3sRWHVAzEfom0IiJCpbpWLBWF
 Ium5R2P7ZHaTsE4HO3_KgGpo3kM.Xx26FSQUsFEctG2rcofubbr3ceGl9PTEGqSY9RER7qbUrlZo
 f5AEwyISLF0vweXYp.IX_sNJe0V_Lwlx8CFD5qB_N5S7Jq1UmqbRaugjeZeBTFhkdz2G3mvAkXwk
 yzArGJ7PhAexmlOqOfDmwkPgMu5KFDFQx5V5W2mFbTS.2d7wpLGnf4JL_NxH0Q3xU7wPxfLAO3Cc
 MaPRtI9NsR.A6ZCIxCW9eP5AUjfdMpumK8fWWWxDEuH9OHV.A2SiwSS8gB8mp9ghFKXkC3x36fGd
 RDHsDv2P.Q9CQ7L_kS_4ovqtpMm_ktWM1r38VFFpwVKDJb0KUiNdbqxO3lK7AVJ0YD9r8KBPtZl5
 uSf_U2qvakWZpTZ9RnYp8IvpDQP2whbjQqgJVItc3TL4Jb6GkcQXBcVmzymkmA8RCZqi.U8C7iIc
 xUENM4eG0ylVkfYAE7G1Hoc0kqu_mdxDu6J4oA0Se_ZeftcYzrm_cxJEnIs4sFNByT4MxSovYifY
 h_mxl
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d8fbacfb-bad1-48b2-9e50-181746af7092
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Nov 2023 20:23:29 +0000
Received: by hermes--production-bf1-5b945b6d47-tqjmf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 80cede5cb8b29e5d7dc09b4409cc38d1;
          Fri, 10 Nov 2023 20:23:27 +0000 (UTC)
Message-ID: <b32a3279-5c2f-4ddb-b400-09681276cf1d@schaufler-ca.com>
Date:   Fri, 10 Nov 2023 12:23:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: mark the lsm_id variables are marked as static
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
References: <20231110173427.79275-2-paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231110173427.79275-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/10/2023 9:34 AM, Paul Moore wrote:
> As the kernel test robot helpfully reminded us, all of the lsm_id
> instances defined inside the various LSMs should be marked as static.
> The one exception is Landlock which uses its lsm_id variable across
> multiple source files with an extern declaration in a header file.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/apparmor/lsm.c    | 2 +-
>  security/bpf/hooks.c       | 2 +-
>  security/commoncap.c       | 2 +-
>  security/loadpin/loadpin.c | 2 +-
>  security/safesetid/lsm.c   | 2 +-
>  security/selinux/hooks.c   | 2 +-
>  security/smack/smack_lsm.c | 2 +-
>  security/tomoyo/tomoyo.c   | 2 +-
>  security/yama/yama_lsm.c   | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 332198e0a017..e490a7000408 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1454,7 +1454,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
>  	.lbs_task = sizeof(struct aa_task_ctx),
>  };
>  
> -const struct lsm_id apparmor_lsmid = {
> +static const struct lsm_id apparmor_lsmid = {
>  	.name = "apparmor",
>  	.id = LSM_ID_APPARMOR,
>  };
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 91011e0c361a..57b9ffd53c98 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -16,7 +16,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
>  };
>  
> -const struct lsm_id bpf_lsmid = {
> +static const struct lsm_id bpf_lsmid = {
>  	.name = "bpf",
>  	.id = LSM_ID_BPF,
>  };
> diff --git a/security/commoncap.c b/security/commoncap.c
> index a64c0c8592bb..162d96b3a676 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1441,7 +1441,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>  
>  #ifdef CONFIG_SECURITY
>  
> -const struct lsm_id capability_lsmid = {
> +static const struct lsm_id capability_lsmid = {
>  	.name = "capability",
>  	.id = LSM_ID_CAPABILITY,
>  };
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index d682a851de58..8e93cda130f1 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -209,7 +209,7 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
>  	return loadpin_check(NULL, (enum kernel_read_file_id) id);
>  }
>  
> -const struct lsm_id loadpin_lsmid = {
> +static const struct lsm_id loadpin_lsmid = {
>  	.name = "loadpin",
>  	.id = LSM_ID_LOADPIN,
>  };
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index f42d5af5ffb0..1ba564f097f5 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -262,7 +262,7 @@ static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old
>  	return 0;
>  }
>  
> -const struct lsm_id safesetid_lsmid = {
> +static const struct lsm_id safesetid_lsmid = {
>  	.name = "safesetid",
>  	.id = LSM_ID_SAFESETID,
>  };
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 942f2b8c4ebb..b340425ccfae 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7031,7 +7031,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>  }
>  #endif /* CONFIG_IO_URING */
>  
> -const struct lsm_id selinux_lsmid = {
> +static const struct lsm_id selinux_lsmid = {
>  	.name = "selinux",
>  	.id = LSM_ID_SELINUX,
>  };
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 99664c8cf867..53336d7daa93 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5006,7 +5006,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>  	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
>  };
>  
> -const struct lsm_id smack_lsmid = {
> +static const struct lsm_id smack_lsmid = {
>  	.name = "smack",
>  	.id = LSM_ID_SMACK,
>  };
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 722205433105..e10491f155a5 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -543,7 +543,7 @@ static void tomoyo_task_free(struct task_struct *task)
>  	}
>  }
>  
> -const struct lsm_id tomoyo_lsmid = {
> +static const struct lsm_id tomoyo_lsmid = {
>  	.name = "tomoyo",
>  	.id = LSM_ID_TOMOYO,
>  };
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 5cdff292fcae..49dc52b454ef 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -422,7 +422,7 @@ static int yama_ptrace_traceme(struct task_struct *parent)
>  	return rc;
>  }
>  
> -const struct lsm_id yama_lsmid = {
> +static const struct lsm_id yama_lsmid = {
>  	.name = "yama",
>  	.id = LSM_ID_YAMA,
>  };
