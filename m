Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D5C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9CC60E78
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 09:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhKCJ2N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Nov 2021 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhKCJ2M (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Nov 2021 05:28:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95636C061714;
        Wed,  3 Nov 2021 02:25:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x1-20020a17090a530100b001a1efa4ebe6so1332996pjh.0;
        Wed, 03 Nov 2021 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=g4AX39dCBvYQienKQDyxN0jAYne+Ve3lwZzCPu1W3gU=;
        b=PH53maJ5OzwSihtLJU7h5t4zhY047RlVK/GmR4RjwFn/p3FMRFVJohtvBP26G7B2Gq
         +xEXvuXZYBWIcuDKedvJ3oNuoqsetU8hYb6iP5D7AEIokjuOUICVxE3dNh8zt3C/fDb5
         NdQm0EFW/GeMzm8K+6oc+H9W5ZmDECBYXcjCnpgAs3WpslyjRrT0qhwPo0loCZkBQ7pj
         9DphuE8vYrbud0axLOd7LMjAsL5O9qDMeV6QGc8yBRzaK2bL8ebssE7cwhhtF54qGJE6
         NnbLBCarDh3ZOUU6JsFSquXyVATFJ73fu0HrJ42xOrM58ku6ZeG0vNtZhbaAU0jPTFa0
         etxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=g4AX39dCBvYQienKQDyxN0jAYne+Ve3lwZzCPu1W3gU=;
        b=IdeA4EfdG4TzLkHuh+VKeyfaFGe3wHfmUSbv3JtZ/DPICA5/be3iErTKTpNqSWPPx+
         Au4HOgz78LKDjIiOxUfu/X68JJvxggvIyngVRWY8LlncUpQMcIFHJNBqqY1ofwPK+fqh
         b0O+PO2gIvBbkd7l+ViZ5zmMKA8eCdru6RHzoi0dFiPOUqEgycZhgcCeLsaiwIaS7Zh5
         7j+hPWMS8eLlFz0IBR/hVG6X5hojNgLgLmvyc5J31x1LhniBeBAieRsusY9tOgGId8jy
         M1Rg78tlivwyjXz+KGEuvp29+Mu0h9vRwL8f4QgtphMO5EwkVlbRja7lBTjfVu0vLmoz
         iolg==
X-Gm-Message-State: AOAM532TZ1Yifewv1mKm+jy6cKZuKdAQnC2DzyoghVreVWxKPJ1bzdta
        kc+bNph53LUafcIsfWyl7iSjfqpXGzNv8g==
X-Google-Smtp-Source: ABdhPJxnpA5cJ54pRhjLNeqJbCTqdjZLA25xFnnMlXbh0/ElSQhiZvurWSJt7+c88DULYM5IMRRNSQ==
X-Received: by 2002:a17:902:e548:b0:141:f4ae:d2bd with SMTP id n8-20020a170902e54800b00141f4aed2bdmr15976636plf.41.1635931536157;
        Wed, 03 Nov 2021 02:25:36 -0700 (PDT)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id l1sm1416738pgn.27.2021.11.03.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 02:25:35 -0700 (PDT)
Date:   Wed, 3 Nov 2021 09:25:31 +0000
From:   Austin Kim <austindh.kim@gmail.com>
To:     john.johansen@canonical.com, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austindh.kim@gmail.com
Subject: [PATCH] apparmor: remove duplicated 'Returns:' comments
Message-ID: <20211103092531.GA25721@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

It might look better if duplicated 'Returns:' comment is removed.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 security/apparmor/procattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index c929bf4a3df1..fde332e0ea7d 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -21,8 +21,6 @@
  * @profile: the profile to print profile info about  (NOT NULL)
  * @string: Returns - string containing the profile info (NOT NULL)
  *
- * Returns: length of @string on success else error on failure
- *
  * Requires: profile != NULL
  *
  * Creates a string containing the namespace_name://profile_name for
-- 
2.20.1

