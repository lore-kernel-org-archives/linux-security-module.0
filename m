Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD90EC001E0
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Jul 2023 01:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjG1Bzf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jul 2023 21:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjG1Bze (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jul 2023 21:55:34 -0400
Received: from mfwd27.mailplug.co.kr (mfwd27.mailplug.co.kr [14.63.193.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EB1173F
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jul 2023 18:55:27 -0700 (PDT)
Received: (qmail 4969 invoked from network); 28 Jul 2023 10:55:23 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        28 Jul 2023 10:54:23 +0900
Received: (qmail 1706683 invoked from network); 28 Jul 2023 10:54:23 +0900
Received: from unknown (HELO sslauth27) (lsahn@wewakecorp.com@211.252.85.38)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        28 Jul 2023 10:54:23 +0900
Message-ID: <02da6484-658c-bfe8-0ae0-08ffe9b93c47@wewakecorp.com>
Date:   Fri, 28 Jul 2023 10:54:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [LSM Stacking] SELinux policy inside container affects a
 processon Host
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
 <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I hope you have a great day today

2023-07-07 오후 11:20에 Paul Moore 이(가) 쓴 글:
> On Fri, Jul 7, 2023 at 4:29 AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:

[...]

> 
> What you are looking for is a combination of LSM stacking and
> individual LSM namespacing. Sadly, I think the communications around
> LSM stacking have not been very clear on this and I worry that many
> people are going to be disappointed with LSM stacking for this very
> reason.
> 
> While stacking of LSMs is largely done at the LSM layer, namespacing
> LSMs such that they can be customized for individual containers
> requires work to be done at the per-LSM level as each LSM is
> different. AppArmor already has a namespacing concept, but SELinux
> does not. Due to differences in the approach taken by the two LSMs,
> namespacing is much more of a challenge for SELinux, largely due to
> issues around filesystem labeling. We have not given up on the idea,
> but we have yet to arrive at a viable solution for namespacing
> SELinux.
> 
> If you are interested in stacking SELinux and AppArmor, I believe the
> only practical solution is to run SELinux on the host system (initial
> namespace) and run AppArmor in the containers. 

Paul, I don't get that SELinux on the host system and run AppArmor in 
the containers is the only practical solution. Could you please explain 
that in more details?

Best regards,
Leesoo
