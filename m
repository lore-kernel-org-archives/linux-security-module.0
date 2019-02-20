Return-Path: <SRS0=vYSA=Q3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ED1C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398D72147A
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 16:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mahU/fAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfBTQAp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:00:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40137 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTQAp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Feb 2019 11:00:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id bj4so12427593plb.7
        for <linux-security-module@vger.kernel.org>; Wed, 20 Feb 2019 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RY11cIriJiQSAMxw9Y+OKRZpU3gInWMmnwtnKL7ESTo=;
        b=mahU/fAmVgFJMmY1HOrY8vlYPp1BtdCssDMXjzZqDddjWiIGNhISThFMZb2monQuv6
         bXnuK6ZOOo05OLlTz/LGTn6MqZHSeOly4OOujYAp81eVrR91l/HLIJC9Mhen/L+pbUc3
         TeGKiMYx/cXTTfaWE8c5v0WGPBWI5TdvrpoWBBjxCaRuVkb0ivPAKKcVbarh0pmIDlSa
         CakG2PtkATIpnfM3L5dbPvxQ8EPWhl9g15J53gJ8zxGarf6Ih7eu1VMyYAoTeslmrCFZ
         Rz6r0X0CBd6IsrA2AX9hOHYK0lp1R0QNaRotXa1nZxbTFX69Sd5wGjB4fsOopaHIohzs
         oXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RY11cIriJiQSAMxw9Y+OKRZpU3gInWMmnwtnKL7ESTo=;
        b=phxKQ0ZUeYrl1X0DT+3tlg4i+mf7g2y3uWOu71j93HYBg9lMks4MH3JybSVnRk+zoZ
         qgNR9KZGtoLHe5vgrpRipNAsvjG44+EP+Ym6iol1n5WWzGaS2kShlS3iA0dWmztXvc2W
         oSjjgMKqwXU26FcnYyeSXelcv2xkyTFrJVGTMlzlUY25/DunSbshDNszzZx9ws9oRVvA
         gXO/EK80uxLo7Q9SuVindrv+QTBSPProLKzm060qis4SbM8VJ90q6qHN93lIlTMbWWZM
         aBlWYMaHyNiUSleI9nNpzU/vAtZSjYw+9s+wr7nqHOpmP0AQSIAlid0uZ7wwNTc58f2q
         QfLw==
X-Gm-Message-State: AHQUAuarOQqXYZIfUNxUGmJ6gCEA6VKUsJEchoHoZ66Tqv23xD14TL+7
        zF5ieDihyRMZ1vEnzBfwzTSLnA==
X-Google-Smtp-Source: AHgI3IZrMSSAdOlqKlcGRid3pAKHrrIxikBSsRqtAHc7I/ueTGAhyQslkMGqf53BI49555BCCocLpw==
X-Received: by 2002:a17:902:7c98:: with SMTP id y24mr19525405pll.191.1550678444132;
        Wed, 20 Feb 2019 08:00:44 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id l2sm6129849pgj.64.2019.02.20.08.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 08:00:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwUIc-0007vb-PL; Wed, 20 Feb 2019 09:00:42 -0700
Date:   Wed, 20 Feb 2019 09:00:42 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, peterhuewe@gmx.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 -next] tpm: Fix the type of the return value in
 calc_tpm2_event_size()
Message-ID: <20190220160042.GD8429@ziepe.ca>
References: <20190220022300.25888-1-yuehaibing@huawei.com>
 <20190220063159.GA23027@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220063159.GA23027@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 20, 2019 at 08:31:59AM +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 20, 2019 at 10:23:00AM +0800, YueHaibing wrote:
> > calc_tpm2_event_size() has an invalid signature because
> > it returns a 'size_t' where as its signature says that
> > it returns 'int'.
> > 
> > Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Two remarks:
> 
> - git config user.name "Yue Haibing"
> - "Cc: stable@vger.kernel.org" before the fixes tag.

'Theoretical' bug fixes are not suitable for stable

Jason
