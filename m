Return-Path: <SRS0=wiIN=6U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7A3C28CBC
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E43820708
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 18:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgEFSta (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 May 2020 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbgEFSt3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 14:49:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E6C061A0F;
        Wed,  6 May 2020 11:49:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWP6e-002KDg-8L; Wed, 06 May 2020 18:49:20 +0000
Date:   Wed, 6 May 2020 19:49:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] securityfs: Add missing d_delete() call on removal
Message-ID: <20200506184920.GD23230@ZenIV.linux.org.uk>
References: <202005051626.7648DC65@keescook>
 <20200506011431.GB23230@ZenIV.linux.org.uk>
 <202005052024.2D7626C742@keescook>
 <20200506040252.GC23230@ZenIV.linux.org.uk>
 <202005060831.C05759E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005060831.C05759E@keescook>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 06, 2020 at 08:34:29AM -0700, Kees Cook wrote:

> Just posted the whole series:
> https://lore.kernel.org/lkml/20200506152114.50375-1-keescook@chromium.org/
> 
> But the specific question was driven by this patch:
> https://lore.kernel.org/lkml/20200506152114.50375-11-keescook@chromium.org/

Yecchh...  First of all, you are leaving a dangling pointer in your
struct pstore_private ->dentry.  What's more, in your case d_delete()
is definitely wrong - either there are other references to dentry
(in which case d_delete() is the same as d_drop()), or dput() right
after it will drive ->d_count to zero and since you end up using
simple_dentry_operations, dentry will be freed immediately after
that.

I have not looked at the locking in that series yet, so no comments
on the races, but in any case - that d_delete() is a misspelled d_drop().
