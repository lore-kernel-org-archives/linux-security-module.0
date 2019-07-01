Return-Path: <SRS0=pBN5=U6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A0BC0650E
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Jul 2019 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58FC21721
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Jul 2019 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562004030;
	bh=xpY1EBUzIWK61a9XmKXiInhRfflqLqEF8sLQbS9giOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OHGn6gyTbD/fYNCW9hmLj8WSpd5VJWW7syerqRUt8EmItvl8uKAqZLS0y7qRur7DX
	 aOoNKz38ZAMkHw1wevMK91LkXQEcgPUVFcmEapN2kvL6vvxYTbb8VqHW/EUDl4GPMm
	 uq1xjfWCu969KHXyyLR1W00iodGbyswmmcnnv/Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfGASA2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfGASA2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Jul 2019 14:00:28 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D345321721
        for <linux-security-module@vger.kernel.org>; Mon,  1 Jul 2019 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562004027;
        bh=xpY1EBUzIWK61a9XmKXiInhRfflqLqEF8sLQbS9giOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KZ8t3c+46LUc2RnsFuurWFH/RtlewRZNtMF7j8HIvuEqHNorxgZxejmMZfY/VGERp
         dG3fQJbgw1nGK0w7zyxUBm2q0Llxtz5EoHmfhb5YUJkNpnxwiPz4cPngO/KAWjE/+z
         FS4rdGPJFxAoXqyi1zV9mguWIhiUxJHl8q/Fm6ug=
Received: by mail-wm1-f53.google.com with SMTP id x15so405329wmj.3
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jul 2019 11:00:26 -0700 (PDT)
X-Gm-Message-State: APjAAAUBpGZZkYHHMbR6t2htooIEaprpkIu6qM1Fsz2W4hFf8TEZeghx
        EnXrmzA1AFBIlxMdx+jqNjHBh2T/B7nsM6TXpvUF3Q==
X-Google-Smtp-Source: APXvYqyw9dvWrtHk90LkZmKRlVzMRqpHgJe9TzwyFIZj43TF8150/NTA+Lgjqy/I6sp4bNqHi6jmJGneIt0FYHs7+TE=
X-Received: by 2002:a1c:1a56:: with SMTP id a83mr303202wma.161.1562004025513;
 Mon, 01 Jul 2019 11:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190619222401.14942-1-sean.j.christopherson@intel.com> <20190619222401.14942-5-sean.j.christopherson@intel.com>
In-Reply-To: <20190619222401.14942-5-sean.j.christopherson@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Jul 2019 11:00:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXtVzCZW4mb994prdrzXxMP2T=xxU+fhy5k9N8AqjcqhA@mail.gmail.com>
Message-ID: <CALCETrXtVzCZW4mb994prdrzXxMP2T=xxU+fhy5k9N8AqjcqhA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 04/12] x86/sgx: Require userspace to define enclave
 pages' protection bits
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-sgx@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org,
        Bill Roberts <william.c.roberts@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 19, 2019 at 3:24 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>  static int sgx_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>         struct sgx_encl *encl = file->private_data;
> +       unsigned long allowed_rwx;
>         int ret;
>
> +       allowed_rwx = sgx_allowed_rwx(encl, vma);
> +       if (vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC) & ~allowed_rwx)
> +               return -EACCES;
> +
>         ret = sgx_encl_mm_add(encl, vma->vm_mm);
>         if (ret)
>                 return ret;
>
> +       if (!(allowed_rwx & VM_READ))
> +               vma->vm_flags &= ~VM_MAYREAD;
> +       if (!(allowed_rwx & VM_WRITE))
> +               vma->vm_flags &= ~VM_MAYWRITE;
> +       if (!(allowed_rwx & VM_EXEC))
> +               vma->vm_flags &= ~VM_MAYEXEC;
> +

I'm with Cedric here -- this is no good.  The reason I think we need
.may_mprotect or similar is exactly to avoid doing this.

mmap() just needs to make the same type of VMA regardless of the pages
in the range.
