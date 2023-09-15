Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D10EE6457
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Sep 2023 11:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjIOLaI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjIOLaH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Sep 2023 07:30:07 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F711B0
        for <linux-security-module@vger.kernel.org>; Fri, 15 Sep 2023 04:30:00 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38FBTtfe019206;
        Fri, 15 Sep 2023 20:29:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Fri, 15 Sep 2023 20:29:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38FBTsxT019201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Sep 2023 20:29:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4a6b6e2c-9872-4d4c-e42e-4ff0fb79f3ae@I-love.SAKURA.ne.jp>
Date:   Fri, 15 Sep 2023 20:29:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
 <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
 <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/12/2023 11:08 AM, Paul Moore wrote:
> Once again, we've already discussed this many, many times: out-of-tree
> LSMs are not the priority and that is not going to change.  One
> corollary of this is that we are not going to assign LSM IDs to LSMs
> that remain out-of-tree as this would negatively impact the LSM layer
> by cluttering/depleting the LSM ID space.  LSMs that are working
> towards integration with the upstream Linux kernel can self-assign a
> temporary LSM ID which will be finalized upon merging in the LSM tree.
> Based on all of the arguments you have already submitted - and let us
> be very clear: you are the only one speaking out against this - I see
> no reason to change this policy.

The sane and the better usage of LSM ID is to register any publicly available
LSMs. If LSM ID serves as an index for what LSMs are available in the world,
by maintaining "the LSM module name, the LSM ID value, short description about
that LSM module, the public git repository or web site for more information
about that LSM module" pairs, people can easily find what LSMs could be used
for their purpose, and developers can avoid re-inventing similar LSM modules
which are already available somewhere in the world (and optionally helps
avoiding module name collisions with any publicly available LSMs).

If you worry about cluttering/depleting the LSM ID space, don't assign
64 bits for LSM ID; the LSM community won't accept 100+ LSMs for in-tree.

+/**
+ * struct lsm_id - Identify a Linux Security Module.
+ * @lsm: name of the LSM, must be approved by the LSM maintainers
+ * @id: LSM ID number from uapi/linux/lsm.h
+ *
+ * Contains the information that identifies the LSM.
+ */
+struct lsm_id {
+	const char	*name;
+	u64		id;
+};

Developers will more likely to abuse LSM ID (as if randomly generated GUID, or
something like 0xdeadbeef) if the LSM community does not allow out-of-tree
LSM modules to have a persistent registration. Once some value is assigned and
published via a publicly available git repository by the LSM module author,
the merit of "LSM: Identify modules by more than name" will be lost.

> As discussed many times prior, I consider in-tree, upstreamed LSMs my
> priority when it comes to decision making.  LSMs which are under
> development and are working to be merged come next, and LSMs which
> have decided to remain out-of-tree remain last.  I do not
> intentionally plan to make life difficult for the out-of-tree LSMs,
> but if that happens as a result of design decisions intended to
> benefit in-tree LSMs that is acceptable as far as I am concerned.  You
> are free to disagree, but I believe the policy I've described here is
> consistent with the bulk of the other kernel subsystems and I have no
> plans to change this policy.

I don't care if out-of-tree code encounters build failures like
https://sourceware.org/bugzilla/show_bug.cgi?id=30831 due to changing
in-kernel APIs. That's what remaining out-of-tree means. But they have
the rights/freedom to fix and load and run their code using their resources.

In-tree Linux kernel developers do not prevent out-of-tree Linux kernel
developers from loading and running their out-of-tree code. I absolutely
resist if out-of-tree code encounters loss of ability to load and run
that code (e.g. sys_init_module() prevents out-of-tree modules from
loading because your priority of out-of-tree modules is the lowest).

Although LKM-based LSM modules are not currently supported, people have
the rights/freedom to load and run out-of-tree LSM modules by rebuilding
their kernels.

Those who develop a kernel module have rights/freedom to give any name.
But as a whole, developers try to avoid identifier collisions.

You are intentionally making life difficult for the out-of-tree LSMs, by
requiring an LSM ID (and facilitating LSM ID collisions). No matter how
priority of out-of-tree LSMs is low for you, what you are about to merge
goes against the "developers try to avoid identifier collisions" effort.

Introducing a numeric identifier is a good opportunity for permanently
eliminating possibility of identifier collisions. But current usage of this
numeric identifier is designed for facilitating possibility of identifier
collisions.

