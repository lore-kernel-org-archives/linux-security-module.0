Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FBDC433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Feb 2022 20:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiBPUr5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:47:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiBPUr4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Feb 2022 15:47:56 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A44C3304
        for <linux-security-module@vger.kernel.org>; Wed, 16 Feb 2022 12:47:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vz16so2134707ejb.0
        for <linux-security-module@vger.kernel.org>; Wed, 16 Feb 2022 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SvjEChs8oB4bFzrOdFEF4f6WDD2x5bbX154HINupHHc=;
        b=6nnmVyblMn2NYTB8bThctxxAF936b0o+WhtLScsHxJQuuXlYCi3NTu30mpelQPplVu
         CBSl9E3VRbHopbQZ2Op0mSStO0330dQD6jbQira4Fj3bhvFkLRuF4qZSn091dYycbvgD
         BTzNibxjh3gholQIqZMgecsv8IXPdQ7ZbyqTQ6/I1KfDe+7H5tVa50V2BivDOfGHosMo
         Lwiptp4PaFzk32tbRgMJqGjplV0WX+ZUXFnQWIfeR+U7lxPDFHtGRYtqcVwHk7vaYuM9
         OpP621kUbODvE5gYIvDMm8m5/plJVzvT3nOdFfpCq7jm+yAKjGnfA69T071bZC79zbMi
         OhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SvjEChs8oB4bFzrOdFEF4f6WDD2x5bbX154HINupHHc=;
        b=CoXG6lrESugdpXT3IBmKavKpSQBPp8nqvi6jBRY5BzwbMemmNI4ieGZH50tUHGXcy6
         zaiwY6poutpaRffgvMEH3y05H55hF7HullAQrkgoawpYHpjiGU6fiagXDOreGXVrwnNs
         2+YZVNoE16gUa/A37sKsKdd1k7tR4HAP4JoQX8xDnN/WGk/oiVdZnSCeq8s3brOzYrJO
         UrJ6LxMDNOlanfF92eD3zsl3GzcyTIaeW9ZJ5TNvqGdWom8HDIFhXLVFrC4wHNfceFTg
         lLiI2hY7OVDHEwdC34wBDmMiaAbLoiFnoY25m4Rr4OsLDM0yvGbw5RY6DzBI08vWzhIM
         LlCQ==
X-Gm-Message-State: AOAM53251Qbbywhsesmt6GcAnjDtC7QvcQbBnqE79IoLSVwP5hJZzqk7
        XOpmxbNRt+n9U12kZtuVTvJYUz9T+03Z1LmBqgzD
X-Google-Smtp-Source: ABdhPJw53KebzyYKq4ObwOesZ4Xgi2GpfK9U8pkjMwJBatkW6N2qbSYIpHMcaLrLTDdnKqk7zMd+NIcxv2Z+H1Dik8w=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr3759463ejp.12.1645044458734; Wed, 16 Feb
 2022 12:47:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
 <20220216125206.20975-1-igor.baranov@huawei.com>
In-Reply-To: <20220216125206.20975-1-igor.baranov@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Feb 2022 15:47:27 -0500
Message-ID: <CAHC9VhTDu1GDxJwFg5gAMWhuMKUWEU5eXuTr_6eG=tGwiGsMTw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] SELinux-namespaces
To:     Igor Baranov <igor.baranov@huawei.com>
Cc:     hw.likun@huawei.com, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, xiujianfeng@huawei.com,
        alexander.kozhevnikov@huawei.com, yusongping@huawei.com,
        artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 16, 2022 at 7:52 AM Igor Baranov <igor.baranov@huawei.com> wrote:
>
> Hi all!
> Our team at Huawei decided to revive the work on SELinux namespaces.
> We took https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
> as a basis with some patches from selinuxns-xattr.

Hello!

For reference there is a *slightly* more recent forward port of those
patches in the main SELinux repo under the working-selinuxns branch.
I haven't forward ported those patches since v5.10-rc1 as there are
some rather significant technical hurdles around persistent object
labeling which I don't believe have been adequately resolved yet.  The
prefixed/namespaces xattr approach that you mention above may work for
a limited number of namespaces, but I worry there is a scalability
issue that needs to be resolved; we can't simply keep adding xattrs to
inodes.

 * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

Also, are there rest of your patches online anywhere?  Patch 1/1 isn't
very interesting on its own.

-- 
paul-moore.com
