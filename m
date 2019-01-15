Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8821AC43444
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5592E20656
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 19:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aDmPsjwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfAOTwp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:52:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35616 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbfAOTwo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 14:52:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so3024385lfc.2
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 11:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AU24S+YzPMy9EhsY1e5c5P1gdmUxxFSVGKgC+A0fFo=;
        b=aDmPsjwntNCGE4a/0CiSnS/x/IeJc75soxR5dDmJZ58pgtu34Q1v267WKSGJW/BYaS
         //WjNPz4w0kG6ZCK6uox6uhgXq0W27e4myzcZvKJdWL+lVWZ12jNnSmBnYVTeLoOxGGC
         TDTXQ4SfxryTYN0bk3Nrl/N0e1PzI+Usjp/qwXNtWFyMZegIS/fhst5isFkBvElYjwYk
         Wfr9DqLQP2bblP9RjhleYEyIoeHl+rxaMAMktiURgIN1SglUIUJwwdZ4JlZeQJ6g6pzv
         e1/vv82u25Hd26ULhfXEZycbTPy8RPTTCmP+xruRyBdpDjM5LUBwOjiveqs5ypF1zTCL
         wS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AU24S+YzPMy9EhsY1e5c5P1gdmUxxFSVGKgC+A0fFo=;
        b=ZUSZoCh4tM9BskCLJj1KuNyrajDXD0ZBb+h+Idm/HC/i9XCApzjGIiH9M3EQXJj+/M
         j4xQtewJYyyInNRoFSEh+ve3/lAHhxlSnbsk/MMRL2ZkOldflxOteqvjmxYCI0OS1YHw
         a/YrWbmdLc6LCmGGz70E+88zBhdRDhsKLhqNkAwewm/nA7S5L1qWyruww84DZwOR23ZP
         t6PfIq49svtZvN4jVJPOprKcqq1M4347pU4X+M7fruzbxVkrpZLJHYDLMdyc4fn36O1O
         0cwS5GBG1+qmdGNFxKGSwRC+5W0+PbdOG8BCv7H4gaoWPCx/APSOQp8p685TefNYB1qL
         ZdUQ==
X-Gm-Message-State: AJcUukf/Nj3cwJLyd7i6JXrkKtDcKXqjUt304WsiKKXkXR/+/tAGMpfq
        fS02BXmxR8bDU/uzmh30FGeTTHBvQPoMljRZ3LeW
X-Google-Smtp-Source: ALg8bN5tYX/YVY8JGkKH2LfQikK5YwSt3BFSQaS3T5VlgyW//KFGvHvLi+Iy9T2f0pptWiKugriBr/LG5pDc7IOu01Q=
X-Received: by 2002:a19:5402:: with SMTP id i2mr4023804lfb.128.1547581962295;
 Tue, 15 Jan 2019 11:52:42 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net> <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com>
In-Reply-To: <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Jan 2019 14:52:30 -0500
Message-ID: <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 15, 2019 at 12:55 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/15/2019 9:06 AM, Nazarov Sergey wrote:
> > Hello!
> > Security modules (selinux, smack) use icmp_send for discarded incorrectly labeled network packets.
> > This could be on TCP level too (security_sock_rcv_skb -> cipso_v4_error for INET stream connection, for example).
> > icmp_send calls ip_option_echo, which uses IPCB to take compiled IP options.
> > After moving IP header data to the end of the struct tcp_skb_cb (since 3.18 kernel), this could lead to
> > kernel memory corruption when IP options copying.
>
> Can you explain how that corruption might occur?
> Do you have a test case?

Thanks for pointing this out Nazarov.

Presumably we are going to hit a problem whenever icmp_send is called
from outside the IP layer in the stack.  We fixed a similar problem a
few years back with 04f81f0154e4 ("cipso: don't use IPCB() to locate
the CIPSO IP option").

I've CC'd netdev, as I'm guessing they will have some thoughts on
this, but my initial reaction is that your proposed patch isn't as
generic as it should be for code that lives in icmp_send().  I suspect
the safe thing to do would be to call ip_options_compile() again on
skb_in and build a local copy of the ip_options struct that could then
be used in the call to __ip_options_echo(); the code could either live
in icmp_send() or some new ip_options_echo() variant
(ip_options_echo_safe()?  I dunno).  Unfortunately, calling
ip_options_compile() is going to add some overhead, and may be a
non-starter for the netdev folks, but this is error path code, so it
might be acceptable.  Hopefully the netdev folks will have some
better, more clever suggestions.

> > This patch fix a bug, but I'm not sure, that this is a best solution. Perhaps someone more familiar with the
> > linux TCP/IP stack will offer a better one.
> > Thanks.
> >
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -679,7 +679,8 @@ void icmp_send(struct sk_buff *skb_in, i
> >                                         iph->tos;
> >       mark = IP4_REPLY_MARK(net, skb_in->mark);
> >
> > -     if (ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in))
> > +     if (__ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in,
> > +                     ip_hdr(skb_in)->protocol == IPPROTO_TCP ? &TCP_SKB_CB(skb_in)->header.h4.opt : &IPCB(skb_in)->opt))
> >               goto out_unlock;
> >
> >



-- 
paul moore
www.paul-moore.com
