Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC05C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 31 Dec 2021 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhLaNII (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 Dec 2021 08:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhLaNII (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 Dec 2021 08:08:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57DEC061574
        for <linux-security-module@vger.kernel.org>; Fri, 31 Dec 2021 05:08:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z9so38869720edm.10
        for <linux-security-module@vger.kernel.org>; Fri, 31 Dec 2021 05:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZMnPNYw+9QRoB3NHTvQCvKc6Ghwxp0JAkdekGED2qcM=;
        b=H4XeAIBqH3yLD0tEhOXcWeFjTNarFjxDSIDC1FfhmlLQk4/DWVy1RKHuu2cy45wLVu
         qin2Vsor9WCh49eLOET+xcbNfZz2T30qCIxX8+ztkdMBwIqKuRVk8TbjsG/ZruQmL9oS
         iVgsniK45JRLLMtGJMoBT8+w06FcjoAKhrH4wellsb2x8kVpOFCNrOuV1IruiqLjnj8g
         aFz9btSo0Cv8uXNgWOR2gkc7JDVQV3VTJHxSX6Gk/cX6WxlkZ+aAlYngjl2UaTm5Kx2W
         P4eGkAJTcwl/P8KzRHZfkzZXdYWxegRZ803OzF02WBnZSZ2vDYmgjJlZ1v27gqd7TEIh
         /Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZMnPNYw+9QRoB3NHTvQCvKc6Ghwxp0JAkdekGED2qcM=;
        b=IwxSBZofEOneic5wvMJ+v4G958nuafhwtocHOH8ID8SirHyEuPn2KgY5tVxOktm8JL
         EuH0HOLBl2JZu/PxoDSmag/5/5bRKqzbq6jbQIThGkVwzxJIm7a7hQD7Xngrbdzo++Tj
         PSU6ssmudCVTXg+Gs/N4oltbwQBbT5qBwMY34EN6Ou9iyXcq5qjo3SHYdtQcCkuEk90Z
         g2I9Kj08FdkMOdQFY0FRQvwXlh5ZSJJxFt2yd0k/2xHhASw+fUvlV9w2Tu8xZO9cWUOp
         F08K8XPs1Qwzf77iboYGriG9bdXm1G3T153g5UOmz+j213M7WsCdG9f6dljlvMTo2C0M
         5MyA==
X-Gm-Message-State: AOAM532HkwqRoy5c2XhqkrYfZpYvUUpgDQYF64Lzk6ueQTPmYDF+sCDa
        IznvqwAMHslosrTXtbuzC6JWJr62n2Q=
X-Google-Smtp-Source: ABdhPJyuBdigtW5WdWnaMFW5wr6dtx1tJiKvmfaU+xaFaHq1f7G9GpECnwNeOd41ua1WNPC0+1MI7g==
X-Received: by 2002:a05:6402:51cc:: with SMTP id r12mr35303913edd.239.1640956086122;
        Fri, 31 Dec 2021 05:08:06 -0800 (PST)
Received: from [192.168.1.164] (i59F77C41.versanet.de. [89.247.124.65])
        by smtp.gmail.com with ESMTPSA id o22sm10599863edc.85.2021.12.31.05.08.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 05:08:05 -0800 (PST)
To:     linux-security-module@vger.kernel.org
From:   Denis Obrezkov <denisobrezkov@gmail.com>
Subject: SMACK: how are smack blobs getting into cred->security and
 inode->i_security?
Message-ID: <470651da-88da-8a9e-7ba1-c5f36066bf72@gmail.com>
Date:   Fri, 31 Dec 2021 14:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

I am trying to understand how smack works (looking at
smack_inode_permission hook). I can see that that smack security
information is taken from  cred->security and inode->i_security but how
did they get in there? Also, when does it happen? (for a task and for a
file)

-- 
Regards, Denis Obrezkov
