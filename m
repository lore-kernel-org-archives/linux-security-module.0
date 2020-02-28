Return-Path: <SRS0=sUyx=4Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18016C3F2CD
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Feb 2020 18:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59DB246AC
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Feb 2020 18:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="zUDtvA66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUscW+i2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgB1Sb0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:31:26 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47849 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgB1Sb0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Feb 2020 13:31:26 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 48EC2AB9
        for <linux-security-module@vger.kernel.org>; Fri, 28 Feb 2020 13:31:25 -0500 (EST)
Received: from imap4 ([10.202.2.54])
  by compute1.internal (MEProxy); Fri, 28 Feb 2020 13:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm2; bh=91iDt8BQL4Avos2gM5eSATLKVz2ounHcbnawCEUnj5Q=; b=zUDtvA66
        pdKOGFnGMCVNlaHlpzD7BDmIKAGylN4QSwFRMfyB8grracHwLnOf0x36JwPZVyyo
        fEZmi+ZOtgaTgjEn6FwTzZQDCr9ZIEralXt0CM/w6fbiKNemoUwtF2XQ0u6bKjOe
        75ZSybcLqqRzdpqTGezruy/GvqOqP315te+TKZ7cPELd2ZYjkExIkDi28BGJ5O2p
        fWqVMIks15NIIaIUDRpXd6xYWE2JPb5N4oc4+NWD9wFOo3QwZb48UaIq2xJZAmH4
        QM9w6NbYyfvzv/Sr6CcmtmZUqOuFWJZTakO3QAfCk1uOQzu/wKVS9sYuRwQxElIy
        r95t1ZRPiwWqkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=91iDt8BQL4Avos2gM5eSATLKVz2ou
        nHcbnawCEUnj5Q=; b=KUscW+i2emDMZDaZ2AsTu6TsgLe1iy1nXJa2L5Ro7ZvHS
        3CGH6Vpn6XBVjGOGSOttxcQXTrR9OJ5N+tCSQ4CFRCzK2MPOrXJ/CkoI4zdP25up
        /RSAR63fSOC7Vqx8E2ggevcwRfVJ3//XNH2GbrGMokjfsR1d96jTslI0375aJ16X
        IplxcaegdWyHmQVPxYXeh0wkwz/hK56frk4OpNFW/bVXIX3PNHOQXdXYkqQWOiRt
        dokoav27rrgnBQkg6xHK/cZucaKIsA38bp03X7YmcTbNgqZ7PbHkZA4CATCJ6Z7n
        guYjpJ9B0dwFqJkv/cOP3gPSm4yxiM/mx7WJc/wRA==
X-ME-Sender: <xms:fFxZXm1o0YoyTvFbuFAYjUaxdQcTlXSksahfU2qRGgwyrJVroWjZIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleekgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedftehlvgigrghnuggvrhcukfhvrghnohhvfdcuoegrmhhivhgr
    nhhovhesfhgrshhtmhgrihhlrdgtohhmqeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrmhhivhgrnhhovhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fFxZXg2nSeQ4NYR5E9AJcKoXj1HhN4NH1CFY0X9K0hM1E76wqMCRyg>
    <xmx:fFxZXj4-gfxOQ3b3x0JhCTDzjaV5gvTrMWdnB5smzz2KGdNaCWp8rw>
    <xmx:fFxZXv3u78fD-9iTjmH7CER9cgn6PHd81s75bB20cctzf9xP0FiOVQ>
    <xmx:fFxZXoVvyn1nohmRD4WYXPSpPZKqxoV9x7o7yS9GIJcm6H5xwn8ENw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C901D3C00A1; Fri, 28 Feb 2020 13:31:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-967-g014f925-fmstable-20200226v1
Mime-Version: 1.0
Message-Id: <91958250-142b-4ceb-877c-3dd9036c7a9c@www.fastmail.com>
Date:   Fri, 28 Feb 2020 10:31:04 -0800
From:   "Alexander Ivanov" <amivanov@fastmail.com>
To:     linux-security-module@vger.kernel.org
Subject: protecting overlayfs's lower consistently.
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

We have LSM that implements file_open call back to protect fs object based on path. Now, supposed are to protect /mnt/l in the following setup

mount -t overlay -orw,lowerdir=/mnt/l,upperdir=/mnt/u,workdir=/mnt/w none /mnt/m

However, when one attempts to change the upper (for the objects that originates on lower) the dentry passed into vfs_open() and then to do_dentry_open() points to the lower and there seems no easy way to calculate its upper. It

This seems was different in older kernels, eg. 3.10 (rhel7). The changes the seemingly broke that behaviour happened around kernel 4.4. What was a reason for that change and is there anyway to figure out the upper given the lower passed into vfs_open()?

Thanks,
--Alex
