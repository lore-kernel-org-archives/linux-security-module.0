Return-Path: <SRS0=ikEQ=WE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BDAC32754
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4095E21874
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3UXrNSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfHHAH0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:07:26 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33613 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfHHAHZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:25 -0400
Received: by mail-pf1-f201.google.com with SMTP id d190so57758577pfa.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RA/AzJFbqTTjRNhYxA2E49Vb11Ruh+1EJHlxTueWjTY=;
        b=X3UXrNScaPGXcZrnUuHWqeCsi+0ba/hy6lA/tcRliqPEmv+PCWNVtiZ5NkTmWRUfWA
         FYXYef5PqQjgWqrA3Vaq3/yl3c8J7zWfN2qotCd+nXliqQ0i2psj1dpndL8y7vdKF+12
         7Xdr5s9Ea5Ci5KdN7azDmW5TRUnbHfuG8I9c+AoBKB+RvTfY0yQYbFsWBLDqu3GrLghj
         K9sj1BzMDrefvide68vZUJ3BlYFn9ABSac6mhMP7CVWcsO7Jn6iE8Z3HoDCZh+hAhNYD
         b88UuaMB7nNjBacqWnqCnGNoSLoe+/NjjX1GBfsvhrMfYpU2PccJW3YGI9FjR6URUeMu
         zzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RA/AzJFbqTTjRNhYxA2E49Vb11Ruh+1EJHlxTueWjTY=;
        b=EdXd3slLJ9jlgWLc8/v3ri3GbymE8zsyQXUeNo+tajYeX/n11hU7cjQaA1c1H7XgJL
         LXK+z2D3vtSdc5WEC0a1KppMgrSFIn/Rr6rmoWDAf7E7n7oUYEoMVP1yCXwy7k/CDeIE
         uF8FVRVpGUhh7pHoO4qI0Nfag1k7Vv2Yus31H3Hidder58YU+KjqntwXHSnHk+C2ERpn
         hRvSrRZmYZd0j9xfQ4WH/lddMca2h/vOnviEUHA8lnukeC0WxVDo7LbO0cr8g/Tgxjmh
         zk4tNp56KcALdlipoNytEieGSQOXTZxqGDkrIGs0/87NuCtUHn/5Zv9clCst6A8t9rbe
         9yiA==
X-Gm-Message-State: APjAAAUrq67PBQFkM89ow0/ulFQ3Hjb1UTUb1obXFK6WFSIbjA99VpDw
        iZpbf5ceM7CmsjWJcZ3VLFkNEC82auUPiDl44l8R1g==
X-Google-Smtp-Source: APXvYqxt5HteYlNYSyG0H4Bdm+j8ER0YvN1NzjCzMXnO3nx4gpqpTHXi3q+FUGWL6wetdciOWJ3PzX6gavYgbpYrXeQlmg==
X-Received: by 2002:a65:6096:: with SMTP id t22mr8991690pgu.204.1565222844769;
 Wed, 07 Aug 2019 17:07:24 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:52 -0700
Message-Id: <20190808000721.124691-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 00/29] security: Add support for locking down the kernel
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixed an unused function parameter in patch 19, otherwise identical to
V37.


