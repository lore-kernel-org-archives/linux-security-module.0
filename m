Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C16C282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 15:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FEF217F9
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 15:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfBEPTF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:19:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56776 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbfBEPTF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 10:19:05 -0500
Received: from mail-yb1-f198.google.com ([209.85.219.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gr2V5-0004xS-8g
        for linux-security-module@vger.kernel.org; Tue, 05 Feb 2019 15:19:03 +0000
Received: by mail-yb1-f198.google.com with SMTP id y4so1619057ybi.0
        for <linux-security-module@vger.kernel.org>; Tue, 05 Feb 2019 07:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xj37CtNcS/y5pi4Gq6YdkdO+q+j/uv4oSoSjroFz6HI=;
        b=XGV9qsuw9+MlA8kjQTtLFVbvkmqjuWqyA1zZhRAZUjMy6HAfM3VqTzVPnT/RpG9UuE
         IY0rqBpoPxwO51Cz2lxpmUYC+3EKkx76rQAxGq4B0WSk2d69QYqVNtv/D3ZU4GQ4b97A
         SkSd9oQS+OcdvPMJq1rlRHaHIgROU3PFJg9Xxe4cCFxkCSxmDK7kXaqfNrjNSKtaO/CQ
         XwcukZxKgfNS+5/GUEKB0gZ4fjrgGsX1Q6pzk1KMkJG0dahF34vHwpa/3nvqxmAemdUj
         dldfhSo0AUX9QfP80uo9qhoow87+7vmDtZBdKNh1YAh1We00ARmU7qrrlEDrZtGooLal
         CFQg==
X-Gm-Message-State: AHQUAubi3O/gIxVlBCK8Y04REIeDGURig8seUgZBFUnNXKCM4hXxone9
        6112HpFHjTs2iajEGMxwv9OBN3Oeu1TFBW4Mht8sjUQuklV9DgPoyKCieRQ83xi6TqljzmuRcwo
        Sh/y7CZ1yrqH1ZdIW7aHkBULWQuBGG9bTu7byPX8LJD7ILiSDvvAN0A==
X-Received: by 2002:a25:2fc6:: with SMTP id v189mr4327464ybv.121.1549379941975;
        Tue, 05 Feb 2019 07:19:01 -0800 (PST)
X-Google-Smtp-Source: AHgI3IY7S0RpTDRGdHQDsUVkaz7/giuZ+rR/DJC16+6c1ojJ9/HgzvMs3KUBAoSM31CKWjr5HnACCg==
X-Received: by 2002:a25:2fc6:: with SMTP id v189mr4327413ybv.121.1549379941393;
        Tue, 05 Feb 2019 07:19:01 -0800 (PST)
Received: from localhost ([2605:a601:ac2:fb20:2df6:439b:8b17:3e1f])
        by smtp.gmail.com with ESMTPSA id f188sm1418274ywc.70.2019.02.05.07.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 07:19:00 -0800 (PST)
Date:   Tue, 5 Feb 2019 09:18:59 -0600
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
Message-ID: <20190205151859.GD16362@ubuntu-xps13>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
 <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 31, 2019 at 02:18:59PM -0500, Mimi Zohar wrote:
> Require signed kernel modules on systems with secure boot mode enabled.
> 
> To coordinate between appended kernel module signatures and IMA
> signatures, only define an IMA MODULE_CHECK policy rule if
> CONFIG_MODULE_SIG is not enabled.
> 
> This patch defines a function named set_module_sig_required() and renames
> is_module_sig_enforced() to is_module_sig_enforced_or_required().  The
> call to set_module_sig_required() is dependent on CONFIG_IMA_ARCH_POLICY
> being enabled.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

With respect to interactions with the kernel lockdown patches, this
looks better than the patches I saw previously. I don't feel like I know
enough about what's going on with IMA to ack the patch, but I feel
confident that it's at least not going to break signature enforcement
for us.

Thanks,
Seth

