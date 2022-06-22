Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE7ACCA47A
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jun 2022 06:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiFVGIz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Jun 2022 02:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiFVGIx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Jun 2022 02:08:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171E51CB21;
        Tue, 21 Jun 2022 23:08:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o23so10928834ljg.13;
        Tue, 21 Jun 2022 23:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=S7mjpK/M+Dj2QUAMVzQMxy95Nz35P2kWVi4qmBs9FaI=;
        b=c8zZsZw4yF2vD84Jltja4RRpT8reCc8d2zsGZN+JAw2NKxHlnoRrcjI9V34HOhYhrq
         yJybnHfegsg7hw3BdOmAgjmocK5GbfRu2BiUJKZUtSC7De/YGZoi+T0W5JtjTeHNAirH
         plrQKjHHERe62ewez8bYjDlUV46Cwb5hoaq6AXfSSU3aTs7xeQF3uwWQTSHmVSZf1aG+
         ztzA8kjRd6Zr5zX2pAmYig55b8hX5lU2YLFzj7beYA78qmjkgJ7E62dx08/9Jz5UUXVZ
         Pf0zQpKOjXk1Dg+Z59xiB10nXn53xZrq5mNNn+RJ9peIGLXbbdFjgNy4eDhPVI9DCD9q
         nGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=S7mjpK/M+Dj2QUAMVzQMxy95Nz35P2kWVi4qmBs9FaI=;
        b=Zcu3ykLrjeew5KQaXB3bOBkDLQFAxTbxBynBUApTgkTHhKjaUIQNCAUW+IaY7PaMCC
         AYQmx+F0A0Axalb1bNf64+hwVy7RM+DnQBc2mVnJFDPai8pKLWNCG6X8HfIOOXWkfEIE
         Jjsqj/CNn6b8MhHS9ZYr99ND3LqZq3GRnb2aRfVVRMo4r7iEBzjb/PnCxs8bOmRSEvag
         K1KlbhIOsGO8uMXOQIXPcgHDTfT4huQ0tP3SjoVhG0PR3DajSXWcwwAeVhtT9MBJcOjl
         1IGxiqPz+Z0/8t40TUJnVHRqtScSZ5086FXiVxCpBjL9FSaz2v4q/nnJqwJ3Imc5wHjn
         fIrQ==
X-Gm-Message-State: AJIora/1lcmhCUxsIrNqyhXIMgATKE1f1fXMVZ8zTXQVZdDiDuDlABbn
        3eiQhWb2VnhlpvJjR+h2WGnGitGpieb0pBxFWXozkLF8m/o=
X-Google-Smtp-Source: AGRyM1vrxPgqDsyEq10YQi7/hA0k/MFiCT6W4kGM/zAv7zqFDWew9S1J/2y1HFNsMJX+ZjPKyZrUt2lxRoprmaXzj2g=
X-Received: by 2002:a2e:a90c:0:b0:258:edc3:4d2b with SMTP id
 j12-20020a2ea90c000000b00258edc34d2bmr956668ljq.225.1655878130979; Tue, 21
 Jun 2022 23:08:50 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Wed, 22 Jun 2022 11:38:39 +0530
Message-ID: <CAHhAz+jSYb6=x89oFin=AHBrNhg_Q61YQvanb=2ZGkZBDiLyiw@mail.gmail.com>
Subject: Linux: Use-After-Free exploitation
To:     linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi All,

Use-After-Free bugs result in kernel crashes. If these bugs result in
kernel crashes then how is it possible to exploit this vulnerability
for local privilege escalation?

-- 
Thanks,
Sekhar
