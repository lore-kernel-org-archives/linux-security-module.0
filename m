Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE81BC43334
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jul 2022 23:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiGOXSI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Jul 2022 19:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGOXSG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jul 2022 19:18:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616AB90D9E
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 16:18:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so7452361pjl.4
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OUhFNdoayRnfhDVjmY1UcFA6crmBOplqqO2jHduu9cg=;
        b=gCYaU634v/gTJWGxKwyJyKzUNg3NxPXehyoZvBGvkZOa7XsJTeadx0oVGFxRSKF/Ex
         8jJ2GOkTjoBKU+7Oex5aUq0mdqzB3V1PkjE3qJyiZyfbTXAWNBvmqU3swNPJ4wxYjrFU
         KX5Nccy4mpZ0a8PnJiR7tfVbIzpFJ7JF/qhnyAEr/XPMVHNfiksxjNPr2gh+2+MxU9GB
         mSnjnsjaI4agsw4dbGBsuLy0x8zBiQoO/AdQEWjoz1SAtpq6RPrp39MNSeHK+tjvYdLh
         9+NGChnjvPLfIBDVX2q7kpK7stDFrdURM9jbpaEFdAgH6y58t0BB9kyeOf3LnkrpB7E0
         Giow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OUhFNdoayRnfhDVjmY1UcFA6crmBOplqqO2jHduu9cg=;
        b=a7LWUOMzi+BL27SBGxAXnp35vQFwfns3OG3JyJYAVeHinfHrv/00ppZWopO26mQBdf
         CZpZaNdDpyS1NhlCycaCOc4y5My/S3HZltHhNImE4gqkyt6jcbE8eCmcdqI5cWGTwH8c
         1lXQjcII3kD1rR/j3FLGeyxCAXAhPIX9rEo0MGgMtY+QAwuAcw1qNdbeAhj61yr+FKy0
         zDYF2b2dd1TZ4l3mdyHTX4rD/53VVlSpCaBPEc2WU0lifFS6rnyK2NPuyJzGB8ajqmW4
         ISB7Do3//BZUsdTMgdRXkdEK91hWws4QhBzeJW5bvHaHmimMM9OjiN2GJ2G5VfNFI0Ny
         ocpw==
X-Gm-Message-State: AJIora89ZEwzeFnlsfCTJDjd2K623lrLNiCzO2y60DBZLkiEkm7JitFz
        Ulh2oF5BlfRn7BLuPd+ap8LTfw==
X-Google-Smtp-Source: AGRyM1tdyJFRZuO9w48l1eL9unCDRXPDAMCfbuKDgr7RQxu3LMmhIaSKiJLOcx/ICh2HJ5VjiDGr6g==
X-Received: by 2002:a17:902:778a:b0:16c:a1c9:7b14 with SMTP id o10-20020a170902778a00b0016ca1c97b14mr12582774pll.116.1657927085866;
        Fri, 15 Jul 2022 16:18:05 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b0016c59b38254sm4198801plg.127.2022.07.15.16.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 16:18:05 -0700 (PDT)
Message-ID: <27b03030-3ee7-f795-169a-5c49de2f6dd2@kernel.dk>
Date:   Fri, 15 Jul 2022 17:18:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     joshi.k@samsung.com, linux-security-module@vger.kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, a.manzanares@samsung.com,
        javier@javigon.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <566af35b-cebb-20a4-99b8-93184f185491@schaufler-ca.com>
 <e9cd6c3a-0658-c770-e403-9329b8e9d841@schaufler-ca.com>
 <4588f798-54d6-311a-fcd2-0d0644829fc2@kernel.dk>
 <d8912809-ffeb-8d88-3b6b-fd30681ad898@schaufler-ca.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d8912809-ffeb-8d88-3b6b-fd30681ad898@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 7/15/22 5:14 PM, Casey Schaufler wrote:
> On 7/15/2022 4:05 PM, Jens Axboe wrote:
>> On 7/15/22 5:03 PM, Casey Schaufler wrote:
>>
>>> There isn't (as of this writing) a file io_uring/uring_cmd.c in
>>> Linus' tree. What tree does this patch apply to?
>> It's the for-5.20 tree. See my reply to the v2 of the patch, including
>> suggestions on how to stage it.
> 
> A URL for the io_uring tree would be REAL helpful.

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.20/io_uring

That's the pending 5.20 tree. But there's really nothing exciting there
in terms of LSM etc, it's just that things have been broken up and
aren't in one big file anymore.

-- 
Jens Axboe

