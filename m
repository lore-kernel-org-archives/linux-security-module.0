Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540BFC433DB
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 04:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216E622287
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 04:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbhALEjb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:39:31 -0500
Received: from namei.org ([65.99.196.166]:45860 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730106AbhALEjb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Jan 2021 23:39:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 5AA7F8CE;
        Tue, 12 Jan 2021 04:38:18 +0000 (UTC)
Date:   Tue, 12 Jan 2021 15:38:18 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Fan Wu <wufan@linux.microsoft.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: Question about inode security blob
In-Reply-To: <f85cdd1b-1118-026b-c696-18863ad6352e@linux.microsoft.com>
Message-ID: <391d332-4a31-2ed8-85a3-106f393dd1db@namei.org>
References: <156f6860-73a4-f754-b460-d64de40ff626@linux.microsoft.com> <f4f21823-240c-394b-2222-bb8214e4ba7f@schaufler-ca.com> <f85cdd1b-1118-026b-c696-18863ad6352e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 11 Jan 2021, Fan Wu wrote:

> > The inode->i_security should never be NULL if the inode has been
> > initialized. Any LSM hook that finds this to be NULL has probably
> > identified a bug elsewhere in the system.
> > 
> 
> Thanks for the quick reply. If I understand correctly, I should follow the
> first pattern if I want to use the inode blob.

I don't think it's necessary, and if there's a race somewhere causing 
this, we shouldn't just paper it over.

Btw, none of the existing cases are even using WARN_ON or similar to let 
the user know there's a problem.


-- 
James Morris
<jmorris@namei.org>

