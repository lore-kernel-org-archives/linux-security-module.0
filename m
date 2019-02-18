Return-Path: <SRS0=s2IT=QZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42098C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Feb 2019 13:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213A21872
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Feb 2019 13:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="QrHaLF0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfBRNjS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:39:18 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:39448 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727483AbfBRNjS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Feb 2019 08:39:18 -0500
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 98A761E8054D;
        Mon, 18 Feb 2019 16:39:13 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback14j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BiyURNAmi4-dBGeCrEX;
        Mon, 18 Feb 2019 16:39:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550497152;
        bh=9ipw3FavveuSmTbeYKUzwcYkvsCng18ZyCpXSVAwHPg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=QrHaLF0TBeooGnBmgdFv1CNkJPdyX0JNiSvgg+NTtej4d+Q1GMaCTCVvIAUWODq+y
         bd2Mi3qXbGgFNEjPky8/8LDQoOzxYqvH2VRwJPZ132yP8vOthU5j771hfvzzgBPfw8
         Wh06ODWpQeemWvFYn2c+k41Gmhb9I60BrHImQcjg=
Authentication-Results: mxback14j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva7-d29a8296bc3c.qloud-c.yandex.net with HTTP;
        Mon, 18 Feb 2019 16:39:11 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
In-Reply-To: <CAHC9VhRys7Efm=aQqph2ug9c8Ryra9imEG66avjeEeY8QZWTqw@mail.gmail.com>
References: <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net>
         <20190214.084343.1138362153341500718.davem@davemloft.net> <CAHC9VhQK6Cmcx5kwYAPipR4YGyBHdkLEe3UH+VmNYGHu4PWqjQ@mail.gmail.com>
         <20190215.120009.1549205062473501080.davem@davemloft.net> <CAHC9VhRys7Efm=aQqph2ug9c8Ryra9imEG66avjeEeY8QZWTqw@mail.gmail.com>
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 18 Feb 2019 16:39:11 +0300
Message-Id: <1122331550497151@iva7-d29a8296bc3c.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I think, it would not be a good solution, if I will analyze all subsystems using icmp_send, because I do not have enough knowledge for this.
I propose to add a new function, for example, ismp_send_safe, something like that:

void icmp_send_safe(struct sk_buff *skb_in, int type, int code, __be32 info)
{
	unsigned char optbuf[sizeof(struct ip_options) + 40];
	struct ip_options *opt = (struct ip_options *)optbuf;

	memset(opt, 0, sizeof(struct ip_options));
	opt->optlen = ip_hdr(skb_in)->ihl*4 - sizeof(struct iphdr);
	memcpy(opt->__data, (unsigned char *)&(ip_hdr(skb_in)[1]), opt->optlen);
	if (ip_options_compile(dev_net(skb_in->dev), opt, NULL))
		return;
	__icmp_send(skb_in, type, code, info, opt);
}

which could be used when the code works at different network stack layers.
And the subsystems developers, knowing their code well, will decide which one to use.

15.02.2019, 23:04, "Paul Moore" <paul@paul-moore.com>:
> On Fri, Feb 15, 2019 at 3:00 PM David Miller <davem@davemloft.net> wrote:
>>  From: Paul Moore <paul@paul-moore.com>
>>  Date: Fri, 15 Feb 2019 14:02:31 -0500
>>
>>  > On Thu, Feb 14, 2019 at 11:43 AM David Miller <davem@davemloft.net> wrote:
>>  >> From: Nazarov Sergey <s-nazarov@yandex.ru>
>>  >> Date: Tue, 12 Feb 2019 18:10:03 +0300
>>  >>
>>  >> > Since cipso_v4_error might be called from different network stack layers, we can't safely use icmp_send there.
>>  >> > icmp_send copies IP options with ip_option_echo, which uses IPCB to take access to IP header compiled data.
>>  >> > But after commit 971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses"), IPCB can't be used
>>  >> > above IP layer.
>>  >> > This patch fixes the problem by creating in cipso_v4_error a local copy of compiled IP options and using it with
>>  >> > introduced __icmp_send function. This looks some overloaded, but in quite rare error conditions only.
>>  >> >
>>  >> > The original discussion is here:
>>  >> > https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
>>  >> >
>>  >> > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
>>  >>
>>  >> This problem is not unique to Cipso, net/atm/clip.c's error handler
>>  >> has the same exact issue.
>>  >>
>>  >> I didn't scan more of the tree, there are probably a couple more
>>  >> locations as well.
>>  >
>>  > David, are you happy with Sergey's solution as a fix for this?
>>  >
>>  > If so, would you prefer a respin of this patch to apply the to the
>>  > other broken callers (e.g. net/atm/clip.c), or would you rather merge
>>  > this patch and deal with the other callers in separate patches?
>>
>>  I'd like the other broken callers to be handled.
>
> Sergey, do you think you could fix the other callers too, or do you
> want some help with that?
>
> --
> paul moore
> www.paul-moore.com
