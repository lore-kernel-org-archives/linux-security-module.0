Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F2BC4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Nov 2022 23:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiKIX5r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKIX5q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 18:57:46 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E9248C8
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 15:57:45 -0800 (PST)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A9NvALS091732;
        Thu, 10 Nov 2022 08:57:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Thu, 10 Nov 2022 08:57:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A9Nv973091729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Nov 2022 08:57:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <82e46552-54da-6df5-c451-485991dcb5c3@I-love.SAKURA.ne.jp>
Date:   Thu, 10 Nov 2022 08:57:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
 <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
 <20221105234614.GA23523@mail.hallyn.com>
 <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
 <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com>
 <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp>
 <CAHC9VhS9RQdeCipSpSH3_LZyFfb-BDry=EsSmkt4OLVk=OZnEg@mail.gmail.com>
 <f52e6e9f-5e95-8843-c2f5-c50bba48e5e4@I-love.SAKURA.ne.jp>
 <CAHC9VhS=0Ts8E647JJiJ6dwPmnuLuYTyOS0QEYJO_EmAb3yFcw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhS=0Ts8E647JJiJ6dwPmnuLuYTyOS0QEYJO_EmAb3yFcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/11/09 23:48, Paul Moore wrote:
>                                             If there is a significant
> change, e.g. the overall kernel policy towards out-of-tree code, we
> can reconsider this policy but as of right now only upstream LSMs will
> have LSM ID tokens assigned to them; in-development LSMs are free to
> temporarily assign themselves an ID token (which may change when the
> LSM is merged upstream), and out-of-tree LSMs are free to do whatever
> they like with respect to their code, just as they do now.

If in-development LSMs and out-of-tree LSMs cannot get a stable ID token,
developers cannot write and publish userspace tools which make use of ID
token. If ID collision happens by use of temporarily ID token, this token
is no longer an identifier. That is a pointless and needless constraint
for getting LSM modules created / tested / used.

