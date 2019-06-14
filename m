Return-Path: <SRS0=4asR=UN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF12C31E44
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Jun 2019 08:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7C62080A
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Jun 2019 08:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgNaSFKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfFNIQ1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:16:27 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:33603 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfFNIQ0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Jun 2019 04:16:26 -0400
Received: by mail-lf1-f47.google.com with SMTP id y17so1123098lfe.0
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jun 2019 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sz21dcEmUnt78YNFfm6F9rMky982RcdT6miE7Kwy+xQ=;
        b=cgNaSFKwKYmVfImDO2DRLbyekomRK9qHKelIPfrEQAtqGlD1M55ojIBI7PTJXK6ig0
         VlSjky6WaPqSI113zdWaJbUUGusnixgE68yKeX0SUfDFX1Td0a8SkmoodjzeNEkMYBTe
         /iBHx4Smi1pAPuNhZiBPk2XbdRhx/Pp8pYRVXPdOv2IxSK1Xy2yIvxP1ZrJHm5CFjw4q
         ePBGvlF5iluLyr+9Jyu9BuoJDyoyVMZlKvYs/45e1ppUV5/2FZJO/uvy2N4J009is8qu
         BjaIGtSadmPLLgk2zxF/2WNL9qP65CHoWbydut0H7Nrt7w9gWhrmTAUWbaqfRnsQKfk3
         WiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sz21dcEmUnt78YNFfm6F9rMky982RcdT6miE7Kwy+xQ=;
        b=rPcDDXgG0fX9DvbnjLHYitxliB5o5Vfu6gAtnfPeWIQ3K44QhgjqSb/6iKI1PPc8ut
         JTAy6aWm1AqwrnxxdbWVbJcXpz8Jx1bRUU6+tGJy2lN3iaIuCXnHPD4cJNqzK3wp8LM6
         pnQ1Q63A2eaqxNKEQzGrek7ChtMVu6bReqhl4MCiDqjg6oOZXs/nSKb8rJmdXZ0FVOph
         8J9NG3eZql/3gy5GmFeO+hPSrGdT/ar3L9PXPhqk+JtEIVritmMD+o9M9MhttK14RW6e
         w6IasJt8VJrz6+nmN5Q/gyMIyGdLqURG4KWsFEL0jO1ImD4/qKEhKwoSxwjOhHLVX5b7
         MHdQ==
X-Gm-Message-State: APjAAAWfxht+daPGbPWlma2JSYjpR4WgJZvMMYmTAPfta1vu02NRRLjU
        9XM8DYcFFqQrwRnE80tt9RqNgw==
X-Google-Smtp-Source: APXvYqz2SFwlCts58NJ9uhwjuLDS0BZ40ErMRTVyj9BXE6UW3BuzWyga/5vhM3jc6xoSbw4tyw5ZYA==
X-Received: by 2002:ac2:418f:: with SMTP id z15mr18332522lfh.177.1560500184883;
        Fri, 14 Jun 2019 01:16:24 -0700 (PDT)
Received: from jax.lan (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id q13sm357761lfk.65.2019.06.14.01.16.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 01:16:24 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:16:20 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [RFC 2/7] tee: enable support to register kernel memory
Message-ID: <20190614081619.GB9347@jax.lan>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560421833-27414-3-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 13, 2019 at 04:00:28PM +0530, Sumit Garg wrote:
> Enable support to register kernel memory reference with TEE. This change
> will allow TEE bus drivers to register memory references.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>


Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens
