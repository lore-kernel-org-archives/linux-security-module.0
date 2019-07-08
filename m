Return-Path: <SRS0=y5yI=VF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CEDC606BD
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Jul 2019 18:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62E4205ED
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Jul 2019 18:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfGHSNc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:13:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60592 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfGHSNc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jul 2019 14:13:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkY8V-0003vz-Um; Mon, 08 Jul 2019 18:13:12 +0000
Date:   Mon, 8 Jul 2019 19:13:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
Message-ID: <20190708181311.GW17978@ZenIV.linux.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
 <20190708131831.GT17978@ZenIV.linux.org.uk>
 <874l3wo3gq.fsf@xmission.com>
 <20190708180132.GU17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708180132.GU17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 08, 2019 at 07:01:32PM +0100, Al Viro wrote:

> Right now anyone relying upon DAC enforced for MS_MOVE has worse problems

That'd be MAC, of course.  Sorry.
