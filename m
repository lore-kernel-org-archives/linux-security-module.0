Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546DCC6FA83
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Sep 2022 16:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiI0Qyf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiI0QyN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 12:54:13 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8009CFB314
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 09:52:46 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4McQfC4NM4zMqnZC;
        Tue, 27 Sep 2022 18:52:35 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4McQfB5Tpwz3j;
        Tue, 27 Sep 2022 18:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664297555;
        bh=zz9l4xpKfZ/apNznukdF5CRsTs4o3l6iVFdsTZpnrBw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NlYeqLYZNCrL/XPHBSWu4pPUXsK8dfEBITM9q/9z3YnRYjjlB5Ewt0C6C0Wzi/Zi3
         0d/k49Bkkj7P9rvrMoer54C8BSSlXatP+0vLrbSb2KfB0qm1B7NjgxA8/w/Zsa734h
         Bi+p1bjBUayuxsT4rm8hOv6AzvDs5fl1r+Gkdma4=
Message-ID: <2200767d-ef88-b8dc-b5bd-f0b8e65d4cef@digikod.net>
Date:   Tue, 27 Sep 2022 18:52:34 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 3/3] landlock: Fix documentation style
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220923154207.3311629-1-mic@digikod.net>
 <20220923154207.3311629-4-mic@digikod.net> <Yy7S07GpqZEY4J8n@debian.me>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Yy7S07GpqZEY4J8n@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 24/09/2022 11:50, Bagas Sanjaya wrote:
> On Fri, Sep 23, 2022 at 05:42:07PM +0200, Mickaël Salaün wrote:
>> It seems that all code should use double backquotes, which is also used
>> to convert "%" defines.  Let's use an homogeneous style and remove all
>> use of simple backquotes (which should only be used for emphasis).
>>
> 
> A little nit: the kernel log content at the opening paragraph should
> also be in inline code:

Is there some precedent? Explicit quotes (") seems more appropriate 
because we are talking about a text string (not a command nor a code 
snippet).

> 
> ---- >8 ----
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index cec780c2f4973c..5dbd577b5f58b7 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -19,10 +19,10 @@ unexpected/malicious behaviors in user space applications.  Landlock empowers
>   any process, including unprivileged ones, to securely restrict themselves.
>   
>   We can quickly make sure that Landlock is enabled in the running system by
> -looking for "landlock: Up and running" in kernel logs (as root): ``dmesg | grep
> -landlock || journalctl -kg landlock`` .  Developers can also easily check for
> -Landlock support with a :ref:`related system call <landlock_abi_versions>`.  If
> -Landlock is not currently supported, we need to :ref:`configure the kernel
> +looking for ``landlock: Up and running`` in kernel logs (as root): ``dmesg |
> +grep landlock || journalctl -kg landlock`` .  Developers can also easily check
> +for Landlock support with a :ref:`related system call <landlock_abi_versions>`.
> +If Landlock is not currently supported, we need to :ref:`configure the kernel
>   appropriately <kernel_support>`.
>   
>   Landlock rules
> 
> Thanks.
> 
