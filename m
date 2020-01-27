Return-Path: <SRS0=BnuI=3Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAF3C2D0DB
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1624679
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 21:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="clAVsAjj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpCz4Xy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0VJi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:09:38 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55009 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgA0VJi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jan 2020 16:09:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 43838625;
        Mon, 27 Jan 2020 16:09:37 -0500 (EST)
Received: from imap4 ([10.202.2.54])
  by compute3.internal (MEProxy); Mon, 27 Jan 2020 16:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=p6CAiIPrIkTnkHyDBkWKiRewAnx6gnW
        lkiOf7tCBOmE=; b=clAVsAjjnMkTTSAbtGUTHb9y7lfOaqgSgu71wwRpOFrkZsX
        6W8emMzyWnS2BYKxVuiGcPXZkypIgYYS3Yk2SSCyITB9kOVJRtKj4Ubn1V6QfEIX
        PvSZC6MBdw3af5Kq8+750nQZcYBRClAU4FkxdP4bQaOWI5AdDkZkUwhKwx2u2HuN
        YL8TORM6k4g5AoZbaBeL7MaMp2VKuH9SM4XIK2ryAdrQPUyWc8RfXNrLPrOh8ilR
        2mceU0HTpuBKmruqg6MWhLC6Yfcn9G2nZxF8F58U6IX7pHG3S8akwBqhJYp/ZyTL
        CkE+KmJmCOb/8ZXlFS2h7Bb4udMG1K81JSaXNbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=p6CAiI
        PrIkTnkHyDBkWKiRewAnx6gnWlkiOf7tCBOmE=; b=rpCz4Xy8MosY4CA4DcWpPJ
        YMxUCL8gP/Zvk9TT1iZIyPnZC2vOBbhkGVcEcGQveA7TF/9wQp9SF1i1fYLo/Raz
        RFqQtfliavyIHfaMqtz05fv8q0uOmoEb7MCrqehlDZUXfRN8NIzFT/od1FEIS53l
        54GfP5M0YMWj3MpqsOaXvFdvBhpm9ixLw27EVCXymwwX106VALWGHsvSK0CrUx3o
        S65gWP7+iCQRT/RaBUJOkEGMGPYd3fF5IVzHSqHTjGW13xzscDUzMCAVpbT4D0Uq
        f73JjmAwpIwMDVALIOnyRQynX3FQ8rYRidxBEXCLGrKUJhrf5+P3OkzfPvo086Ww
        ==
X-ME-Sender: <xms:j1EvXljbc1KqLSG9NZpeiK2IBVuZ2Cl3IScNeCOP2EhcewHiTfi9Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetlhgv
    gigrnhguvghrucfkvhgrnhhovhdfuceorghmihhvrghnohhvsehfrghsthhmrghilhdrtg
    homheqnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghmihhvrghnohhvsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:j1EvXtF1-ufh3cnCL7Rd8LGjS9bqt02rvr95-zRP51vNNr-Erax6eA>
    <xmx:j1EvXvvHRwL16T29dYwRpPJxV0Er1Cr6ho_dMnZ5cl3C8gV5MKs-jg>
    <xmx:j1EvXmcfolRFWCVMeVhyGKMqwmJUM0plO_9boc5lgeLASnBrxHd11A>
    <xmx:kFEvXnnIBns7IL9SSFNnLD0Ig5yGrKo0lTkTzsGAdR0Ga7lf9SLYcQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D14B93C00A1; Mon, 27 Jan 2020 16:09:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-781-gfc16016-fmstable-20200127v1
Mime-Version: 1.0
Message-Id: <e9ef81ce-d115-46d1-9e18-c2a39371415e@www.fastmail.com>
In-Reply-To: <alpine.LRH.2.21.2001280754180.22715@namei.org>
References: <9e7ccbf8-e640-49b1-8e9c-ffa330b0feef@www.fastmail.com>
 <alpine.LRH.2.21.2001280754180.22715@namei.org>
Date:   Mon, 27 Jan 2020 13:10:04 -0800
From:   "Alexander Ivanov" <amivanov@fastmail.com>
To:     "James Morris" <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: Denying access from sb_umount issue
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On Mon, 27 Jan 2020 12:58 -08:00, James Morris <jmorris@namei.org> wrote:
> On Mon, 27 Jan 2020, Alexander Ivanov wrote:
> 
> > The lsm module implementes sb_umount() hook to disable lazy umounts. When access is denied, all consecutive umounts fail. It looks like mount reference count is messed up when sb_umount() return -EPERM. Is it possible that umount syscall assumes do_umount() touches those references and it calls 
> > 
> >  dput(path.dentry);
> >  mntput_no_expire(mnt);
> > 
> > regardless of what do_mount() returns?
> 
> You mean do_umount()?
> 

yes, typo, sorry.


> There are several other do_umount() error cases which would have the same 
> behavior, right after security_sb_umount().
> 

We do umount with MNT_DETACH, thus those early returns seem not applicable?


> What error codes are you seeing for the consecutive failures?
> 

We got EBUSY.

Thanks,
--Alex
