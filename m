Return-Path: <SRS0=3Yzx=EP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0768C5517A
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 04:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20C7206A5
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 04:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g9PuNzZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgKIEbZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Nov 2020 23:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIEbY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Nov 2020 23:31:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20FC0613CF;
        Sun,  8 Nov 2020 20:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=H2MmivuEFUCxmeEez6uv4vlPLqKUyp4vC9/NvB7etIo=; b=g9PuNzZJJgxLnHOHhcXI9TI9C7
        gARcoSZfJ4oK3z+7VkdiJKLHy7Ep7N7bs3VzDb5Btz6ORWN1p0w99+JurG/XiMSZqYBfhJlaG+m/V
        rsOFY65PB8FvjeYV0UCSF8x2HxI8mr+7OOHlvtOZxdbWKYZi/W6It91L9KmNCQkoK5jCqyk/vSyg2
        UMFnpclpvhyMl6w4tDlv7gnL4eISjhztr+gZQxe+4CAidLvaPYNj0qngJpCFcQCCOpVPYuk52DQyX
        +hiPzZn5DKO3aVPUGjdAeBnfmmYoHKJp/2aM7n1gUhFaqjNZSX61RxENSbP/htW6SaRPql85cfHp3
        gZouB/3Q==;
Received: from [2601:1c0:6280:3f0::a1cb]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kbypp-0007QS-Ap; Mon, 09 Nov 2020 04:31:19 +0000
Subject: Re: [PATCH v2 7/8] Documentation: Add documentation for the Brute LSM
To:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20201025134540.3770-1-john.wood@gmx.com>
 <20201025134540.3770-8-john.wood@gmx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2ab35578-832a-6b92-ca9b-2f7d42bc0792@infradead.org>
Date:   Sun, 8 Nov 2020 20:31:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201025134540.3770-8-john.wood@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/25/20 6:45 AM, John Wood wrote:
> Add some info detailing what is the Brute LSM, its motivation, weak
> points of existing implementations, proposed solutions, enabling,
> disabling and fine tuning.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  Documentation/admin-guide/LSM/Brute.rst | 118 ++++++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst |   1 +
>  security/brute/Kconfig                  |   3 +-
>  3 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Brute.rst
> 
> diff --git a/Documentation/admin-guide/LSM/Brute.rst b/Documentation/admin-guide/LSM/Brute.rst
> new file mode 100644
> index 000000000000..20c6ccbd625d
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/Brute.rst
> @@ -0,0 +1,118 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +===========================================================
> +Brute: Fork brute force attack detection and mitigation LSM
> +===========================================================
> +
> +Attacks against vulnerable userspace applications with the purpose to break ASLR
> +or bypass canaries traditionaly use some level of brute force with the help of

                      traditionally

> +the fork system call. This is possible since when creating a new process using
> +fork its memory contents are the same as those of the parent process (the
> +process that called the fork system call). So, the attacker can test the memory
> +infinite times to find the correct memory values or the correct memory addresses
> +without worrying about crashing the application.
> +
> +Based on the above scenario it would be nice to have this detected and
> +mitigated, and this is the goal of this implementation.
> +
> +
> +Other implementations
> +=====================
> +
> +The public version of grsecurity, as a summary, is based on the idea of delay

                                                                           delaying

> +the fork system call if a child died due to a fatal error. This has some issues:
> +
> +Bad practices
> +-------------
> +
> +Add delays to the kernel is, in general, a bad idea.

   Adding

> +
> +Weak points
> +-----------
> +
> +This protection can be bypassed using two different methods since it acts only
> +when the fork is called after a child has crashed.
> +
> +Bypass 1
> +~~~~~~~~
> +
> +So, it would still be possible for an attacker to fork a big amount of children
> +(in the order of thousands), then probe all of them, and finally wait the
> +protection time before repeat the steps.

                          repeating

> +
> +Bypass 2
> +~~~~~~~~
> +
> +This method is based on the idea that the protection doesn't act if the parent
> +crashes. So, it would still be possible for an attacker to fork a process and
> +probe itself. Then, fork the child process and probe itself again. This way,
> +these steps can be repeated infinite times without any mitigation.
> +
> +
> +This implementation
> +===================
> +
> +The main idea behind this implementation is to improve the existing ones
> +focusing on the weak points annotated before. The solution for the first bypass
> +method is to detect a fast crash rate instead of only one simple crash. For the
> +second bypass method the solution is to detect both the crash of parent and
> +child processes. Moreover, as a mitigation method it is better to kill all the
> +offending tasks involve in the attack instead of use delays.

                   involved                         using

> +
> +So, the solution to the two bypass methods previously commented is to use some
> +statistical data shared across all the processes that can have the same memory
> +contents. Or in other words, a statistical data shared between all the fork
> +hierarchy processes after an execve system call.
> +
> +The purpose of these statistics is to compute the application crash period in
> +order to detect an attack. This crash period is the time between the execve
> +system call and the first fault or the time between two consecutives faults, but

                                                           consecutive

> +this has a drawback. If an application crashes once quickly from the execve
> +system call or crashes twice in a short period of time for some reason, a false
> +positive attack will be triggered. To avoid this scenario the shared statistical
> +data holds a list of the i last crashes timestamps and the application crash
> +period is computed as follows:
> +
> +crash_period = (n_last_timestamp - n_minus_i_timestamp) / i;
> +
> +This ways, the size of the last crashes timestamps list allows to fine tuning

        way                                                               tune

> +the detection sensibility.
> +
> +When this crash period falls under a certain threshold there is a clear signal
> +that something malicious is happening. Once detected, the mitigation only kills
> +the processes that share the same statistical data and so, all the tasks that
> +can have the same memory contents. This way, an attack is rejected.
> +
> +Per system enabling
> +-------------------
> +
> +This feature can be enabled at build time using the CONFIG_SECURITY_FORK_BRUTE
> +option or using the visual config application under the following menu:
> +
> +Security options  --->  Fork brute force attack detection and mitigation
> +
> +Per process enabling/disabling
> +------------------------------
> +
> +To allow that specific applications can turn off or turn on the detection and
> +mitigation of a fork brute force attack when required, there are two new prctls.
> +
> +prctl(PR_SECURITY_FORK_BRUTE_ENABLE, 0, 0, 0, 0)  -> To enable the feature
> +prctl(PR_SECURITY_FORK_BRUTE_DISABLE, 0, 0, 0, 0) -> To disable the feature
> +
> +Fine tuning
> +-----------
> +
> +To customize the detection's sensibility there are two new sysctl attributes
> +that allow to set the last crashes timestamps list size and the application
> +crash period threshold (in milliseconds). Both are accessible through the
> +following files respectively.
> +
> +/proc/sys/kernel/brute/timestamps_list_size
> +/proc/sys/kernel/brute/crash_period_threshold
> +
> +The list size allows to avoid false positives due to crashes unrelated with a
> +real attack. The period threshold sets the time limit to detect an attack. And,
> +since a fork brute force attack will be detected if the application crash period
> +falls under this threshold, the higher this value, the more sensitive the
> +detection will be.
> +

So an app could read crash_period_threshold and just do a new fork every
threshold + 1 time units, right? and not be caught?

thanks for the documentation.
-- 
~Randy

