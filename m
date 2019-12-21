Return-Path: <SRS0=UJ12=2L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65221C2D0D3
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Dec 2019 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3794221D7E
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Dec 2019 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0bEi+w/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLULD2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 21 Dec 2019 06:03:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35171 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfLULD2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 21 Dec 2019 06:03:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id 15so8998301lfr.2;
        Sat, 21 Dec 2019 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8wvoNTD0W8Mh3r1dJmeiND0yoDYzPWABA6vVSLjHPQ=;
        b=E0bEi+w/IjeutYlkNNykm2LuYWGb1kOYoOTRgoQvuTSi4DZY8fBrtUrI5Mg5Yk6oAZ
         ZHOpvJuJNrABS0H1pzxlmZWM6PdoKJsCUKO/tjcgUWeYUM2pu096sANiCJfu6rKYAFRa
         dzLeIV1i3LoTSrgzCFVS99vL0g0vYzxeTSsjBn7Svkjx4r4dYAmXiiNwfVqth4Au0/Kz
         j0pvLSaJpGKg3c7eLqX9XW9xmAavidkkMzEq1f55sbfw0zPW1oTeU0FpznVqAPtpzrXD
         +14h9DnNOG9g/GeTM6umYRezqJS3r0tyyqsFe0fjp7agv+JaPclKdRVO1TL2n0FyyBD/
         BOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8wvoNTD0W8Mh3r1dJmeiND0yoDYzPWABA6vVSLjHPQ=;
        b=Ay6CitxG5FQVVOYfjViBtWE4jzRsuLXOKNLV7Xe+B77uSfWu7b3KV55ISaZAW2WvIx
         VJOn+6Whxhyl01ViSmwhJ0WZCVNZbA1dXGXnXJk72tBIrsnDsPyIEewZNJb1ro1ueGZ9
         PwqcrgZWkU6Qlirv07Z01mnqx2MC67ABF0YtW1fzr3M5KZjqgFdiHo69vXK8VImJG+Ww
         POa4TZ/Yz2mRyeozSXdIPuKyth0niHmeyoqmR5ZalCWVwoQeo83LwbfDrTZFhV4suvI+
         m3DA20jMV1T1eoVbGCz1juFbTszGJbxE60wdXlXyZEaG9Xj5CqyuDNWf6hcx7yk8VuNe
         8VRA==
X-Gm-Message-State: APjAAAWkqBYz4PoiVcscLn3UEcaHKcT5AChmxoZ7gTeEN3jBZ7Sni76W
        UYFhGNOfMNGZOvGQice89sTqJQZHcewwLRQEgke3LA==
X-Google-Smtp-Source: APXvYqy+cjTvEL52irzzFC/g87uyz5MBzbe8j7DMhCWXF3Qh7vS5DveaTa7jzNo5fmSrT/bvMZH4YTmOKzENlzd3VnA=
X-Received: by 2002:a19:c1c1:: with SMTP id r184mr11986347lff.128.1576926206056;
 Sat, 21 Dec 2019 03:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20191220074929.8191-1-janne.karhunen@gmail.com>
 <1576850665.5241.52.camel@linux.ibm.com> <CAE=NcrZUyLe1Ftk5wOuEMJBPnw+DBx9LACbk1JPJcpg8VdDiJQ@mail.gmail.com>
In-Reply-To: <CAE=NcrZUyLe1Ftk5wOuEMJBPnw+DBx9LACbk1JPJcpg8VdDiJQ@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Sat, 21 Dec 2019 13:03:14 +0200
Message-ID: <CAE=NcrY1aAriy7XRGODnQe9hiVObSrFFe7PPE+5drgMmnqTQpQ@mail.gmail.com>
Subject: Re: [PATCH v1 - RFC] ima: export the measurement list when needed
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Dec 21, 2019 at 12:41 PM Janne Karhunen
<janne.karhunen@gmail.com> wrote:

> > Should the kernel be involved in writing the IMA measurement list to a
> > file or, as Dave suggested, this should be delegated to a userspace
> > application?
>
> That is a good question. I went this way as it did not feel right to
> me that the kernel would depend on periodic, reliable userspace
> functionality to stay running (we would have a circular dependency).
> The thing is, once the kernel starts to run low on memory, it may kill
> that periodic daemon flushing the data for reasons unrelated to IMA.

Besides the dependency, I think the requirement should be that we can
survive the basic test of 'while true; do touch $RANDOM; done' at
least until we run out of allocated diskspace. While arranging this
with userspace flushers is not impossible, it is order of magnitude
more complex to do correctly than just letting the kernel write the
file. Even if it feels somewhat unorthodox.

Above patch survives that test case with 3 line addition via a
workqueue. Once the admin points IMA to some mount, the above test
case (while loop creating files full speed) will run a long, long
time. Effectively this is really just kernel doing its own memory
management as it should. Flush out the dirty pages you do not really
need to stay running.


--
Janne
