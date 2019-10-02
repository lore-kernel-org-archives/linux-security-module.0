Return-Path: <SRS0=xhHr=X3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B3C352AA
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Oct 2019 08:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3941218DE
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Oct 2019 08:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfJBI7U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:59:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58125 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBI7T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Oct 2019 04:59:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iFaTa-0006Ku-3E; Wed, 02 Oct 2019 10:59:14 +0200
Date:   Wed, 2 Oct 2019 10:59:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
Subject: Re: [PATCH v4] apparmor: Use a memory pool instead per-CPU caches
Message-ID: <20191002085913.xs3oglbegsjrrrcq@linutronix.de>
References: <02d7772b-5d06-1c32-b089-454547fbe08b@canonical.com>
 <20190502105158.2hluemukrdz5hbus@linutronix.de>
 <7b41609f-2592-93c1-55f7-6026ff6dba26@I-love.SAKURA.ne.jp>
 <20190502134730.d3ya46ave6a7bvom@linutronix.de>
 <001f651f-c544-c3fa-c0c2-f2a2b1ed565a@i-love.sakura.ne.jp>
 <20190503114827.yky7r2cjq7zy4dfm@linutronix.de>
 <20190503115145.anv7z4kk7okydthm@linutronix.de>
 <56de7347-b119-155d-675c-23a227ffd516@i-love.sakura.ne.jp>
 <20190503141221.qvqdfbfmmmzc7gfr@linutronix.de>
 <b2bb1be2-2130-3d77-2430-1de526accf2a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2bb1be2-2130-3d77-2430-1de526accf2a@canonical.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019-05-07 12:57:04 [-0700], John Johansen wrote:
> I am going to pull this into my tree and let it sit in linux-next
> for a cycle so we can get better testing on this before it is pushed
> out

We talked about this during the merge window for 5.2-rc1. These changes
were not part of 5.4-rc1. Was there a fallout, anything I can help with?

Sebastian
