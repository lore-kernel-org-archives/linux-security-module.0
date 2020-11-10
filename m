Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA8C388F7
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 04:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BC2206D8
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 04:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgKJEnI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Nov 2020 23:43:08 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52096 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbgKJEnI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Nov 2020 23:43:08 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0AA4h6ag067872;
        Tue, 10 Nov 2020 13:43:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 10 Nov 2020 13:43:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0AA4h5rr067869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Nov 2020 13:43:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3 1/2] security: add fault injection capability
To:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>, jmorris@namei.org,
        serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
References: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
 <20201029183526.2131776-2-aleksandrnogikh@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <04d8c32a-06cd-d71a-43d9-47b1de6c7684@i-love.sakura.ne.jp>
Date:   Tue, 10 Nov 2020 13:43:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201029183526.2131776-2-aleksandrnogikh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/10/30 3:35, Aleksandr Nogikh wrote:
> +#ifdef CONFIG_FAIL_LSM_HOOKS
> +
> +static struct {
> +	struct fault_attr attr;
> +	int retval;
> +} fail_lsm_hooks = {
> +	.attr = FAULT_ATTR_INITIALIZER,
> +	.retval = -EACCES
> +};
> +
> +static int __init setup_fail_lsm_hooks(char *str)
> +{
> +	return setup_fault_attr(&fail_lsm_hooks.attr, str);
> +}
> +__setup("fail_lsm_hooks=", setup_fail_lsm_hooks);
> +
> +static int lsm_hooks_inject_fail(void)
> +{
> +	return should_fail(&fail_lsm_hooks.attr, 1) ? fail_lsm_hooks.retval : 0;
> +}
> +
> +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> +
> +static int __init fail_lsm_hooks_debugfs(void)
> +{
> +	umode_t mode = S_IFREG | 0600;
> +	struct dentry *dir;
> +
> +	dir = fault_create_debugfs_attr("fail_lsm_hooks", NULL,
> +					&fail_lsm_hooks.attr);
> +	debugfs_create_u32("retval", mode, dir, &fail_lsm_hooks.retval);

Since production kernels will use CONFIG_FAIL_LSM_HOOKS=n, we won't need to worry about userspace ABI.

Reviewed-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

By the way, fail_lsm_hooks.retval is "signed int" but debugfs_create_u32() handles "unsigned int".
Do we want to allow lsm_hooks_inject_fail() to inject arbitrary !IS_ERR_VALUE() values?

> +	return 0;
> +}
