Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B22C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Jul 2022 15:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiGFPJN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Jul 2022 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiGFPJM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 11:09:12 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4007D5FBF
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 08:09:11 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id g14so18607738qto.9
        for <linux-security-module@vger.kernel.org>; Wed, 06 Jul 2022 08:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tsz2MOLF2Bl4qmuGvjK22N+/EXyHNeIKMYNiVvkEHV8=;
        b=thPqX0IGEWjZaK/iFd2XgSBQnatpfmWUkxwOAAHv83ZWD04IHiwfBS1k+UdXIKnlMu
         0pxOKX9HcpydZ7rCINIJezXgylHrBHEgM5hZoDKbjCau6KZjY2+IqcOoR4bgAVkK7ODd
         w5RVoNQiKiB73AIcRkBKLylavTgMi8EtaadalBfRf3Ab9N4jpSV5mD3qfkYxmUthcecG
         TTcNLv/vkeMzOrKDX9CAxvqgvr7A2s0cx+T8MFe26VX0gejEM0HfwH+1u4Q61AiBVoNG
         ob0LVpa26NhpX89Uvr0tDwI4Oh6ouE01+1MRFI3AeGdOpw3ROTB03/jk4gRS81by6SrG
         y31g==
X-Gm-Message-State: AJIora8YCrjhe+aO9FjCh2r/gee5qUFc/rsHXhQVDVGRpik5OzPD3ROE
        I6qWt7DtPcXeNAExImvK5mK6
X-Google-Smtp-Source: AGRyM1t5PF0DSFrQbt4bi5LBPcIBQxZL7P89Hk2jkSRxl7RATw5BhQNCdgNUDq/Dg1qVd17q5SsXwQ==
X-Received: by 2002:a05:622a:110b:b0:31d:3958:e6e9 with SMTP id e11-20020a05622a110b00b0031d3958e6e9mr22319256qty.660.1657120150141;
        Wed, 06 Jul 2022 08:09:10 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a431000b006a7284e5741sm30587670qko.54.2022.07.06.08.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:09:09 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:09:08 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v7 3/3] dm: verity-loadpin: Use
 CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
Message-ID: <YsWllA0uZadrrXut@redhat.com>
References: <20220627153526.3750341-1-mka@chromium.org>
 <20220627083512.v7.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627083512.v7.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 27 2022 at 11:35P -0400,
Matthias Kaehlcke <mka@chromium.org> wrote:

> The verity glue for LoadPin is only needed when CONFIG_SECURITY_LOADPIN_VERITY
> is set, use this option for conditional compilation instead of the combo of
> CONFIG_DM_VERITY and CONFIG_SECURITY_LOADPIN.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Kees Cook <keescook@chromium.org>

Acked-by: Mike Snitzer <snitzer@kernel.org>
