Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD75BC43334
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Jul 2022 02:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiGDCga (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 3 Jul 2022 22:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiGDCg3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 3 Jul 2022 22:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6C446560
        for <linux-security-module@vger.kernel.org>; Sun,  3 Jul 2022 19:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656902188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1FJ6cqRuF8dBXv9KcZczCA6imIHUu41nOlrwT+WJ0s=;
        b=W1cDKYoHu/NasPpd5MjqxsGoXKy5Z8uLJkfzwRUXN4t56+7jXaK9n4mSOIH2ICQLb6K3OF
        yh8rAQ76MBc+AKHNElbmYfqsjLhc4ZEgxXmXAVYxMea52BmsssiSmZDPQhXM/n0NIqwj3Z
        a8GqReEk2L0IIOzfAsBV9b36Oz3daso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-FYcXjujqMAeLRZl34AbSJQ-1; Sun, 03 Jul 2022 22:36:22 -0400
X-MC-Unique: FYcXjujqMAeLRZl34AbSJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A3B485A581;
        Mon,  4 Jul 2022 02:36:22 +0000 (UTC)
Received: from localhost (ovpn-13-121.pek2.redhat.com [10.72.13.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5646C1415308;
        Mon,  4 Jul 2022 02:36:19 +0000 (UTC)
Date:   Mon, 4 Jul 2022 10:36:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v7] x86/kexec: Carry forward IMA measurement log on kexec
Message-ID: <YsJSIIsCnjoL+ObY@MiWiFi-R3L-srv>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
 <YqtMf9ivGR8Rkl8u@noodles-fedora.dhcp.thefacebook.com>
 <Yr1geLyslnjKck86@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1geLyslnjKck86@noodles-fedora.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 06/30/22 at 08:36am, Jonathan McDowell wrote:
> On kexec file load, the Integrity Measurement Architecture (IMA)
> subsystem may verify the IMA signature of the kernel and initramfs, and
> measure it. The command line parameters passed to the kernel in the
> kexec call may also be measured by IMA.
> 
> A remote attestation service can verify a TPM quote based on the TPM
> event log, the IMA measurement list and the TPM PCR data. This can
> be achieved only if the IMA measurement log is carried over from the
> current kernel to the next kernel across the kexec call.
> 
> PowerPC and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so use the setup_data mechanism to pass the IMA buffer to
> the new kernel.
> 
> (Mimi, Baoquan, I haven't included your reviewed-bys because this has
>  changed the section annotations to __init and Boris reasonably enough
>  wants to make sure IMA folk are happy before taking this update.)
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> Link: https://lore.kernel.org/r/YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

