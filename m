Return-Path: <SRS0=9Sj3=7O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C66C433DF
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Jun 2020 17:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8F5206E2
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Jun 2020 17:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFARy0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFARy0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Jun 2020 13:54:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66AEC05BD43;
        Mon,  1 Jun 2020 10:54:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7267D2A2519
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Paul Gofman <gofmanp@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-security-module@vger.kernel.org,
        Zebediah Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Organization: Collabora
References: <20200530055953.817666-1-krisman@collabora.com>
        <202005300923.B245392C@keescook> <851rn0ejg9.fsf@collabora.com>
        <9a512096-7707-3fc6-34ba-22f969c0f964@gmail.com>
        <20200531164938.GF19604@bombadil.infradead.org>
        <c007e3e9-e915-16f3-de31-c811ad37c44c@gmail.com>
        <20200531173157.GG19604@bombadil.infradead.org>
        <9c1f9db8-5680-cd1a-37aa-5f494b034825@gmail.com>
Date:   Mon, 01 Jun 2020 13:54:19 -0400
In-Reply-To: <9c1f9db8-5680-cd1a-37aa-5f494b034825@gmail.com> (Paul Gofman's
        message of "Sun, 31 May 2020 21:01:46 +0300")
Message-ID: <85367e7juc.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Paul Gofman <gofmanp@gmail.com> writes:

> On 5/31/20 20:31, Matthew Wilcox wrote:
>> If it's the cost of the syscall that's the problem, there are ways
>> around that.  We'd still want a personality() call to indicate that
>> the syscall handler should look (somewhere) to determine the current
>> personality, but that could be issued at the start of execution rather
>> than when we switch between Windows & Linux code.
>
> Sure, we can call personality() at start and specify the location to
> look at, the only thing is that the location should be thread specific,
> that is, based on fs: or gs: or whatever else which would allow us to
> have different threads in different "personality" state. If anything
> needs to be set up at thread start we can do that also of course.
>
> If there will be any proof of concept solution I will be happy to make a
> proof of concept Wine patch using that and do some testing.

Let me give that a try and share the patches with you, so we can look at
how this implementation would look like.

-- 
Gabriel Krisman Bertazi
