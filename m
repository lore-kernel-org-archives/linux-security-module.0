Return-Path: <SRS0=32Xp=S7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EADC004C9
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 04:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62E32087B
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 04:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="MT3mzMT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfD2Eyx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Apr 2019 00:54:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43216 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfD2EyJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id e67so4691590pfe.10
        for <linux-security-module@vger.kernel.org>; Sun, 28 Apr 2019 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CXY8NMI+MMoFwyd5a0U3G9swoqWap2mhzcLLts/Z+iE=;
        b=MT3mzMT76800YDXvDZ5HeHvywukXbF/p5hE0jBqJpGYZZg1bhMX2UHmZ1HU1dvIheR
         9V3fe+IwApl8EGbBqr2IZkMENTIoZrC2hLsTBul7PX4wqT1iG/MuEFlYgfUtMUoSToFc
         7CbzrSVAtGB1V9nsEgm59WhrmtIFGM7bhpw1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CXY8NMI+MMoFwyd5a0U3G9swoqWap2mhzcLLts/Z+iE=;
        b=Pa8ACbty0BbH/oNK8nz9mRno48lNe24rHH3GkhCjov4qD29up+DNDVPO1za/0BfT2I
         rvLusQyOvnLMwt33xTbJxauWHEWBr10w5KuHkgEU9E4sta30SLbXs9SmdKivZ95SI/Xd
         CYo5+d2XjlP0KQ99iZto8+Bany00NIXRB+zrkxNzAYdkjYX14eaWNnOmqDR4wleYAAtR
         F2PMfKGmd8AGgvtLT+o9p5DZ0gXzjSGsk35OMkoTjHh6fUNDzml17ZgcQR3KfQHA750O
         xDzCFWtXGIpnpgmkYP3pRAvugzD462yBOrTMYvBpUpj9Iu+GPz0oQiLYDU5tbUbUxxl0
         DILw==
X-Gm-Message-State: APjAAAXlAz+kAsxAd008nEIUzmJS6UuNgzekYLYNVxTOthXoZCnSCAQh
        Xgrt+32mGiNvF3DdMtyQNeWUMA==
X-Google-Smtp-Source: APXvYqxOmKGuDu957cqrxEQ+1VImzuI7N1RjWAr+p16Qnie6ZNUhOIBHM3h6IhCgt1zC9o45e1De9A==
X-Received: by 2002:a63:7d03:: with SMTP id y3mr55014550pgc.8.1556513648514;
        Sun, 28 Apr 2019 21:54:08 -0700 (PDT)
Received: from localhost (ppp121-45-207-92.bras1.cbr1.internode.on.net. [121.45.207.92])
        by smtp.gmail.com with ESMTPSA id j67sm74431179pfc.72.2019.04.28.21.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 21:54:07 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Matthew Garrett <mjg59@google.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr <cmr@informatik.wtf>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the running kernel image
In-Reply-To: <87wojdy8ro.fsf@dja-thinkpad.axtens.net>
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com> <059c523e-926c-24ee-0935-198031712145@au1.ibm.com> <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com> <87wojdy8ro.fsf@dja-thinkpad.axtens.net>
Date:   Mon, 29 Apr 2019 14:54:03 +1000
Message-ID: <87tvehxvh0.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi, 

>>> I'm thinking about whether we should lock down the powerpc xmon debug
>>> monitor - intuitively, I think the answer is yes if for no other reason
>>> than Least Astonishment, when lockdown is enabled you probably don't
>>> expect xmon to keep letting you access kernel memory.
>>
>> The original patchset contained a sysrq hotkey to allow physically
>> present users to disable lockdown, so I'm not super concerned about
>> this case - I could definitely be convinced otherwise, though.

So Mimi contacted me offlist and very helpfully provided me with a much
better and less confused justification for disabling xmon in lockdown:

On x86, physical presence (== console access) is a trigger to
disable/enable lockdown mode.

In lockdown mode, you're not supposed to be able to modify memory. xmon
allows you to modify memory, and therefore shouldn't be allowed in
lockdown.

So, if you can disable lockdown on the console that's probably OK, but
it should be specifically disabling lockdown, not randomly editing
memory with xmon.

Regards,
Daniel
