Return-Path: <SRS0=ebHT=ED=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807A4C56201
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Oct 2020 23:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CED20782
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Oct 2020 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgJ1XFD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:05:03 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63744 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390003AbgJ1XE6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Oct 2020 19:04:58 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 19:04:57 EDT
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 09SDMwnF001101;
        Wed, 28 Oct 2020 22:22:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Wed, 28 Oct 2020 22:22:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 09SDMwwV001095
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 28 Oct 2020 22:22:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: fix clang pointer arithmetic warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org
References: <20201026215236.3894200-1-arnd@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7bb56fd2-ffe2-2985-19d0-31b42bc9e7e8@i-love.sakura.ne.jp>
Date:   Wed, 28 Oct 2020 22:22:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201026215236.3894200-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thank you for a patch. I have two questions.

On 2020/10/27 6:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about additions on NULL pointers being undefined in C:
> 
> security/tomoyo/securityfs_if.c:226:59: warning: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Wnull-pointer-arithmetic]
>         securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
> 
> Change the code to instead use a cast through uintptr_t to avoid
> the warning.
> 

> -	securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
> +	securityfs_create_file(name, mode, parent, (u8 *)(uintptr_t)key,
>  			       &tomoyo_operations);

(1) Does clang warn if "(void *)key" is used instead of "(u8 *)(uintptr_t)key" ?

(2) tomoyo_open() has

	const int key = ((u8 *) file_inode(file)->i_private) - ((u8 *) NULL);

    which decodes the "u8 key" passed to tomoyo_create_entry(). For symmetry,
    I'd like to remove NULL from tomoyo_open() as well. Does clang warn if

	const int key = (u8) (file_inode(file)->i_private);

    is used?
