Return-Path: <SRS0=2BO2=3E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D0C32771
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 18:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B2020728
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 18:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SKYJhUZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOSpv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:45:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40895 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgAOSpv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jan 2020 13:45:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so1050808wmi.5
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2020 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XhG7oKm+eUCDXzWAmBj1ApEpGRAwwk7JTkSRtwr4uDc=;
        b=SKYJhUZLU3m5uB+IwXigYsHxvV5o1M+7PQOjuaa8htp7C1d128jxoaBhSeOwMbUuZ5
         asWpNenhoM1ou5bOufNnZam1MHduqFELyxinQh1KeJSyJE8ICbIB47RiLkeBZdpguPWq
         NeayeqR6/qGB194gVdes9ah3JpJsuW5dMNdh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XhG7oKm+eUCDXzWAmBj1ApEpGRAwwk7JTkSRtwr4uDc=;
        b=BVotNPxv6VdBsAeqO3h+qEpKx6eTcAJ1J/6eMeCGQKnofSeVPn0y0CCkFOyAcIseVS
         0mOpyTVbPnvEayOAjcByWkSEZViAjBnS4CCZpJdbu7/ZNa6/5ER2G5QhOgLsTFyhk1jr
         BHsk2bivoGz2BILDQ0eeiSM0j3TPR+1Iu7JMwXgQf5fIZSQc4xIyX8FQf2u6QqmJfKJe
         9OcD4O9nix4WVGQYnSWnqJSZZFT1SSZ4sy/I4jkxQpY4xvR0SFp7u+H+BgCrp+feJw4i
         RnL/NQ2I7It/8dnz3LlZcMghcN91tH7j6glfLyXWkB3qU/3GYejltVIVZ/DHRjsBePfb
         ATUw==
X-Gm-Message-State: APjAAAX+wWddzJU3ZZMMTg1TThxg0lbCIHKiKXoKENXYlw/H9Uc7SGrt
        6ky2/qTGqUt2Se/xkxCQYHwZ+w==
X-Google-Smtp-Source: APXvYqxJUJuymcgl6BW34ydWB72BE5+YHoGJoQlEbVg0nk9JyqjTNyO7XAGrpWf/djrH7Rdzmj5LAA==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr1380457wmc.126.1579113948983;
        Wed, 15 Jan 2020 10:45:48 -0800 (PST)
Received: from revest ([37.165.158.17])
        by smtp.gmail.com with ESMTPSA id h17sm26445192wrs.18.2020.01.15.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:45:48 -0800 (PST)
Message-ID: <b88cbb1fb39175611e4b31e12a47df240a46dd48.camel@chromium.org>
Subject: Re: [PATCH v2] ima: add the ability to query the hash of a given
 file.
From:   Florent Revest <revest@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, KP Singh <kpsingh@chromium.org>
Cc:     linux-integrity@vger.kernel.org, mjg59@google.com,
        nramas@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Wed, 15 Jan 2020 19:45:43 +0100
In-Reply-To: <1579113367.5032.19.camel@linux.ibm.com>
References: <20200106162524.164650-1-revest@chromium.org>
         <20200113104830.GA28588@google.com>
         <1579113367.5032.19.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-01-15 at 13:36 -0500, Mimi Zohar wrote:
> On Mon, 2020-01-13 at 11:48 +0100, KP Singh wrote:
> > On 06-Jan 17:25, Florent Revest wrote:
> > > From: Florent Revest <revest@google.com>
> > > 
> > > This allows other parts of the kernel (perhaps a stacked LSM
> > > allowing
> > > system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the
> > > hash
> > > of a given file from IMA if it's present in the iint cache.
> > > 
> > > It's true that the existence of the hash means that it's also in
> > > the
> > > audit logs or in
> > > /sys/kernel/security/ima/ascii_runtime_measurements,
> > > but it can be difficult to pull that information out for every
> > > subsequent exec.  This is especially true if a given host has
> > > been up
> > > for a long time and the file was first measured a long time ago.
> > > 
> > > This is based on Peter Moody's patch:
> > >  https://sourceforge.net/p/linux-ima/mailman/message/33036180/
> > > 
> > > [1] https://lkml.org/lkml/2019/9/10/393
> > > 
> > > Signed-off-by: Florent Revest <revest@google.com>
> > 
> > Thanks for adding this Florent!
> > 
> > Reviewed-by: KP Singh <kpsingh@chromium.org>
> 
> Thanks, this patch is now queued in next-integrity-testing.

Good to hear Mimi! Thank you.

I would just like to make sure that you queued the v3 of this patch
though...? (this thread is for the v2 :) ) The v3 includes a couple of
comments you asked for.

