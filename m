Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141CCC43334
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jun 2022 04:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiFXEty (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Jun 2022 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiFXEs2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA7369253
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jun 2022 21:48:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so1685908pjj.5
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jun 2022 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=VOrN2Skldd6ynBdimZLEfOLlQdQeXbU4ZvduMfJHL6c=;
        b=XgTwJU2SJn7OgRjOacDrBq8AbIvZy9A81IA50d1kPRNcGZ35nasRgjV4RLK/GhrSHQ
         liBXBNjEUUlPp7BL7s5TqwGWSyxagHvQ+xTyaGyQcCkEpt11davqrfMjfjAoapuf6WZn
         v6n8vJYQWsu4abQaVlYDcuSEV6Jot7TID2g+Pt0cEwyChpdWBH/41ODLnB/El/jl5Xlc
         WGrSAghyUAohMDgNK8/g16MxKloX+ZO5e5BTBzscGGT9lseU/cNO1WuZfmcRl5onAV85
         +S2Z1J0jMLcEbiefwlIIQiebdEEaaQDPxk7iERWdaKfVeUWSz1gTQ1mXF06EWgq4DNX0
         fgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=VOrN2Skldd6ynBdimZLEfOLlQdQeXbU4ZvduMfJHL6c=;
        b=m6ZkDmtta4bPNIxIVtSZFXglagL9dZGtWLiGwU9JsgtKvPF/6RaytupKmcVn59qOPz
         mC1twEU+XmXxPNZwdxfoYzjB1DgG09tiAUYFerGKy7AE9/ZQSLlfpdrVPcIsvwAkgN3X
         e7gpb6jLlMXcCpBSSTFFzkLxbFYYqQGUs3UgHIqgi0hCHWeyDuuGnbCb/7MWWoZaXho1
         ufgRQaK9Fq7B7RvravA42IkRaSFn2h0kv1e1lEFsTIHJrUAsKh482mbEBcqIub3tehNc
         YTGBWJdkshNSpQxwy7dHdqLARPanR6DpP/BXwVu2kn2QQrxJCrJMiRum+ElOxpcAurgH
         Ae6A==
X-Gm-Message-State: AJIora+CINA2CEksYGveog+hhOFQZQ8xnJS/e8kHZW/FZCgNUb23Ub6n
        IgWdKXXybSp/rDYyK4nZDe0WPQ==
X-Google-Smtp-Source: AGRyM1twjNfvXdC15oBPlo3E7P9L0CcbGOzh0tICPbKtW3VyqvOblbLp0OUdm7yJez7FETjSBlaYbg==
X-Received: by 2002:a17:902:d48e:b0:16a:67e7:d979 with SMTP id c14-20020a170902d48e00b0016a67e7d979mr1887249plg.29.1656046104242;
        Thu, 23 Jun 2022 21:48:24 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id x20-20020a056a00189400b005251b9102dbsm557073pfh.144.2022.06.23.21.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:23 -0700 (PDT)
Subject: [PATCH v2 0/5] Support kexec_file on 32-bit RISC-V
Date:   Thu, 23 Jun 2022 21:48:06 -0700
Message-Id: <20220624044811.9682-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This rolled itself back to the top of my inbox, so I figured I'd send it
again as Rob's review landed.  IMO the security/integrity/ima/ change is
sufficiently trivial that it's fine to take it through the RISC-V tree
but I don't have an Review/Ack so I'll wait until this loops back again
to give the security/integrity/ folks a chance to chime in.

If this loops back to the top of my queue (which looks about a month
deep right now) without any comments then I'll put it in riscv/for-next.

Thanks!

Changes since v1
<https://lore.kernel.org/all/20220520154430.18593-1-palmer@rivosinc.com/>
* Collected reviews for drivers/of/kexec.c.


