Return-Path: <SRS0=ehTW=ZZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A4C432C0
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Dec 2019 02:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4344A20684
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Dec 2019 02:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS10tHKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCCja (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:39:30 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37219 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCCja (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 21:39:30 -0500
Received: by mail-yw1-f65.google.com with SMTP id 4so736377ywx.4
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 18:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5EEcRzVUSv/wje5OYg15nPJPBFoZqbpt9ohaPGQzn0M=;
        b=oS10tHKMU2qnZ9D538Ky5kA06SKsQMuX0wxMoS6sXEX9SyvOXiKtkpOy6VbuO/Isxr
         pc2bBxekDmT8kNI72S93jMpGYtOkGc7e8celnUnuCq2RNfPFqxFbfjFkEuGh7WunGVwj
         +ElPgnSDIytE7lDKYN5B4vQVMH7Pm+yqQtfBkOxqNhyyt4RgT1HAxTDJrcUmpdgMs59w
         qXe4MuiePSQczLkqU4s66nC9/NaJsDvUdKf0B+G2g4WlErLu1Umx3hxi1iNanOBWHtoZ
         mbK7kcg8jn3Z7kMvqp0EI2c2xrZ7NFleeWCRLEdEzmOFjssYbRcAauaUgHcEsTiUMv2a
         yxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5EEcRzVUSv/wje5OYg15nPJPBFoZqbpt9ohaPGQzn0M=;
        b=CYSx/bnjLYncpvxuCcDfFlqQdaS2nk6+ZNPPJJhsePzOZoZlmQ/ql2MyienHFurwpS
         QmpJvctuFI2brxvkSR0VksQhDh9ckJT+uK5rCJqWzjOhgnWkkT1kkxpL7hwCLC+kfEbk
         AQqdE31DyzaCvdNz91GiOC/f+kPPimzj0tUV5hc/m6Hqr9p9ZF0PLr7wDAJV8T4x4LuS
         lfDDZ6kTwh/4kCNB32t407Ou5uHYA9nGb0dBxqv8JUbuwFUUsGjatkc0mlYGZOoTx6ie
         YotU784fdtoruWmopsuhF0ynIjQaprEyg1sF60X/Tqn+L3ILQEOdy9cC1UFG3Eyk/831
         39dg==
X-Gm-Message-State: APjAAAUFadWEUWjpeOnKGtayz4An6/WNKKZZv8TOO68Z0O4CzmSWnUyl
        /HO7rGm6ckQy9sn2YCEqKZ8=
X-Google-Smtp-Source: APXvYqyWJ+YPL7/V/6X7QzVIiJAd1ZqZRFWC3cZrgi3gDDXzqPwYm8eynO3k10DkCe7nU9a9MS7+hw==
X-Received: by 2002:a0d:ea41:: with SMTP id t62mr2033414ywe.29.1575340769320;
        Mon, 02 Dec 2019 18:39:29 -0800 (PST)
Received: from [192.168.2.190] (173-17-41-233.client.mchsi.com. [173.17.41.233])
        by smtp.gmail.com with ESMTPSA id g6sm859351ywe.16.2019.12.02.18.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 18:39:28 -0800 (PST)
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
From:   Matt Parnell <mparnell@gmail.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, matthew.garrett@nebula.com
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <201911301035.74813D4533@keescook>
 <62ccc074-ac6d-edea-10c6-925f99dfc592@gmail.com>
 <CACdnJuuDKX2GXZoubLGFoh8D3a1a38j+9rwu2iBZG6pqpqgokw@mail.gmail.com>
 <80b97dca-6eec-b008-81aa-74eb4f14ea0b@gmail.com>
Autocrypt: addr=mparnell@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b887b039-ebf6-5ef1-429e-04792f3cd664@gmail.com>
Date:   Mon, 2 Dec 2019 20:50:45 -0600
MIME-Version: 1.0
In-Reply-To: <80b97dca-6eec-b008-81aa-74eb4f14ea0b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Correction: I'm out of caffeine, tired, and it has made me an idiot.

That message triggers regardless, it seems. I apologize.

On 12/2/19 8:24 PM, Matt Parnell wrote:
> For what it is worth, this doesn't happen with lockdown disabled.
>
> That message and the code that checks for mitigations is in
> arch/x86/kvm/vmx/vmx.c - for some reason locking down the MSRs is even
> making the kernel think that the MSR for the mitigation isn't there,
> meaning that it is also likely not mitigating the bug.
>
> On 12/2/19 8:16 PM, Matthew Garrett wrote:
>> On Mon, Dec 2, 2019 at 6:01 PM Matt Parnell <mparnell@gmail.com> wrote:
>>> I should also mention the kernel itself thinks it is vulnerable with the
>>> MSRs locked down:
>>>
>>> [    7.367922] L1TF CPU bug present and SMT on, data leak possible. See
>>> CVE-2018-3646 and
>>> https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for
>>> details.
>> The lockdown code doesn't touch any of the codepaths the kernel uses
>> to access MSRs itself (a *lot* would break in that case), so if the
>> kernel is asserting this inappropriately then that seems like a kernel
>> bug.
