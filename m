Return-Path: <SRS0=FyGa=TC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C062FC43219
	for <linux-security-module@archiver.kernel.org>; Thu,  2 May 2019 13:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C3D2063F
	for <linux-security-module@archiver.kernel.org>; Thu,  2 May 2019 13:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfEBNSM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 May 2019 09:18:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64557 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBNSM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 May 2019 09:18:12 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x42DHfrQ066138;
        Thu, 2 May 2019 22:17:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Thu, 02 May 2019 22:17:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x42DHZSn066036
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 2 May 2019 22:17:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 1/2] apparmor: Use a memory pool instead per-CPU caches
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
References: <20190405133458.4809-1-bigeasy@linutronix.de>
 <ae17e2a3-7d08-5863-4fba-66ddeac11541@canonical.com>
 <20190430144725.gd6r3aketxuqdyir@linutronix.de>
 <02d7772b-5d06-1c32-b089-454547fbe08b@canonical.com>
 <20190502105158.2hluemukrdz5hbus@linutronix.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <7b41609f-2592-93c1-55f7-6026ff6dba26@I-love.SAKURA.ne.jp>
Date:   Thu, 2 May 2019 22:17:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502105158.2hluemukrdz5hbus@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/05/02 19:51, Sebastian Andrzej Siewior wrote:
>>>> * some buffer allocations had to be done with GFP_ATOMIC, making them
>>>>   more likely to fail. Since we fail closed that means failure would
>>>>   block access. This actually became a serious problem in a couple
>>>>   places. Switching to per cpu buffers and blocking pre-empt was
>>>>   the solution.
>>>
>>> GFP_KERNEL is allowed to use IO/SWAP and ATOMIC has emergency pools. The
>>> new approach won't return a NULL pointer, simply spin to either allocate
>>> new memory or get one which was just returned.
>>>
>>
>> yeah, I am not really a fan of a potential infinite loop trying to allocate
>> memory. It may be worth retrying once or twice but potentially infinitely
>> spinning on failed allocation really isn't acceptable.
> 
> It shouldn't spin infinitely because even if kmalloc() does not return
> any memory, one of the other CPUs should return their buffer at some
> point. However, if you don't like it I could add two retries and return
> NULL + fixup callers. On the other hand if the other CPUs BUG() with the
> buffers then yes, we may spin.
> So limited retries it is?

There is 'The "too small to fail" memory-allocation rule'
( https://lwn.net/Articles/627419/ ) where GFP_KERNEL allocation for
size <= 32768 bytes never fails unless current thread was killed by
the OOM killer. This means that kmalloc() in

+char *aa_get_buffer(void)
+{
+	union aa_buffer *aa_buf;
+
+try_again:
+	spin_lock(&aa_buffers_lock);
+	if (!list_empty(&aa_global_buffers)) {
+		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
+					  list);
+		list_del(&aa_buf->list);
+		spin_unlock(&aa_buffers_lock);
+		return &aa_buf->buffer[0];
+	}
+	spin_unlock(&aa_buffers_lock);
+
+	aa_buf = kmalloc(aa_g_path_max, GFP_KERNEL);
+	if (WARN_ON_ONCE(!aa_buf))
+		goto try_again;
+	return &aa_buf->buffer[0];
+}

can't return NULL unless current thread was killed by the OOM killer
if aa_g_path_max <= 32768. On the other hand, if aa_g_path_max > 32768,
this allocation can easily fail, and retrying forever is very bad.

If current thread was killed by the OOM killer, current thread should be
able to bail out without retrying. If allocation can never succeed (e.g.
aa_g_path_max == 1073741824 was specified), we must bail out.



By the way, did you really test your patch?

> @@ -1399,6 +1404,7 @@ static int param_set_aauint(const char *val, const struct kernel_param *kp)
>  		return -EPERM;
>  
>  	error = param_set_uint(val, kp);
> +	aa_g_path_max = min_t(uint32_t, aa_g_path_max, sizeof(union aa_buffer));

I think that this will guarantee that aa_g_path_max <= sizeof(struct list_head)
which is too small to succeed. :-(

>  	pr_info("AppArmor: buffer size set to %d bytes\n", aa_g_path_max);
>  
>  	return error;

