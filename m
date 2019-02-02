Return-Path: <SRS0=oenN=QJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F9AC282D7
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Feb 2019 04:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BC520855
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Feb 2019 04:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfBBESX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:18:23 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:11908 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfBBESW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Feb 2019 23:18:22 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x124IIII059336;
        Sat, 2 Feb 2019 13:18:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Sat, 02 Feb 2019 13:18:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x124IE4K059137
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 2 Feb 2019 13:18:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: Basic all-cap/all-lower case question on Environment variables
To:     J Freyensee <why2jjj.linux@gmail.com>,
        linux-security-module@vger.kernel.org
References: <52a3fb2c-8ffb-655e-a9bc-76344b27e64f@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <57fe6767-e8c2-3d3c-84f0-ba3b2a124bc8@I-love.SAKURA.ne.jp>
Date:   Sat, 2 Feb 2019 13:18:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <52a3fb2c-8ffb-655e-a9bc-76344b27e64f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/02/02 6:19, J Freyensee wrote:
> System environment variables, like PATH, LD_LIBRARY_PATH, HOME, etc.  Can they ever
> default to all lower-case in a Linux Distro, i.e., path, ld_library_path, home, etc?

There is no rule for environment variables, except environment variable name can't
contain '=' because '=' is used as a separator for environment variable value.

> If so, is there a mode bit, kernel configuration setting or sysfs file to check for this setting?

No such settings. Just a convention. Even mixed name like OPENSSL_ia32cap is permitted.

