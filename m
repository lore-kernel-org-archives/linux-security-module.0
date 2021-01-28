Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26835C433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19F864DDD
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 13:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhA1NAU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:00:20 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57585 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhA1NAR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jan 2021 08:00:17 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10SCxYc6075273;
        Thu, 28 Jan 2021 21:59:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Thu, 28 Jan 2021 21:59:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10SCxY3q075270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Jan 2021 21:59:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] smackfs: restrict bytes count in smackfs write
 functions
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     andreyknvl@google.com, casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mhocko@suse.com,
        serge@hallyn.com,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
References: <3c35f7cc-1c8d-2fa0-6bc9-bde4e96017ce@i-love.sakura.ne.jp>
 <20210128115801.1096425-1-snovitoll@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5271074f-930a-46e9-8ece-2cc65d45dc19@i-love.sakura.ne.jp>
Date:   Thu, 28 Jan 2021 21:59:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128115801.1096425-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/01/28 20:58, Sabyrzhan Tasbolatov wrote:
> @@ -2005,6 +2009,9 @@ static ssize_t smk_write_onlycap(struct file *file, const char __user *buf,
>  	if (!smack_privileged(CAP_MAC_ADMIN))
>  		return -EPERM;
>  
> +	if (count > PAGE_SIZE)
> +		return -EINVAL;
> +
>  	data = memdup_user_nul(buf, count);
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
> @@ -2740,10 +2754,13 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
>  		return -EPERM;
>  
>  	/*
> +	 * No partial write.
>  	 * Enough data must be present.
>  	 */
>  	if (*ppos != 0)
>  		return -EINVAL;
> +	if (count == 0 || count > PAGE_SIZE)
> +		return -EINVAL;
>  
>  	data = memdup_user_nul(buf, count);
>  	if (IS_ERR(data))
> 

Doesn't this change break legitimate requests like

  char buffer[20000];

  memset(buffer, ' ', sizeof(buffer));
  memcpy(buffer + sizeof(buffer) - 10, "foo", 3);
  write(fd, buffer, sizeof(buffer));

?
