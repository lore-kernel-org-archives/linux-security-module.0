Return-Path: <SRS0=p3Qd=62=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E694CA90AF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163972054F
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gLg6PpJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgELQDR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 May 2020 12:03:17 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:45775
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728957AbgELQDR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 May 2020 12:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589299396; bh=o4V6Ojns+3S3dbpqfxxqD6QRxuVDE62B+SyjLJ3t7b4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gLg6PpJ7WCknSootPWo2iQEM1rlWa97uSwVzexUYN7rPmyZHZh3QSj6QDZjdD3st/6PYNUqvRiVdI/rMjZCpfhYNE+fRMOo6c/WBsz0nIy64Wrp45zbrEc28RtxFUq46LGCDAzkKdmHaCV90fuTHnreLBCYFFjGos3Gv77NIAZFd+tK5bpn35KoDD/rQ76/blLbiKyxUSYvIqGdf00ZQsYkEL6o1oLrjEcdewl+75h2klo+ibNLPA4kC8zSCu8AAK81mBlDGa4sUhkC9QHUsLOl9OkNtk20l87v3AKx9FqBwnGDsFSRQ6y0nm7lucji+9EwGLO/wDg92SBK59wKM5Q==
X-YMail-OSG: 4D_LO8QVM1m_xXQJdRYpgpEcXPp55XTdXvGeMR__d9pD3ug_V6ZNE2xzAnG0nNJ
 lSKe3EpVVYph0.gZA3JJsnSmzQyNr2SBdC2scEPTWGG5c27qDf_3Mb9zgxc_5jNZX9l96ZZazDPS
 sqtPgLwQh8SPXa7biUBuT0buJC9b3TBQlRkRa5d4paLle_Lp.LG_OBQ32JWxcwGVN9f4HbuuCTfS
 VV_hgqp0N8OEBrexT9iJo9QvErfWYYvsOvkQPy8iHNGL1.dfhAGkfJAvsM.dq4M_QE.aEQDvF8EA
 P8WattHiSmeHuwvF4sijw1eLooiYHfKyiL1AGK.ZElKPpntG6H36atL0c1H8VawiYx9I0LGjgu5O
 5bKuhrjQiTDRtQOy4dcD0i1p_udEoowv9mU2SfUg06WzyN0al8EQPyUpzZaeJ5Kbjsw2D5Mf75ao
 M4QDU4TfF6jquweuEw.sX59BTH15griRUk6cFH4ePWstdAFlG7qNaE3jYH1m5v7pbU5bEVXhyUJ4
 scRBanD45vcjQWZYdLPZi2NlKhNZBT555VFzzRJrNceS.xcs_0C_DydzGs4xQWFG2VwqRMtz6bvc
 2RIERZESbNHbkCt9YiWrvy0EIInE787Sz4EU4LmYkLF4ww6o9GYJ4POgfH7ByykOQSr89_uGpJ9U
 QN47rJ4jI.vbA.FHQNouo3Y.u3KXJ8Kh7TfGzrhJWPJTqh2v3z3JdZhyGghxrVMCOqp4gBYhsMqU
 D6UkQ_Z7y55CsjhMcNyrl6W4q1gVE8mUZHBka8KCc0V69wmhol4RuJcMHob0ZupolRNtLX2NQjgb
 amSIi6swN6SNIYS.odEUk7_yB3y4OsOqmVnf6TL97YpHUUBG160Pu_lai.xjcgGAjZocb6ZDZ9hV
 Zh3DqOlV1ssAb7JgU2pLpSKe5.co8Dl5Vfa4lfplzQWx1hEgTHXUECphzDCPLCiLZa6Y_7LWMj5V
 rHNGOVSMPhKwhiOFfx9gyeFSGpKtcjqiY0O91odCFjKUHScKF.rD4J8RO1UKadVPFoF.FU89pU_i
 cCYaFNHmY9gI.GMGa.lxp3cEG6dy8OWCat54eJHcBuuFYcguFl..jChETNWkn86zxWNIcbf4y2HB
 5Zufe6tIWTRbAfACPB3GjiNW9pI4VniYDNqOhwx2Hv5ZkSOOOI39jRshnhD6jSnPrW6JnPTI8cqx
 VXndXl9Ox7yOV1czy_9CHdd5c5kSezwxf0wSXzpoYQlAw4n.fI3jvEiAnYqAok0.383pksx3ZfmL
 LBw_TWLPikYh5ztgp9AO4vbihLFfMeQFG28Nhh.asE4OqbZBrmOeTG2IAXLRTRTnw8CbMRq5jjMQ
 mLBZzgVG2v1AJFQSJi7EBiXeaBDJar1B04FoJzClL6RAZSLSi3VezNDvW4pph71Tked58lIbw3mU
 C.poTJVBdUjN06vmgQiVn81V75IgdFrXkp4TMQZSf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 May 2020 16:03:16 +0000
Received: by smtp421.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID aed177487a27b3c5dbe2321e7c5309d3;
          Tue, 12 May 2020 16:03:14 +0000 (UTC)
Subject: Re: [PATCH -next] Smack: Remove unused inline function
 smk_ad_setfield_u_fs_path_mnt
To:     YueHaibing <yuehaibing@huawei.com>, jmorris@namei.org,
        serge@hallyn.com, tglx@linutronix.de
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200509112019.54164-1-yuehaibing@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <771984b0-6a0f-8bcf-340a-8e6f492cbe73@schaufler-ca.com>
Date:   Tue, 12 May 2020 09:03:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200509112019.54164-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15902 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/9/2020 4:20 AM, YueHaibing wrote:
> commit a269434d2fb4 ("LSM: separate LSM_AUDIT_DATA_DENTRY from LSM_AUDIT_DATA_PATH")
> left behind this, remove it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I have taken this. Thank you.

> ---
>  security/smack/smack.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 62529f382942..f244c9d10004 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -505,10 +505,6 @@ static inline void smk_ad_setfield_u_fs_path_dentry(struct smk_audit_info *a,
>  						    struct dentry *d)
>  {
>  }
> -static inline void smk_ad_setfield_u_fs_path_mnt(struct smk_audit_info *a,
> -						 struct vfsmount *m)
> -{
> -}
>  static inline void smk_ad_setfield_u_fs_inode(struct smk_audit_info *a,
>  					      struct inode *i)
>  {
