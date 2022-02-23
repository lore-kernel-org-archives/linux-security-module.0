Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA5C433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Feb 2022 13:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiBWN4b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBWN4a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Feb 2022 08:56:30 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C21B0C43
        for <linux-security-module@vger.kernel.org>; Wed, 23 Feb 2022 05:56:00 -0800 (PST)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21NDtCDg070600;
        Wed, 23 Feb 2022 22:55:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Wed, 23 Feb 2022 22:55:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21NDtCs8070597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Feb 2022 22:55:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <026864d4-3b4b-f2c3-b020-7e1d8cee2f63@I-love.SAKURA.ne.jp>
Date:   Wed, 23 Feb 2022 22:55:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] TOMOYO: fix __setup handlers return values
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        tomoyo-dev-en@lists.osdn.me, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20220222214533.10135-1-rdunlap@infradead.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220222214533.10135-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/02/23 6:45, Randy Dunlap wrote:
> __setup() handlers should return 1 if the parameter is handled.
> Returning 0 causes the entire string to be added to init's
> environment strings (limited to 32 strings), unnecessarily polluting it.

Applied as https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits/39844b7e3084baecef52d1498b5fa81afa2cefa9 .

Thank you.
