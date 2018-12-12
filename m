Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C8C65BAF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 19:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E6620851
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 19:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E6620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeLLTd0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:33:26 -0500
Received: from namei.org ([65.99.196.166]:51308 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbeLLTd0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 14:33:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBCJXKEO029554;
        Wed, 12 Dec 2018 19:33:20 GMT
Date:   Thu, 13 Dec 2018 06:33:20 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
In-Reply-To: <d0910aed-5e4e-201d-f452-fa61e87183c5@i-love.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.1812130632120.29507@namei.org>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com> <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com> <alpine.LRH.2.21.1812120556040.11653@namei.org> <d0910aed-5e4e-201d-f452-fa61e87183c5@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 12 Dec 2018, Tetsuo Handa wrote:

> On 2018/12/12 3:57, James Morris wrote:
> > On Tue, 4 Dec 2018, Kees Cook wrote:
> > 
> >> On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> v5: Include Kees Cook's rework of the lsm command
> >>>     line interface. Stacking is not conditional.
> >>
> >> Can you resend this series with corrected "From:" lines in the body, etc?
> >>
> >> Beyond that, I obviously like it. James, what's needed for this to move forward?
> > 
> > If there are no outstanding issues, I plan to merge this for 4.21.
> > 
> 
> Then, can we send it to linux-next.git shortly
> so that we can have some time for testing by syzbot?

It's best to let the 4.20 cycle complete (so as not to confuse things 
there) and then merge it for next in -rc1.


-- 
James Morris
<jmorris@namei.org>

