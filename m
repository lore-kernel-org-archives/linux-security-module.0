Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF496C7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA37320659
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 20:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzQNWrBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfGPUcp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:32:45 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40578 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfGPUcp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 16:32:45 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so13235249vsd.7
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81NxWyaYYLOx3U0CNAY+vem2FwAQtGrb2n7o/OCCQ6Q=;
        b=EzQNWrBC5qDZZtG/w0lKikRR/oNojiw9cBTeaFyF+wRtC0dUeoMDAVmJAyqgyBzSEe
         NnHR+bKb6u1SnmKae3PIH+umXwHZMHtFajbm/8e/0FKjLrjds+MrgdBNWGVgxTk/yr6r
         a85dbUuIp7o5N3v/8tNZHHWO3WTJG2qgU7hh2JmzThDmC4LWVEqOIQxnLnkYtDSCe2ti
         5FQhqEyqvKKdQWNiHM1ecC46U6rAWhmCVAaC9TfrC8eScLAfgKAcSwq1bSAoiEmgzGkY
         v9jXDgZ1Ero5tUf69xUGxmjRwnF44LzOVHGe3Veh7QYw4fFvqvGOrUYAfq8zFdebhPQT
         bgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81NxWyaYYLOx3U0CNAY+vem2FwAQtGrb2n7o/OCCQ6Q=;
        b=HFFC81/w67YxIzOa88h9PO6MwP5qX07J9HSGIn+oghQOZdbb5PtWEp0+z0rxk2rYnN
         v8gJE2xIBlszZcMY5vzLOy5fu71Fzrsw9RF2t+y6SmVl61oCstc5v6H0ntjolTwE7g7E
         oDj6xLd+D/ZlaKmhpyC/evRPak6DtJ2cBnM8hhfO5BgHdUmhtDO2kuZO9GHOdDuZEPRi
         QxT1MyNTxS+s00IwUZrABRTqOoB0mutMWUu40w6Z4G3ya5us+PLHcN+qadhcB8Z1RdYC
         7XasK7pjuqmD15+AC3fh19swpOpRxWzS52NQlbZUlxPRGAGSkBjPXaVxnTly1q0AECuU
         xuUw==
X-Gm-Message-State: APjAAAVS6WBysivwUJmdSTgZQ0rlk+OwiSIHXdN9FL8js4VdRaj/0C+5
        JE55cTOtH2nSPZuRKg1YazJNIDaEAiqkBDk2l4KBq8HC4RU=
X-Google-Smtp-Source: APXvYqxQj6V0JsV1Wq1M4PK/ZqnLQAggZqvxwAWQtvoVxjTqMsgvXgRRn/MxQo0FX6SkSFdhHPKRHE9oRdeF58llyro=
X-Received: by 2002:a67:fb02:: with SMTP id d2mr12106614vsr.207.1563309164025;
 Tue, 16 Jul 2019 13:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-24-matthewgarrett@google.com> <5d363f09-d649-5693-45c0-bb99d69f0f38@iogearbox.net>
In-Reply-To: <5d363f09-d649-5693-45c0-bb99d69f0f38@iogearbox.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 13:32:33 -0700
Message-ID: <CACdnJuudpnaQ5YUhoxmxNWVdRB6v0u0Bf2O6NmYOXjp8_govyg@mail.gmail.com>
Subject: Re: [PATCH V35 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 15, 2019 at 3:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Hmm, does security_locked_down() ever return a code > 0 or why do you
> have the double check on return code? If not, then for clarity the
> ret code from security_locked_down() should be checked as 'ret < 0'
> as well and out label should be at the memset directly instead.

It doesn't, so I'll update. Thanks!
