Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E4C433FE
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Nov 2022 23:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKEXqW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Nov 2022 19:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEXqV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Nov 2022 19:46:21 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797212776
        for <linux-security-module@vger.kernel.org>; Sat,  5 Nov 2022 16:46:16 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id EB99B839; Sat,  5 Nov 2022 18:46:14 -0500 (CDT)
Date:   Sat, 5 Nov 2022 18:46:14 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Message-ID: <20221105234614.GA23523@mail.hallyn.com>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
 <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 05, 2022 at 01:05:44PM +0900, Tetsuo Handa wrote:
> On 2022/11/05 11:43, Serge E. Hallyn wrote:
> > On Wed, Nov 02, 2022 at 10:57:48AM -0700, Casey Schaufler wrote:
> >> On 11/2/2022 10:10 AM, Tetsuo Handa wrote:
> >>> The main point of this submission is to demonstrate how an LSM module
> >>> which can be loaded using /sbin/insmod can work, and to provide
> >>> consideration points for making changes for LSM stacking in a way that
> >>> will not lock out LSM modules which can be loaded using /sbin/insmod .
> >>
> >> CaitSith could readily be done as an in-tree LSM. The implementation
> >> of loadable module infrastructure is unnecessary.
> > 
> > Sorry, I'm getting confused.  But in-tree and loadable are not related,
> > right?
> 
> Very much related. My goal is to get CaitSith in-tree as a loadable LSM module
> which can be loaded using /sbin/insmod .

Great.  I support that.  But the sentence

> >> CaitSith could readily be done as an in-tree LSM. The implementation
> >> of loadable module infrastructure is unnecessary.

suggests that because CaitSith could be done in-tree, it doesn't need
to be loadable.  I'm saying that is a non sequitur.  It sounded like
that setence was meant to say "Because CaitSith could be in-tree, it
doesn't need to be =m.  Only out of tree modules need to be loadable."

-serge
