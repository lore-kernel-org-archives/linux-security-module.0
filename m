Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED59DC433ED
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Apr 2021 02:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE9860E08
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Apr 2021 02:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhDSDAD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 18 Apr 2021 23:00:03 -0400
Received: from m12-13.163.com ([220.181.12.13]:59700 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhDSDAD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 18 Apr 2021 23:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=G7QSs
        /bXDpbqG6hm4GcEzVUO9UnTQnXvFf1cnwQYUfE=; b=lr+8pRTWW4ZBZLJ9ZcoX2
        7avqByH11JBYHG8czcxHhy174iY6/JvBoRf4GI6Z2M06S7Oy/VSHvLGDghWG6Acj
        56l82aloWhVGNDTcZARtyCXVASvDzkPCT3DzyGq9mCS0DbY0t6cGGxCDF7QYr+QR
        O+pYm+H/9+d3CtswN1c6fk=
Received: from localhost (unknown [183.46.37.234])
        by smtp9 (Coremail) with SMTP id DcCowACnv0_P8XxgHbtwGg--.562S2;
        Mon, 19 Apr 2021 10:58:25 +0800 (CST)
Date:   Mon, 19 Apr 2021 10:58:21 +0800
From:   Zhongjun Tan <hbut_tan@163.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhongjun Tan <tanzhongjun@yulong.com>
Subject: Re: [PATCH] lsm:fix a missing-check bug in smack_sb_eat_lsm_opts()
Message-ID: <20210419105821.00001082.hbut_tan@163.com>
In-Reply-To: <YHmSwVpR2oq2yqUG@zeniv-ca.linux.org.uk>
References: <20210416095303.530-1-hbut_tan@163.com>
        <YHmSwVpR2oq2yqUG@zeniv-ca.linux.org.uk>
Organization: Yulong
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowACnv0_P8XxgHbtwGg--.562S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWfWFWfZr48JFy5Wr1UGFg_yoWxCrgEg3
        97Xa48Xrykuws8G3W8Zr45tr40kF1DWr1q93yDZFy5AF98t3yvvws0yFZIy3W7ZFZrK3Z7
        Gr9xGwnxX39FvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0jLvtUUUUU==
X-Originating-IP: [183.46.37.234]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBqBt5xl75blzTeQAAsz
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 16 Apr 2021 13:36:01 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Fri, Apr 16, 2021 at 05:53:03PM +0800,  Zhongjun Tan wrote:
> 
> > @@ -710,13 +711,14 @@ static int smack_sb_eat_lsm_opts(char
> > *options, void **mnt_opts) token = match_opt_prefix(from, len,
> > &arg); if (token != Opt_error) {
> >  			arg = kmemdup_nul(arg, from + len - arg,
> > GFP_KERNEL);
> > +			if (!arg) {
> > +				rc = -ENOMEM;
> > +				goto free_mnt_opts;
> >  			rc = smack_add_opt(token, arg, mnt_opts);  
> 
> 			if (arg)
> 	  			rc = smack_add_opt(token, arg,
> mnt_opts); else
> 				rc = -ENOMEM;
> 
> and no other changes are needed anywhere...

update patch v3 , just four codes and no other changes are needed. 

