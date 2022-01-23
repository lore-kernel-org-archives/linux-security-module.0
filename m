Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09AFC433EF
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jan 2022 19:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiAWT6v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 23 Jan 2022 14:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbiAWT6v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 23 Jan 2022 14:58:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DEEC06173B
        for <linux-security-module@vger.kernel.org>; Sun, 23 Jan 2022 11:58:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a13so9850680wrh.9
        for <linux-security-module@vger.kernel.org>; Sun, 23 Jan 2022 11:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TUWl6dmQTNvBjvx6XYIqGZFahJGyLZ/ZYOAILo4w7V8=;
        b=YZb9Y+grOTJWkIlxH8l9Mb4GnP3dkJW8gYhC226DVzC/rcZnQR1hhZ7Qti8nWDIYzE
         BfD6hZSq9hUupyYFwYkxBCN9v+M/LFpJCEVCm4ACmaFa/JYtHvl20Y9qhDF6uARwfden
         kzGJUnzces2q7lrmXA5bucTuPyMQzbeSY3lJGuoOlNUFhd3/II2i7I2Mo+NyCq4bRfF/
         nVshbKOynQi+RkkpoQRwMQiE978OTqQNS+cmv3JYpuP3Gg9CN/o3+Ncm4UjauOBRw4bR
         SJM6TgZetGmfkPFS+qpqhiaSX5XcGvfLMSImcxRKew3aiOn4KA/DtTMEaL2fvfdbYI33
         4chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TUWl6dmQTNvBjvx6XYIqGZFahJGyLZ/ZYOAILo4w7V8=;
        b=jBwjpCEP1GWBiSFyEPQgPXKnxHqZFXOetfpxSkaRO5obJiSkOv12P5VPsedOnr/8J/
         GcX6mD/oEaDsFBlstU3Kb5wP2a0s/lI5mAMl938Poi7m9x06FKC0MeNNWO8xsvn/gzMo
         pPw63orLO93b/eQFwj5AO0M3kqhB6g6yxexrC4k2wotWOShB7KPDoJC1GcDPodq/CMTt
         ESyaZFDePeAOJYyRKmmmaqocg2HJphFsaeNVo28/znYQOntH522BScp8xY5b0CvANM96
         j3DaXGiVu7Yzc1zbrn11bVswGTeLlBIVC+5NR7BBzJaT2xuAA7cEuwGLDPEFATOhAXf1
         TkaQ==
X-Gm-Message-State: AOAM531rUGHULI4XB3Q991Z0bTMjgbpd7QlIMhOOSlD7/RSDrPBUrX29
        rtBGidT/XAjpu26AhgPeQGDzBSE2Isw=
X-Google-Smtp-Source: ABdhPJwEtScGmfjopeLQe9saKsybwxvQ1TwDVPZb2KzPvFaGlKI9ER6XhpZCL6R3wmMni8sD9NprDg==
X-Received: by 2002:a5d:644a:: with SMTP id d10mr11429398wrw.295.1642967929123;
        Sun, 23 Jan 2022 11:58:49 -0800 (PST)
Received: from [192.168.1.164] (i577BC8ED.versanet.de. [87.123.200.237])
        by smtp.gmail.com with ESMTPSA id i2sm2556035wmq.23.2022.01.23.11.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 11:58:48 -0800 (PST)
Message-ID: <882d62bb-1cc2-0019-cc8c-cdacea31e8d3@gmail.com>
Date:   Sun, 23 Jan 2022 20:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Custom LSM: getting a null pointer dereference when trying to
 access a task security blob
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <c4cbfdb3-f904-b587-d407-268650e6565d@gmail.com>
 <028166ec-0921-977e-8990-4134b5920cad@schaufler-ca.com>
From:   Denis Obrezkov <denisobrezkov@gmail.com>
In-Reply-To: <028166ec-0921-977e-8990-4134b5920cad@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


> 
> There's nowhere near enough information here to identify what's
> going wrong here. Is the KeyLock code otherwise a copy of Smack?
> Have you registered KeyLock correctly with the infrastructure?
> 
Yes, right now the only difference is that I don't have a single
repository for all labels. For each task/inode I store only a pointer to
a head of a list of its own labels. I want to store pointers in
creds->security and inode->i_security. So, basically each subject will
have its own repository of (its) labels.
Right now, I have only one security context which is defined in my .c file:
struct keylock_known keylock_known_system = {
        .label          = "system\n",
        .kl_mask        = 7,
};

First tasks receive the pointer to this structure and I can see that the
pointer value for them is non-zero. But later I can see that other tasks
in keylock_inode_alloc_security have zero pointers,
I have two hypotheses. First is that my keylock_known_system is not
visible to other tasks (though it is initialized in a global scope of my
.c file). Second is that I didn't implement some crucial hooks and a new
task is created without a label. I have implemented those hooks:


static struct security_hook_list keylock_hooks[] __lsm_ro_after_init = {
        LSM_HOOK_INIT(inode_alloc_security, keylock_inode_alloc_security),
        LSM_HOOK_INIT(inode_init_security, keylock_inode_init_security),
        LSM_HOOK_INIT(task_to_inode, keylock_task_to_inode),
        LSM_HOOK_INIT(cred_transfer, keylock_cred_transfer),
        LSM_HOOK_INIT(cred_alloc_blank, keylock_cred_alloc_blank),

};


And I initialized my KeyLock LSM in a way similar to that of SMACK.

--
Regards, Denis Obrezkov
