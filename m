Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B89EC2D0A3
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 03:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BD82067B
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 03:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKJDPR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Nov 2020 22:15:17 -0500
Received: from namei.org ([65.99.196.166]:39792 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKJDPR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Nov 2020 22:15:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AA3Et8b032521;
        Tue, 10 Nov 2020 03:14:55 GMT
Date:   Tue, 10 Nov 2020 14:14:55 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>
cc:     serge@hallyn.com, akinobu.mita@gmail.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>, mortonm@chromium.org
Subject: Re: [PATCH v3 0/2] security: add fault injection to LSM hooks
In-Reply-To: <CAFSQ=y455bVOGMpRW86Gto+WdL1idxSXM0RPifokEotyg2ccjg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2011101414330.30138@namei.org>
References: <20201029183526.2131776-1-aleksandrnogikh@gmail.com> <CAFSQ=y455bVOGMpRW86Gto+WdL1idxSXM0RPifokEotyg2ccjg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 9 Nov 2020, Aleksandr Nogikh wrote:

> On Thu, 29 Oct 2020 at 21:35, Aleksandr Nogikh
> <aleksandrnogikh@gmail.com> wrote:
> >
> > From: Aleksandr Nogikh <nogikh@google.com>
> >
> > Fault injection capabilities[Documentation/fault-injection/fault-injection.rst]
> > facilitate testing of the stability of the Linux kernel by providing
> > means to force a number of kernel interfaces to return error
> > codes. This patch series proposes adding such fault injection
> > capability into LSM hooks.
> >
> > The intent is to make it possible to test whether the existing kernel
> > code properly handles negative return values of LSM hooks. Syzbot
> > [https://github.com/google/syzkaller/blob/master/docs/syzbot.md] will
> > automatically do that with the aid of instrumentation tools once these
> > changes are merged.
> > [...]
> 
> What tree should these changes go to?
> 

Mine, but more signoffs/acks are required.

> Is there anyone else who is not on the recipient list but still might
> be interested in the series?
> 

-- 
James Morris
<jmorris@namei.org>

