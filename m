Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD81C64EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801F206B2
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8801F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJCCRp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:17:45 -0400
Received: from namei.org ([65.99.196.166]:35092 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeJCCRp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 22:17:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w92JWnFu019437
        for <linux-security-module@vger.kernel.org>; Tue, 2 Oct 2018 19:32:49 GMT
Date:   Wed, 3 Oct 2018 05:32:49 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     linux-security-module@vger.kernel.org
Subject: LSM mailing list archive at Lore
Message-ID: <alpine.LRH.2.21.1810030530530.19309@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks to mricon and the folks at LF, there is now a kernel.org archive of 
the LSM mailing list:

	https://lore.kernel.org/linux-security-module/


This is in addition to

	http://kernsec.org/pipermail/linux-security-module-archive/



-- 
James Morris
<jmorris@namei.org>

