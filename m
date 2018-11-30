Return-Path: <SRS0=p+6+=OJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B89C64EB4
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Nov 2018 15:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A44320867
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Nov 2018 15:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A44320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeLACYQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:24:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbeLACYQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Nov 2018 21:24:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1A20308FF03;
        Fri, 30 Nov 2018 15:14:37 +0000 (UTC)
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E6C918E4B;
        Fri, 30 Nov 2018 15:14:36 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-api@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Security modules and sending signals within the same process
Date:   Fri, 30 Nov 2018 16:14:27 +0100
Message-ID: <87lg5asilo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 30 Nov 2018 15:14:38 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Is it guaranteed that tasks in the same thread group can always send
signals to each other, irrespective of their respective credentials
structs?

It's not clear to me whether this is always possible based on the
security_task_kill implementations I've examined.

I want to support per-thread setresuid/setresgid, but we also use
signals for inter-thread communication.  This is mainly for thread
cancellation; the setxgid stuff isn't needed for threads with private
credentials.  I wonder if I need to disable cancellation for threads
with such credentials.

Thanks,
Florian
