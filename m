Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB796C07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 11:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D7A2083D
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 11:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Rxk/fhhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D7A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLGLrQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:47:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44699 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGLrP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 06:47:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so1835507pfh.11
        for <linux-security-module@vger.kernel.org>; Fri, 07 Dec 2018 03:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y1k4ZAHwRUKOvYtOycMNHrzcfMSWO5Mk/Kf1Oas6D5w=;
        b=Rxk/fhhWloELRoqMrXPIySqqHyJ1OVgigFXXgPVuFGPcZHmAcxFOsQD7kiiXpinrlW
         aIlFabX5Q0VnUUj8aNWKBa37bcR5LKOkz+Q8A3+7fSjjFlKxehP3PvkcraevEkmAd8yj
         pQH7BlQO5dWnhN177WCMN95O1cdo4EJzPimRHJwkTEadCn3cniUmnD1Gg98RBLXg6ksl
         XAl2zuS9c1KFLjC9KlBYlgxkIUxvQWB4KrcHItvDpmu5/GT+fAcd45jdqFZvf1OMot5H
         8cNjjPscjWpKELz/n6DcV13scKsNUNGIVaTc2wi7SeG7dY0FFclLsXEUIULPqEp4K/2T
         kXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y1k4ZAHwRUKOvYtOycMNHrzcfMSWO5Mk/Kf1Oas6D5w=;
        b=FFnh0zUwzryyloY6ICrh1w7ulsi5MU7CI2yMa9cEA19V5wDWgdmz+ltEvZK9BvAI6a
         /roXfw25tdphsMoaJDIevApxRkqiFU4j03+vfWuCWvQ716FKa135IPeB/lPMaEdEymDT
         FR0K9EJF36MOZrmA6t65V5OLqiTeML22/eKXprGAwV/YGxWGV+HxR2JFzc8AFmsvP36E
         e5gbX5UeO8P8oOc23n0uuehp2XMTm2Lq8y4d7doQAhyenAon/Vlsl2TaN6VXaDpWrHsi
         IQDbPqbzXRs7tC3fZYb7srvNjUS3HOLPKFe9HDXRPDe95bIPQxiOjNTuB7O7oRKa/yDd
         NsXg==
X-Gm-Message-State: AA+aEWZ9HJ1AazSLJo+jvZ3Q1D8bqowfJykphCa96UbOrdaJtjH5MqOk
        yx3tjzyZBuTDyoUV1CyMc/FfiGF/7TA=
X-Google-Smtp-Source: AFSGD/XKQ9Qx7aVI1oE4cgIuDckNZURm9MqQNGSYPty6KlsCeiS35tfZh7GGhSIUlfBsiZDHb+hwww==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr1578080pgi.105.1544183234616;
        Fri, 07 Dec 2018 03:47:14 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id a73sm5380769pfa.7.2018.12.07.03.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 03:47:13 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 795143000CA; Fri,  7 Dec 2018 14:47:09 +0300 (+03)
Date:   Fri, 7 Dec 2018 14:47:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 12/13] keys/mktme: Save MKTME data if kernel cmdline
 parameter allows
Message-ID: <20181207114709.kmrbghihyrht2l65@kshutemo-mobl1>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c2668d6d260bff3c88440ad097eb1445ea005860.1543903910.git.alison.schofield@intel.com>
 <1544148839.28511.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544148839.28511.28.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 07, 2018 at 02:14:03AM +0000, Huang, Kai wrote:
> Alternatively, we can choose to use per-socket keyID, but not to program
> keyID globally across all sockets, so you don't have to save key while
> still supporting CPU hotplug.

Per-socket KeyID approach would make things more complex. For instance
KeyID on its own will not be enough to refer a key. You will need a node
too. It will also require a way to track whether theirs an KeyID on other
node for the key.

It also makes memory management less flexible: runtime migration of the
memory between nodes will be limited and it can hurt memory availablity
for non-encrypted tasks too.

In general, I don't see per-socket KeyID handling very attractive. It
creates more problems than solves.

-- 
 Kirill A. Shutemov
