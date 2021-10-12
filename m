Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90DDC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10C46101D
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 14:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhJLOmW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbhJLOmW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 10:42:22 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1DEC061570;
        Tue, 12 Oct 2021 07:40:20 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1maIwx-0007iq-Fb; Tue, 12 Oct 2021 16:40:15 +0200
Date:   Tue, 12 Oct 2021 16:40:15 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Florian Westphal <fw@strlen.de>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH smack] smack: remove duplicated hook function
Message-ID: <20211012144015.GD2942@breakpoint.cc>
References: <20211011143309.17203-1-fw@strlen.de>
 <700b26f3-a8ef-969b-dd3c-4ad849d8c4ab@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700b26f3-a8ef-969b-dd3c-4ad849d8c4ab@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Casey Schaufler <casey@schaufler-ca.com> wrote:
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> Looks fine, with the one change I've noted below. If you're
> OK with that change I can take it for smack-next.

Sure, smack_ip_output() is fine.
