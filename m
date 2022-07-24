Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65719C43334
	for <linux-security-module@archiver.kernel.org>; Sun, 24 Jul 2022 07:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiGXHtB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 24 Jul 2022 03:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbiGXHs7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 24 Jul 2022 03:48:59 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB312ACB;
        Sun, 24 Jul 2022 00:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658648915; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=D7QPHKnVbln4NvVF3VcPvXZvlTD7Slo8l7PX+TEAVNQhojIPVqTSnEy4kFhJPh8nqKfX2jAQsquG68M9HLSih9O0AF0aVjnm/NQZ1/ZgHLczGOE8i4dfzoozTK/AqXbjdWKn39C/hULXOJqX72xj8oGiWyrHWQKqnh3M6kw5jks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658648915; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0CMsPuiLvSHXtnR93pzVmo+ozRvtQTA4XOCT87ZUj8U=; 
        b=QNhIYp9mTvuQ/Nk1dUvoXzVnhz99dMjfEEAOUWCgKpkSkbd8N0ZsjrZw5/ovI3lOOrJ0sFFlozRu1Ofu0ePgtEruNLbfwg12pjOVXj5QTMIH113ymNa084ITA/EPYFMq+HryCRQKc1qdTqpqkZLrEOPcOI5XmzC2cl/Sj+r3cOY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658648915;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=0CMsPuiLvSHXtnR93pzVmo+ozRvtQTA4XOCT87ZUj8U=;
        b=QYyZRx9iRJC2IvBtaYqkqvdR3JXzeAlUeBhzwpLB2v9JET3S9ru79glKktT6diyr
        H0WcDq9b4hACwA86Zvz29IlpNy3kUSoHwd2qgDe/StQzxFTLEdvkaKYH2D4YRYBqDbw
        7zeGV7ZF+BHw4AwEorQmGLhVhw7X1ckuBtbp2qME=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658648902672458.5296544751634; Sun, 24 Jul 2022 13:18:22 +0530 (IST)
Date:   Sun, 24 Jul 2022 13:18:22 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Hillf Danton" <hdanton@sina.com>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <1822f2dbbef.8458d4be628891.5196957454517111607@siddh.me>
In-Reply-To: <20220724071958.2557-1-hdanton@sina.com>
References: <20220724052426.2504-1-hdanton@sina.com> <20220724071958.2557-1-hdanton@sina.com>
Subject: Re: [PATCH v2] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 24 Jul 2022 12:49:58 +0530  Hillf Danton <hdanton@sina.com> wrote:
> Given defunct serialized, still need to clear wqueue->pipe in the clear
> path as proposed?

I am not sure what you mean by this...

If you mean freeing the pipe, it is done by free_pipe_info(), which is
the caller of watch_queue_clear().

If you mean making wqueue->pipe NULL, it is being done so in the patch.

Thanks,
Siddh
