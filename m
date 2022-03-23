Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC97C433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Mar 2022 10:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiCWKJy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Mar 2022 06:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiCWKJv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Mar 2022 06:09:51 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731D6FA33
        for <linux-security-module@vger.kernel.org>; Wed, 23 Mar 2022 03:08:18 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22NA7cEL060187;
        Wed, 23 Mar 2022 19:07:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Wed, 23 Mar 2022 19:07:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22NA7cHF060181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Mar 2022 19:07:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d0b370d2-403c-9fa8-c1b5-3e5b2c42c88c@I-love.SAKURA.ne.jp>
Date:   Wed, 23 Mar 2022 19:07:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v1] LSM: Remove double path_rename hook calls for
 RENAME_EXCHANGE
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220222175332.384545-1-mic@digikod.net>
 <b71454bb-d084-bfd6-7cd3-aa6bfdaaab00@digikod.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <b71454bb-d084-bfd6-7cd3-aa6bfdaaab00@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/03/23 17:40, Mickaël Salaün wrote:
> Any comment? John, Tetsuo, does it look OK for AppArmor and Tomoyo?

I'm OK with this change regarding TOMOYO part.

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Thank you.
