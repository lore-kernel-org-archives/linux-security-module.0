Return-Path: <SRS0=m0b+=VP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7988DC7618F
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 19:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4229E21849
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZlLOIpnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfGRToT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:44:19 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52431 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfGRToT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:19 -0400
Received: by mail-pf1-f201.google.com with SMTP id a20so17186416pfn.19
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xp3ecTtNAHqJkdcWL6adDos1ABQx+LyNLUf8CfzP0Ig=;
        b=ZlLOIpnLCtfHaZx6w871GqzN0rpps3Lcq5JfjC1eRGjrwwwT5MxgvWqb/P6BEB35rN
         zjxPUJQZ3aSvZ17nsDDa7y7D4Rk9VKu3Zqyd+kd51m7JC5rRPU5hsdYPvUgykxlHNGzJ
         stYJhevSns6B/W8PpwVW6GtgWwh8+JkYOS4jQqSua2bj35/ah25HZl79HTFfNe6cJKQ5
         AOB0IWe9NS2YSAwRfZxJjrN/3nRAGYo78ymvz8oI0VR/0ecse4yaWVwzqQPaY2a/qscP
         xk3tvF2NeIHGjXxbTP+ctWRTmyULD18sKhH0bI3SN79JVKy1EyuNQRoDlXvLksAvOX8r
         OEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xp3ecTtNAHqJkdcWL6adDos1ABQx+LyNLUf8CfzP0Ig=;
        b=f4UPrzT6kbathhJw+vpY74sRbOJIy5IsS8LRfC40uMg9KVxX8hemTseHYcqVBMz/Sj
         2rJgZ+OA5/ZEZEUPcPRYhaBCXDaxWDfkck1KUhWRUfFRaGaCoHpt+06LtK3bNNWikbPc
         lMQXcOv8VXG0F3O7XTbQhaBsZpIKbbAYwdsri9pAW0WziMXlhly2yZRkK4sn3G87rXoD
         OiB/vT4BOprdv1cqHqXRdizJjOuD93EoBuhqrcC0k1gwxHJR4rX6Ls0wH2EW0W0veEds
         DtDTBcuFxLr1fZfLFqmQsZyJ4WvW/xH5smKWbAmkl/ThkUX2m+d41qB8PA1rGrH3rm3I
         4wZQ==
X-Gm-Message-State: APjAAAV2mH6dCzt6UAh2nvFR0tY6QJXiFlxk+T1pK58xsSmNzp/P+zfp
        HC7ypYYMSSVp9BH63hWI/Xoyoxr9vN+lwjjzXtUjUg==
X-Google-Smtp-Source: APXvYqw6iv/IkO8z0G/6fsZ5m4780ywOZ7ifZyLtWG+ULLe0N+2yN/cFvlzzHlJh4YbfOFXsbIXh+DnY8DhO9Ne4F9C3sQ==
X-Received: by 2002:a63:204b:: with SMTP id r11mr9630785pgm.121.1563479058516;
 Thu, 18 Jul 2019 12:44:18 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:46 -0700
Message-Id: <20190718194415.108476-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 00/29] security: Add kernel lockdown functionality
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Minor changes to the previous set, other than a significant rework of
the "Ignore acpi_rsdp kernel param" patch to deal with the early parsing
of that parameter under certain circumstances.


