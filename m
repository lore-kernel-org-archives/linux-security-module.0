Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC5EC433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Dec 2021 11:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbhLOLrL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Dec 2021 06:47:11 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58036 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbhLOLrK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Dec 2021 06:47:10 -0500
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BFBkdIQ069200;
        Wed, 15 Dec 2021 20:46:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Wed, 15 Dec 2021 20:46:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BFBkcSF069136
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Dec 2021 20:46:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <8da31317-9306-70d0-2bf7-382ed157bc5c@i-love.sakura.ne.jp>
Date:   Wed, 15 Dec 2021 20:46:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] tomoyo: Check exceeded quota early in
 tomoyo_domain_quota_is_ok().
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     takedakn@nttdata.co.jp, jmorris@namei.org, serge@hallyn.com,
        nogikh@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211214094526.2442154-1-dvyukov@google.com>
 <4ad30f21-9955-a72c-d7f0-912de6c205be@i-love.sakura.ne.jp>
 <CACT4Y+Z63jk9cFgkcKeU0HN6ES_CBhrotY0Zabae17R-gqG6SA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <CACT4Y+Z63jk9cFgkcKeU0HN6ES_CBhrotY0Zabae17R-gqG6SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/12/14 20:42, Dmitry Vyukov wrote:
>> Therefore, asking administrator to also clear domain->flags[TOMOYO_DIF_QUOTA_WARNED] after
>> increasing pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile) would be
>> tolerable...
> 
> Should we reset flags[TOMOYO_DIF_QUOTA_WARNED] on any writes that
> change TOMOYO_PREF_MAX_LEARNING_ENTRY?
> 
> If I am increasing TOMOYO_PREF_MAX_LEARNING_ENTRY because I observed
> the warning, it's useful for me to receive the warning again.

I decided not to reset flags[TOMOYO_DIF_QUOTA_WARNED] automatically, and
applied your proposal as-is. Thank you.

https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits/04e57a2d952bbd34bc45744e72be3eecdc344294
