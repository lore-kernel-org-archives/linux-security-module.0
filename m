Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2C9C433EF
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Jan 2022 21:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiAAVe6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 1 Jan 2022 16:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiAAVe6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Jan 2022 16:34:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A93C061574
        for <linux-security-module@vger.kernel.org>; Sat,  1 Jan 2022 13:34:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j6so120787372edw.12
        for <linux-security-module@vger.kernel.org>; Sat, 01 Jan 2022 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vhGopR69jEW+7HJdT2nZ5Tv4novtr0LbKvTLFnKCVbE=;
        b=NdPTq4rJM7x8G+2cSR0zQEg5m4/sLXYM/qmWR/8GIPpBbjJw9KOucXJUegCie4891Q
         cLMkmuAA1xiSkkSN3DIdKMNzIDd0ufkjsScmDyB9vYUhqQUgVRsrGcdha262u/j+VlLV
         GcBYSoLSherff7hLLDVbL7ZwCZMg1uyMn5mJp6DtJ0G4u6ZttZvErNZHQh7yMcKNX3RM
         hYh8L5DPMC74AtrsILL83KYWe3/ZydcGZ6/6lTZ5twJZxCXk9NXvtCsQj/tfAxH6F8si
         azTtNWVYRb3nRdPO/iI4CbDfnU2sx8CwaiQHdMHClvYuiKEDJQiBoS6uaZng9pKMuiS4
         cMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vhGopR69jEW+7HJdT2nZ5Tv4novtr0LbKvTLFnKCVbE=;
        b=JNHB19SQUby23PzsJkEcTk1/739BzfNSNEv24L/eLqzt+C0WV1yjgaSkNrcs6/LZJI
         EEQc/tFS77HlQLW9aZrwGTsU/daN4l7k/BP07ZoclkHDAm/QU3jsqrg18i37p1CTnWmB
         kkpOFbaSAjQtRNcljsvr0nsBKQjjMvlfFHd5pm16t/jrpshUqv5QoSDnNdwQF9pu/cWH
         RG8XhNCSZC3V6Hn8GcVsOeFV0OVSN9ZYM3m57bpfPMPSYUnbRfMlYaX7FPB1Hr+8gf3H
         cdEvTiuDxWffyQJNOIgd0u0pGwFAnE2oetXhSxeiU0cVq9x+RaK6xsleQWQPX46D/0vn
         gbrg==
X-Gm-Message-State: AOAM531cToJkTU9rfN1ilViY70KnTo/B8NDtQJlMY4nE1y1F5wzhdx2g
        CCPaxYyhgT2lyTsdhqaIkCHQkC1778c=
X-Google-Smtp-Source: ABdhPJybJNXV+bvpCwRdQ3s/wC58Ukb6JZhRqVcFQJsR7UpT3Zl4JO6bOVc94cgeAilBGjWkuP4HMQ==
X-Received: by 2002:a05:6402:26cd:: with SMTP id x13mr40017897edd.167.1641072895451;
        Sat, 01 Jan 2022 13:34:55 -0800 (PST)
Received: from [192.168.1.164] (i577BC9A6.versanet.de. [87.123.201.166])
        by smtp.gmail.com with ESMTPSA id ht14sm9401980ejc.64.2022.01.01.13.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 13:34:55 -0800 (PST)
Subject: Re: SMACK: how are smack blobs getting into cred->security and
 inode->i_security?
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <470651da-88da-8a9e-7ba1-c5f36066bf72@gmail.com>
 <8cd68537-8ac4-625d-3416-3ce6eba938f1@schaufler-ca.com>
From:   Denis Obrezkov <denisobrezkov@gmail.com>
Message-ID: <eedaa146-c4a6-6761-8e9c-56fd038a8b27@gmail.com>
Date:   Sat, 1 Jan 2022 22:34:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8cd68537-8ac4-625d-3416-3ce6eba938f1@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> The LSM infrastructure (security/security.c) allocates cred and inode
> security blobs. This allows multiple security modules to use them.
> 
>>   Also, when does it happen? (for a task and for a
>> file)
> 
> security_cred_alloc() and security_inode_alloc().
> 
I mean how is information from SMACK64EXEC and SMACK64 getting into
those blobs? Do I understand the sequence right:

First, both labels (SMACK64EXEC and SMACK64) are installed in
smack_inode_post_setxattr. Second, when we launch a program, there is a
hook smack_bprm_creds_for_exec that installs a security label from the
program file inode into the corresponding smack task structure. Third,
when the program tries to access a file, it is caught in the
smack_inode_permission.

I am also not sure what is happening in security_inode_alloc. Does it
just copy a pointer to a security structure of a current task?

I also can't find where security_cred_alloc is used. I found
security_cred_alloc_blank but it is called only from cred_alloc_blank
from cred.c (and I can't find from where the latter is called).

-- 
Regards, Denis Obrezkov
