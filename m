Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC5FC433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Mar 2022 09:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiCWJq7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiCWJq4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Mar 2022 05:46:56 -0400
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C2FD14
        for <linux-security-module@vger.kernel.org>; Wed, 23 Mar 2022 02:45:26 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KNk444mZjzMpxwc;
        Wed, 23 Mar 2022 10:45:24 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KNk43579yzlhFgC;
        Wed, 23 Mar 2022 10:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648028724;
        bh=E8eWbx/RSrlcEvnjFzLzNI7huChIghnY7KBIMWCfSms=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=t/L233tnlfrpmnDdg/GIONsW2nb41m+CGuPoTNBhEO3kz//oo0MfwvE48d2LPfBtR
         WIZ92QI3yORu6m9k9Y7BSjexSbf+VQ6AURvBM0wlP167JYSRvyrZPQImZfdj76LK+E
         0O0ARIJwVK45KsaVz8JIHAwopcMe/Vh1AAw6gA6g=
Message-ID: <2c6c684b-1380-d65e-78d2-b8ab7239ea4a@digikod.net>
Date:   Wed, 23 Mar 2022 10:45:22 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tom Rix <trix@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
References: <20220321115913.478505-1-mic@digikod.net>
 <CAADWXX_06uyx5KLE-6pv6pqQJ5qH4EqYiYK7rGK3zMyEZjW4dw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [GIT PULL] Landlock fixes for v5.18
In-Reply-To: <CAADWXX_06uyx5KLE-6pv6pqQJ5qH4EqYiYK7rGK3zMyEZjW4dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 21/03/2022 18:37, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 4:58 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> Please pull these Landlock updates for v5.18-rc1 .
> 
> Mickaël, both your pull requests (this and the 'trusted_for(2)' one)
> were marked as spam for me.
> 
> The reason seems to be that you're using a SMTP host that doesn't
> actually do modern anti-spam measures (no DKIM), and while it does do
> SPF, gmail really dislikes it.
> 
> There doesn't seem anything in particular standing out in the email
> itself, so I suspect your hosting provider (seems to be infomaniak.ch)
> ends up either being in a block of IP addresses that is also being
> used for spam, or it's just allowing a lot of spam itself.
> 
> Some people think that gmail is being way too restrictive about these
> kinds of things, but since I hate spam with a passion, I end up siding
> with rather strict spam measures.. Honestly, if an email provider
> doesn't do DKIM in this day and age, it's not a very good email
> provider imho.

Thanks, it should be good now. Is there anything else you want me to do?

Regards,
  Mickaël
