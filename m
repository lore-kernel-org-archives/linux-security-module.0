Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F2BCCA47C
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jul 2022 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiGLOWd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiGLOWb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Jul 2022 10:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5563531911
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657635749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRth/JuCuClo783o03abQL28yzBSESS3ebbCWk69Wso=;
        b=aUGC4iEi7QxlYE52Uju6mSISoYD7JG4GfC/mzCFFUzP16udCboRQWh3yZNxuQoitoqqyCG
        Ix+0KvqsRF8FkwiTxxqKKf7O9WULmfU3jC+SyjPMN6cQBMQsK2P0QQOBskemme/N+R/Bad
        sCpQG/fCZ8JNYNj+iDBVyzuQC7ey7xA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-D6N5tND6Oumc9Wc2DLzzRA-1; Tue, 12 Jul 2022 10:22:28 -0400
X-MC-Unique: D6N5tND6Oumc9Wc2DLzzRA-1
Received: by mail-qt1-f198.google.com with SMTP id j29-20020ac8405d000000b0031e9bb077dfso6998064qtl.15
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 07:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRth/JuCuClo783o03abQL28yzBSESS3ebbCWk69Wso=;
        b=IkpF0NNlxGA5qN3DION/qDTNdLjGit+plfEZsIgH7IUx7pjGx3yKmhVqsB1/qcvltf
         TSNzqujpuFrjekkvf9g+/wUbnOdyPWRBBuxGqb+5Kn69N5ysX5sFe3q8wG3v8J7sEzL4
         Wrgx8hz9I5DDjan3nZJCMGeKViJrkmgYLt7RcsHoPycMuUEAaxNSgNrXHk8ica00sSTb
         qjl7QjD6zSv7+ErKaoCDDVQjunAf/c1swokgavYx0ky/wo75EBJE4lJgOFz4FdCk3hky
         CCODItlFeDXqGBoc232XiITg1ZyMDZb2/73OTWf1dkkBSF07xYDDOJIjzMbE5F6/pDdm
         ZqVA==
X-Gm-Message-State: AJIora/OhwS8UXy/6mpqglb1UPrnUwDVrTjaMix/52k8YbZmSaz48jbn
        E6fvn7ByHL2XVWjyTNpKthlL7pImTcCZCrBFzgoIIYQORgyPbdc9urU8w2pEgjaLydGpr99dRRs
        d058u5in9RpTrXSNdow7wDrwvG3JwV5Irr4yC
X-Received: by 2002:a05:622a:186:b0:319:1d49:2db7 with SMTP id s6-20020a05622a018600b003191d492db7mr17712532qtw.444.1657635748132;
        Tue, 12 Jul 2022 07:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tv78XEVFTMuhWhQKwfrYHtCI9m9VH1riCwijD5DC+NNMp6Ay9I1CfvMy+cndUw9mqJUB3Uxg==
X-Received: by 2002:a05:622a:186:b0:319:1d49:2db7 with SMTP id s6-20020a05622a018600b003191d492db7mr17712507qtw.444.1657635747901;
        Tue, 12 Jul 2022 07:22:27 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id t20-20020a37ea14000000b006a6d7c3a82esm9106182qkj.15.2022.07.12.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:22:27 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:22:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert O'Callahan <roc@ocallahan.org>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
Message-ID: <Ys2DobolHlrXP4/M@xz-m1.local>
References: <20220708093451.472870-1-omosnace@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220708093451.472870-1-omosnace@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 08, 2022 at 11:34:51AM +0200, Ondrej Mosnacek wrote:
> Since userfaultfd doesn't implement a write operation, it is more
> appropriate to open it read-only.
> 
> When userfaultfds are opened read-write like it is now, and such fd is
> passed from one process to another, SELinux will check both read and
> write permissions for the target process, even though it can't actually
> do any write operation on the fd later.
> 
> Inspired by the following bug report, which has hit the SELinux scenario
> described above:
> https://bugzilla.redhat.com/show_bug.cgi?id=1974559
> 
> Reported-by: Robert O'Callahan <roc@ocallahan.org>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

