Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93B2C07EBF
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6E220850
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 18:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hjTPlIWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfARSC4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:02:56 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:41836
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728576AbfARSCz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Jan 2019 13:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547834574; bh=NsOBtX/TFaisOJ3guSquSkXb+3ljI8RkExC2mWN3Eyk=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=hjTPlIWL6cJeq3bA0ka8RCJF06ooYtI5+L92kc+TmsL9mx7o3sSfzfKeeZ1qPVzKrQ3hynN5dgqQ1JKnjk6SR7RNbm10NTm1HtfiQojbShpgr57Uev5/XUJkfYNoSVhruHQfr75bhK3dnH0EIkyUxOhJSGqD1Dl74eo3NrK4rq52l+kjhJOkFjbrGY0/bcYk0nsvPOdOiGOhV4xxzj+Q98Kw61qGf2o541paLqJ886I2piblWuYqKPiOpQ13G8F0+OFuBji2H6l9ZYM5sqYwdDvv6lkqQd/J+HUA9smUHTSWT6V+K7Tb7Zbaj0DscAsWCg8GHfxvtlvkfPHzWgE2iA==
X-YMail-OSG: 3i_pjUYVM1mbhw7jamI5Xn126InMsxWA4UGjSZFtay5Oi4eOWylT2e45j0MZ5PH
 NavUC3gaG5bVr2eGhDRsjQXKaG0FTtgknWLDkTVZFEdSGAZeH3HzSjt9XsD1yIn8jpzeyuH4Jw.o
 yQ9iROCW29EAkOvZONLJf4jpQv8K1PE6vAwGSB1jmdrovkcFq88GMoqAJpLhYxN.BOu2ASG2b_6d
 Gm4BiwDe3_EUMXBETR0vU4Dv5T8XEO_dmc1WtIQHINF5z2_6ypyGdCcvK30UIJjxvgPcA3SBKo8l
 EZgv0s2jsti8gdXAidug5lz_OTkc1Oww5EzYf5DrAKh6sDG0D90lzg0puAXjMEj.0TKVKtfdKMcb
 RdfFRmcfckeJ1ZTURkzbu7Brn43FNG6maOPfkS0XNFi25QWaUkijyHQrhI0uiCwcJ0aZF.yCLlQQ
 dsCvP0O5w9oO8kf.XocmIuzqUYS3RDabQ52eEQotR175M_ZqqVdsWLY7Ata.v5Gx8Q3LFyksHgqB
 EXQxvLFJknN0wmh5YLT3T44kI3A1QwmcwJpeC7ppwA4Y_SyzwXYOrnpkZ.CXViU_KSkNLmIsk2g6
 TZ5rlLNEUGxzVwc846dxlPhMcBPLyBAAwQn.o5oBDiFBNLWN5lTz7MRcveDnAxg4Cg8zUZsBYj2c
 nFnSsNtnFBMyy9ys6FS9QZwjy4nvrgIFQMUUr8UXfGTdyP.wodXtCkk96U72pEnt0FjlR71mHkEK
 KVZ3HWIJkJLzrIx2pxWQFUPKNvJ4dak9fZu1YRgVVwRQWi45ok9NeTyr2HVpbDXd1IHULeIe92xH
 hIBs0ECW1NS6g4oAaRL8GabjoIaCSLHACFKal9Ozef9_bCULcC.3NCrjVQtvNhCxc5JLj613ZVfw
 0w7jJayirTWEPhHY4FZTf3_dp_mcMMhrGInDzegazCoKaUnapmBNhyR1uS9dEVdpenP8KQ1Qx8Tl
 j5.BDZgYwdNj6fPUZG1.X.y6Nh6T8rzlFCTNgskfzOz5CBepnPZT7QdcObBbiturXhe6157kBO1h
 .0XCcf0YwvbO2pgl4GAhAYVp5OyvGGHXUHETgwBnbCgksJJ8ZCZe_vkDVceaQsSIH4zzbGaBjVHv
 Jl2IyefmO8g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Jan 2019 18:02:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a54cb2e9962e9d4c8ff27fcef8e0fa02;
          Fri, 18 Jan 2019 18:02:51 +0000 (UTC)
Subject: Re: [PATCH] tomoyo: Swicth from cred->security to
 task_struct->security.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org
References: <1547806711-13571-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <ae8a9cbb-bca6-f850-d4c4-6abe61a4d9bf@schaufler-ca.com>
 <c1455a86-2444-9e60-23be-a98a77f87fa5@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <538ebe59-c25a-5eeb-e371-55fb8fd6fc39@schaufler-ca.com>
Date:   Fri, 18 Jan 2019 10:02:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c1455a86-2444-9e60-23be-a98a77f87fa5@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/18/2019 9:17 AM, Tetsuo Handa wrote:
> On 2019/01/19 2:01, Casey Schaufler wrote:
>>> -/**
>>> - * tomoyo_real_domain - Get "struct tomoyo_domain_info" for specified thread.
>>> - *
>>> - * @task: Pointer to "struct task_struct".
>>> + * @task - Pointer to "struct task_struct".
>>>   *
>>>   * Returns pointer to "struct tomoyo_security" for specified thread.
>>>   */
>>> -static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
>>> -							    *task)
>>> +static inline struct tomoyo_security *tomoyo_security(struct task_struct *task)
>> Could you use tomoyo_task() instead of tomoyo_security()?
> Possible. But tomoyo_task() might be more confusing because it sounds like
> "struct task_struct" when it actually returns "struct task_struct"->security.
>
> Isn't tomoyo_task_security() better if I rename?

To my mind that just adds a _security suffix in a place where
we pretty well know you're doing something about security. I
used the <lsm>_<blob>() convention in part because it was usually
no longer than referencing the blob. smack_cred(cred) isn't
much longer than cred->security, whereas smack_cred_blob()
or smack_cred_security_blob() would be. I admit that I'm
looking at it from the viewpoint of someone who cares more about
how security modules are structured in general than I am in
how a specific module works.

In the end it's your code, but I hate to see divergence so
soon after I put a bit of order in place. 

>> To the extent that it's been possible I've worked to add
>> consistency in the security modules, and this breaks it.
> Do you want me to rename
>
> /* Structure for "struct task_struct"->security. */
> struct tomoyo_security {
> 	struct tomoyo_domain_info *domain_info;
> 	struct tomoyo_domain_info *old_domain_info;
> };
>
> to "struct tomoyo_task" or "struct tomoyo_task_security" as well?

tomoyo_task would be my choice. Again, isn't appending _security
to things just adding keystrokes?

