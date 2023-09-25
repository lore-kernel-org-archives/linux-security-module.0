Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E66CE7A8B
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Sep 2023 01:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjIYBcR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 24 Sep 2023 21:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYBcQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 24 Sep 2023 21:32:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D84BD
        for <linux-security-module@vger.kernel.org>; Sun, 24 Sep 2023 18:32:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c3f97f2239so48393525ad.0
        for <linux-security-module@vger.kernel.org>; Sun, 24 Sep 2023 18:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695605530; x=1696210330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t421teeWfsLYuWefWnb6yYiHbVNYi0Xr91E0o6nFyPY=;
        b=VxdpKuCt8ET1lyID1TTMw4eYMhZvF6JQObwHuk+Q5cHCgZdOGaLhFUEXxn54mBNu6/
         F+BnxD3zIUmeulv0Lmsy3y/+qrDKBUAEMSsO5xOjNOjG5VfOOIwc5A4YrKcFE7CQA9Zb
         7w6SxAvNVHnX5H9db/LOpJ4rxi8tJZX+JnA1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695605530; x=1696210330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t421teeWfsLYuWefWnb6yYiHbVNYi0Xr91E0o6nFyPY=;
        b=rTiQOKWF9dolYUDWecbGkmrtCJQYCCewJIBO/vQ1UFdAYzrNpr8tBFepUn2dUHGRP7
         3zcnVUy/0V1tSmYX2JAk521HB0SwfS7RVMAZESLpREQ/dYAZoR84cJuoMI9EdTRtfQQK
         etuGeSMECbHS8Gi+0k3DRX2raYYM3KjGPrZtaNa5l+PppiPm1NyrlBsZw7mnH1yIPvXe
         eMJvSx2LD04AODRtvJnPl6ca6V7zEHa9yEOCh1RCMPsuQoviz1TPZWm3D7n0DSNfEkt/
         yLH7WZqI+Ew9AvpOm/Wz/hhef/LmRiPZPook9T1KqP9eGOOZO9CJ1KnK+jB63rCrfcU3
         3z9w==
X-Gm-Message-State: AOJu0YyGMEpeaim3zh/lrA7iNiOMvzJ9QOrAlcw0Dt04sK2k0sKEY1Yn
        cNZF+Sdk9SvQ7BHYwmqPaNavlGYCOxPoSgpikZE=
X-Google-Smtp-Source: AGHT+IG9jDl0J5CtblmiFw0dieeTUSdJ67ky6Bdvv9hT/cioU44PIxosx6uo8QOLD5gb18M1RV2uSg==
X-Received: by 2002:a17:902:ab5b:b0:1c4:67ae:9431 with SMTP id ij27-20020a170902ab5b00b001c467ae9431mr6475379plb.57.1695605529880;
        Sun, 24 Sep 2023 18:32:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b001b9f7bc3e77sm7476893plx.189.2023.09.24.18.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 18:32:09 -0700 (PDT)
Date:   Sun, 24 Sep 2023 18:32:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <kees@kernel.org>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ANN: new LSM guidelines
Message-ID: <202309241827.6818149EC8@keescook>
References: <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
 <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
 <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
 <c8d58922-9af4-b425-03c6-6710ad17b739@schaufler-ca.com>
 <CAHC9VhTdtF=_4nj3-eQvBUhWhnEss28KKUKCciBCrBL9pN+uQw@mail.gmail.com>
 <8912fc96-cb8e-ec3b-273d-6bd8ad6b5513@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8912fc96-cb8e-ec3b-273d-6bd8ad6b5513@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 25, 2023 at 09:55:47AM +0900, Tetsuo Handa wrote:
> On 2023/09/13 4:00, Paul Moore wrote:
> > On Tue, Sep 12, 2023 at 2:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 9/12/2023 11:08 AM, Paul Moore wrote:
> >>>
> >>> Once again, we've already discussed this many, many times: out-of-tree
> >>> LSMs are not the priority and that is not going to change.  One
> >>> corollary of this is that we are not going to assign LSM IDs to LSMs
> >>> that remain out-of-tree as this would negatively impact the LSM layer
> >>> by cluttering/depleting the LSM ID space.
> 
> Like Kees Cook said, we don't need to worry about depleting the LSM ID space
> because lsm_id::id is a u64. We only need to worry about cluttering/conflicting
> the values.

Right, this will go one of two ways:

1) author: "Hello, here is a new LSM I'd like to upstream, here it is. I assigned
            it the next LSM ID."
   maintainer(s): "Okay, sounds good. *review*"

2) author: "Hello, here is an LSM that has been in active use at $Place,
            and we have $Xxx many userspace applications that we cannot easily
            rebuild. We used LSM ID $Value that is far away from the sequential
            list of LSM IDs, and we'd really prefer to keep that assignment."
  maintainer(s): "Okay, sounds good. *review*"

No problems detected.

-Kees

-- 
Kees Cook
