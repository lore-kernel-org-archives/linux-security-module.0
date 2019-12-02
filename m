Return-Path: <SRS0=f5xb=ZY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC12C432C0
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 23:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65323206E1
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 23:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHBOL0hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfLBXbc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:31:32 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38871 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBXbc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 18:31:32 -0500
Received: by mail-yw1-f65.google.com with SMTP id 10so567717ywv.5
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vWSKJYVdEIGPh9x4hLrw+DDx4YPKnD+RoUAkORDfIWI=;
        b=JHBOL0huSWr5qYu3zrt/CkXDJJ6+gBxhJ9yQmVZGS1eGPBJhXoPFZ3S1I3urqXqgg7
         QbIwUphNmBhOmHdjbOfeEyAB0g0Pe2Q6VCb3m++nI+9FLRo6F2vrS6/H3SbOJ15vSREf
         oEIQqPStODq/sHTeV9Ax5wywECd95KL1Ea+wMT2wjqLdaUqtAhGnVG7ZuM5uMLV8FUzz
         ZSFy0wA5m/xtcGADFHv1X4uVDGmAPg31ozetOmAAzvtk3aKVa7ssvRxGbcSQFnzT0YLQ
         ma2wGKwbdLQkGC6VaKD/epp0mtNxUsVuCFRuc5FbKA/j7Zod+nAk9RYCPvuELDWkWzOs
         M0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vWSKJYVdEIGPh9x4hLrw+DDx4YPKnD+RoUAkORDfIWI=;
        b=obqXchzzYHLSB5Zkc+ASMCYPIbTDP/QKrWrQhT5TWr9lznkc08IozYvU8/FwOKd3Z/
         aapf0O5zdzZSXGtf1QW980N07EHD/HQKbNB1KRr6VrLlNXNI9gqa5JpGkKREzQzEdNCJ
         VWE9dYY43cyoxH7gffGSOHkRBXaQOZ9aUTtLCFwFbPF0hNcJIjxmgjUKhVkl9z+oEYlV
         ySKf3CdAzjcdfC7vkaDxMYknfwTfslW93qAEgBUZPOAjGkbUFkDiXJ+dxTrw/C0xOHZZ
         QNfAZvBlABQ0i4ZfhjcX8v8UMD6Dp15C7vgb7ABIEMVgtfyNKs+O2rEAIArsM2OETXco
         TTSg==
X-Gm-Message-State: APjAAAU6IyX/QkxPSF0E9C2du58ch80oGLxyCHMzjM9MjFU4IR78xpBx
        PI4uDVtBT0gyJFIzKhqMKKs=
X-Google-Smtp-Source: APXvYqyvsgeaChbtwMso6lscJ6sfjMiaZjjTWpgvrrc7dpybF/vX3TwCQlWbXm8V7nZzLdvyPRPKbA==
X-Received: by 2002:a81:4788:: with SMTP id u130mr1041594ywa.455.1575329489862;
        Mon, 02 Dec 2019 15:31:29 -0800 (PST)
Received: from [192.168.92.133] ([64.22.231.226])
        by smtp.gmail.com with ESMTPSA id 6sm599456ywu.28.2019.12.02.15.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:31:29 -0800 (PST)
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
To:     Matthew Garrett <mjg59@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <201911301035.74813D4533@keescook>
 <f415ec28-8440-3b29-176c-50da09247ea3@gmail.com>
 <f988a531-a7f8-cef6-d3b4-6fbd89f5351f@gmail.com>
 <96625b06-3bba-6831-7127-22b690fccf1b@gmail.com>
 <-uRGQFmc8hMANlmvOpPXEib39VyGsx15MXwgVf-vripxhDcjILDfe5O17fyf5MXoZflmIE4avp7SqW4ijO1kHPqgHJMCqg1fWtXeGylu2uc=@protonmail.ch>
 <CACdnJutjZk4r_7oCZTnQdmKGZKay1KvvDA+7goj9fwkMVcfHmQ@mail.gmail.com>
