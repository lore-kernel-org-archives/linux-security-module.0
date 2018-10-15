Return-Path: <SRS0=Ek2e=M3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2003C71133
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Oct 2018 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B399A2098A
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Oct 2018 17:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B399A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeJPB1A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:27:00 -0400
Received: from namei.org ([65.99.196.166]:35230 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeJPB1A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Oct 2018 21:27:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9FHejKR001635;
        Mon, 15 Oct 2018 17:40:45 GMT
Date:   Tue, 16 Oct 2018 04:40:45 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [GIT PULL] linux-integrity patches for Linux 4.20
In-Reply-To: <1539286401.11939.110.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1810160440240.1254@namei.org>
References: <1539286401.11939.110.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-412428846-1539625245=:1254"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-412428846-1539625245=:1254
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 11 Oct 2018, Mimi Zohar wrote:

> Hi James,
> 
> Sorry for the delay.  This pull request contains a couple of bug
> fixes, including one for a recent problem with calculating file hashes
> on overlayfs, and some code cleanup.

Thanks, pulled to next-integrity and next-testing.

-- 
James Morris
<jmorris@namei.org>

--1665246916-412428846-1539625245=:1254--
