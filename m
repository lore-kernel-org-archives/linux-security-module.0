Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00253EEB57B
	for <linux-security-module@archiver.kernel.org>; Sat,  9 Sep 2023 01:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjIIBlM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Sep 2023 21:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjIIBlK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Sep 2023 21:41:10 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2298C186
        for <linux-security-module@vger.kernel.org>; Fri,  8 Sep 2023 18:40:40 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3890k4an028147;
        Sat, 9 Sep 2023 09:46:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sat, 09 Sep 2023 09:46:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3890k3BX028144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Sep 2023 09:46:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
Date:   Sat, 9 Sep 2023 09:46:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/03 7:00, Paul Moore wrote:
> * The new LSM must be sufficiently unique to justify the additional work
> involved in reviewing, maintaining, and supporting the LSM.  It is reasonable
> for there to be a level of overlap between LSMs, but either the security model
> or the admin/user experience must be significantly unique.

s/work/burden/ ?

> * Any userspace tools or patches created in support of the LSM must be publicly
> available, with a public git repository preferable over a tarball snapshot.

What is the definition of "publicly" here? Everyone can download related resources
including the source code etc. anonymously (e.g. without asking for creating user
account and/or buying subscriptions ) ?



If one of userspace tools designed for the new LSM depends on the LSM ID, when can
the author of the new LSM obtain the stable LSM ID for that LSM ?

This might trigger a catch-22 situation while reviewing, for the author of such
userspace tools will not be able to publish on a publicly available git repository
without the stable LSM ID whereas LSM people say that only in-tree LSMs get the
stable LSM ID. If userspace tools needs to be publicly available while reviewing,
a stable LSM ID must be assigned for that LSM in order to allow userspace tools
being published on a publicly available git repository by the moment the author
of a new LSM proposes that LSM to the community for review.

I'm still against the "only in-tree LSMs get the stable LSM ID" part. As long as
someone developed an LSM in a manner that is publicly available, a stable LSM ID
should be assigned, regardless of whether that LSM succeeds in becoming one of
in-tree LSMs.

