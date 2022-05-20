Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2432C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 20 May 2022 15:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351033AbiETPp1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 May 2022 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351032AbiETPp0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 May 2022 11:45:26 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78161796F5
        for <linux-security-module@vger.kernel.org>; Fri, 20 May 2022 08:45:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so8064564pgc.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 May 2022 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=gs3k/28itFHvJXmdsRExbdUsV2UQMie33SCkn2ny4ZU=;
        b=0L8NTjV/6EsGEzTVPkwaauu66xx4YsEzUoOBnKyeT8AKQ+eiucSVQznEY4zduqcyDi
         0CLs1ZMX4LtInxWYR0lOUHXiLuT12sMMkriI+yvKElKS9UMbR0JE+OaI+76C2qdfF3Hy
         jZtun6jyoo7julKaC4P4QdqO9PLV/Vg5jCN1X0S47LZt+9QFApjRdLCcdWX62xXndUY2
         nQnxou1/l4hl7wb+KaYWLjGwV7izEFK3VT+KEM82NspqCBHbsTa80DQ5q+k3u7jsgDO7
         h/fFQFJjvATlEy9anqSgbM0MJQYkuyscPwNW5Es94zhcTICI8DGnphfk4ySh06KjrZAa
         zQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=gs3k/28itFHvJXmdsRExbdUsV2UQMie33SCkn2ny4ZU=;
        b=a/3hpcNuUijPdRjPFwdJt1+QIImd6EziGE6AxnCtC6EHISx0l69ijboizjhib1MZFp
         r9EYbXhBo6eynXYplGmd/D36woRzdPJNUhGAimUT6Uv9Gqe8n52K5IlluBmW3Gl//KzL
         PUeN/AyVW+2jrygB89/nw3llE0PfLMobjLqVS5O30S8VA8oUMt1qR2U6LiOwlAvb18t0
         PQog9gZEUxvVl4cEk+/tozikroQEeDW4DMEUWFdBgtSCOfUJCakO8aLlVNIMjU4p1cnO
         3JJR4HEVVbHZqWAAKEQ2qEPM2hUsfCQNWG+qt/V/skHP3y4B1WKLcao10PheJ6IgreEt
         Dwig==
X-Gm-Message-State: AOAM531sqhbY4TXMLp6sSc4m4jOmDDvexAErAe5AmY010E8VmvYvl19m
        BgY/zWRcvhYiweBs7TIv2f5Irg==
X-Google-Smtp-Source: ABdhPJwZQuyWJmMpMf/TR7lpahjw2nquTx9J7AVvExgDhp9Su6K3b7Yem6V1CcSf9pHCcHH0pCVRBw==
X-Received: by 2002:a63:488:0:b0:3f5:e6da:4619 with SMTP id 130-20020a630488000000b003f5e6da4619mr8966800pge.6.1653061523297;
        Fri, 20 May 2022 08:45:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902ce1200b0015e8d4eb1easm5838502plg.52.2022.05.20.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:22 -0700 (PDT)
Subject: [PATCH v1 0/5] Support kexec_file on 32-bit RISC-V
Date:   Fri, 20 May 2022 08:44:26 -0700
Message-Id: <20220520154430.18593-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        liaochang1@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     lizhengyu3@huawei.com
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

kexec_file() support was recently added for RISC-V [1], which triggered
a handful of build issues on rv32.  These all seemed pretty minor, but
it looks like this is the only 32-bit platform that has attempted to
build the kexec IMA support before so I'm not sure if there's something
more complicated going on that I'm missing (I haven't tested any of
this).

The rv64 support was just merged into kernel.org/riscv/linux/for-next as
83a7a614ce58 ("riscv: kexec: add kexec_file_load() support").  I've put
these on top of the pre-merged version at
kernel.org/palmer/linux/riscv-kexec_file-rv32 if that helps anyone.

1: https://lore.kernel.org/all/20220408100914.150110-1-lizhengyu3@huawei.com/


