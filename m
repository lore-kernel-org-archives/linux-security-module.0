Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01286C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 20:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C505220700
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 20:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553633753;
	bh=boyJ3Buo2pPC9t7P96nVK4DIZZBxcZsfGGAPdiYwOqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qu5gvEyEtO65szZZoRghgK1WneeyML/2uvl4xecvZjhLk6ixvDiqe7lrtVvIopglq
	 Y2zeKn684XzOeogrsMyio/SMlVAsey/HM1jVgYbyBG8mcKQsJOQqp+YC36npzjp3gQ
	 kt4rfFQbTHEhUxUf/8GBjaGuqG8Er17ZZDE0NqxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfCZUzx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732748AbfCZUzw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 16:55:52 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF5421738
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 20:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553633752;
        bh=boyJ3Buo2pPC9t7P96nVK4DIZZBxcZsfGGAPdiYwOqQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hDVTJCYYK+ctAydkulvCscDWHwdq3eXq7tlPLUds/HghYBvTIs3KUDaUvqwgQ1ty5
         dzf5BqtRWoXTxDe8XsEg889M6uL0lIZ+BoFEis26j9aX+uct6AxWbhJe4zWjGCd8yY
         PRn9LyIHAHkS4sCxpOVE15svTfGYh7nsRV/xNSSI=
Received: by mail-wm1-f47.google.com with SMTP id z11so14230434wmi.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 13:55:51 -0700 (PDT)
X-Gm-Message-State: APjAAAVa0h15uosOsyMQVh2y8sPYA1zoizPMu3C0i9f64QbJmOwmN6W/
        Kq+s8ttUU/Xmn5ysU5RyHrRQcSiMQKxdG2aKTBeC1w==
X-Google-Smtp-Source: APXvYqwiosCi1l4wHJhYr/e48fuZj9iPqzVTecVH+cFvt04RmxBfsTMTGOZpZrqZEJKMSUwN0Jd6MUpVgVsSf4WKe2Y=
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr11751037wml.74.1553633750383;
 Tue, 26 Mar 2019 13:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com> <20190326182742.16950-11-matthewgarrett@google.com>
In-Reply-To: <20190326182742.16950-11-matthewgarrett@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 13:55:39 -0700
X-Gmail-Original-Message-ID: <CALCETrW43Syz-deM-fGUCbWfA8tcsoCJJ5XqjFhpg+d0sNYDRA@mail.gmail.com>
Message-ID: <CALCETrW43Syz-deM-fGUCbWfA8tcsoCJJ5XqjFhpg+d0sNYDRA@mail.gmail.com>
Subject: Re: [PATCH V31 10/25] PCI: Lock down BAR access when the kernel is
 locked down
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> From: Matthew Garrett <mjg59@srcf.ucam.org>
>
> Any hardware that can potentially generate DMA has to be locked down in
> order to avoid it being possible for an attacker to modify kernel code,
> allowing them to circumvent disabled module loading or module signing.
> Default to paranoid - in future we can potentially relax this for
> sufficiently IOMMU-isolated devices.

Does this break vfio?

--Andy
