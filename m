Return-Path: <SRS0=sHE6=MN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1818C43143
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 22:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC568208AE
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 22:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgiy8jMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC568208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeJBEni (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:43:38 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39339 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJBEnh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 00:43:37 -0400
Received: by mail-yb1-f196.google.com with SMTP id c4-v6so6314489ybl.6
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G4WcYotR03OEiNZiei9M0bOlxNlJjM/PINeXng+gx/M=;
        b=lgiy8jMhzBgIGEBGrPZhMcj8TTB261UftqDh5TzpBimaxjJ1FIwdJ/GRff2r1AC6Bc
         B5R4sUiLA/1U83AoKpyhFreRdDY0RNHuj0RFSKVOEkB10C6Ds1DjNO2Xam/Tt18aLhDT
         cltTpHVsiCm5bW317fIcdRaho9chmr7VjzWhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G4WcYotR03OEiNZiei9M0bOlxNlJjM/PINeXng+gx/M=;
        b=ntJUFqlv7lXikbh3L0xFBnSx4noZ562GQSXfO+SqoRWcfL8uij9hy7KLaJi0dZkAgQ
         v/UUqw7X/7FDdG9DGJJzwWECQVzQNyt+bFDXlHUb7jK+nceV1Es6wST61HkIcjo8Pvm2
         gTFH3gpAhECF7tbjXYt84PH63MQu/chigFoFzjmXdhquFxseUZhPnK2QlXnu/1n8zfNK
         S//xjRlJsVEWeShO8t+F9sYHY1tfNgnq9Pht/vFhylkI16EDM9rvJ3jh/CuRCCcSuW9+
         DizXdrNytHuVHs6QrEagCCo2pHPNAjNz9VnIGh/JXbi78kFyJ9D+492/VH2mXZOmZVtC
         9SZQ==
X-Gm-Message-State: ABuFfog/FQQ67Gh3MtAdMA5hLubxj6NzAq8/5KnCY12SuWyBfquKZA1p
        Vk/irD6Rp/syxMuaBHOElP2FfLV9saA=
X-Google-Smtp-Source: ACcGV61OuLO13zM64ke87SlI2OJ+wtbN183uR4Y0vvX+qNASl7GDYB9RrKPpc3Oh6MpMNAw+DoB4nQ==
X-Received: by 2002:a25:7106:: with SMTP id m6-v6mr7066041ybc.427.1538431421887;
        Mon, 01 Oct 2018 15:03:41 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id s200-v6sm3906790ywg.61.2018.10.01.15.03.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:03:40 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id m127-v6so2595411ywb.0
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 15:03:40 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr7157668ywf.237.1538431419933;
 Mon, 01 Oct 2018 15:03:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 15:03:39 -0700 (PDT)
In-Reply-To: <110c9903-0fbb-8d6f-1fd0-7731402d600f@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-13-keescook@chromium.org>
 <110c9903-0fbb-8d6f-1fd0-7731402d600f@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 15:03:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK+WT-1QkapORpzBJDCeZSAXUf_tN0mwRU+cWy=phRdgA@mail.gmail.com>
Message-ID: <CAGXu5jK+WT-1QkapORpzBJDCeZSAXUf_tN0mwRU+cWy=phRdgA@mail.gmail.com>
Subject: Re: [PATCH security-next v3 12/29] LSM: Provide separate ordered initialization
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 1, 2018 at 2:17 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 09/24/2018 05:18 PM, Kees Cook wrote:
>> This provides a place for ordered LSMs to be initialized, separate from
>> the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
>> ordered_lsm_init(), but it will change drastically in later patches.
>>
>> What is not obvious in the patch is that this change moves the integrity
>> LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
>> with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
>> list, there is no reordering yet created.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> I know its already being done, but I don't like splitting the init
> order

Can you describe what you mean here? Do you mean having two init
functions? This is only done temporarily while the other pieces are
reorganized. The later patches reintegrate this. (Before this series,
we effectively had three implicit init paths: minor, major, and
integrity, so even this patch "alone" is an improvement IMO.)

Thanks for the reviews!

-Kees

-- 
Kees Cook
Pixel Security
