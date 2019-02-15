Return-Path: <SRS0=pLHH=QW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5644C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF04D21B18
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 20:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBOUAL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:00:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44918 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOUAL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Feb 2019 15:00:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 36655106CF194;
        Fri, 15 Feb 2019 12:00:10 -0800 (PST)
Date:   Fri, 15 Feb 2019 12:00:09 -0800 (PST)
Message-Id: <20190215.120009.1549205062473501080.davem@davemloft.net>
To:     paul@paul-moore.com
Cc:     s-nazarov@yandex.ru, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHC9VhQK6Cmcx5kwYAPipR4YGyBHdkLEe3UH+VmNYGHu4PWqjQ@mail.gmail.com>
References: <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net>
        <20190214.084343.1138362153341500718.davem@davemloft.net>
        <CAHC9VhQK6Cmcx5kwYAPipR4YGyBHdkLEe3UH+VmNYGHu4PWqjQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Feb 2019 12:00:10 -0800 (PST)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Feb 2019 14:02:31 -0500

> On Thu, Feb 14, 2019 at 11:43 AM David Miller <davem@davemloft.net> wrote:
>> From: Nazarov Sergey <s-nazarov@yandex.ru>
>> Date: Tue, 12 Feb 2019 18:10:03 +0300
>>
>> > Since cipso_v4_error might be called from different network stack layers, we can't safely use icmp_send there.
>> > icmp_send copies IP options with ip_option_echo, which uses IPCB to take access to IP header compiled data.
>> > But after commit 971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses"), IPCB can't be used
>> > above IP layer.
>> > This patch fixes the problem by creating in cipso_v4_error a local copy of compiled IP options and using it with
>> > introduced __icmp_send function. This looks some overloaded, but in quite rare error conditions only.
>> >
>> > The original discussion is here:
>> > https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
>> >
>> > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
>>
>> This problem is not unique to Cipso, net/atm/clip.c's error handler
>> has the same exact issue.
>>
>> I didn't scan more of the tree, there are probably a couple more
>> locations as well.
> 
> David, are you happy with Sergey's solution as a fix for this?
> 
> If so, would you prefer a respin of this patch to apply the to the
> other broken callers (e.g. net/atm/clip.c), or would you rather merge
> this patch and deal with the other callers in separate patches?

I'd like the other broken callers to be handled.
