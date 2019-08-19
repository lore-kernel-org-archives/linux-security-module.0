Return-Path: <SRS0=yDeW=WP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA34C3A5A0
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Aug 2019 16:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3E8205ED
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Aug 2019 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566233091;
	bh=Ye/IL7qi7ntpWlo7GGNzyZeXk2i5RgzzrtIV4cW/m+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z9twn+E7NwW6aj+P5HsvvTZZIJBGt/2C5FWC+BryvxO+7lS20JwCvp5AYQadezV7l
	 G039FVvIu58y2RWbSB+8mQnxRLhqfXYaOQPHu4kUGSJqUanqD+21+5Wk75JPbOPrtV
	 fenD7/8TwwAtelkvP6OEgJT6Jt3AL/XuyRE7Wz0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfHSQov (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:44:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41011 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHSQou (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 12:44:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so1886852lfa.8
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTgEEhnQW7rA7Swk7XmZoE/TVWKiM/rYLloBH44I1Y4=;
        b=HXYiO3uvFIJxP8AzLPiB1vCojk2HYF1PHjHSec/oU/g4xnNPfhabSnJiKWyvKhdvPL
         PSTBApqcqrNATd12uSC/OSvm8TCRNPUsxfylRETL95enFuQ/shakvQqEAneNqGoKLzuq
         zpeeR8Q32NiN+R8GM+dAc/To+08EVo1OrugEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTgEEhnQW7rA7Swk7XmZoE/TVWKiM/rYLloBH44I1Y4=;
        b=uReedhZuUIojJEzMOuujMLMtcJUHmib5xvyoxHCBRqHS5XWKiPqSEvCZXa/czJOMuW
         CWu3kC32QONzDUmiBbE/4d1TvpoSUTi/GplcjUebRNZpWWbksWBlSf4NjTIt1Ir7Ic+W
         klSO+85ickYwMkDFernf7+EPU3vofFo7uvm+Fy53KXptZ7EcLjhqVmW5JYqPTDLiATyU
         mwLrG7NrmGHn/+qJC0heqRW9KItHkkq303z3074I9OoQiMC/jwuOdplRI5VXslEhfs4o
         0WRM2tQM3S7QBX0vApjFNzVk/vGZO3/4MqeAtCSiJua0NEpFOR6RgWxvpnt3Qou44FZu
         ZhEg==
X-Gm-Message-State: APjAAAWqpqHKPhVQsTkpyKmrGW96LJDShUBu7rftY91u2cr7TfhV1O+c
        ZzTgtZDE4V6M3QWl/7eB4sOGK2/58LE=
X-Google-Smtp-Source: APXvYqzCM/yI3KNIkdTpqlby0475GeDa7yvJuFOG4pDmk7O4pAa/jOV6TU24hF3Y4DbvKky/ytdJWA==
X-Received: by 2002:ac2:5637:: with SMTP id b23mr13288138lff.186.1566233088340;
        Mon, 19 Aug 2019 09:44:48 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id y66sm2403694lje.61.2019.08.19.09.44.47
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:44:48 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x4so2401444ljj.6
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 09:44:47 -0700 (PDT)
X-Received: by 2002:a2e:88c7:: with SMTP id a7mr11508843ljk.72.1566233086820;
 Mon, 19 Aug 2019 09:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <156622692131.21558.12335114959426121841.stgit@warthog.procyon.org.uk>
In-Reply-To: <156622692131.21558.12335114959426121841.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Aug 2019 09:44:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiP7j+vzthU+wokF-PfR-CtA1YnwT6tYeNO9HK1KWUpiQ@mail.gmail.com>
Message-ID: <CAHk-=wiP7j+vzthU+wokF-PfR-CtA1YnwT6tYeNO9HK1KWUpiQ@mail.gmail.com>
Subject: Re: [PATCH] keys: Fix description size
To:     David Howells <dhowells@redhat.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 19, 2019 at 8:02 AM David Howells <dhowells@redhat.com> wrote:
>
> This can be fixed by simply increasing the size of desc_len in struct
> keyring_index_key to a u16.

Thanks, applied.

              Linus
