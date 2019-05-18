Return-Path: <SRS0=ku+q=TS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93231C04E87
	for <linux-security-module@archiver.kernel.org>; Sat, 18 May 2019 02:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62190218A2
	for <linux-security-module@archiver.kernel.org>; Sat, 18 May 2019 02:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="TaT9fKi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfERCPb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 22:15:31 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39921 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfERCPb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 22:15:31 -0400
Received: by mail-yw1-f66.google.com with SMTP id w21so3488570ywd.6
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 19:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e/Re8JNkMMZS5vb+q48mFRH1gM+SXPJbTk6PEc7g9q4=;
        b=TaT9fKi7fztMIo4wYsgTLZDMnxKQdpEqwKs28V2zcIpqmFTLAKns45HPPfCE5WngUb
         /cjUP/dtAXmL/O2bc96thZrQHaWxU6ZtLzswD7p9cBMORrNKTnWGpz0PM1j9bBl69Lbz
         mujkZe1Ja74zvbfU2kEu2rit4TTS1EcCBAV+T5XByRj11EEwm7k4hj7NpeDumKkpXjYk
         Pof24nksP+mkg9BlqfvxkCflkBHCuKtRxV77HbRrclQZEzBnnAR5Zs8Uk/kK2wivODdS
         MPW/elYrHw4itfDNH92HuXJVCV+YcqPJ7f77k5+LhM8UqkUZt+NPYDfSScblabao+j28
         xvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e/Re8JNkMMZS5vb+q48mFRH1gM+SXPJbTk6PEc7g9q4=;
        b=p2Z9kTX3sbJxjD9yUYUtVUBZgFWdt/XCFfBp7EEyQ6xkCB/D6dhzYi/ymucwu9IIjJ
         qnweMyoNrpjpHno7TyU1ATPe9vvvl24LQXfF45qwF55UgrFpqYHxNRx3yvCa+Ek22L/D
         OtCNNZNGEgXkCDGVlJtYrctqxCr94hE7Jv8Fls58KAAFK9KcfNGOFmpcL2T95V0xn87/
         EZxAJLhZN8FDyDfhgVHYuGLbaRpzPTY0FqTmo0u22bcGxzBb1RULxtHGwlz+6+vL+bXX
         xnMBFMk9zYxsrG3H+LsxOnEcvLsBNak6w4ESaF0suJeUE531Pl9YLeU4EaImj280vvwL
         YU1A==
X-Gm-Message-State: APjAAAV4zlUa7NA0QGZiKzwwMDMswjYoFiGl0KDaoYTJVqG2VRt86rn3
        Iwg7H6ULfLKN+++RgvFEFTSNjA==
X-Google-Smtp-Source: APXvYqwRQOdT2dPGlb54WwSW65T5Xzg/Y07ZThJYNzxMvkjGyvfuFPRNe52MRH3TF3M7IMuEtXBv+g==
X-Received: by 2002:a81:3bd5:: with SMTP id i204mr22821560ywa.254.1558145730321;
        Fri, 17 May 2019 19:15:30 -0700 (PDT)
Received: from [192.168.43.9] ([172.56.6.82])
        by smtp.googlemail.com with ESMTPSA id f129sm2902432ywe.35.2019.05.17.19.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 19:15:29 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        james.w.mcmechan@gmail.com, niveditas98@gmail.com
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
 <69ef1f55-9fc1-7ee0-371f-3dbc77551dc0@zytor.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <a0afd58f-c682-66b5-7478-c405a179d72a@landley.net>
Date:   Fri, 17 May 2019 21:16:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <69ef1f55-9fc1-7ee0-371f-3dbc77551dc0@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/17/19 4:41 PM, H. Peter Anvin wrote:
> On 5/17/19 1:18 PM, hpa@zytor.com wrote:
>>
>> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
>>
>> A side benefit is that the format can be simpler as there is no need to encode the filename.
>>
>> A technically cleaner solution still, but which would need archiver modifications, would be to encode the xattrs as an optionally nameless file (just an empty string) with a new file mode value, immediately following the original file. The advantage there is that the archiver itself could support xattrs and other extended metadata (which has been requested elsewhere); the disadvantage obviously is that that it requires new support in the archiver. However, at least it ought to be simpler since it is still a higher protocol level than the cpio archive itself.
>>
>> There's already one special case in cpio, which is the "!!!TRAILER!!!" filename; although I don't think it is part of the formal spec, to the extent there is one, I would expect that in practice it is always encoded with a mode of 0, which incidentally could be used to unbreak the case where such a filename actually exists. So one way to support such extended metadata would be to set mode to 0 and use the filename to encode the type of metadata. I wonder how existing GNU or BSD cpio (the BSD one is better maintained these days) would deal with reading such a file; it would at least not be a regression if it just read it still, possibly with warnings. It could also be possible to use bits 17:16 in the mode, which are traditionally always zero (mode_t being 16 bits), but I believe are present in most or all of the cpio formats for historical reasons. It might be accepted better by existing implementations to use one of these high bits combined with S_IFREG, I dont know.
>
> 
> Correction: it's just !!!TRAILER!!!.

We documented it as "TRAILER!!!" without leading !!!, and that its purpose is to
flush hardlinks:

  https://www.kernel.org/doc/Documentation/early-userspace/buffer-format.txt

That's what toybox cpio has been producing. Kernel consumes it just fine. Just
checked busybox cpio and that's what they're producing as well...

Rob
