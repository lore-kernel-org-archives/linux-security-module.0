Return-Path: <SRS0=hpNi=QV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0960C10F04
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 19:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCFB21B24
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 19:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfBNTAy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:00:54 -0500
Received: from namei.org ([65.99.196.166]:52234 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfBNTAy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Feb 2019 14:00:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1EJ0pma018040;
        Thu, 14 Feb 2019 19:00:51 GMT
Date:   Fri, 15 Feb 2019 06:00:51 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [GIT PULL] linux-integrity patches for Linux 5.1
In-Reply-To: <1550153052.4078.5.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1902150600140.17510@namei.org>
References: <1550153052.4078.5.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1351698452-1550170851=:17510"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1351698452-1550170851=:17510
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Feb 2019, Mimi Zohar wrote:

> Hi James,
> 
> Linux 5.0 introduced the platform keyring to allow verifying the IMA
> kexec kernel image signature using the pre-boot keys.  This pull
> request similarly makes keys on the platform keyring accessible for
> verifying the PE kernel image signature.*
> 
> Also included in this pull request is a new IMA hook that tags tmp
> files, in policy, indicating the file hash needs to be calculated.
>  The remaining patches are cleanup.
> 
> *Upstream commit "993a110319a4 (x86/kexec: Fix a kexec_file_load()
> failure)" is required for testing.
> 

Thanks!

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity
and next-testing.



-- 
James Morris
<jmorris@namei.org>

--1665246916-1351698452-1550170851=:17510--
