Return-Path: <SRS0=MkZ/=TD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C9C43219
	for <linux-security-module@archiver.kernel.org>; Fri,  3 May 2019 12:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821102075E
	for <linux-security-module@archiver.kernel.org>; Fri,  3 May 2019 12:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfECMmI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 May 2019 08:42:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58099 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfECMmI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 May 2019 08:42:08 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x43CflFs036107;
        Fri, 3 May 2019 21:41:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Fri, 03 May 2019 21:41:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x43CfkUk036102
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 3 May 2019 21:41:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] apparmor: Use a memory pool instead per-CPU caches
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
 <001f651f-c544-c3fa-c0c2-f2a2b1ed565a@i-love.sakura.ne.jp>
 <20190503114827.yky7r2cjq7zy4dfm@linutronix.de>
 <20190503115145.anv7z4kk7okydthm@linutronix.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <56de7347-b119-155d-675c-23a227ffd516@i-love.sakura.ne.jp>
Date:   Fri, 3 May 2019 21:41:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503115145.anv7z4kk7okydthm@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/05/03 20:51, Sebastian Andrzej Siewior wrote:
> +void aa_put_buffer(char *buf)
> +{
> +	union aa_buffer *aa_buf;
> +

buf == NULL if aa_put_buffer() was called due to aa_get_buffer() == NULL.

> +	aa_buf = container_of(buf, union aa_buffer, buffer[0]);
> +
> +	spin_lock(&aa_buffers_lock);
> +	list_add(&aa_buf->list, &aa_global_buffers);
> +	spin_unlock(&aa_buffers_lock);
> +}
> +
>  /*
>   * AppArmor init functions
>   */
