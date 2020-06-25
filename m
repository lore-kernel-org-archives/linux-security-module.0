Return-Path: <SRS0=LaDg=AG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC29AC433E3
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jun 2020 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86DB20773
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jun 2020 17:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TG9W9c4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406795AbgFYR2F (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406789AbgFYR2F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Jun 2020 13:28:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DA1C08C5DB
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2020 10:28:04 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r22so6087017qke.13
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2020 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gmdzvrjKvy7zOpV1NRuITfFsyUSJo95kHGnNoBx7SWo=;
        b=TG9W9c4fV8P6kucxRYY3WhM2fQlAiAfIIHNf+B91GL+OmpVqBJMnTwRomjo8dY9iXX
         0oxVntm0rbHyQFyWnEM89Cp/zgkg5WR1n6V9kxDTSAIGh6lIjQ1jKao1bHnl65Q6/xqg
         T7wvSq8GyUeJllsfC0yvy7re3wM3HR+Ry2XJqwse0iL5SQngYN6k709OssiNChYg9LYv
         ZxERXwJiEJW+zNJB6g9HXkqQzV4X85ZMpva36rHTOcOOle3+v0ET8+tkf2xk0t7QXMIb
         egFAEImp4Wfl7FVeAui2jZuWmFBhpeOTnutWojoevEj7dyOWn2YT29KHLHvEdvZJ0gVi
         Tkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gmdzvrjKvy7zOpV1NRuITfFsyUSJo95kHGnNoBx7SWo=;
        b=HmYA5qzP8fLppEFdzqup5ZJbcAcIUQfz2AUb0M7uEUE+yhVUj9sIID1FxzrHLoMJkX
         1KALYbYZ2sTGpRHIcnOxRq0a++nT9eqzZZaERjkY4jC8/ImnXN7CKCOVBrXBSlivsbfm
         DIArIcAG5sqoz76ja4hUCC7wWi4JttT8Qr5e15Qp00VqxfhQ9pHCVIDFGnx6zw77OZ/B
         OA8UDIote1C5joZ4YHfI2mpKFMcjHqMqpu/2n1vpky1CU5Alh/RIBQgSxk3AXD87efxv
         +hvD9e2j/KDzTNRwTK75DWRibQ634QOyoKOzDuLs0iK+RIMDdZkTiOZJ7ITMeUFeN+qS
         fuTA==
X-Gm-Message-State: AOAM532vPJXpxnS2HAkK3jUX1mkC9R07deVICBIa5dFGp2E9XzUmLU1J
        DcIs+BepMxxW5FxmczqHTcBc8Q==
X-Google-Smtp-Source: ABdhPJycbq62BggoDK0636NrdFXplcmFZ/swXm/+3aPR05wce0Y58DlZyNHuDGwiEpqljWYajCu0Vg==
X-Received: by 2002:a37:46ca:: with SMTP id t193mr1551563qka.293.1593106083838;
        Thu, 25 Jun 2020 10:28:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l46sm1431464qtf.7.2020.06.25.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 10:28:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joVfO-00EGZI-KT; Thu, 25 Jun 2020 14:28:02 -0300
Date:   Thu, 25 Jun 2020 14:28:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enabling interrupts in QEMU TPM TIS
Message-ID: <20200625172802.GS6578@ziepe.ca>
References: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 25, 2020 at 10:56:43AM -0400, Stefan Berger wrote:
> Hello!
> 
>  I want to enable IRQs now in QEMU's TPM TIS device model and I need to work
> with the following patch to Linux TIS. I am wondering whether the changes
> there look reasonable to you? Windows works with the QEMU modifications
> as-is, so maybe it's a bug in the TIS code (which I had not run into
> before).
> 
> 
> The point of the loop I need to introduce in the interrupt handler is that
> while the interrupt handler is running another interrupt may occur/be posted
> that then does NOT cause the interrupt handler to be invoked again but
> causes a stall, unless the loop is there.

That seems like a qemu bug, TPM interrupts are supposed to be level
interrupts, not edge.

Jason
