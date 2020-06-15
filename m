Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F1BC433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2887320714
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 20:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBiEOdK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgFOU0q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOU0p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 16:26:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97416C061A0E
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 13:26:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g1so12487154edv.6
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=CquvhuXV8eGeejmw4Vie++KpEp3/WsF+43BVN4NO5qc=;
        b=QBiEOdK+4ixNdpWl0BJV/BQuGcytc3rlEG8bZSBiAzlWgD6+n3ZcqnbuiYQKt/M4GE
         il8MEm60/EEHdLBPBxTCwZ7tHEL7OWUso+jJMQwHDvpTA2zVVb9NeyG1L9gX3wquvJjo
         69BNXUutNZa5NTjANUJpe2YfZ/gq5dvpaqN+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CquvhuXV8eGeejmw4Vie++KpEp3/WsF+43BVN4NO5qc=;
        b=szdbND1yXhl5xbqkoZQrCF77rbYLIZpnv5bDEAEO1D/+i2UvLm9lwBSX6ynVKyoTh/
         5g6DX1eRZ1TjASvBaHpB9HP0yGUpU4VWktQqwmdrvUd4HxDe1nQ6qGjFeN26dSqki9bq
         xRnOfPSwreVvgy10AxF//M58oU3Kx8mXC99wU3k2Kiw6PHGzkQ6BFv2S/dp31V6DfIqJ
         cPQmp6JWuF7mRS3xKqfPR9unhJoj3NIl8pgOrqyvk0qp8OcOdicjPNH5cTa6qJaQQkON
         cJrrXYFBrpPS8vfWy01Oofg/1mkZ87CYEUaAZcFDPgd5mBHsPcR8vRKdrKRGOj08d8rV
         lzjQ==
X-Gm-Message-State: AOAM532jK66UHhJC33kjKoFNAe1hAUUjWxCWp8vhNJJSbrZEsbDmvJqt
        3aVZ6Sy/FhagaHyugB0Qk7WD+ZHqcGqXKa3eEa2DQ/Ta/80=
X-Google-Smtp-Source: ABdhPJzALm9LrhPFtkaq7P+laaKExSFZ7yxpO4WOY9MHB+EIcAmjmDP4C1p23vu33UiDj4P6RrtAUDoGYtRGfOs17jU=
X-Received: by 2002:a05:6402:b13:: with SMTP id bm19mr25943783edb.82.1592252804121;
 Mon, 15 Jun 2020 13:26:44 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 15 Jun 2020 13:26:33 -0700
Message-ID: <CAJ-EccP7W5h1dZ4PfmiiE0r7ngxoSrD+tq3o_P03XM55DK806A@mail.gmail.com>
Subject: Add SafeSetID LSM tree to linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Stephen,

Could you add my safesetid-next branch from my tree to linux-next? It
can be found here:
https://github.com/micah-morton/linux.git#safesetid-next

Let me know if there is anything else I need to do.

Thanks!
Micah
