Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D445BC433B4
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7DD61107
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 13:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbhDPNgo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbhDPNgn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 09:36:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93293C061574;
        Fri, 16 Apr 2021 06:36:18 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXOdd-005laJ-Hu; Fri, 16 Apr 2021 13:36:01 +0000
Date:   Fri, 16 Apr 2021 13:36:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     =?iso-8859-1?Q?=A0Zhongjun?= Tan <hbut_tan@163.com>
Cc:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhongjun Tan <tanzhongjun@yulong.com>
Subject: Re: [PATCH] lsm:fix a missing-check bug in smack_sb_eat_lsm_opts()
Message-ID: <YHmSwVpR2oq2yqUG@zeniv-ca.linux.org.uk>
References: <20210416095303.530-1-hbut_tan@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416095303.530-1-hbut_tan@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 16, 2021 at 05:53:03PM +0800,  Zhongjun Tan wrote:

> @@ -710,13 +711,14 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
>  		token = match_opt_prefix(from, len, &arg);
>  		if (token != Opt_error) {
>  			arg = kmemdup_nul(arg, from + len - arg, GFP_KERNEL);
> +			if (!arg) {
> +				rc = -ENOMEM;
> +				goto free_mnt_opts;
>  			rc = smack_add_opt(token, arg, mnt_opts);

			if (arg)
	  			rc = smack_add_opt(token, arg, mnt_opts);
			else
				rc = -ENOMEM;

and no other changes are needed anywhere...
