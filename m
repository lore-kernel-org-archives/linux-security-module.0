Return-Path: <SRS0=BnuI=3Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF680C2D0DB
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 20:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9887A24679
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="txcCO4ws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="paURXrYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0Udi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:33:38 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54031 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgA0Udh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jan 2020 15:33:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F10B6638
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2020 15:33:36 -0500 (EST)
Received: from imap4 ([10.202.2.54])
  by compute3.internal (MEProxy); Mon, 27 Jan 2020 15:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm2; bh=zg5ssK407JPg1RZMfOec4RxYfdcQGWZdVLCugGNiFFk=; b=txcCO4ws
        5DL65ZIABDdY2mMQNZ9TnLKjQymITjLaczZHQt0JSmzsa8zS0EPSbYTZl0/Kf6Ux
        WBwWt17A72etn8lvAeOZZweu/bkYnvhrkcG+ds+cyYi/VGuC+Eh9s3i8seb5HswI
        CYUokkZfEYLpa9wB4p44my+W+gaevAzAZeYkClO5bunQmWE5EIkaPadlBPO8jeTG
        bh4wxL23H7h0mUabUySMCiaeoR+BVNMwuvBlBmCeMG2ZHE1Cac8LGfAxCg2uB+BR
        w3dA66GmVqKO/+DSSW1AyS0Ic+Ud3j+cTNP3PInhP2ovKGiTWEfVtbv8mIPMCx5X
        Cc6kcghHAakSfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=zg5ssK407JPg1RZMfOec4RxYfdcQG
        WZdVLCugGNiFFk=; b=paURXrYuxaM/obwpK4J8CFuRfyr4pfgSVpJsi5VMF9mTL
        N1eYtYUqHsYfpfmHSMBkChsiuL7XH4M4KI3Ds/ZnGiINgTovV/ZEEqje087x9TbI
        +uJLJQoJ0zt/p5w3AAoBlAY30FJP6ROgY11gYEkA2GTGXG9C3i/eL1k8SGGZqXPh
        UCCsmTPZ0WXFHUgYTCxL8mnwXn1KpqcdIZpwmCZIJQIY1kPE4jOB29s3/gO0UrTa
        DWdQglmZxzmAPXlN1zP8KdRsOaejl9D91YPSrEtjJMBrYsUsnXSXLtbeajC7cB5k
        7uBu3RMMa5y50LnukCqt3BfsRqi4VQZntz0RZhOBw==
X-ME-Sender: <xms:IEkvXtj94Ax1W5x3gw6F0deGVRiaoGpfYEXpQfM9NRe1NxP-a-PpGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedftehlvgigrghnuggvrhcukfhvrghnohhvfdcuoegrmhhivhgr
    nhhovhesfhgrshhtmhgrihhlrdgtohhmqeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrmhhivhgrnhhovhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IEkvXmL4v4IYP3DpNyw6BYL1JhCr5GtNtvKkdy-w7SOOBk3TcUCx2w>
    <xmx:IEkvXoqNbV59vJgYAWcxOWLZ-9jwlqDW39sK046ilooBS5iUO0FUbg>
    <xmx:IEkvXkjDDUvFhE1qTIHkdc6VpRA5T2yj8SO15pjEeyGn5YX6HZnVqw>
    <xmx:IEkvXi1KEgmWhobXqjsxvdNRsAOCCaT6yILMv6ULy74n9nqyEwJSag>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 784333C00A1; Mon, 27 Jan 2020 15:33:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-781-gfc16016-fmstable-20200127v1
Mime-Version: 1.0
Message-Id: <9e7ccbf8-e640-49b1-8e9c-ffa330b0feef@www.fastmail.com>
Date:   Mon, 27 Jan 2020 12:34:05 -0800
From:   "Alexander Ivanov" <amivanov@fastmail.com>
To:     linux-security-module@vger.kernel.org
Subject: Denying access from sb_umount issue
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The lsm module implementes sb_umount() hook to disable lazy umounts. When access is denied, all consecutive umounts fail. It looks like mount reference count is messed up when sb_umount() return -EPERM. Is it possible that umount syscall assumes do_umount() touches those references and it calls 

 dput(path.dentry);
 mntput_no_expire(mnt);

regardless of what do_mount() returns?

Thanks,
--Alex
