Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E17BC6FA82
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Sep 2022 18:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIUSJM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIUSJK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Sep 2022 14:09:10 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D68D883EC
        for <linux-security-module@vger.kernel.org>; Wed, 21 Sep 2022 11:09:07 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 3so4553760qka.5
        for <linux-security-module@vger.kernel.org>; Wed, 21 Sep 2022 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2KAjKe3iq+QwXIwjpYW0v2WCVk5payTUoCJDsQmbzI8=;
        b=fHDduti3CxdhlR7cTOA3bHhFjSsFgLzHd7cyUqMp7cDXRqkMCXpLOCc22ysE/u6Kh2
         HIGYwvhJxEZfTaOngML/3hnx0h432B4fP7654sKJhbc5rtbz36iNUhGVxIJi+7ZkpwJK
         Hjm/3CgbuCWlweV9iNYNfgs81GLrkku0T+vBnkfB6J2jO02uzYEZ3hQ0SfGKaqtZL6v1
         TyJGu1wof5Q41gchlf9KraJgvFxDWjGIzqspgvV9PCaNgCxTeXJuBXQlqrVf41ZO3v41
         l0igml8T46Gi/I4N/N2ciB7wX2RNoBfMYAPi5C86mv/+8zmytwTakT45ZHsr8oD2zbaV
         YSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2KAjKe3iq+QwXIwjpYW0v2WCVk5payTUoCJDsQmbzI8=;
        b=GHqujdPHQzwRlgNUCBUAzCTTFWo7EzRfCCqsBh+K0eo4wtt17FymONa4oFQFWRqGlf
         o6ppKXXqyRKldE3RVi9NBFkfCm75BBhWrh0MIZhj75DhG4miEvWF7rFuKDZI0MUTkql9
         QWXZsSxv+6Hygs7YA5eHZfWy6UXCi/+2iyLFW+VwycY14kji0ku4ZzUciqnFM3BJqHrI
         Gw1GqBy/twtHg2cTmg9QK9pmJHdGABwIBTsbjbXcrek0i/sRWrHRKDdsQ3Hm+fFWRXIO
         9whrsWL5y5I3xSAb4eZw8nYe2HdPxLN5H3O3GOXpNcSCFCUnrXAFCUK4YUIrHY9mw8lj
         GtSQ==
X-Gm-Message-State: ACrzQf3yR8gp6I4RJiTg4LoB3WFuO2O4/EW/gFeD8JAOpC3V6s2VGiaX
        8fOEHm1xMFA3luZ9JfGbf0X8Gg==
X-Google-Smtp-Source: AMsMyM4UCVkUuJlIWCzIoLcjoOrjvEbZNm7U4braBDAIgp5TxPj0szTxk92o8GSPD6WK1CcXL2nSfg==
X-Received: by 2002:ae9:eb04:0:b0:6cb:d287:d6d4 with SMTP id b4-20020ae9eb04000000b006cbd287d6d4mr20476883qkg.310.1663783746781;
        Wed, 21 Sep 2022 11:09:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o10-20020ac841ca000000b00339163a06fcsm2075049qtm.6.2022.09.21.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:09:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ob49g-001Gq7-T9;
        Wed, 21 Sep 2022 15:09:04 -0300
Date:   Wed, 21 Sep 2022 15:09:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
        gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        apronin@chromium.org, dlunev@google.com, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, corbet@lwn.net, jejb@linux.ibm.com,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Encrypted Hibernation
Message-ID: <YytTQPOlAC58Bk7W@ziepe.ca>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220920084648.GA17087@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920084648.GA17087@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 20, 2022 at 10:46:48AM +0200, Pavel Machek wrote:
> Hi!
> 
> > We are exploring enabling hibernation in some new scenarios. However,
> > our security team has a few requirements, listed below:
> > 1. The hibernate image must be encrypted with protection derived from
> >    both the platform (eg TPM) and user authentication data (eg
> >    password).
> > 2. Hibernation must not be a vector by which a malicious userspace can
> >    escalate to the kernel.
> 
> Why is #2 reasonable requirement?

These days with kernel lockdown we don't allow userspace to enter the
kernel

> We normally allow userspace with appropriate permissions to update the
> kernel, for example.

And in a lockdown secure boot environment only a signed kernel can be
booted in the first place.

A series like this is effectively carrying the secure boot trust
across the hibernation

Jason

