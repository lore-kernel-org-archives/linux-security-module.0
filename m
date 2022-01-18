Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECEC433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jan 2022 11:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiARLdy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbiARLdx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jan 2022 06:33:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4F1C061574
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jan 2022 03:33:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v123so26977070wme.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jan 2022 03:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tr92pS9KHO3IXbg3RLhi3ox4VYUbSG2NiLrhY+N+UTg=;
        b=nsfolPASo/m7mhIpIbeU9JEqAq6BPisPV1CxAA7PpkEBxdBQ+5zGPdDLUAskZM2mbT
         /OMMpDobz/zr7gGCuNFy124OqzjbWSB5jld33U16ktoeiK/QyLuL4cHwyBq1Idz5ejPw
         ZstTh7QgFEDXGXrRRjSybUu+ciDJFSxrm9ZaM57N6AcPh0zFiw48SYLxMJb4tT7eLEgL
         JhAA6+yrUEaRvlkh2WQACwzniLZ4FokCh3FxzHoxQvuHDbz+BmSEqCFBADwUqFx6Tcmz
         50HjQ7DmF8e6djDnQo7B0yU9TSmVoiU4cBT9EeSLaMjl8XxD82zR7ti3YH4SptL8Zv7j
         uAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tr92pS9KHO3IXbg3RLhi3ox4VYUbSG2NiLrhY+N+UTg=;
        b=HAwk0iHCIMW6J0+2/PXxhiDMpt4e0eM47SsIfapDn9P42r+OUvLcMwGe0ESLwTs1NC
         2L5Fqn7kSyUMl1rpaGgkfuKsaK/Xy5WbWhDFj/Qo07rCH1YQ2wRJZSIv29wbwk+LkYPa
         vnyc0JDCU8Yk2Ainhx8z8xqL1PgQcI8dK7MP1j8jhWgJGl1/s9fO2bG98G2FMas4ux2Z
         4WCjPtBGIVjcSwuKIQvQR8C5+9aEIjie1obnrRwHfI60wqBBSxC1OdgkJZH3MNZbE+Rx
         w1gt2tNs275OZpod6F3fKocU4L9wALerX2JTpKAsnZ0oOeZdG5UJC1uavZVvtM9lkbFD
         /q0A==
X-Gm-Message-State: AOAM530kSHVHRATKnkj3jZcot6CuBD0w2dAS7ZA4WOxtXPQ75qD9jorM
        Fpe7aemMkhiwZVIk6tVmdGxLJveLbPM=
X-Google-Smtp-Source: ABdhPJzK2fUrkuw36uHJn15gAe3eMWF6H1LW/3UksC2a4hQcSvIOJw97X2weL+tiOnRCUO/JWF1xMg==
X-Received: by 2002:a1c:545b:: with SMTP id p27mr31888797wmi.178.1642505631411;
        Tue, 18 Jan 2022 03:33:51 -0800 (PST)
Received: from [192.168.1.164] (i5E86669E.versanet.de. [94.134.102.158])
        by smtp.gmail.com with ESMTPSA id i8sm8276529wry.33.2022.01.18.03.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 03:33:51 -0800 (PST)
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Denis Obrezkov <denisobrezkov@gmail.com>
Subject: Why is there an alignment from cred->security?
Message-ID: <720c8d15-8951-3f47-60b8-7d2d8649ce6a@gmail.com>
Date:   Tue, 18 Jan 2022 12:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I am digging through the SMACK code. There are the lines:

static inline struct task_smack *smack_cred(const struct cred *cred)
{
        return cred->security + smack_blob_sizes.lbs_cred;
}

and smack_blob_sizes are defined as:

struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
        .lbs_cred = sizeof(struct task_smack),
        .lbs_file = sizeof(struct smack_known *),
        .lbs_inode = sizeof(struct inode_smack),
        .lbs_ipc = sizeof(struct smack_known *),
        .lbs_msg_msg = sizeof(struct smack_known *),
};

So, basically, to get a struct we take the size of the struct as an
offset for cred->security, right? I can't understand why. So, we have
the following memory layout:

|_________(zeroes)__________|_____task_smack content____|
^                           ^                           ^
cred->security     cred->security +              cred->security +
                 sizeof(struct task_smack)   2*sizeof(struct task_smack)

Do I misunderstand something?


-- 
Regards, Denis Obrezkov
