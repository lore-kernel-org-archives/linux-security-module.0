Return-Path: <SRS0=nZhg=OU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A5C5CFFE
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 18:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F095820851
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 18:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F095820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeLKS2L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:28:11 -0500
Received: from namei.org ([65.99.196.166]:58920 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeLKS2L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Dec 2018 13:28:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBBIRiau011806;
        Tue, 11 Dec 2018 18:27:44 GMT
Date:   Wed, 12 Dec 2018 05:27:44 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Nayna Jain <nayna@linux.ibm.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v2 1/7] integrity: Define a trusted platform keyring
In-Reply-To: <20181208202705.18673-2-nayna@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812120527150.11653@namei.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com> <20181208202705.18673-2-nayna@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 9 Dec 2018, Nayna Jain wrote:

> On secure boot enabled systems, a verified kernel may need to kexec
> additional kernels. For example, it may be used as a bootloader needing
> to kexec a target kernel or it may need to kexec a crashdump kernel. In
> such cases, it may want to verify the signature of the next kernel
> image.
> 
> It is further possible that the kernel image is signed with third party
> keys which are stored as platform or firmware keys in the 'db' variable.
> The kernel, however, can not directly verify these platform keys, and an
> administrator may therefore not want to trust them for arbitrary usage.
> In order to differentiate platform keys from other keys and provide the
> necessary separation of trust, the kernel needs an additional keyring to
> store platform keys.
> 
> This patch creates the new keyring called ".platform" to isolate keys
> provided by platform from keys by kernel. These keys are used to
> facilitate signature verification during kexec. Since the scope of this
> keyring is only the platform/firmware keys, it cannot be updated from
> userspace.
> 
> This keyring can be enabled by setting CONFIG_INTEGRITY_PLATFORM_KEYRING.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

