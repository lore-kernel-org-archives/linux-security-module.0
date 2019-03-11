Return-Path: <SRS0=1JdI=RO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DDC4360F
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Mar 2019 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F511214AE
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Mar 2019 19:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jnzq6KMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfCKTUZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:20:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38230 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfCKTUY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Mar 2019 15:20:24 -0400
Received: by mail-io1-f67.google.com with SMTP id p18so5090724ioh.5
        for <linux-security-module@vger.kernel.org>; Mon, 11 Mar 2019 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgiadYIru6QemLmL1/wWY3rmCAqxL3UBWIQeAnIyE60=;
        b=Jnzq6KMd1T9lf0cWn392R/dsbT3wN7YHKsBaJcPwmFj6g/5IGMczjKWWnjktBj7PmZ
         uRNZpWKPhmxbkNw41H5CAFFlersAOcfAoj4zzXP/S3CJ5R21fIPxR3Xs5AAk8rIUZ91q
         LqpgMM0dTOfBESvDv8XKTGQBHFMLDYgmxfyt2XaiENGVoG2UMIICtNhjZKa92R/oAZwI
         dhEZaylw1zNCTYBX6hWHGCQ4xN+EEPflE+NA+IQJ+Y+GOZO7on6C4TYrT5pzpsxpQX6v
         BRLXrk+X0fhZULtLIW5YlFaZHdYaC0suAaxtMWaoo1Z9MmDpQR2aJ4VOshJ9X6zkH37Q
         3DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgiadYIru6QemLmL1/wWY3rmCAqxL3UBWIQeAnIyE60=;
        b=YzSJybfUxNh1TPqrvvAybofyS06F1Mei5X62j6JlbElpBIqFIsRs5Bl0Kf5NxMt8Ps
         k+WRcxTFAFuht7rVQlPS1yz8yuHhgER3WJMD0peQNr5u3ESFA1Hh9jik4ylTc5sc41i2
         XWk1iT8BWWqM+pSyVSnijPWLbqOrgjHd7tLQjLHfy96WKidufZpYhRJgTbKAPQt3TOdT
         HMax5sPlC4axvugxtM25ZC7z4Fg4sMfU88o0X6d9/Wqv/gVE85IqizVrxS6Ephu/6igU
         KpK0wD6p0Wu38x4LNRJjAn4LoJFl/0lyTx7pPx1Yoo6mQkF58LZit5VHfKTSBH+2MAum
         cnXg==
X-Gm-Message-State: APjAAAXwNM7tKBdFopFIXqNHSR8mmetplNCs72xC8bphCgxNW73jvQLR
        ec//9mgxFSNOVX9832WYZXBJVMd5IGjM7qGV8Ek2ZJ3ebZE=
X-Google-Smtp-Source: APXvYqyYlyqTxbdAXsQhzh00O+rcLRcUUaDMzn5WxksfkGq2YX9xbsay3i0vkiyWe1DtXCoaciP9vysRnfBvuoqhY08=
X-Received: by 2002:a5e:950f:: with SMTP id r15mr3307807ioj.88.1552332023644;
 Mon, 11 Mar 2019 12:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com> <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com> <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
 <1552052377.4134.23.camel@linux.ibm.com> <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
 <1552323292.6100.45.camel@linux.ibm.com>
In-Reply-To: <1552323292.6100.45.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 11 Mar 2019 12:20:11 -0700
Message-ID: <CACdnJustD1fvBYsE=zHE85ZSrKwpArW=_jhRDyhDngdDRNOXJA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Justin Forbes <jforbes@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 11, 2019 at 9:55 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Fri, 2019-03-08 at 09:51 -0800, Matthew Garrett wrote:
> > Hm. And this only happens on certain firmware versions? If something's
> > stepping on boot_params then we have bigger problems.
>
> I was seeing this problem before and after updating the system
> firmware on my laptop last summer.  If updating the firmware had
> resolved the problem, I wouldn't have included this patch.

Ah, sorry, when you said that you saw this with older firmware I
thought that meant that newer firmware fixed it. What machine are you
testing on?
