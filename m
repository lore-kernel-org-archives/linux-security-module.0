Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA7FC07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 11:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA5420989
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 11:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="10tNucBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA5420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLGLyh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:54:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34223 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGLyh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 06:54:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so1648604pgg.1
        for <linux-security-module@vger.kernel.org>; Fri, 07 Dec 2018 03:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HyNJMq53ow/uSgSuL18f5sEEVr6bPc/VlLsH0bgmtwk=;
        b=10tNucBZ5D8R7NDg/7pPavaQ35r+9Cz96QxNdZAOez42vRNaFv5PmPYh4eWebwd4eG
         bIzD2HUtdAOSzDHvSgIiyqkJt9T/1JkgMP5xn+8lpOWy30HnLILjqlgP0ikuy19TGy/U
         mE7eC3dc6rdfyGXJpD5hc6xp8Bc6YDFHGKiavSN74RdZqNbMomRJchv1TFlL4eNN4OuW
         TjC72s9jwWtH5ATTQr0QzqHWKYhIw6hhDcCrojszPECoC7ECbqgFsS2N1+u8iyHQwLaO
         5WcY0QB/wN6dlT87sC7RkvhJdnvj2dMPfbdrQHfxQY5VLos+PAmCrHuAzOJ1AbjX2+hs
         XOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HyNJMq53ow/uSgSuL18f5sEEVr6bPc/VlLsH0bgmtwk=;
        b=B09lLLqxEoMuZXHuKh3OT89IFxtOc7T/vVMQYkP8CJdL5o9IdHCaoTzfrZXJCrAHDm
         SOz9xZTMD134LW/9CzykIR7xOYWiR/x50egjOlCIUHOVwqJUVrnT8rFycqMWPff36a4J
         rrL+8jVgiw723qNb6oNGKQfv610pELdzmtgLDIaUgORDEwNNtygj4owfWD4Ym6jyzrCG
         gVjgOqJ2xRh78UvocTxWOchTtlQWtX2Kc8aT0aHzGkjoicaM1qEEc7yfNLV211BbabS9
         qRIGrLsUY1e0PmEEMIg2MUcvSB1CzAoX51KWBenUOoLJQJLYc1uVbs8GDxddUi+hNNWW
         9Nog==
X-Gm-Message-State: AA+aEWZT3U4tdS41bDnJ7+ESM3A5J3Hssv+5ar7+R5tBv4SLIIfCL26N
        X4/KKu/MMS3oxbNDcJZD0m/i/Q==
X-Google-Smtp-Source: AFSGD/UWUZ07DB6FoM0RLoHL0fwDhiErMniU37umO7DKfQjewcZ2/f7joJi+dKrXihF4ItS5luWivw==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr1933555pfn.91.1544183675739;
        Fri, 07 Dec 2018 03:54:35 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id o8sm5476407pfa.42.2018.12.07.03.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 03:54:34 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 9830A3000CA; Fri,  7 Dec 2018 14:54:30 +0300 (+03)
Date:   Fri, 7 Dec 2018 14:54:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-ID: <20181207115430.xrj64q4j7hqdmbsw@kshutemo-mobl1>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <20181204092550.GT11614@hirez.programming.kicks-ass.net>
 <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
 <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
 <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
 <3a0a11bc557288190f6fa804dc8e7825738ccc70.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0a11bc557288190f6fa804dc8e7825738ccc70.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 06, 2018 at 09:23:20PM +0000, Sakkinen, Jarkko wrote:
> On Thu, 2018-12-06 at 14:22 +0300, Kirill A. Shutemov wrote:
> > When you say "disable encryption to a page" does the encryption get
> > > actually disabled or does the CPU just decrypt it transparently i.e.
> > > what happens physically?
> > 
> > Yes, it gets disabled. Physically. It overrides TME encryption.
> 
> OK, thanks for confirmation. BTW, how much is the penalty to keep it
> always enabled? Is it something that would not make sense for some
> other reasons?

We don't have any numbers to share at this point.

-- 
 Kirill A. Shutemov
