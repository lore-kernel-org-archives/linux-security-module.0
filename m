Return-Path: <SRS0=7rO8=PZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B30C43387
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Jan 2019 23:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48AF20851
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Jan 2019 23:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAQXUB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:20:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60011 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAQXUB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Jan 2019 18:20:01 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([134.134.139.83])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0HNJoQT938934
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 17 Jan 2019 15:19:51 -0800
Subject: Re: [PATCH 01/17] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LSM List <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-2-rick.p.edgecombe@intel.com>
 <20190117154701.78aa8e9d0130716e0d9ac026@kernel.org>
 <F3B332DA-4637-4A3B-93F9-C7903C1D9FF9@zytor.com>
 <8817DE5F-BCF4-4F6A-A496-E0DB6889D86E@vmware.com>
 <F84CA28B-8BAA-468E-BA85-442E245871E5@zytor.com>
Message-ID: <937f59ca-1d82-f5d9-4734-89680f23a661@zytor.com>
Date:   Thu, 17 Jan 2019 15:19:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <F84CA28B-8BAA-468E-BA85-442E245871E5@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> 
> I think we have three subcases:
> 
> 1. Early, UP, or under stop_machine();
> 2. Atomic and aligned;
> 3. Breakpoint.
> 
> My proposed algorithm should remove the need for a fixup which should help this interface, too.
> 
> The specific alignment needed for #2 is started by the hardware people to be not crossing 16 bytes (NOT a cache line) on any CPU we support SMP on and, of course, being possible to do atomically do on the specific CPU (note that we *can* do a redundantly large store of existing bytes, which adds flexibility.)
> 
> To the best of my knowledge any CPU supporting SSE can do an atomic (for our purposes) aligned 16-byte store via MOVAPS; of course any CPU with cx16 can do it without SSE registers. For older CPUs we may be limited to 8-byte stores (cx8) or even 4-byte stores before we need to use the breakpoint algorithm.
> 

Sending to a restricted list, because I don't actually know how publicly
known this is, but it is known there are operating systems in the field
already which rely on the 16-byte atomicity guarantee.

	-hpa
