Return-Path: <SRS0=EaTW=76=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57F3C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5892082F
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jun 2020 05:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592371600;
	bh=79DzjT3Wyf8IFb34qS9prqoal958fCGONTbZiSKFSOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IeVWP1ejm8NoOj4aCGkIJfnCraZui8JCIJVut8LT4bCD+4GtFcvi/ngj+nFbbV6kx
	 30sYpXqzA8EX1h2I7jL0snzkDfyEbAysceoTX+emL7rXSm1SjsMr1fzFD4VlJNmCbE
	 XGrY63f81JkmClHSzFNvq946JxtLGbhWLD5MIzxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgFQF0j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgFQF0j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jun 2020 01:26:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4022207E8;
        Wed, 17 Jun 2020 05:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592371599;
        bh=79DzjT3Wyf8IFb34qS9prqoal958fCGONTbZiSKFSOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhxoiszNvEdttqcF/zrnRIJzXcBDo/rLz9ZT5v38k4slmW526WEJGtwK/1F4PjEMT
         CepUk8nl9ooUHOwQlnO+NnBkH0prif+4Lv3lJ6DGJoO5nImGx95QlnL7A7yGjswijX
         +qs9XiUJ1nkweH7GtPnT9C+YHxuuRWnCWtriTwE8=
Date:   Wed, 17 Jun 2020 07:26:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Jessica Yu <jeyu@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] fs: move kernel_read_file* to its own include file
Message-ID: <20200617052633.GA1351336@kroah.com>
References: <20200617033152.16883-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617033152.16883-1-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 08:31:52PM -0700, Scott Branden wrote:
> Move kernel_read_file* to it own kernel_read_file.h include file.

That says what you did, but not _why_ you are doing it :(

