Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775DC4338F
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Aug 2021 20:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA29600CD
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Aug 2021 20:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhHCUub (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Aug 2021 16:50:31 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:43911 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhHCUub (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Aug 2021 16:50:31 -0400
Received: by mail-qv1-f48.google.com with SMTP id db14so93545qvb.10
        for <linux-security-module@vger.kernel.org>; Tue, 03 Aug 2021 13:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zHYVWr4mmHyTyCpyV2whxo9UjKhSnFI15vUftGzFR1s=;
        b=WExrA/Trpt3RBqsN5U/LeS4oNidxtKFrBY8w3v0xH+SccFnpylciUft60hz3jALCg1
         DPJMKcHR6lGaEBU7/kiFv2xYAdkwzPIGr0TbTSpv2M6vHhHDAMQsxcgj2xIeDr/jL+g3
         pK/ZKgzBidNVu78xkU5j8k+Z2iGfV0PdGxkdi7rk82g+dtnN7GofcIPKxthNHvEOCtkG
         naSTs0HtUNEs8TbnFIIJndZbpoCiJsuU34TnthnlmJUBSaJc41IY9NWlor0r3QyqKCX0
         Tqlh15K2MEnk6lgzdtoipN2vISkz4kJFv5sQbFIWg9znWks+/NWnrtCvLqZuCl8V1JG8
         /dTg==
X-Gm-Message-State: AOAM5329NxCR1me2xTR1YMyabumziO3NlSZFiwrXyDA2HT/EzlB1IKst
        oH6bvro0qO7oSKz1YVb5Two=
X-Google-Smtp-Source: ABdhPJx1jhPTcmaja+edS6HEOG1tiQk0GYscpWySMBvDFUvOWdi7pgcJhSZX2gD8ZSyCzAH9Xbjm2w==
X-Received: by 2002:a05:6214:27e4:: with SMTP id jt4mr4112719qvb.45.1628023818500;
        Tue, 03 Aug 2021 13:50:18 -0700 (PDT)
Received: from [192.168.1.109] ([213.87.135.90])
        by smtp.gmail.com with ESMTPSA id a5sm53550qkf.88.2021.08.03.13.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 13:50:18 -0700 (PDT)
Subject: Re: Linux Kernel vulnerability scripting
To:     "Weber, Matthew L Collins" <Matthew.Weber@collins.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        keescook@chromium.org
References: <CY1P110MB0102E9CF9461FDAA8C3B8C22F2F09@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <53ad0be9-5fd6-8805-98dc-0d8889c546db@linux.com>
Date:   Tue, 3 Aug 2021 23:50:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CY1P110MB0102E9CF9461FDAA8C3B8C22F2F09@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On 8/3/21 11:07 PM, Weber, Matthew L Collins wrote:
> Hello,
> 
> (I didn't want to spam the whole LKML, so I've included the LSM list and top hits with get_maintainer.pl on the scripts and tools folders.)
> 
> I'm organizing a project to take some prototype scripting and publicly publish/rewrite.  The script I'd like to add to the kernel code base breaks down a kernel build and identifies the active code (using enabled Kconfig and obj file list). 

If I understand you correctly this is what I started to do since the beginning of the year with CVEHound project.
https://github.com/evdenis/cvehound/

Kconfig analysis available with --config option.

> It then uses the kernel version and queries a public vulnerability database(NIST NVD) to identify possible patches against known vulnerabilities.

I take info about fixed CVEs from MITRE, NIST NVD and other sources (RedHat, Ubuntu, linuxkernelcves, ...).
Vulnerable version info in the databases is not reliable. Most of the time I need to figure out the bug commit
and event double check the "Fixes:" tag.

> The script then attempts to patch the source code to determine which vulnerabilities are still present in the codebase.

Just application of a patch with -R option will not work in case the code is modified since the fix and in case of backports.
I describe CVEs with coccinelle patterns. https://coccinelle.gitlabpages.inria.fr/website/
Coccinelle is already broadly used in kernel (see scripts/coccinelle).

> The end goal is to help the user understand the state of the active codebase, whereas most tools stop at the kernel version, and then the activity is all manual.

Exactly. CodeBase+KernelConfig.
Many vendors (e.g. samsung) don't update kernel version info, they just backport fixes.

> For an example of what the scripting impact could improve, a recent Kernel 4.14.x dump of vulnerabilities had hundreds that needed to be paired down.

> Our estimate before tooling put the effort at about 10-15mins a CVE (determine active code, review code paths in suggested patches).

As for now, I described > 200 kernel CVEs with coccinelle patterns.
Usually it takes me exactly 10-15 minutes to write a pattern (without testing it).
I test a pattern to detect a missing fix since the commit the bug was introduced.
https://github.com/evdenis/cvehound/blob/master/tests/test_05_between_fixes_fix.py

I don't rely on kernel version at all. Usually a pattern contains information about
bug conditions or/and about missing fix.

I already found some trophies with it like missing backports:
  https://lkml.org/lkml/2021/1/21/1278
or partial backports:
  https://github.com/oracle/linux-uek/commit/ee7ab9e8f9cb844c4fac8ca9bcc1a0f3f8fdc9bb
  vs
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/block/rbd.c?h=linux-4.4.y&id=e349a5786f4c23eb11d1e7385703ddbf94f3f061

Regards,
Denis
