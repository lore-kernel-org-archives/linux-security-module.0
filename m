Return-Path: <SRS0=sHE6=MN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2C3C43143
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 22:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB662084C
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 22:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oPwhyJMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB662084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeJBFTB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:19:01 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34053 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJBFTB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 01:19:01 -0400
Received: by mail-yb1-f196.google.com with SMTP id 184-v6so1982ybg.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 15:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UMzJokdN836gOh5JAgIVLjCkTlz0ooJGNhxCcGJyP+w=;
        b=oPwhyJMemd0B4pNTa9TnSGo0z51tzG9fA7HhMGTMc7mr3rAZvdxdFtBpA9nbLou/rH
         bUC6MGt26lYWo1p+/IcqVeyOT7lTa4b0Fiuu7i0xElg4vblKUwuW24B1dlnSqBEWTBTC
         ShTLjvl2Ki9YeDtkNox/KUgQ1L7M1WBgPNSfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UMzJokdN836gOh5JAgIVLjCkTlz0ooJGNhxCcGJyP+w=;
        b=ks1adkPLkNC/VudQkPvpwtsHT4rGj278menUXYLUJ7jNUdas+x1U1atOIZBrbdoutq
         e7P8D8sC0qFGoKLUUnUsHhmssEoCmmmalQ/k1NLDtQxZFXc+paRmGTt3fngjYh98ywRl
         lfCSwFlqNrLaf4BkFL0Z0oYhMxWLVFI6wJPscVM0aQtEDLRaxJsE0P5LeiB1sLvl/e7B
         K8VGEEqhsHbBBOGKaKEN6f7lTpTU0KIQ/QOCal1NJqbl2KDW3O0yf9NGkPplZaXcVlmV
         DEjkXGu9AjCAGEFxj6eIzFalO1qqDV1/VM5+mpoBGBclh9jhvZgrjt36e+60uSdUR5Au
         gRrg==
X-Gm-Message-State: ABuFfogiUKKItDTFav8poSLxxZk2ROow0AlXbuFOnx953OjHpocjNq6w
        v2Uu40XAjuuZDQAXjldP8Z36XVahMe0=
X-Google-Smtp-Source: ACcGV60NcSFXq7IQIl+QUi3EKRfJUCeesAsycqdoxFI23X4DOOzsfE10/vGdYY1I4BdmgwELdGi2LA==
X-Received: by 2002:a25:9982:: with SMTP id p2-v6mr7068039ybo.315.1538433538573;
        Mon, 01 Oct 2018 15:38:58 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id z20-v6sm15645186ywz.75.2018.10.01.15.38.56
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:38:57 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id s73-v6so6213387ywg.11
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 15:38:56 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr7166457ywp.407.1538433536573;
 Mon, 01 Oct 2018 15:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 15:38:55 -0700 (PDT)
In-Reply-To: <20181001172315.225d18dc@gandalf.local.home>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-5-keescook@chromium.org>
 <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com> <20181001172315.225d18dc@gandalf.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 15:38:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJbO7c0Hiw8_9hhkbo74c-56g5ppW8g1ynyPt-WsLaxRw@mail.gmail.com>
Message-ID: <CAGXu5jJbO7c0Hiw8_9hhkbo74c-56g5ppW8g1ynyPt-WsLaxRw@mail.gmail.com>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 1, 2018 at 2:23 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 1 Oct 2018 14:07:55 -0700
> John Johansen <john.johansen@canonical.com> wrote:
>
>> On 09/24/2018 05:18 PM, Kees Cook wrote:
>> > This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> > security and console initcall trace events") since security init calls
>> > are about to no longer resemble regular init calls.
>> >
>> > Cc: James Morris <jmorris@namei.org>
>> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> > Cc: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
>> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> > Cc: linux-security-module@vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>>
>> though I do think it would be a good idea to add a new set
>> of trace points, but that can come as a separate patch
>>
>>
>
> Agreed.

BTW, how would this look? I'm not familiar with adding new tracepoints...

-Kees

-- 
Kees Cook
Pixel Security