From:   Matt Parnell <mparnell@gmail.com>
Autocrypt: addr=mparnell@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFo3GdQBEADtjJfHcx+4ZWkygvBe298oW4OwHbF0iLJd/+yOObV/2/F2hHNvIsnY0syy
 ew0pdCBGbzhUlQbzIGEI1aBiikFP/g7zbWGf2r1Gkye+vka252dPZbeCW+reSbMQ6wsSpaLN
 tKvhwq7gIRQjMrSIXtLF/idxMzcd6R0r+DD2cojhktj/qsfhGArigjsuCedX5xFHHjM368Du
 o8FhTteNZePd8VoA7INrDmSUtEp1OOP98UCCr1bIO1K1AvMxHfAhqhEELXDZDgp3UgaIn24q
 SxqNDfNExSnqjMUPafGW3Gxq8hez5hmTrvml14v8VT3B/TIbqzOOH0CWxwTNUkq3gOjrZWcZ
 X4giVsBhZtFckr1KIMOl0IbL9N1El20LxPiqqQDrg633s4+22pKDq9c9JLuNSCHpXVaIaDS4
 mY36SWCXNkO1QZn1NrIjctTjqmSzqH2w7borNUbtQLnnCo9SBXnCP9tO7pM4SI8dN0ehE9tP
 mQjNyPQjCCCaVMCAx69qTSKhIHQ9flnDbW+NNY3rFdN/IlpEqmZaFC21b+xRwEYys9MOdumR
 WVv4+mjMUkoyNRwtMg1W6WUhcQ0VczmTiczgztjTAJy3NjVfklIT1t6jM8n2yJOoUzLmp7DP
 4dJmHpmUa73ITH6FtbOqE2AhOMFlXDxsNvPE8ukiWotP+m+xSwARAQABtCFNYXR0IFBhcm5l
 bGwgPG1wYXJuZWxsQGdtYWlsLmNvbT6JAlQEEwEIAD4WIQTLFpSDKxWZjIp7E2+53Q5PJNJa
 oAUCWjcZ1AIbIwUJCWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRC53Q5PJNJaoJaa
 EACoF+DCyEZAkDAa+E+Mj0molEY41CmRmJGzsMd+Uhh7ZdLc65FqxDyN59w4DOEcFVUef95F
 YAjyhDrvf17EUS12R1TZ5h31akBsAKk0KR81W0ZCvI6/iS1ChZ0+wG+GedNxwp3YY+8gvnix
 B6/W3kmgHqBJAHGtlEjzGhkoHzsyc/+f0IsCd3G/bB6ZJLOQbqCKPS8YtaSflWt9SlPsHB9D
 +JjbsNT7Kn05ygeeF2J25L/q+Dwy9W0p2TByb2HAZpma2U4MIUUdCtrEQ7xMQ79xFqakBuKT
 f3dp2RJYXTeRkbFrsuycX60hH9flJZPZ6Q5wGCWzhiApjYy+mhnCzvrAuyvuuozvLxJ0M6Wk
 zCMMFFVnQNypYZTUYwXICb2oo4HcN50U5ZkzzWAjCLJg90ZioD/7fCO7rOs301GsB6rV94ah
 ktt+ma7a+hu25EZinAiTGFDk3n2G40rtELkphH+GIZYCrKrGcnEhicuGEAzi5+TewWnfLVTm
 wRVfXPMMcKFTV6XEUjWYGtgG4yxAjjBFqIY0XtT1GzpVVNzg90SW3ABD9dTSfsqk2MugrgPa
 /zELohio/V/O7Zm26BnhPi5sfK3T0AeDLqHwJrup5Osd2tf5zx3b3uFCRd1Jf8uoAZIBmKmH
 oios8sXRXOKy3dJEvtyeRZ9ai6lsNwaid2+zoLkCDQRaNxnUARAAu0Vk93D3ETcFVtb3uszZ
 K2Rzd6Wa3PJDnQ0PC4ER0ZK8QZg6I0rFlsxYWf8d9SghI5aXxtqcsyTiVoIPhCtH3KXt7nDU
 bsOlwP43KTX4VhlT4ocGpJb0DvfryjD3HD68IOeyvrsPWgf64Vk0CWYFSGYfBIC8ydew4YOT
 g6n/h/qrNhSMZTTJwNmXaHxPQy6OeMggu/5ZMylJTZ6Rs8inKLDs1/Wa584coH9npX2xsl9o
 GyBv2cIzz9fNmpLuRc+QWFeFtFuiZhd09GIEtbwH+qzo+8wq7lJxedEiePXYa4KfKigGmfTk
 D1W+WTGvF1Ui1uIljDZCRhMZlfIFcmwSeNLMjexaQboQnfS+qgnrwNkvN80azJd0wUcmsTAm
 A5ES4QleM0U1b/0YcoGni0ES1FgebLbptj8R1eem5ZTXJ4pxm5IZCmaYgv2rJwTl4dDYxUVO
 A8ATQUQ4tPPclk8FECfG1k/fGLpyku2n3rUFMTv4JGCZvHrTuy4BPQAwztVAxPw3Qx85TlwI
 5U9npigZa3tNuXrvOXfJzwZZaedCFf2JjJYBpWEYDDqdUXdj38hpOeZszwgRyWCqrxUSi1O6
 DoChrBlM2ETBQ9WG38TDQ1CyAXI8ctm8anUfVgVyDbbUTaHw61S+Nn4w9fj1sA4+q9hSsIlM
 xTXxMgpAfPwQ7kUAEQEAAYkCPAQYAQgAJhYhBMsWlIMrFZmMinsTb7ndDk8k0lqgBQJaNxnU
 AhsMBQkJZgGAAAoJELndDk8k0lqgcMoP/iaPjCViJAoae8/x8IGykah8l7QYjJWraxKuNI4C
 wYL9Hmm4pr6C3vtckOKs678QdB3Js6sfuD6eCQowTLQEBrP7LJU0Cw0S4x0oaSw7i1aySTIa
 QuPc5gjuqmZa7NeP0/sY/Is43b2mePf5ETTbcJM3PA44xkjQ21qR05pbF5ISlDqKvDog60dE
 /dDAnlFkP7H8PPmuXnqcaW1isPoBIZOsNY1Lt91rogTgvKXiIvz+ze2VYuBaEpyqJfchkwfR
 oUEQGljjXn5E98KfCDqou0gcP14BKBP45XhlD121PyoNgs/zCWpeAkrerctpl579hVrfg2yT
 gMsRsE9dlOdBsB1RAhB0Tmtqn75uBCKU3SCBgP/GZ0ZvoBiF+YQk/a5BFjQK1BsEdtXkwJxY
 mCGMPE3C0ADjxKUTx7wnmineBjc9B3yDugN7efpwHfltM6kKkbHNGoUz95Nhdp00GMYiwpcW
 EGbY1YzYACwMFwyWLaO8wWVo5MDe28OLpKbjHz3Zlu7E4gIJx3jId4coWSV7X1oAnq0JGUSO
 ypEChR786n/GobJlYw5UDWUJsmOFB9IXzt7o3YyKibpjPMmQY4tPUc137cJrbjsXU22fYrZn
 BPsD42iWdKVVoEd04MIj6OvIZCNHBRZA8Bly8xKPSLJIWNG0YZ7ETA0070lPmh9s3xqW
Message-ID: <f1cda5e6-5d10-fa96-d2f8-00c1f3a7683c@gmail.com>
Date:   Mon, 2 Dec 2019 17:31:03 -0600
MIME-Version: 1.0
In-Reply-To: <CACdnJutjZk4r_7oCZTnQdmKGZKay1KvvDA+7goj9fwkMVcfHmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I suppose that turning off the early lockdown functionality, and then
having apparmor or selinux grant intel-undervolt permission to the MSRs
is probably another method of going about this, only slightly less "tight."

On 12/2/19 5:29 PM, Matthew Garrett wrote:
> On Mon, Dec 2, 2019 at 2:55 PM Jordan Glover
> <Golden_Miller83@protonmail.ch> wrote:
>
>> Could you clarify if blocking msr breaks internal power management of intel
>> cpu or it only prevents manual tinkering with it by user? If the latter then
>> I think it's ok to keep it as is.
> The latter.
