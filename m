Return-Path: <SRS0=4koF=W7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AECC3A5A8
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Sep 2019 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572202087E
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Sep 2019 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIiZLF14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfIDQro (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:47:44 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:43722 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732324AbfIDQrn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Sep 2019 12:47:43 -0400
Received: by mail-io1-f45.google.com with SMTP id u185so41855292iod.10
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2019 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFnr7zgJe+61oG4oqxymDnM4izKIkBVQkyb90hB3S+I=;
        b=iIiZLF14sOBStDzF/zd5qvQJo3HPHJzWwvCAMo/xC62V6+aBfDX2kCYoBGGFUL3io9
         mWteVTYIKwVmcppcgjI1Gz1JAjVVCiH8X54EIkWjj6U27wYnJiIYrUt3pXw9gVP7wPn/
         4tuIZY8AfhSpnphPjvx4Hgk9KszlkdMQOFMlLTO2Ebh9fCM+JJRVD6JJgeiTgVNJqYQa
         JR8hQpqmlmA+DIrPW9H61r1U6ESB3m1BaWvc1rcuGx7tUZlmPqVnJO9VdyK1rpiMSxuY
         FVQxbLlmDI5xjHezuh8ZT8KOGWtLHQUqteGreVrFv/CpWVoh3ir59di5coFcOFJIy+Zh
         AfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFnr7zgJe+61oG4oqxymDnM4izKIkBVQkyb90hB3S+I=;
        b=cX9UXqCHTaCaUHOvtdwVffCASZkc3OSld7Swvx14s9CELHBxw8RSnByy1S8trDspl+
         TNWTeByhm5emJzw0w7INXzfrUoBqn+knrDEbyMwjf62twjkj1UsGM5mWkFRHA4LqDjbS
         mbgX+YFWS+m4Ea+yu2hfF+2cR/hKzFcbnfTUVmXfma21u+CjwxrtYfDBO4K7VMPLKBNu
         0zIjdQEVjeL7XN8T4ZHNYT7nmWfWk5pLVecWyDGogHPVHFG9ADBg9uFfG5Dj8dONzniu
         c0s21P9GCxc0TDcFPE2j7bwPWXN4L87Bb+2rO+7DVss011/09GBrAO6IMiD0nwUlYxN8
         mRTw==
X-Gm-Message-State: APjAAAVnxd1je4giQSevTt/zvBvlDT0EI0mtBXpRSEdYJOxO+9mzIb2e
        B269aThlFZScPqR1a190MwiGiPG+3kJe+BTHuZFV4A==
X-Google-Smtp-Source: APXvYqxSl27LcKurdt2fQvWY+lSxjaoKv1CHvidnAFxG8QO4wPpbzVxnVi7kqXp7e40rk4a0QrrOJkCYYK+1aHl5iSo=
X-Received: by 2002:a02:6a17:: with SMTP id l23mr5941298jac.102.1567615662334;
 Wed, 04 Sep 2019 09:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <cf90a8aa-536e-f4df-0b2f-60724e4034fb@mev.co.uk>
In-Reply-To: <cf90a8aa-536e-f4df-0b2f-60724e4034fb@mev.co.uk>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Sep 2019 09:47:30 -0700
Message-ID: <CACdnJuumhcFw2394J-ymAq1VVAGXpknhdd1T8x565pcU6eAU-w@mail.gmail.com>
Subject: Re: Should PCI "new_id" support be disabled when kernel is locked down?
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 4, 2019 at 9:12 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> Hello,
>
> The "new_id" PCI driver sysfs attribute can be used to make an arbitrary
> PCI driver match an arbitrary PCI vendor/device ID.  That could easily
> crash the kernel or at least make it do weird things if used
> inappropriately.  Is this scenario in scope for the "lockdown" security
> module?

Crashing the kernel isn't really a concern - the issue is more whether
it's possible to get a driver to perform a sufficient number of writes
to a device that it can in turn cause the device to overwrite the
kernel in a controlled manner. This seems theoretically possible, but
I think I'm inclined to leave it as is unless someone demonstrates
that it's more than theoretical.
