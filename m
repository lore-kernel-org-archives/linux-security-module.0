Return-Path: <SRS0=axxp=AS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C006C433DF
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 03:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C04020786
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 03:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gP+Wl4DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGGDIj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgGGDIj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jul 2020 23:08:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC256C08C5E1
        for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2020 20:08:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so4113299pll.3
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2020 20:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mAgioibrvE891f5K7HmCJlPOrtHJXNuC1DkC4uszNXM=;
        b=gP+Wl4DJKDJ3UySQvm6ehWCx/RKB143fnyHUuQ0t9BRhhXM335BMaeWAeNXiPHFS+A
         yuJXG+rXHT/me7lsV8JRFhJGr0PHF+YCM9CfQH6E2adRJBk43IvCMRwvvBVl3/3Ixm3I
         fq54xhOeSkABkDAJr2DPslruFRUcT0nLWUjG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mAgioibrvE891f5K7HmCJlPOrtHJXNuC1DkC4uszNXM=;
        b=aWj2Hlv8P8js7EfZyVrQWrk/79H5u0MYMxRIucHZS3ozMeFm3ZyMadi/UwE6wcnz9c
         JkxVTsVVKMyyi+cKKJMWvgLcFcG2/qwE51wgna8cOCPjTLj0y7Ur0gGmNYMdrHJvh1EV
         UV6bfzkP+a7yh/cL3g3ch1p+ObOs26k90U+1vG/Wv2K1YhOUmlvLXyvcgUCYUUBluQ3i
         XBpawX4XT0xNIDnw1xfwI47y+dvzdgeZkQW1gdYiLMHBumFnFVcogyJGDSqXd2OeGyu5
         HrzO5p195bmDMzzCAL9BPhuAengt9p8ndNp/zsT1QSyfr5g6au7IW9ErBvIaVvu1Y66k
         OZxA==
X-Gm-Message-State: AOAM531ULmePOMYCtOKbHw5qRatU6Q+NdoX6COEFhQQWkfqEJTrDaS8N
        9PzEH+LRxgerH8ykFBJZn55YZg==
X-Google-Smtp-Source: ABdhPJy83Oe1nEfdDuQGPzOU8w+tiZ5G3NUxNgvI9H4y2E5D1RYyMkaPmU7mTa1I6i1BJx5hBV9wHA==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr45161895plr.132.1594091317238;
        Mon, 06 Jul 2020 20:08:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14sm20750527pgj.62.2020.07.06.20.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 20:08:36 -0700 (PDT)
Date:   Mon, 6 Jul 2020 20:08:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 9/9] ima: add FIRMWARE_PARTIAL_READ support
Message-ID: <202007061950.F6B3D9E6A@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-10-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-10-scott.branden@broadcom.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 06, 2020 at 04:23:09PM -0700, Scott Branden wrote:
> Add FIRMWARE_PARTIAL_READ support for integrity
> measurement on partial reads of firmware files.

Hi,

Several versions ago I'd suggested that the LSM infrastructure handle
the "full read" semantics so that individual LSMs don't need to each
duplicate the same efforts. As it happens, only IMA is impacted (SELinux
ignores everything except modules, and LoadPin only cares about origin
not contents).

Next is the problem that enum kernel_read_file_id is an object
TYPE enum, not a HOW enum. (And it seems I missed the addition of
READING_FIRMWARE_PREALLOC_BUFFER, which may share a similar problem.)
That it's a partial read doesn't change _what_ you're reading: that's an
internal API detail. What happens when I attempt to do a partial read of
a kexec image? I'll use kernel_pread_file() and pass READING_KEXEC_IMAGE,
but the LSMs will have no idea it's a partial read.

Finally, what keeps the contents of the file from changing between the
first call (which IMA will read the entire file for) and the next reads
which will bypass IMA? I'd suggested that the open file must have writes
disabled on it (as execve() does).

So, please redesign this:
- do not add an enum
- make the file unwritable for the life of having the handle open
- make the "full read" happen as part of the first partial read so the
  LSMs don't have to reimplement everything

-Kees

-- 
Kees Cook
