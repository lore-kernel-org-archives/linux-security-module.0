Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE8FC43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9749520652
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCGP7s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:59:48 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:35552 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfCGP7r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Mar 2019 10:59:47 -0500
X-Greylist: delayed 3848 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2019 10:59:46 EST
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x27EtTLg005783;
        Thu, 7 Mar 2019 14:55:29 GMT
Date:   Thu, 7 Mar 2019 14:55:28 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 09/27] hibernate: Disable when the kernel is locked down
Message-ID: <20190307145528.24c1b4d3@alans-desktop>
In-Reply-To: <20190306235913.6631-10-matthewgarrett@google.com>
References: <20190306235913.6631-1-matthewgarrett@google.com>
        <20190306235913.6631-10-matthewgarrett@google.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed,  6 Mar 2019 15:58:55 -0800
Matthew Garrett <matthewgarrett@google.com> wrote:

> From: Josh Boyer <jwboyer@fedoraproject.org>
> 
> There is currently no way to verify the resume image when returning
> from hibernate.  This might compromise the signed modules trust model,
> so until we can work with signed hibernate images we disable it when the
> kernel is locked down.

That one is a bit worrying since whilst the other stuff may be useful in
some business environments, mandatory hibernate not suspend to RAM is a
common corporate IT policy because of concerns about theft and recovery
of memory contents.

Alan
