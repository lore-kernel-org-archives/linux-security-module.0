Return-Path: <SRS0=snF/=RZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3218CC4360F
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0908C218A5
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 14:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfCVOAV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:00:21 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41784 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfCVOAV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Mar 2019 10:00:21 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44QlfV2Bd7z1rgYV;
        Fri, 22 Mar 2019 15:00:18 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44QlfV1TqZz1qvWq;
        Fri, 22 Mar 2019 15:00:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id pTBWl1QzcXfR; Fri, 22 Mar 2019 15:00:17 +0100 (CET)
X-Auth-Info: rna/S+KrsKfyEyn/FC5HKYvvMbWYEKHq4UuH1uF2vGCBRBQiyqNL3x9DQXlzjNZY
Received: from igel.home (ppp-46-244-167-18.dynamic.mnet-online.de [46.244.167.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 22 Mar 2019 15:00:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id AB84D2C12D4; Fri, 22 Mar 2019 15:00:15 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 11/43] convert do_remount_sb() to fs_context
References: <87a7hnyx4x.fsf@igel.home>
        <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
        <155059379404.12449.7151387243186063769.stgit@warthog.procyon.org.uk>
        <21016.1553253953@warthog.procyon.org.uk> <8736nfyr60.fsf@igel.home>
X-Yow:  Am I accompanied by a PARENT or GUARDIAN?
Date:   Fri, 22 Mar 2019 15:00:15 +0100
In-Reply-To: <8736nfyr60.fsf@igel.home> (Andreas Schwab's message of "Fri, 22
        Mar 2019 14:28:23 +0100")
Message-ID: <87y357xb4g.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mär 22 2019, Andreas Schwab <schwab@linux-m68k.org> wrote:

> On Mär 22 2019, David Howells <dhowells@redhat.com> wrote:
>
>> Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>>> That breaks booting for me.  The problem appears to be that udev fails
>>> to create the block devices.
>>
>> Can you give some more information?  Is this on m68k?  Are there any messages
>> logged?
>
> It is on ppc and ppc64, and I now see that devtmpfs has failed to mount.

# mount -t devtmpfs -o mode=0755,nr_inodes=0 devtmpfs /dev
mount: wrong fs type, bad option, bad superblock on devtmpfs,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
