Return-Path: <SRS0=y35J=WQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1885FC3A5A1
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26ED22CF6
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUH1JVMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfHTASL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:11 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:33308 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHTASL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:11 -0400
Received: by mail-vk1-f202.google.com with SMTP id l80so2379802vkl.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VwF/91o4aMHrQL5QM73+22fSApAs/2NiXgYkaBxXzFM=;
        b=CUH1JVMihclalX5q2seurV8HS9Qtk8nNORqI67CyNzpt8f4YKj9PsBh2yhEiLjpN0N
         Fknxxgr4PJdGVml+Jh2OhZg5E3JvdD0eGWvF5Fmj48bmwNl5sWVh0boqVtCTRu0mQHas
         1xR/eyrBcny62z5z0RXhFDmY63lItRvyMCbNrGAku/YYgZEVoLwuK/uqG8c8z1Py5OSr
         A6r1/J/F5nwciw7FJDr6x0eGnjeLDqYrBnU6tU/LRSjombP6Ii7IjYs4x7MFqzCatoKk
         c5ORjqJyd7wx6vbPsu0EDtwg03Dm+tZqvDQMHo7P8iZ7nhjRLYSJI6ZiO9T9s7fsnTfy
         eFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VwF/91o4aMHrQL5QM73+22fSApAs/2NiXgYkaBxXzFM=;
        b=C4E2e/8tT9xdgNdKVPiuKCDS0GwX8a7NGYOUeU7zWmrZSeOWUAOtDMN+rrNvpSP+gx
         zqycNYGDw5pTnV8a10RMYWSqpvNrTkHE0+G7yt4vemt5hRI3zXOJuWHXWfG+j0tM3bMf
         RIL2IQxTRKmkx9QMVLigxo8nPVNoIAHkp7f3cWFyhEFMZeNHEfp3YLBT8i2TWSMCFktQ
         Dx1W1PYAUwhoQQNfN0FLUp3bK4g3Hqn6PRM2TzMWPSCfP591EkE3skkfuKiqd3yUwOjH
         TW/HZFf9Qoj0X4y+T7OzW7iGdxvLS1VM+driXOMU7ssOjeUU8c5b313LR54rbPOzvFba
         Kf1A==
X-Gm-Message-State: APjAAAW9zYooOGA5ipJAtU58iq0ttpqTUI5zY0+YAQkEqCIqR28GHc9G
        TYzD7kJu0xiFpaCwzr3mfLoIG+U0YM6puiwp+n+YDA==
X-Google-Smtp-Source: APXvYqz41WMqs6ZJ50zP00x9Ki+LU6ocf63OApf5Deq/yukX6RTwToHjUAj4ZEXRYb662kA7qgoSvA9acMVNeIZGiXQafw==
X-Received: by 2002:ac5:c801:: with SMTP id y1mr9262710vkl.41.1566260290111;
 Mon, 19 Aug 2019 17:18:10 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:36 -0700
Message-Id: <20190820001805.241928-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 00/29] Add kernel lockdown functionality
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

After chatting with James in person, I'm resending the full set with the
fixes merged in in order to avoid any bisect issues. There should be no
functional changes other than avoiding build failures with some configs,
and fixing the oops in tracefs.


