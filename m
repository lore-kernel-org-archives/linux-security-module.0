Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C7FC433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Jan 2022 09:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiAXJ4R (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiAXJ4Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jan 2022 04:56:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEDEC06173D
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jan 2022 01:56:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r2-20020a1c2b02000000b0034f7b261169so2121845wmr.2
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jan 2022 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=RzdVsdm9Zb1aklQVkpXh9iSDvgaH9+mmZy8V6Vj+IVA=;
        b=Ry3GMWqxTpdRdTTk9IJBiDdZHA+/qp1zkAoF5WU4dgb2WtkegDEjoQxOSncHzUHy8q
         3IiQyExu3WNCVzVHsek+RrlqmHMcL6rVYu3f2t3ibSisNTdMy5BfHj6ZQKNehmtHRnrH
         +P4l8LxjMDS29NmKDhf8uOFguMSlekjVlkTon64OXun/ixDJf/qyEEY0uQQTLdeMDZIq
         VuD9SMTv6Xlw73aUwksFcHQjep65jvrbY9QcLR26Lkc8T7dlrPehOLxfFwzTzoaVUAZY
         MttFEzQsXgNxOeYcGiyx9Xfh/bmMg0l4uecqkSUpOydRw1OI9EO5EtvqSxoLGSnMYdbj
         SiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=RzdVsdm9Zb1aklQVkpXh9iSDvgaH9+mmZy8V6Vj+IVA=;
        b=Axc/o65Se/OgjSM0Qz71LA+k9Zj8TxT5IsYVPJ4rg3sHqZnFhclcdL6dIDk9x7uBJ5
         Zb3Qp6x5DHo5aDdu9dzlEjkPZJS1ORZ2lWGvXN0e0ks1aEPHSp5p1iYSn94EsxpcZc/O
         Tb2ywIWWHZupzGLmZblIlYd7+aQKng71waMUx1OdElmquN7o8Sr0Nzku4Ok05P0H1J0M
         twqkn+1G66eO9sXfkv5mFT9vr2W8QPyI2wnMyi9GobmFbKZJXnh/J4IkjdIM/F07HGdb
         6iLVrzD7vRcpozXfOVS97U34FqTfEuMw7pTyHvK3YTDHkms/dOHT6Ct879gLxYr9xh2P
         tf0A==
X-Gm-Message-State: AOAM530SgcMcS6rzdG6cXm/Tq5HcQcf9rl9UKqF1ayEI3zSEbcIf3ICn
        1PCXwQh7vSes0rrqDmE9YGZxgBZ/rA4=
X-Google-Smtp-Source: ABdhPJwKpOOxY3J3xkLvQOtYACrWj0ob0Xi/kSr6pSdQ/uU4vAKCHbA6xIWN5MazrwWfEb0mtvdxhA==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr1081695wmc.120.1643018174708;
        Mon, 24 Jan 2022 01:56:14 -0800 (PST)
Received: from [192.168.1.164] (mue-88-130-56-160.dsl.tropolys.de. [88.130.56.160])
        by smtp.gmail.com with ESMTPSA id r16sm2820742wmq.3.2022.01.24.01.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 01:56:14 -0800 (PST)
Message-ID: <15530231-a608-8299-7dd1-a8b0155e5e29@gmail.com>
Date:   Mon, 24 Jan 2022 10:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Custom LSM: getting a null pointer dereference when trying to
 access a task security blob
Content-Language: en-US
From:   Denis Obrezkov <denisobrezkov@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <c4cbfdb3-f904-b587-d407-268650e6565d@gmail.com>
 <028166ec-0921-977e-8990-4134b5920cad@schaufler-ca.com>
 <882d62bb-1cc2-0019-cc8c-cdacea31e8d3@gmail.com>
In-Reply-To: <882d62bb-1cc2-0019-cc8c-cdacea31e8d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

It seems I didn't implement cred_prepare and it was crucial.

On 23.01.22 20:58, Denis Obrezkov wrote:

> I have two hypotheses. First is that my keylock_known_system is not
> visible to other tasks (though it is initialized in a global scope of my
> .c file). Second is that I didn't implement some crucial hooks and a new
> task is created without a label. I have implemented those hooks:
> 
> 
> static struct security_hook_list keylock_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(inode_alloc_security, keylock_inode_alloc_security),
>         LSM_HOOK_INIT(inode_init_security, keylock_inode_init_security),
>         LSM_HOOK_INIT(task_to_inode, keylock_task_to_inode),
>         LSM_HOOK_INIT(cred_transfer, keylock_cred_transfer),
>         LSM_HOOK_INIT(cred_alloc_blank, keylock_cred_alloc_blank),
> 
> };
> 
> 
> And I initialized my KeyLock LSM in a way similar to that of SMACK.
> 
> --
> Regards, Denis Obrezkov

-- 
Regards, Denis Obrezkov
