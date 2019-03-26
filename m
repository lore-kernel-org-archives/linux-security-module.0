Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D3FC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 05:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FD820828
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 05:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IO969YHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfCZFaf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:30:35 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:55417 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZFaf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 01:30:35 -0400
Received: by mail-it1-f179.google.com with SMTP id z126so17649693itd.5
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuH+jwjS5cxwDT/xNLxhJ5pir6EDS0bIdJPjuQU8hFI=;
        b=IO969YHXXlIkOavbhgpdXJcHCP41hNoIUHZdqWrXfigEa3w9SeIADfnSYDnkaveLDJ
         IB0dhMIW6JTzg4p8CCP/6VoK8ogV2AGbuxd+hadkXikQTpu/H5sizJnCS0A0az5r86Ko
         FigaEBa0PR8MRcHCyW+LrJycRHk7MPrOQHAQsDMK3xr2TckppWyWWf7ylFWU63ySUl3a
         Yaplgg8a9QNGaBC0rYnc8JGQcQbthw55ZIp7YHhZD72xKte43wULEv5cgLLu6WEMqT9d
         364Lo1t6ybjmjH8GWDdek42zqhNnauVSfUTj6xnfKJ6sBOcxFW8FF4bKQVWqGG3Ajavr
         3J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuH+jwjS5cxwDT/xNLxhJ5pir6EDS0bIdJPjuQU8hFI=;
        b=FImOxXL7I8yiTcsUs6cQyU9rk7WK+AzB+G8acAeMnPiGXL/JZFl97pdEGnpl/ysIly
         6Hfiyv9D7eHYKGnnL3kOYKIxnxrSgIAez06UnqlW8mf9XMFPypuREvNprTuxT0ZlvQTK
         VFKUpOWGkaTdeUfFYRkeAP1zcQsbqFa8V/IjMv9zR9TeNc56Niy+SdBzncWNC7RZDr/o
         Z4eGgenQ7L8lEqYvPR+X1Fyx4nlz8PEZ1fZLONkFpsqUDw1683VGx+YdA6NnGCs1AUdp
         iyFcHB5jfrMxWxB5LtE8yd5U0riNzbkt/6rMI3C0q4iyFEzfpsf4E/jETLsZAR2SqL8j
         WLww==
X-Gm-Message-State: APjAAAWBh+9VQQoL3lTeO+nFCgyf+6KkQWnOy8t5NgGgllqIfnkJKTKN
        /e4m2tuoYmvBvhJi10svTcPmnD6XazWl6GhI4cm3SZYPdRU=
X-Google-Smtp-Source: APXvYqzRHuzogaTO46QNWh8MFo6g65BIaLQQAaa//RC/dJ24jO0pFcboABgTsjDuqphJ2xLzOiykl7GhczqxpRqHM3s=
X-Received: by 2002:a02:b38f:: with SMTP id p15mr3491360jan.103.1553578233952;
 Mon, 25 Mar 2019 22:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com> <20190325220954.29054-2-matthewgarrett@google.com>
In-Reply-To: <20190325220954.29054-2-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Mar 2019 22:30:22 -0700
Message-ID: <CACdnJuuEUBRABkfX_DhBg67CWr6zKAu_ZvWYq3kN52GTemrdCQ@mail.gmail.com>
Subject: Re: [PATCH 01/27] Add the ability to lock down access to the running
 kernel image
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Based on Andy's feedback, I'm going to rework this slightly and
re-send tomorrow.
