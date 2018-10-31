Return-Path: <SRS0=zj7v=NL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DBCC0044C
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Oct 2018 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EC72080A
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Oct 2018 21:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ilHMBI0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EC72080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbeKAG56 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:57:58 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39571 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeKAG56 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 02:57:58 -0400
Received: by mail-yw1-f68.google.com with SMTP id v1-v6so7124831ywv.6
        for <linux-security-module@vger.kernel.org>; Wed, 31 Oct 2018 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5axIjytaMbxnu25zAi9l7i95RCxMhdFWBZLfHCZvB1k=;
        b=ilHMBI0xrp3OjTVXIggn9WAp7vtlcAdzcYi+KZKxaYauus9sTH28THI6yLJPO2bW3v
         4cWBw1JS5PnjR3vzAmUsWDZATE2gAOXTT2h63SnYp/9M08lNkofZDow5heMEosOFb3NQ
         ofsUZADPgX/QcpZbqGDi4Z2PNF/DJptB5bNb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5axIjytaMbxnu25zAi9l7i95RCxMhdFWBZLfHCZvB1k=;
        b=uLCv88g5bhZeezyTivbG198uaXe7rOzWzP6GuvP7bg4KzUge3v3jcNZBkbbqk/vAef
         vjt0EKD32xvtp0/bDTlLWFqz8zLj2XCMS7m1PfituXwjMl1XvuCAp+oqlXXkh0rC5aql
         Vzh/4GKn6feWsAnfJMcNfH/e+LhUxwf40TdMuxK2A4MBHq8nWV0BDSMY2mZuIoZaLFzy
         +P6vadbAPMhR2CGvCBwcM6R0ktg3eSBHStuhQYpqzYKjENvSKYVH+39gpeJXkAB9XysE
         FOBw+YgE7W1opwkBmvqQ955ZWmQ4iOEmgw0d45PFNuVxXM6QdfkumY+gQovqFQoa44zB
         YZzQ==
X-Gm-Message-State: AGRZ1gK2Q+HX6WbUi9G28t+VbmDZZ9iMy+QacuXyTX3BMMRKnohpX8dg
        rSpKtBUWQ2zKbaL+qAl0RFiER+EjoDs=
X-Google-Smtp-Source: AJdET5dSK+4EWOhTuQJ9lGfW79avn9hHB26/OPSyQDRDdGZvbfAiVmwZF517bOAm2hwC7URaMhUsVw==
X-Received: by 2002:a81:4415:: with SMTP id r21-v6mr4956422ywa.393.1541023081726;
        Wed, 31 Oct 2018 14:58:01 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id k85-v6sm7008673ywa.76.2018.10.31.14.58.00
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:58:00 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id z72-v6so2860251ywa.0
        for <linux-security-module@vger.kernel.org>; Wed, 31 Oct 2018 14:58:00 -0700 (PDT)
X-Received: by 2002:a81:2953:: with SMTP id p80-v6mr5101501ywp.407.1541023079901;
 Wed, 31 Oct 2018 14:57:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 14:57:59
 -0700 (PDT)
In-Reply-To: <20181031210245.GA3537@mail.hallyn.com>
References: <20181031152846.234791-1-mortonm@chromium.org> <20181031210245.GA3537@mail.hallyn.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 31 Oct 2018 14:57:59 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJN4Z8RiweDjRTpEbhVsb=js0N2-w1Xy12o6nrkZE9gwA@mail.gmail.com>
Message-ID: <CAGXu5jJN4Z8RiweDjRTpEbhVsb=js0N2-w1Xy12o6nrkZE9gwA@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 31, 2018 at 2:02 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Just to be sure - your end-goal is to have a set of tasks which have
> some privileges, including CAP_SETUID, but which cannot transition to
> certain uids, perhaps including root?

AIUI, the issue is that CAP_SETUID is TOO permissive. Instead, run
_without_ CAP_SETUID and still allow whitelisted uid transitions.

-Kees

-- 
Kees Cook
