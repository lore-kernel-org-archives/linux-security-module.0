Return-Path: <SRS0=gx/C=4P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FBDC35E15
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Feb 2020 19:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62B32469D
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Feb 2020 19:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="J72fW5mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgB0TdJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:33:09 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36208 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbgB0TdJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Feb 2020 14:33:09 -0500
Received: by mail-qv1-f68.google.com with SMTP id ff2so166678qvb.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2020 11:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SHUqZMiqxXrugyTiyJw+5kNiudFRuI7VyrA9wECW0ig=;
        b=J72fW5mPWHpUAeGa8GWszUuNSkb0QFONZmhovIbvGL9xlofynOtEKg65dV3i2/9vHp
         NX8jTCbg8aS+DG5SOAUoIPdJiyrWvuQZd82R8x6g6hbO0/py7DLb5MJQ0/XYreQaU11c
         2/Dkcskm09qrpwQR+4WF/rXKNDZcNTwzVrVkgp32Mmrfji9nhoWrvWf1dIMboI2CVaTR
         b0lZN2/s2R+ebKkAt2yfWfe45euRfmjbcSMrVunUxx93XVFO5Jc0nRlafpSbd7iZ0pOK
         00CnKGLYBmkeRkqyqE71ie81uIwq2JSuKSE8qv2wgAhv7lRfcUrpKtEWOOElSYDvGAcm
         rWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SHUqZMiqxXrugyTiyJw+5kNiudFRuI7VyrA9wECW0ig=;
        b=TImgPheozhOpCdhbPNwb2jQrZuTTneKn8lY4iz7cdyT6AfV8jRB40kWD0HdoMfygRo
         esVPWL72SwoFsE7x7U/EQKdJAEw7kkX0W0wNO1UiIsRyPjc+WOUP4jI6K/zwxzTeHIrN
         Xs9bTi+JT43uZsldiIEfmrg/mztZvlc28YFxIDWfuLrtRqM0W7cmI5Ie3k7FXGe+U6dH
         ZgysxjWSPgf9ickbZ4WFK7wTFqb/5P8JCyn+3/rCy9hNn/GMBaYkD9TBB87PC0pk8LGH
         sAu6heS3jfFcSPAtd5Ns6mZN9pHixeIfrO9gTwaoH5qifg39fCquMXX4VB19jjmWxmkG
         OoEQ==
X-Gm-Message-State: APjAAAXRJdVywFLLQYM8yyEE7Od30rQLfsvZtt6BtSjGDtmd8dk5zQG8
        uF7dxjeMMgAXU+olBBvJ7W2lhQ==
X-Google-Smtp-Source: APXvYqx7jA/aL2KD5I2k9qdaMge+hyhUwSDtAYGVFKgeefzL8C4Cjur66Z0uHKiPhoj4lA7OoDlcsQ==
X-Received: by 2002:a0c:e2d2:: with SMTP id t18mr512811qvl.130.1582831986313;
        Thu, 27 Feb 2020 11:33:06 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t4sm3670940qkm.82.2020.02.27.11.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 11:33:05 -0800 (PST)
Subject: Re: [PATCH v3 00/25] user_namespace: introduce fsid mappings
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        mpawlowski@fb.com
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2b0fe94b-036a-919e-219b-cc1ba0641781@toxicpanda.com>
Date:   Thu, 27 Feb 2020 14:33:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/18/20 9:33 AM, Christian Brauner wrote:
> Hey everyone,
> 
> This is v3 after (off- and online) discussions with Jann the following
> changes were made:
> - To handle nested user namespaces cleanly, efficiently, and with full
>    backwards compatibility for non fsid-mapping aware workloads we only
>    allow writing fsid mappings as long as the corresponding id mapping
>    type has not been written.
> - Split the patch which adds the internal ability in
>    kernel/user_namespace to verify and write fsid mappings into tree
>    patches:
>    1. [PATCH v3 04/25] fsuidgid: add fsid mapping helpers
>       patch to implement core helpers for fsid translations (i.e.
>       make_kfs*id(), from_kfs*id{_munged}(), kfs*id_to_k*id(),
>       k*id_to_kfs*id()
>    2. [PATCH v3 05/25] user_namespace: refactor map_write()
>       patch to refactor map_write() in order to prepare for actual fsid
>       mappings changes in the following patch. (This should make it
>       easier to review.)
>    3. [PATCH v3 06/25] user_namespace: make map_write() support fsid mappings
>       patch to implement actual fsid mappings support in mape_write()
> - Let the keyctl infrastructure only operate on kfsid which are always
>    mapped/looked up in the id mappings similar to what we do for
>    filesystems that have the same superblock visible in multiple user
>    namespaces.
> 
> This version also comes with minimal tests which I intend to expand in
> the future.
> 
>  From pings and off-list questions and discussions at Google Container
> Security Summit there seems to be quite a lot of interest in this
> patchset with use-cases ranging from layer sharing for app containers
> and k8s, as well as data sharing between containers with different id
> mappings. I haven't Cced all people because I don't have all the email
> adresses at hand but I've at least added Phil now. :)
> 
I put this into a kernel for our container guys to mess with in order to 
validate it would actually be useful for real world uses.  I've cc'ed the guy 
who did all of the work in case you have specific questions.

Good news is the interface is acceptable, albeit apparently the whole user ns 
interface sucks in general.  But you haven't made it worse, so success!

But in testing it there appears to be a problem with tmpfs?  Our applications 
will use shared memory segments for certain things and it apparently breaks this 
in interesting ways, it appears to not shift the UID appropriately on tmpfs. 
This seems to be relatively straightforward to reproduce, but if you have 
trouble let me know and I'll come up with a shell script that reproduces the 
problem.

We are happy to continue testing these patches to make sure they're working in 
our container setup, if you want to CC me on future submissions I can build them 
for our internal testing and validate them as well.  Thanks,

Josef
