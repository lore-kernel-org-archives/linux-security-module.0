Return-Path: <SRS0=3RLe=YX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D59CA9EC5
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Oct 2019 18:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BACC204FD
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Oct 2019 18:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ngQ4YsXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJ3S7E (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:59:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42599 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfJ3S7E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Oct 2019 14:59:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id c23so1397401pgn.9
        for <linux-security-module@vger.kernel.org>; Wed, 30 Oct 2019 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lydW9atQW2RqhX2w9FQSYN22+fl/dNiMF69085WMHtM=;
        b=ngQ4YsXEu3hNnNn3MSw8hh8vZ5syLFrqYQcNZ6AnbPi7LDobSUUnL9sWE4OlkQghF8
         yYdjVJJ6Detmtfk4AntUsuUYUFDP9MTXrG+RdAPrgHZXXDqgzoakrJw1DnjVbg19fYzo
         z/kw/vK6g7IcWfCMXQ03sOl7rkKhj5iGdxf9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lydW9atQW2RqhX2w9FQSYN22+fl/dNiMF69085WMHtM=;
        b=sgfHr0ejLGkeUToyiIfKUqJ/Vyw3YvGx1G3cn3bAuIMji3DFXg00BWXBPLvvo7swJ0
         ovVnsekhHcI5idbQ3ShXm/xRBJnHmRv5j+2riIou0ktMcow2GC0fDozKl672JayIJpwd
         ty6imaGSZ/NUbpWBVqNZRuRpkBFQlhlsnb+lzP8lh4of+uyQZGCa/zd3hXROOUjvt6Cb
         kQ752Ydlnoeg4YGpnt63da54w8w/EJdZ9eAfKekifPWyh2u9M6+btDi5H6JEbQD7SFVO
         CPSRwofVyOfKGTOHqsCkws1wZNK7B9VLq9fhlwqLNGsjqIXKL9UJYglDUTr2zSZiL93x
         zJ0w==
X-Gm-Message-State: APjAAAWY9rdIwtknLp7lfyZCD/7OFZjfk4SybMg/JvfOMXAi/9Tf9nk7
        v6BMPilQvJT0UYKmMtMo56CHrQ==
X-Google-Smtp-Source: APXvYqyi6mqapjcTlpY6OS6+c0zNuBWc9Fp5Tnew7VwPk6+TzOYM8OkMJvisUME8Culvm6LoCo8NTg==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr932975pfd.168.1572461942183;
        Wed, 30 Oct 2019 11:59:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1sm3936091pjc.23.2019.10.30.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:59:01 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:59:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>, john.johansen@canonical.com,
        jmorris@namei.org, serge@hallyn.com, alan.maguire@oracle.com,
        davidgow@google.com, Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <201910301157.58D0CE4D3@keescook>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 17, 2019 at 05:33:56PM -0700, Iurii Zaikin wrote:
> On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> 
> > +config SECURITY_APPARMOR_TEST
> > +       bool "Build KUnit tests for policy_unpack.c"
> > +       default n

New options already already default n, this can be left off.

> > +       depends on KUNIT && SECURITY_APPARMOR
> > +       help
> >
> select SECURITY_APPARMOR ?

"select" doesn't enforce dependencies, so just a "depends ..." is
correct.

> > +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> > +       KUNIT_EXPECT_TRUE(test,
> > +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
> otherwise there could be a buffer overflow in memcmp. All tests that
> follow such pattern

Agreed.

> are suspect. Also, not sure about your stylistic preference for
> KUNIT_EXPECT_TRUE(test,
>                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> vs
> KUNIT_EXPECT_EQ(test,
>                0,
>                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));

I like == 0.

-- 
Kees Cook
