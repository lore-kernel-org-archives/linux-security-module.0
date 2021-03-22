Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00562C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 16:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D4E6191D
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 16:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCVQwJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhCVQv5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 12:51:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A45C861972;
        Mon, 22 Mar 2021 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431914;
        bh=5AyRLAO5DixWjKkZ3XWjFxp2WdDIpIG2VQGTX+JpRvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4bMoJp7NZlKNZyBonXB7Aa7rA1x7p6+1a7mRL2Y2CBOdm3ETacWQvCEXiFSTxsuo
         b0MV3YYEC+QZ5f5jxIXDclVmBsLl1wz87GG2P8PJWaoDRhQ2OxWpXdYrPBzU1pXfpP
         k74/0v28kwonjbzvnGnpATWvSAD2gIbKF7WyvyOJow0p9qTCXg6yoENjAHEwx2czue
         6K9p7xtxRiqYAN+3la1oVAr/TnA3eZgcJz9ddn9m1Ugnjn+3xdi7bzyxImbNr/IcPn
         r/p93fJDDmRAmHyhiUDzpY7HpJb+eXdii79sIquXzQATL4p1YzMP3FiWZTxBldFzDW
         F1kmpSUjXvcRw==
Date:   Mon, 22 Mar 2021 09:51:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] ima: don't access a file's integrity status before
 an IMA policy is loaded
Message-ID: <YFjLG7+mhDgsQOYu@gmail.com>
References: <20210322154207.6802-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322154207.6802-1-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 22, 2021 at 11:42:06AM -0400, Mimi Zohar wrote:
> Only after an IMA policy is loaded, check, save, or update the cached
> file's integrity status.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

This commit message doesn't describe what the actual effect of this change is.
Is it fixing something?

- Eric
