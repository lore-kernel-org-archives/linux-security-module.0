Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C23C2D0A3
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF128206D8
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 19:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4W/Esn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKITGk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKITGk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Nov 2020 14:06:40 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDCBC0613CF;
        Mon,  9 Nov 2020 11:06:38 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id g3so1475231uae.7;
        Mon, 09 Nov 2020 11:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHzkmOmPkjnd4G3j6iZOSBoju4aalKTDiO1p/8nrAtk=;
        b=g4W/Esn0PCw1rNqZHCEy6aVXzNhdlt7xxIAfg11E/IlViUup+R6NwVIP7jvdL5c98W
         ESNR/zWn5Hw94oynRqdEPmrI7ZlE5NR/aDzubeh52GC+kWjE5C/XhOhymskqjAqzybKV
         cuUdvcE11NNU8rIyDobk1zW1gaw5B0ZGewl30b+r9NOAsbCVi0gOMtlZNm3weniT6Y4A
         2AoG0lXC7hJ2I/+741o/FJvNA1YSAAWJbDhw0KyVxJ1XXQ5B1rBhVWDVMZSL5afa5Q7L
         6DkyT+Z+wcrliguiPVPVv5BRfA/jA/Inf5bDB9lmnR92uO5p4HtFu5qsBfA3lxbIuqYG
         G7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHzkmOmPkjnd4G3j6iZOSBoju4aalKTDiO1p/8nrAtk=;
        b=F1fW9N0GBDsCCyxyaitc9HdM1U1ZDjarBTMxVMwbhBGz2Iep+ngNirPtQYannkKOs9
         HbQ/16QLX5McfpK5RYCRGlF/Q9jKVfh0MnczlHd81mTd/5j5TWsiQGy3t/vUm2bltnUS
         67R5CH1rd7ppxqET5WVJ7dsCPqakVAEAsD6H6ktWibbV57074IkhruKrxATIO+5JVXfG
         Dwg9dtl14v0Q6z50oUfWtL1gT9cERcsUr1I6NpBA35KScMcFW7YimKSaNigStb76CGYw
         k9zjpPxCeX712QYAJdNwVH/s3GVv80f2hbJJfdiAtHGWzZv8xy02bdYIlISYZoF2mT57
         dyIQ==
X-Gm-Message-State: AOAM532/DGoHc3VEUWap4aE0RDl7Fwg7X9iC9DLcRpoEaOEuQENnP5Z1
        IB8Vt/R3Tw//5HYDeeXkiSooCF8qIswFB1jgAwo=
X-Google-Smtp-Source: ABdhPJzlySHrx/28itCmErO7VlN5yaENjhocxUQ+TChekl0njkjToaGz2RHgjpUsiNss6rsKZK0eVpzOKBkM2mfe6Sk=
X-Received: by 2002:ab0:549c:: with SMTP id p28mr8452414uaa.47.1604948797853;
 Mon, 09 Nov 2020 11:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
In-Reply-To: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
From:   Aleksandr Nogikh <aleksandrnogikh@gmail.com>
Date:   Mon, 9 Nov 2020 22:06:27 +0300
Message-ID: <CAFSQ=y455bVOGMpRW86Gto+WdL1idxSXM0RPifokEotyg2ccjg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] security: add fault injection to LSM hooks
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>, mortonm@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 29 Oct 2020 at 21:35, Aleksandr Nogikh
<aleksandrnogikh@gmail.com> wrote:
>
> From: Aleksandr Nogikh <nogikh@google.com>
>
> Fault injection capabilities[Documentation/fault-injection/fault-injection.rst]
> facilitate testing of the stability of the Linux kernel by providing
> means to force a number of kernel interfaces to return error
> codes. This patch series proposes adding such fault injection
> capability into LSM hooks.
>
> The intent is to make it possible to test whether the existing kernel
> code properly handles negative return values of LSM hooks. Syzbot
> [https://github.com/google/syzkaller/blob/master/docs/syzbot.md] will
> automatically do that with the aid of instrumentation tools once these
> changes are merged.
> [...]

What tree should these changes go to?

Is there anyone else who is not on the recipient list but still might
be interested in the series?
