Return-Path: <SRS0=fDLm=5R=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4165EC43331
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Apr 2020 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161E720776
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Apr 2020 12:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgDAMkF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:40:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59347 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgDAMkF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Apr 2020 08:40:05 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 031CdZg9063756;
        Wed, 1 Apr 2020 21:39:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Wed, 01 Apr 2020 21:39:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 031CdZ32063751
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 1 Apr 2020 21:39:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH -next] smack: fix a missing-check bug in
 smack_sb_eat_lsm_opts()
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200401071055.8265-1-chenzhou10@huawei.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <bcfe28a1-5ff1-5439-0da3-4bc63feddc3a@I-love.SAKURA.ne.jp>
Date:   Wed, 1 Apr 2020 21:39:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401071055.8265-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/04/01 16:10, Chen Zhou wrote:
> In smack_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul().
> It returns NULL when fails, add check for it.

Thanks. But this check is not needed, for smack_add_opt() returns NULL if arg == NULL.
