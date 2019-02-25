Return-Path: <SRS0=Ku0V=RA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE486C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 23:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6F217F5
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 23:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RAK+qS1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfBYXa2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:30:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43082 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfBYXa1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Feb 2019 18:30:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id z20so9028514ljj.10
        for <linux-security-module@vger.kernel.org>; Mon, 25 Feb 2019 15:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bmacpr0d0HuuaZOGBfQ1TYDYn0+Nzf9xjT1lLtRo4X8=;
        b=RAK+qS1cPv3XlGB3bhdjq+oQwc6M6yZVtpEVECPhWrK9pQtpNLE2Q6zgYcCJT6ODmA
         StWCQMXs0PiRfmlpOPdR+ngTCpOdtZIqBr29iLYXOUGc0OSSQmIOIi46vgsX0GYCXAp5
         J3jg/w/L/Pvweo8ocxUSZnHW+alc5AEvcxDmGXX+cJtssW4nAhfU0IQGYwdGjQ08Eu5X
         NhsEzNRmGzIyi8MKDlB8CF6KO68YZMXpjqDWj0n8DLM3UNiHj+/iMcIzkonDXEk2vLwh
         PhJr38M9/Wdn3YYFjJbKT9r+fLWshBQIes1vk53nBlUNautfCbmI9d2p2xntyjwfI0YK
         CR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bmacpr0d0HuuaZOGBfQ1TYDYn0+Nzf9xjT1lLtRo4X8=;
        b=PvFlVOKl+VdNknB15g2kNs5vjZDr1LqLV1QB+ifYpr08U+Ama3rr4+dkhhZPG4Lqhg
         5IctQgJjJf2t41biqUMGNtsoE/aAyTZ8CHewEd+42x419s8rymSftVWTFvwBYiBKSBoU
         N5/6csK79JscvhkxCBOiyO5yCMqlymkqO2rktXmn+rX4QLlsWYacofEok+tzX2dhDOp1
         1BrIuqtNI+dorGCAXDNt7PPVx1/BL6rkAbBUbMksTxHJaiV/kaPXUnWvAlmx7SsK4oUa
         MrVyaKElp3NJp0ohl4qHAJpNTxbquKxLspNWVsEBxAcuNeEl4eFpCQY8IqODeviJ7glU
         eJhw==
X-Gm-Message-State: AHQUAuYj+WvKWzi6D6lAassJHnyF4thMwovwkV1atLOaHwSjfPTrVKGW
        2W8nviPkcaWyQVa3Y5J9304oMQtWrXp/tNyJtyf+
X-Google-Smtp-Source: AHgI3IYbJqyaQixd1jGR1QiqaPRfbuljgOEcQnEkU2qSvb8emsaa+kigSXyTRzkjw93ZuIhqgWZWdat+plrPf2Oo4dA=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr11349261ljk.169.1551137425525;
 Mon, 25 Feb 2019 15:30:25 -0800 (PST)
MIME-Version: 1.0
References: <33533951550857169@myt3-2475c4d2af83.qloud-c.yandex.net>
 <20190224.173328.1032826011262803545.davem@davemloft.net> <52295911551111855@myt5-f1576e7b5bad.qloud-c.yandex.net>
 <20190225.143355.245256286926542053.davem@davemloft.net>
In-Reply-To: <20190225.143355.245256286926542053.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Feb 2019 18:30:14 -0500
Message-ID: <CAHC9VhRqtrJHd=mHn8WTBCOw6uYyAcbmeZ+cTc_Y85QT4srqrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] NETWORKING: avoid use IPCB in cipso_v4_error
To:     David Miller <davem@davemloft.net>
Cc:     s-nazarov@yandex.ru, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 25, 2019 at 5:33 PM David Miller <davem@davemloft.net> wrote:
> From: Nazarov Sergey <s-nazarov@yandex.ru>
> Date: Mon, 25 Feb 2019 19:24:15 +0300
>
> > Add __icmp_send function having ip_options struct parameter
> >
> > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
>
> Applied with Subject line fixes up.  This commit doesn't even make
> changes to cipse_v4_error().
>
> Anyone who ACK'd this change or added their Reviewed-by did not read
> this email and are just rubber stamping crap.

I should have checked the subject line closer that's my fault (Gmail
does interesting things to threads sometimes, and obscured the subject
line), however, I did look at the content of patch before giving it my
thumbs up.  Claiming the email wasn't read isn't correct (although you
could rightly argue I didn't read the subject line), or I'm "rubber
stamping crap" isn't correct.

-- 
paul moore
www.paul-moore.com
