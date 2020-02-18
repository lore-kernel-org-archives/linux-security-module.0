Return-Path: <SRS0=lArx=4G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58524C3403F
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6F0208C4
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Feb 2020 14:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+CFIqQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBROuv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:50:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34233 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgBROuv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Feb 2020 09:50:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id l16so9993442qtq.1;
        Tue, 18 Feb 2020 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PGsIFpt7ejI04gpcZDzS9agp/KwgfVH4fOkFoivCASg=;
        b=A+CFIqQLqeyU4kvK3MhSbCMbuuEqrbjvvIqJxOUTv2HgmiXGYNW7C1z+p7V0gC79zi
         GQEvfcKfBj14K9RWMUehMaRhJ2bCH/FRNv2MTPHpbNz+UAoC0npdPeZJVhl0U8UI/Wme
         CffES0H9jOiIQ7QEXTg1U5MlAtT6wyJGipAWKClCzYDBkaQ/o7mVwhVmINa1xhrFoxMi
         943U2II4fkn95KMXcsrTNq8qlG6tMcCW3kximKXa7u+r58cfcl+IrK13vkZM2BQAb/mH
         82Pug4U25ikvmGjuiGRS089d55/ZkW/WgwuDwxFqFRMXK6p9Ahy4E6X7bRulK/oz8dx2
         JwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PGsIFpt7ejI04gpcZDzS9agp/KwgfVH4fOkFoivCASg=;
        b=iNAnhHZsCcqKg01Y1WjMEI8qZZ7OtV5Nb9cRhW0pBCbdEUsUbPE2zYrZpr9uuJuAql
         7nwjPm9DRoA95luMki4k5ccJX9b/PdxKzj6lG3+/p6mcBy187UQgTStzCjsPgCm0ybwG
         YkOF7UgCR9DkRQ1OMDGTcxXqqW+FmHLPF/TSEXvQeAOQWRy8S/PNaipRGOgMuTfMbefb
         N8w7A53o9UF54w6ZOzUksRWf/j9M1jozpCXGhTuBxfm88mV9Pzi9nx5Gm2BmhRNlTLa7
         siwjmJj0kRh7PEJA9hJNV+ldHLx2+Cg2FIEibHW7F9tO8RCIJ2HviRxv3Aiod61/zBiy
         32ZA==
X-Gm-Message-State: APjAAAVn4xZDo/8ivJICQ+aGHWZHlXl6SND33GHeA9niBuC+H6oyWZ/J
        oeFtkDWDj2M67zU3rifaVe4=
X-Google-Smtp-Source: APXvYqz3WZcsMIi6+6MdOuy7Qphd3EjWE46lqPDYwzRM1wZevIiPom5g0b7L2RYgvCWP20Z+2K2k7g==
X-Received: by 2002:ac8:1c23:: with SMTP id a32mr17338223qtk.119.1582037448975;
        Tue, 18 Feb 2020 06:50:48 -0800 (PST)
Received: from localhost.localdomain (pool-74-108-111-89.nycmny.fios.verizon.net. [74.108.111.89])
        by smtp.gmail.com with ESMTPSA id h9sm1874717qtq.61.2020.02.18.06.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 06:50:47 -0800 (PST)
Message-ID: <a3bdba9f94669acb1be7bacec456918eb520e606.camel@gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   david.safford@gmail.com
To:     Ken Goldman <kgold@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     monty.wiseman@ge.com
Date:   Tue, 18 Feb 2020 09:50:46 -0500
In-Reply-To: <f095a412-9967-416d-a4d9-d3b5799f8409@linux.ibm.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
         <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
         <1581366258.5585.891.camel@linux.ibm.com>
         <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
         <f095a412-9967-416d-a4d9-d3b5799f8409@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2020-02-13 at 15:11 -0500, Ken Goldman wrote:
> On 2/11/2020 11:10 AM, david.safford@gmail.com wrote:
> > There is no reason to resend the same data for every attestation,
> > nor is there any reason to store already attested measurements anywhere
> > on the client. By versioning the log file names, userspace gets a
> > simple way to know what has and has not been attested, and for small
> > embedded devices we don't need to waste memory or filesystem space
> > on the data already attested.
> 
> Yes ... no.
> 
> There isn't any reason to resend measurements that a verifier has 
> already received.  In fact, the logic I coded also said "if PCR 10 
> didn't change, there's no need to even ask for the measurement log".
> 
> However, don't you have to save already attested measurements for
> the case where there are multiple verifiers?  A different verifier would 
> have to receive all measurements.

Certainly for the use case of multiple verifiers, the client would not 
delete the data until all verifiers had acknowledged receipt.

My main point was that there are at least some use cases in which the
client does not need to keep the measurement list, and IMA should 
support the option of exporting and deleting the list in these cases.

dave

