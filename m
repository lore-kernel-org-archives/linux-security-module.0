Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D2C282D7
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9020811
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 18:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfBEScH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:32:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33991 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfBEScH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 13:32:07 -0500
Received: from mail-yb1-f197.google.com ([209.85.219.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gr5Vs-0008Kf-N8
        for linux-security-module@vger.kernel.org; Tue, 05 Feb 2019 18:32:04 +0000
Received: by mail-yb1-f197.google.com with SMTP id l14so1928111ybq.7
        for <linux-security-module@vger.kernel.org>; Tue, 05 Feb 2019 10:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FVlBFbZ/Rf8EhhvuHPQNiF+bYJe2E/F4dl2//NQxB6s=;
        b=Ahw/E7XJgIAkyVSf5ed6MHuOW7mREvaS6PUang2vPM4n/Nn9vmCEsHYu+IvQ5p9b2d
         IvzxmnS0UjcphV+g3225EoSCj/luwygLnIkdozcY1/6brySa1KU5/cfOdhLtn0wnZs3r
         RXAudBUPCVKQRkLTtB2QJkDqWQ+4ldW3e92hAvpqvcw3r29k1Zp0eY/Qtf/oCN8uXdvb
         HYPYL5fWQ4m9L+gX6Tt6TAAgZOXPW3mEHEADE4tqS/p9cUvAG6Q1Df3WSm6CONIVjrCM
         JfCztR028q4nunoA+OFjrsDHiq1b86uEr2QWKLgsDBK29ASuF0hOcU0stWJrIHPWrsmX
         iFEQ==
X-Gm-Message-State: AHQUAuY7QU/xxyuWmJyctXfJdILjLQFM1W0dXT/PA+Ug7OKEnt2MX0RI
        X6jxlMp7dNAwK9Lu9f+aTQTUaoVXKVYSrVKtiUGa1tbae3GIFLyuo/XcVukh/UUPCIE2DOMiAnS
        MpoNTOeKpe6EvCSgHlO7TDNnD+7XdUw/D2K8SEQp5TdsPrk45KqHIxQ==
X-Received: by 2002:a25:ca83:: with SMTP id a125mr3034487ybg.45.1549391523664;
        Tue, 05 Feb 2019 10:32:03 -0800 (PST)
X-Google-Smtp-Source: AHgI3IbGiAuQ5FUu3eHG8ZYvWmgqLHxC/Y5AGQWoUmLCdi0ABBDyZHzdiR8hCZKvi85lDCT++uG86A==
X-Received: by 2002:a25:ca83:: with SMTP id a125mr3034447ybg.45.1549391523309;
        Tue, 05 Feb 2019 10:32:03 -0800 (PST)
Received: from localhost ([2605:a601:ac2:fb20:ac97:1957:a992:bb67])
        by smtp.gmail.com with ESMTPSA id t129sm1748534ywe.11.2019.02.05.10.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:32:02 -0800 (PST)
Date:   Tue, 5 Feb 2019 12:32:01 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/ima: require signed kernel modules
Message-ID: <20190205183201.GA3218@ubuntu-xps13>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
 <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
 <20190205151859.GD16362@ubuntu-xps13>
 <1549385244.4146.148.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549385244.4146.148.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 05, 2019 at 11:47:24AM -0500, Mimi Zohar wrote:
> Hi Seth,
> 
> On Tue, 2019-02-05 at 09:18 -0600, Seth Forshee wrote:
> > On Thu, Jan 31, 2019 at 02:18:59PM -0500, Mimi Zohar wrote:
> > > Require signed kernel modules on systems with secure boot mode enabled.
> > > 
> > > To coordinate between appended kernel module signatures and IMA
> > > signatures, only define an IMA MODULE_CHECK policy rule if
> > > CONFIG_MODULE_SIG is not enabled.
> > > 
> > > This patch defines a function named set_module_sig_required() and renames
> > > is_module_sig_enforced() to is_module_sig_enforced_or_required().  The
> > > call to set_module_sig_required() is dependent on CONFIG_IMA_ARCH_POLICY
> > > being enabled.
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > With respect to interactions with the kernel lockdown patches, this
> > looks better than the patches I saw previously. I don't feel like I know
> > enough about what's going on with IMA to ack the patch, but I feel
> > confident that it's at least not going to break signature enforcement
> > for us.
> 
> Thank you for testing!  Could this be translated into a "tested-by"
> "(for w/lockdown patches)"?

Yeah, that's fine. To be clear about what I tested, I've confirmed that
it doesn't interfere with requiring signed modules under lockdown with
CONFIG_IMA_ARCH_POLICY=n and IMA appraisal enabled.

Tested-by: Seth Forshee <seth.forshee@canonical.com>
