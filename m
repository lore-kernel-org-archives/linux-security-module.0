Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DE9C433F5
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Oct 2022 18:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJGSWy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJGSWw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Oct 2022 14:22:52 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165EBC630
        for <linux-security-module@vger.kernel.org>; Fri,  7 Oct 2022 11:22:50 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id 8so2925900ilj.4
        for <linux-security-module@vger.kernel.org>; Fri, 07 Oct 2022 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tqdk0hM6x7C5GmuwpualrefrDZUl2Sr4Ok7Sj1B+cIU=;
        b=YdvD6b89fV92Wk8bnSMlVpz7KlcJLnC6EuohbEem59r9z336OqXZuPQqoxAMqvGkJs
         Bvcp2zANLtHXnBmoJSc1YE9RJ/EM4vRHWiTsnpnlcI+Tw00/yKHNlB45tT4Isd/EzVyt
         Rs6lSQ/6UKBFspGUmnYY/ysBpIZ/zSs3csevUn/2m0veB1sQgZEhJThibz/wUZYKLAXu
         V/fOTFbx0S4XEjNtGx1EVPonhYRXdtqzAD30zl/lo6uO0NCCDkxJ6O8tz1/2ygynX63h
         4KByzDOsBeDdBmxIg6w9l/MqzlyowrrYivgchn4JeEpZ3sjqCen7Z3sz13VEFaql3ROS
         ukzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqdk0hM6x7C5GmuwpualrefrDZUl2Sr4Ok7Sj1B+cIU=;
        b=QHNP+02wg7E5fm7q7KBOp/xr5EsjEb2gGDbHkw1/oZvcUmwKudZIIDOmueepK0vveJ
         5GPeLXTxzcOJcUclKb0x7M+JY+833hfNddvWxksVrofIrl5UX1ijLm8zMg2blQDvR2qL
         k2xD5mLx3hZ8Nqmh8J7CUblc9qXeBTyy6NHTrBhvetWe5eSJtWOrfpwvajTiIBZuY/vx
         6MjxDgRRHR+ibJbi4u+a+vgVUaIqfvYqP1GULOV6lBPKbm5T3CqSmGNX4ddHz7AZlZ/E
         gXFMTEgJtKe1heqh4tIzcR2Z9i0p06y6t0cuX33MZbJUn7vCOAorOWSpMeV0t2jlkn9O
         Nnsg==
X-Gm-Message-State: ACrzQf13UxIz2803EWnDnWr2hCAHP9zHW7cQ6ZLkjpdTzbUwLd9+4YJ+
        FFQ1uiArv0GJZ7XHyAoRbY5a9w==
X-Google-Smtp-Source: AMsMyM7IhRaQr3ziBNux5greMX2VvHfaaC7TIUUhff14ccB3j20v1brVoOrflHvId5ctKzMAi5DOcw==
X-Received: by 2002:a92:c208:0:b0:2fa:abf:9d48 with SMTP id j8-20020a92c208000000b002fa0abf9d48mr2923600ilo.127.1665166970015;
        Fri, 07 Oct 2022 11:22:50 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id ay27-20020a056638411b00b00362684ca750sm1146440jab.68.2022.10.07.11.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 11:22:49 -0700 (PDT)
Message-ID: <8647a8d9-a5d0-de35-9639-22bdcb44716a@kernel.dk>
Date:   Fri, 7 Oct 2022 12:22:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: IORING_OP_SENDMSG_ZC should enable auditing just like
 IORING_OP_SENDMSG
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org
References: <CAHC9VhSzQtFkksJ5zBnhOYCpvDGNjjn7SKoC4MmopepWzb+Hfg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhSzQtFkksJ5zBnhOYCpvDGNjjn7SKoC4MmopepWzb+Hfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/7/22 11:34 AM, Paul Moore wrote:
> Commit 493108d95f14 ("io_uring/net: zerocopy sendmsg") added a new
> zerocopy sendmsg command to io_uring, but it enabled the
> io_op_def:audit_skip flag, causing the operation to bypass auditing.
> As far as I can see, the SENDMSG_ZC operation should be subject to
> auditing just as SENDMSG.

As far as I can tell you're right, it's not audited further down.
I'll add a patch getting rid of that audit_skip for SENDMSG_ZC.

-- 
Jens Axboe


