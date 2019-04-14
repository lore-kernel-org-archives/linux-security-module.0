Return-Path: <SRS0=76oK=SQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA045C10F13
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 16:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809BE20693
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 16:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfDNQkD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:40:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50148 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNQkD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Apr 2019 12:40:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hFiAY-0006wV-Eo; Sun, 14 Apr 2019 16:39:50 +0000
Date:   Sun, 14 Apr 2019 17:39:50 +0100
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
Message-ID: <20190414163950.GQ2217@ZenIV.linux.org.uk>
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Apr 14, 2019 at 07:04:14PM +0300, Amir Goldstein wrote:

> Another problem is that they seem to be bypassed by several subsystems.
> cachefiles, ecryptfs, overlayfs and nfsd all call the vfs_rename() helper, but
> only cachefiles bothers to call the security_path_rename() hook.
> This is of course true for all other security_path_ hooks.
> I think that is something that requires fixing regardless of the fanotify pre
> modification hooks. I wonder if tomoyo and apparmor developers
> (LSM that implement security_path_ hooks) are aware of those missing
> hooks?

First of all, _what_ path?  You do realize that there is no such thing
as *the* pathname of dentry, right?  The same filesystem may be mounted
in any number of places, some of which might be visible in a given
namespace (including "none of them" - and you are not even guaranteed
that they are visible in any namespace at all).

It's not "bypassed", it's "inapplicable and deeply flawed in general".
