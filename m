Return-Path: <SRS0=dFet=OK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D14EC04EB9
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Dec 2018 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E595720673
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Dec 2018 15:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugqgiuc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E595720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeLBDCg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:02:36 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:35070 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLBDCg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Dec 2018 22:02:36 -0500
Received: by mail-pl1-f176.google.com with SMTP id p8so4309245plo.2
        for <linux-security-module@vger.kernel.org>; Sat, 01 Dec 2018 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0pRyXwOZ2cigwEQ3KT39MABx+4BBdOma+OwtuHTOIoE=;
        b=ugqgiuc9q0IsfBipgE8sHtBLIx3hNTCUY+WxJUgLBiGdGXm/RnfJ2vQdqR+tnFbDmp
         HYbvPsLRggN1Av9hijIjae2N6YZUj2r3lTbdXifAl3xboRrhMEA7sTcU8vJON6UD24VC
         jEPBOt7dmylE0ksDwiG9Voav9J1E4byvtZS4sMDDhEa3YP1mOrWM6M7a5HUlb1ZcSfhc
         9GP4SNPYfaIx2dHX48Do5++WVp+IZgOBBkTzN6HHIyNbOQacWkrBJYfhjbV0rj+QRnao
         0HfqF0IuQ6DLWgcoHu9KkRiV7vhUUpuB1hc7BQ4wHSRuzh7f6jLdxcqeGU8CnQL9JGw0
         mraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0pRyXwOZ2cigwEQ3KT39MABx+4BBdOma+OwtuHTOIoE=;
        b=U96RP8c9glfOyxM7s0FOt5VNthUs1ROnGSkE0hdsuKCWx1zeiDiNTExbvDUs5ZCE+q
         ZXWn9aXmivEINhAayrlQD6dffJ11wN8RU9WSNH88E3vDIH91WX9aYIq/OcswFplMP2yQ
         jlsKYcBDFkAO0d1B6NN4rXjib/II3Q162QaH1dkCAfHNPQnGoWuxUoOdjoWoqoF8Kgl+
         hHXdioeuuUEL/SZ0aRrYIWjuUwMDZtbL0SHQc+sQqSTTgyoPfna2sdAwLzvgUzQ5BXvO
         VmuQCoTd88lEdOHu06ysqBP93PQVVMvdPXb9XKXlscU/YpFhQoSR//PlXxBOsFO+dspy
         fkSQ==
X-Gm-Message-State: AA+aEWYArfecWULtVvXGAey0CfaR9JkrLoVkpvwwwpmPf44dRBjcsLti
        mqiDkmAK0t4yqpoVwURwYjUwFId/oiYejOrYkMrPkLTh
X-Google-Smtp-Source: AFSGD/VwvZyRc58jY/fF6INFYOLSMlxzdXobpzRA2gMFVdGSPcrYxmZty17g3zijlDpa6J4z6H0J8smAy/68aV1UPsI=
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr9804460plo.210.1543679387994;
 Sat, 01 Dec 2018 07:49:47 -0800 (PST)
MIME-Version: 1.0
From:   Tamir Carmeli <carmeli.tamir@gmail.com>
Date:   Sat, 1 Dec 2018 17:49:12 +0200
Message-ID: <CAKxm1-F9XOExo0F1QuR+ekHkpqCi+BVpMyAVRGN26t=Q1McB8g@mail.gmail.com>
Subject: LSM hook for module loading and unloading
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,
I believe that this is the right place to ask the question, but if it
isn't please let me know of a better forum to ask.

Is there a reason why LSM hooks for kernel module deletion and loading
don't exist? (for delete_module syscall and load_module kernel
function)

Is there some design problem I'm not aware of, or whether the
necessity hasn't come up from any of the mainline LSMs?

I'm considering to write such patch, and I'd like to hear reasons for
why it might be a bad idea.

Thanks.
