Return-Path: <SRS0=tbeH=RY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C49C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Mar 2019 16:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9F021917
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Mar 2019 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553187057;
	bh=VFZVbyHAyA2I8iHvws801hJrn1l6FCnCEEx1Yui6u6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iR3JQSPygOIMWfsxu52QysZhR/Xd211kpN+T/WJit46vlEzkPs7qz2I6JdBRuzdXk
	 6HBVI4oxsIL13Tdhtn7EsD2irkSYoL6yKtLAlE8qQhVNTfKlRhRe9z0JrZZeL/rAPA
	 yC/FvkvNLBuY41p8PLkqyyHC89q31eBLCevG16j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfCUQu5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfCUQu4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Mar 2019 12:50:56 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B112183E
        for <linux-security-module@vger.kernel.org>; Thu, 21 Mar 2019 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553187056;
        bh=VFZVbyHAyA2I8iHvws801hJrn1l6FCnCEEx1Yui6u6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x2rAt+Net1sRydbzqkKmv+j/ZUzYDVSQaRUH65m1U/OYQoNzvVc5DMn8L9IydTBmQ
         dAeKUOMsO6+MOEHQSiIJyiTqribMze4Gbqr4a/Qvduf1F8nOiPrSSii8FGatvdOxVc
         y82CUZ6LYg2C4tfjEvrmpKDoKULSSFq2I9RttgtA=
Received: by mail-wr1-f42.google.com with SMTP id p10so7439978wrq.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Mar 2019 09:50:55 -0700 (PDT)
X-Gm-Message-State: APjAAAV9Sw3h/bPg0vOq/fg/VRm9bCJluGKeb6oLT6gM2svwQG5Ruej1
        bdNAlZ6qwDjdFxrGS3H0a2411SnoBA3euFQScp9awQ==
X-Google-Smtp-Source: APXvYqwN9WAa0l9R5a/RKmQvkzuwqIPT6sCIg1Yv3y5V/7ApqBRZURKGxH5WCD3EOOxNBVzbRBTJrn+NX4+6zwaBWkw=
X-Received: by 2002:adf:f011:: with SMTP id j17mr152260wro.330.1553187052916;
 Thu, 21 Mar 2019 09:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190317211456.13927-1-jarkko.sakkinen@linux.intel.com> <20190317211456.13927-18-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190317211456.13927-18-jarkko.sakkinen@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 09:50:41 -0700
X-Gmail-Original-Message-ID: <CALCETrXQ0x2TD5GnaHhmF6SExk0C8+L0AwfnH-Krqwttfvwz2A@mail.gmail.com>
Message-ID: <CALCETrXQ0x2TD5GnaHhmF6SExk0C8+L0AwfnH-Krqwttfvwz2A@mail.gmail.com>
Subject: Re: [PATCH v19 17/27] x86/sgx: Add provisioning
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Mar 17, 2019 at 2:18 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to provide a mechanism for devilering provisoning rights:
>
> 1. Add a new file to the securityfs file called sgx/provision that works
>    as a token for allowing an enclave to have the provisioning privileges.
> 2. Add a new ioctl called SGX_IOC_ENCLAVE_SET_ATTRIBUTE that accepts the
>    following data structure:
>
>    struct sgx_enclave_set_attribute {
>            __u64 addr;
>            __u64 token_fd;
>    };

Here's a potential issue:

For container use, is it reasonable for a container manager to
bind-mount a file into securityfs?  Or would something in /dev make
this easier?
