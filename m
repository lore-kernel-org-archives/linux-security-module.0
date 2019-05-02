Return-Path: <SRS0=FyGa=TC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF31C43219
	for <linux-security-module@archiver.kernel.org>; Thu,  2 May 2019 14:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782F22085A
	for <linux-security-module@archiver.kernel.org>; Thu,  2 May 2019 14:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEBOLI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 May 2019 10:11:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60821 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOLH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 May 2019 10:11:07 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x42EAoVP006384;
        Thu, 2 May 2019 23:10:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Thu, 02 May 2019 23:10:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x42EAn3b006379
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 2 May 2019 23:10:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/2] apparmor: Use a memory pool instead per-CPU caches
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
References: <20190405133458.4809-1-bigeasy@linutronix.de>
 <ae17e2a3-7d08-5863-4fba-66ddeac11541@canonical.com>
 <20190430144725.gd6r3aketxuqdyir@linutronix.de>
 <02d7772b-5d06-1c32-b089-454547fbe08b@canonical.com>
 <20190502105158.2hluemukrdz5hbus@linutronix.de>
 <7b41609f-2592-93c1-55f7-6026ff6dba26@I-love.SAKURA.ne.jp>
 <20190502134730.d3ya46ave6a7bvom@linutronix.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <001f651f-c544-c3fa-c0c2-f2a2b1ed565a@i-love.sakura.ne.jp>
Date:   Thu, 2 May 2019 23:10:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502134730.d3ya46ave6a7bvom@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/05/02 22:47, Sebastian Andrzej Siewior wrote:
> On 2019-05-02 22:17:35 [+0900], Tetsuo Handa wrote:
>> There is 'The "too small to fail" memory-allocation rule'
>> ( https://lwn.net/Articles/627419/ ) where GFP_KERNEL allocation for
>> size <= 32768 bytes never fails unless current thread was killed by
>> the OOM killer. This means that kmalloc() in
>>
>> +char *aa_get_buffer(void)
>> +{
>> +	union aa_buffer *aa_buf;
>> +
>> +try_again:
>> +	spin_lock(&aa_buffers_lock);
>> +	if (!list_empty(&aa_global_buffers)) {
>> +		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
>> +					  list);
>> +		list_del(&aa_buf->list);
>> +		spin_unlock(&aa_buffers_lock);
>> +		return &aa_buf->buffer[0];
>> +	}
>> +	spin_unlock(&aa_buffers_lock);
>> +
>> +	aa_buf = kmalloc(aa_g_path_max, GFP_KERNEL);
>> +	if (WARN_ON_ONCE(!aa_buf))
>> +		goto try_again;
>> +	return &aa_buf->buffer[0];
>> +}
>>
>> can't return NULL unless current thread was killed by the OOM killer
>> if aa_g_path_max <= 32768. On the other hand, if aa_g_path_max > 32768,
>> this allocation can easily fail, and retrying forever is very bad.
> 
> as I pointed out in the other email, it shouldn't retry forever because
> we should have something in the pool which will be returned.
> 

The point of 'The "too small to fail" memory-allocation rule' is that kmalloc(GFP_KERNEL)
can't return NULL after current thread once reached kmalloc(GFP_KERNEL). That is, current
thread loops forever inside __alloc_pages_nodemask() unless killed by the OOM killer.
If you want to use aa_get_buffer() as if a memory pool, you need to specify __GFP_NORETRY
(or __GFP_RETRY_MAYFAIL).



>>> @@ -1399,6 +1404,7 @@ static int param_set_aauint(const char *val, const struct kernel_param *kp)
>>>  		return -EPERM;
>>>  
>>>  	error = param_set_uint(val, kp);
>>> +	aa_g_path_max = min_t(uint32_t, aa_g_path_max, sizeof(union aa_buffer));
>>
>> I think that this will guarantee that aa_g_path_max <= sizeof(struct list_head)
>> which is too small to succeed. :-(
> 
> Ach right, this should have been max instead of min. Btw: are there any
> sane upper/lower limits while at it?

Although PATH_MAX is a limit which can be passed as a string argument to syscalls,
there is no limit for a pathname calculated by d_path() etc. The pathname can grow
until memory allocation for dentry cache fails after OOM-killer killed almost all
userspace processes.

But for pathname based access control, returning an error to userspace due to memory
allocation failure for d_path() etc. might result in unexpected termination of that
process. Therefore, you don't want to give up easily.
