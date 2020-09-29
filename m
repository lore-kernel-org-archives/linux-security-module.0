Return-Path: <SRS0=OEdb=DG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFD8C4727C
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Sep 2020 17:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0403E208B8
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Sep 2020 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601400266;
	bh=DfVo+QTy1+Ugv+kDx0DjL4/XsDfAyp7qiuKBUZYURrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FfMIH3jXnB2kHCnyFrXxUxyJjJKyEqH3zakF1D/V70lDU1uGQtE9vv/MfSXWpKWbl
	 urbPepmfhbu477z/pFYeJTlEoFHHrKvITEiaf9un4L8pIvT2Te7BwtExUuip0UgHvC
	 9wv40cfcbaYiZVJYL9yvV8ppfUpe/ZhuRcfwucUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgI2RYZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Sep 2020 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2RYZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Sep 2020 13:24:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4814C061755
        for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2020 10:24:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b12so6444604lfp.9
        for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2020 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLAA/pJeKW+cqg50Ky57VCHaGTK5qDXo2yqA2pvF+eQ=;
        b=LjUkXudSoFBbDOO0M3Aw/aA5ORisoLfOBbWS+EuHcCdJ4UVE9j8EhvhFGCA/Zca0w7
         4AaPgkaAJsBVuA6YpTFf7WTJVEp9xTmUeQvlINdGGPRg09Hegrf+uVZEXdkKqgmMKiN+
         Ebp/oOmLKEC9pbX17X2DwXblyrVa/XS3QfE+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLAA/pJeKW+cqg50Ky57VCHaGTK5qDXo2yqA2pvF+eQ=;
        b=nR/ueu4KPRwv5QzTPce8hRdEMi9b74TEvX1HB8jEBIW0Oyr5n9uSCvh9cdiLD+cq4Q
         qNTbARe4X3ybx5+0nIQr49Ess0MQuDGeZskKl6VKquMOklekYMVpnIAGjmhnlK0mzhBK
         UdioLtJZF17VzPDwOLUHJp1DSNUUnXctqWSJb5LzFjW1c9Q+v1PL4XF1d0bryMDcuKQO
         Aa1+buIKipDisUdIp/OwTBEgLRDWRX03Luu8pPqzFBPU9H5BxQ5SPVG2w2hVAb/rtiB4
         podm/LQ/37q3h/rzue3pI5pAq5nlHLszi3+2jqME5yNStALAOtMpx6jdp1fnXwqzYUz4
         ViWA==
X-Gm-Message-State: AOAM532GkphoelMyc2ruqmEM8c3P6p4jg+f5EisNcTTl4fbXR+Vv+Jz8
        581UAPeau/jD3wSD7vZALSSWZ6OWDy4acA==
X-Google-Smtp-Source: ABdhPJzA6QxZnm2DVKDYszh533OoGMG2NwEBsdAAJuQEi4WEGblOEz9FVeLnJGvSs02jFQGZ9JaWpA==
X-Received: by 2002:a19:8286:: with SMTP id e128mr1502567lfd.307.1601400255800;
        Tue, 29 Sep 2020 10:24:15 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x14sm3297234lfc.93.2020.09.29.10.24.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 10:24:06 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w11so6484604lfn.2
        for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2020 10:24:06 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr1747057lfg.603.1601400246233;
 Tue, 29 Sep 2020 10:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
 <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
 <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
 <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
 <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
 <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
 <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
 <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net> <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
In-Reply-To: <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Sep 2020 10:23:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
Message-ID: <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000d2228705b0770cbc"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--000000000000d2228705b0770cbc
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 29, 2020 at 5:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> OK, so it seems that reverting comes out as the best choice here.

Yeah.

> BTW, I'm looking at rw_verify_area() and I see this "If (ppos)" check
> and the comment above it... And then I look at autofs_write(), which
> passes &file->f_pos, while ksys_write() passes file_ppos(file)

Ok, that doesn't matter for the security_file_permission() issue, but
yes, autofs is doing the traditional thing, and it's pointless. Using
file_ppos(file) isn't an option since it's an inline to read_write.c,
but it could just pass in NULL these days and avoid that too.

So how about we just do the appended patch? Can whoever sees this
problem just verify, even though it looks trivially correct...

            Linus

--000000000000d2228705b0770cbc
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kfo8cery0>
X-Attachment-Id: f_kfo8cery0

IGZzL2F1dG9mcy93YWl0cS5jIHwgMiArLQogZnMvcmVhZF93cml0ZS5jICAgfCAxICsKIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvYXV0b2ZzL3dhaXRxLmMgYi9mcy9hdXRvZnMvd2FpdHEuYwppbmRleCA3NGM4ODZmN2M1MWMu
LjVjZWQ4NTlkYWM1MyAxMDA2NDQKLS0tIGEvZnMvYXV0b2ZzL3dhaXRxLmMKKysrIGIvZnMvYXV0
b2ZzL3dhaXRxLmMKQEAgLTUzLDcgKzUzLDcgQEAgc3RhdGljIGludCBhdXRvZnNfd3JpdGUoc3Ry
dWN0IGF1dG9mc19zYl9pbmZvICpzYmksCiAKIAltdXRleF9sb2NrKCZzYmktPnBpcGVfbXV0ZXgp
OwogCXdoaWxlIChieXRlcykgewotCQl3ciA9IGtlcm5lbF93cml0ZShmaWxlLCBkYXRhLCBieXRl
cywgJmZpbGUtPmZfcG9zKTsKKwkJd3IgPSBfX2tlcm5lbF93cml0ZShmaWxlLCBkYXRhLCBieXRl
cywgTlVMTCk7CiAJCWlmICh3ciA8PSAwKQogCQkJYnJlYWs7CiAJCWRhdGEgKz0gd3I7CmRpZmYg
LS1naXQgYS9mcy9yZWFkX3dyaXRlLmMgYi9mcy9yZWFkX3dyaXRlLmMKaW5kZXggNWRiNThiOGM3
OGQwLi4yZmMzMTk0ZTRkMzAgMTAwNjQ0Ci0tLSBhL2ZzL3JlYWRfd3JpdGUuYworKysgYi9mcy9y
ZWFkX3dyaXRlLmMKQEAgLTUzOCw2ICs1MzgsNyBAQCBzc2l6ZV90IF9fa2VybmVsX3dyaXRlKHN0
cnVjdCBmaWxlICpmaWxlLCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90CiAJ
aW5jX3N5c2N3KGN1cnJlbnQpOwogCXJldHVybiByZXQ7CiB9CitFWFBPUlRfU1lNQk9MX0dQTChf
X2tlcm5lbF93cml0ZSk7CiAKIHNzaXplX3Qga2VybmVsX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxl
LCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBjb3VudCwKIAkJCSAgICBsb2ZmX3QgKnBvcykK
--000000000000d2228705b0770cbc--
