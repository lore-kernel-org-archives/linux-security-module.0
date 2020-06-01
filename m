Return-Path: <SRS0=9Sj3=7O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F7C433DF
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Jun 2020 17:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0773F206E2
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Jun 2020 17:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFARxR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:53:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41466 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFARxR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Jun 2020 13:53:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7A1252A2519
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Paul Gofman <gofmanp@gmail.com>, Kees Cook <keescook@chromium.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
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
Date:   Mon, 01 Jun 2020 13:53:11 -0400
In-Reply-To: <20200531164938.GF19604@bombadil.infradead.org> (Matthew Wilcox's
        message of "Sun, 31 May 2020 09:49:38 -0700")
Message-ID: <857dwq7jw8.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Sun, May 31, 2020 at 03:39:33PM +0300, Paul Gofman wrote:
>> > Paul (cc'ed) is the wine expert, but my understanding is that memory
>> > allocation and initial program load of the emulated binary will go
>> > through wine.  It does the allocation and mark the vma accordingly
>> > before returning the allocated range to the windows application.
>> Yes, exactly. Pretty much any memory allocation which Wine does needs
>> syscalls (if those are ever encountered later during executing code from
>> those areas) to be trapped by Wine and passed to Wine's implementation
>> of the corresponding Windows API function. Linux native libraries
>> loading and memory allocations performed by them go outside of Wine control.
>
> I don't like Gabriel's approach very much.  Could we do something like

Hi Matthew,

I don't oppose your suggestion, as Paul said, it should be enough for
us.  But could you elaborate on the problems you see in the original
approach, even if only for my own education?

> issue a syscall before executing a Windows region and then issue another
> syscall when exiting?  If so, we could switch the syscall entry point (ie
> change MSR_LSTAR).  I'm thinking something like a personality() syscall.
> But maybe that would be too high an overhead.
>

-- 
Gabriel Krisman Bertazi
