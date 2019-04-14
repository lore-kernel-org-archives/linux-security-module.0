Return-Path: <SRS0=76oK=SQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84538C10F14
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56FE20850
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 19:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfDNT0M (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:26:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51946 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNT0M (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Apr 2019 15:26:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hFklN-0002xR-Ne; Sun, 14 Apr 2019 19:26:01 +0000
Date:   Sun, 14 Apr 2019 20:26:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: fanotify and LSM path hooks
Message-ID: <20190414192601.GR2217@ZenIV.linux.org.uk>
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190414163950.GQ2217@ZenIV.linux.org.uk>
 <CAOQ4uxg-NsccKfhzJbZnCnXhKA90VfVdV0_qLRt+8iVa53655g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg-NsccKfhzJbZnCnXhKA90VfVdV0_qLRt+8iVa53655g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Apr 14, 2019 at 09:51:38PM +0300, Amir Goldstein wrote:

> But the truth is I would much rather that users have a way to mark
> a subtree root and ask fanotify for events under that subtree.
> As a matter of fact, I have some private POC patches that allow users to
> setup a mark on a "subtree root" dentry, which really marks the super block
> and keep a reference to the dentry. Than every event on that super block
> is filtered with is_subdir() against the marked dentry.

And that is_subdir() is protected by what, exactly?  And what happens
if you have many such dentries?

Or, for that matter, what happens if that dentry gets invalidated?
