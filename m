Return-Path: <SRS0=LWcd=NX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FFC43441
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Nov 2018 17:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9375C22419
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Nov 2018 17:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9375C22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeKMDPu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:15:50 -0500
Received: from namei.org ([65.99.196.166]:52688 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeKMDPu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Nov 2018 22:15:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wACHLeX0008348
        for <linux-security-module@vger.kernel.org>; Mon, 12 Nov 2018 17:21:40 GMT
Date:   Tue, 13 Nov 2018 04:21:40 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     linux-security-module@vger.kernel.org
Subject: Sync to v4.20-rc2
Message-ID: <alpine.LRH.2.21.1811130419080.7992@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

For folks working with my security tree, the next-general branch has now 
been merged to v4.20-rc2.

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

See also: http://kernsec.org/wiki/index.php/Kernel_Repository


-- 
James Morris
<jmorris@namei.org>

