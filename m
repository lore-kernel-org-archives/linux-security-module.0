Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6079BC46467
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Jan 2023 12:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjAGM5l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 7 Jan 2023 07:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjAGM5l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Jan 2023 07:57:41 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6C7CDF
        for <linux-security-module@vger.kernel.org>; Sat,  7 Jan 2023 04:57:40 -0800 (PST)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 307Cv83H083864;
        Sat, 7 Jan 2023 21:57:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sat, 07 Jan 2023 21:57:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 307Cv8Jn083861
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 7 Jan 2023 21:57:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bb3be570-610b-24f1-5fa1-0f7d3955b834@I-love.SAKURA.ne.jp>
Date:   Sat, 7 Jan 2023 21:57:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] tomoyo: fix broken dependency on *.conf.default
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, James Morris <jmorris@namei.org>,
        Michal Marek <mmarek@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <20230107074743.3352242-1-masahiroy@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230107074743.3352242-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

All patches applied to https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/ .

Thank you.

