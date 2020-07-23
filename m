Return-Path: <SRS0=LdBn=BC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0028DC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 11:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DD3206E3
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 11:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ktInN0Bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgGWLwG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgGWLwF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jul 2020 07:52:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4510CC0619E2
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2020 04:52:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so4703416wme.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2020 04:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NZpJnIVSkJItlVzX7BU0eJ1NGmH1x+ATcfuITedLtig=;
        b=ktInN0BkhURtuR83134zOeql/UFN3ASBDoe3ryIQAD7q1ahSWK29E4Vua6VXmbds07
         5dl9Wur6XxmkBYAY8GRyqUeedQPdRgf3M1Dz9bT/Y064Dflg1U9tR2/eV47cXNYWg1v8
         Zzch04KO2wxu0zcLZbnhZsuCnyj4rDYgHdaG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZpJnIVSkJItlVzX7BU0eJ1NGmH1x+ATcfuITedLtig=;
        b=iteYZ79EXVdecBgjlIUEhXRavgTdlDVqB2uI/BZtXY7Zq8O/AwVuv5i1oGB0Grf+ni
         EG3nftw02GyYo0oUvaONJurpmhtPadXq/6RNEEQvLxmTH2TnVtth2d8aiRUTQGtM9QBA
         FnNhSKDaGpOdfdfT/+CR1WOzhPxE3Ld7LOqb5GJUROdMD94cnnqmH12mVKKhJtELCdK1
         Y5VeDJR7l+zkPJYpi64cfvCzIZrorjPo8yEpM5Tb4xzxWw8QUr+CqQJGX+TJj6B+wlvq
         M3uDpw8TQcN+9qPw+IuZWNJFHGkPhnjFonh8cgVSa+BEYla84peEQIrpvKwlD9Cw2iqe
         WZjQ==
X-Gm-Message-State: AOAM533cAqs6nvfis4oLLjLYSkaxir3LWKg3FPUna5+5xYCt+Q/rWnPb
        44LC0/hxU/5/cCOUueTdxMhfNA==
X-Google-Smtp-Source: ABdhPJx5kpjbbRmNFCzRww6zSgYNNCQm73V4u/MTpsk8pd8BfUKI6aPsdfQk8ek0oBVK2gQdotXUiw==
X-Received: by 2002:a1c:e382:: with SMTP id a124mr3869340wmh.11.1595505123981;
        Thu, 23 Jul 2020 04:52:03 -0700 (PDT)
Received: from kpsingh-macbookpro2.roam.corp.google.com ([2a00:79e0:42:206:31d4:524e:af91:4e1c])
        by smtp.gmail.com with ESMTPSA id v15sm3054324wmh.24.2020.07.23.04.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 04:52:03 -0700 (PDT)
Subject: Re: [PATCH bpf-next v5 5/7] bpf: Implement bpf_local_storage for
 inodes
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200722171409.102949-6-kpsingh@chromium.org>
 <202007230807.y1gfvekv%lkp@intel.com>
 <CAADnVQK=m18hgfuRZvykQiJPk_c+z=FR6Dpg0aRVvtJn6-Ckrw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <6a907298-3355-d918-340c-10ef13d4d0d3@chromium.org>
Date:   Thu, 23 Jul 2020 13:52:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQK=m18hgfuRZvykQiJPk_c+z=FR6Dpg0aRVvtJn6-Ckrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 23.07.20 07:18, Alexei Starovoitov wrote:
> On Wed, Jul 22, 2020 at 5:22 PM kernel test robot <lkp@intel.com> wrote:
>>
> 
>> All warnings (new ones prefixed by >>):
>>
>>    kernel/bpf/bpf_inode_storage.c: In function 'unlink_inode_storage':
>>>> kernel/bpf/bpf_inode_storage.c:34:32: warning: variable 'smap' set but not used [-Wunused-but-set-variable]
> 
> KP,
> 
> feel free to resubmit as soon as you fix the build.
> People typically ignore the patches when buildbot complains,
> since they know that maintainers are not going to apply a set with
> known build issue.
> 

Got it. I need to get into the habit of building with W=1 
(at least for the files I change).

Sent a v6 with the fix.
