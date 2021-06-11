Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF2C48BD1
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Jun 2021 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A76F6124C
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Jun 2021 17:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFKRZQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhFKRZO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Jun 2021 13:25:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F246C061574
        for <linux-security-module@vger.kernel.org>; Fri, 11 Jun 2021 10:23:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k25so5620611eja.9
        for <linux-security-module@vger.kernel.org>; Fri, 11 Jun 2021 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzkhQR4zj2j9hClx4qSj3DSk3XkJw57raw7U4YCqfCM=;
        b=U2frkNF0K/FlqX1WkHWwlRnqAMcYLf8zEeUtVCqb3KE1JE1NzKF0vFh3ERUIwk2n++
         Oo0k3X9VcxVDVZ7OJyQb8XGjZVXyoFz/ciRqqIHnPqNFyF4uryTELkx2kRkFG+PDzpOH
         ugWGsGFPNO5q16y7J/G8/SQTgC3+GKDSUp4YaYMBoWexhJYxCDZkh0ovHJhSafllWgRO
         GQ4chkWYor0fRoI2e9sWbMcXD/QS7tFP0Jt3dY55AapfEO9ZnjUkP2Kl7YgYq0Aivs3a
         Z8KpqeqRaKrnUkm6v1vjRyVKAQfdmA4+ozRaq5k4KMRhG+kVkz1Q1mtYeZ98sqoOGJSI
         V2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzkhQR4zj2j9hClx4qSj3DSk3XkJw57raw7U4YCqfCM=;
        b=GfpU6KyYB81XNkf0H19PWgIx3+q1K2VbV5hvG38eASzZeCFyaBVbjTHMUR5KyYZ3QJ
         oSpP2ud9T5RPqwhuPSxTZwx0c5L2Bi8m6O554XsCLzI7uUoLnkeolynIC7HuhFw6i2M+
         p84H9qVU0AjJeVZTWWoPJ5ylGoJpQC4Q6HBsG9TP4HBiObwOJAkgV2EN52RRWaUKnhNc
         JLY+RWsLbWCMOyCEUmAxaeffIys8WMy/VT/IN0QXBmA9Qk/9tYtZ5FrPRXcfm+Q4LeDh
         1jJ41oXEn0AQ7iYpRmdPHS5LHWOCO1lKKmXsX4U2J/6bfpVUhfUQnEnrIcyK/9J1TFHA
         sm+g==
X-Gm-Message-State: AOAM532V0ldY+iGj7c9HsCTNpGfBgmMkx9QVa2EgflyuicUw2jbD3w+H
        1obtnfKhPImDYwnIMdwDLpWaCZoxUDyeSw1OOCYv
X-Google-Smtp-Source: ABdhPJzai4y37jLuVr7Y1UpUR8ztAxvH8hM/u6AmWg96iF9OzzxgsicmwMxu6GLIo5jiIh6IsoiyoahG/pIqtUX7Deo=
X-Received: by 2002:a17:906:1113:: with SMTP id h19mr4568382eja.398.1623432194550;
 Fri, 11 Jun 2021 10:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210611022835.GA1031@raspberrypi>
In-Reply-To: <20210611022835.GA1031@raspberrypi>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Jun 2021 13:23:03 -0400
Message-ID: <CAHC9VhQvq0uimX+S+M-NJfz=W-1-G1QY96d79od=1X6UYYKUKA@mail.gmail.com>
Subject: Re: [PATCH] audit: remove unnecessary 'ret' initialization
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 10, 2021 at 10:30 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> From: Austin Kim <austin.kim@lge.com>
>
> The variable 'ret' is set to 0 when declared.
> The 'ret' is unused until it is set to 0 again.
>
> So it had better remove unnecessary initialization.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/lsm_audit.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
