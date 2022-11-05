Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B73C433FE
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Nov 2022 02:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKECnv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Nov 2022 22:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiKECnt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Nov 2022 22:43:49 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E512B5FDC
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 19:43:47 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 78FB7A97; Fri,  4 Nov 2022 21:43:45 -0500 (CDT)
Date:   Fri, 4 Nov 2022 21:43:45 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Message-ID: <20221105024345.GA15957@mail.hallyn.com>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 02, 2022 at 10:57:48AM -0700, Casey Schaufler wrote:
> On 11/2/2022 10:10 AM, Tetsuo Handa wrote:
> > The main point of this submission is to demonstrate how an LSM module
> > which can be loaded using /sbin/insmod can work, and to provide
> > consideration points for making changes for LSM stacking in a way that
> > will not lock out LSM modules which can be loaded using /sbin/insmod .
> 
> CaitSith could readily be done as an in-tree LSM. The implementation
> of loadable module infrastructure is unnecessary.

Sorry, I'm getting confused.  But in-tree and loadable are not related,
right?
