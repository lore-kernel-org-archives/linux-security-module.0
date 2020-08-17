Return-Path: <SRS0=ORYe=B3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B09C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Aug 2020 21:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E73C2072E
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Aug 2020 21:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmmwQZfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHQVKg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHQVKd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Aug 2020 17:10:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA4C061389
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2020 14:10:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s1so5976412iot.10
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2020 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9EHgQ35aySRkSWoSC1c8YoXvxP+pSzRq6wKj/4IiByU=;
        b=nmmwQZfsGfkcsu0U0Ge/azJVsybIs0DClANORjcuXseaUqE7xU+GmjDUWh/r3evgV0
         iCf4N4rUJ/lHnNv1sezXrO6BPt99zGhlgtbI0H11Du2J8TpbpWF15LXlQHfv0wVdyput
         lK+CBcoR8bkNtpNTY9p58zgpDkX4+O1osLkhB8U+7ipxNJuv95p1V6OODqVobJ4ex1Cw
         RS4dyyB0lbeb/bFYHWzhPaSPZ8CMOdoZz+osDuSeK7iBn3eFo0CWcKuIdexNMPX6rtZq
         DTQlaCU0W3DBG9cAz4hoMbKSurjuASDfWtAHe8HK1afMuQ1n2GoqFAB/exU2/c5Bzt9C
         uq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9EHgQ35aySRkSWoSC1c8YoXvxP+pSzRq6wKj/4IiByU=;
        b=N4g+SybWpKyBmgxjmpGUCg8zZRsrsGNckOeHzw9ahoM3NteS1BQgU/gVIiuMbyPshN
         KNDb/H8Nsk2gHFQAbK1j1L9JyVMvuvylGYTXE2L9KnxEyAtNOQ6whXwUojE6GK5BjK7l
         CfimmvkPhqUY2cTSmoTEEp3Inj4gEr/va2Fw1Y/CfFccnzUPEmsov+kEzRXNt8Rr0uX/
         Ab8ZrVwHMiFFCDFja7RhlJb+Achqmby6e5dyizS4apKbvrRPFvAhD/GJp9tmRYi+Sb38
         1bYRpwFEaPzviP7M+x4snkhQe6ldlxqyEJtRb9uNAe4BB6QqGxxHPnrVpdBeSlGzjT68
         e96Q==
X-Gm-Message-State: AOAM531/v2KP7p7iivXcgUg/odIlt0uWNenYaz7D11MJDK+F8E5jOCP7
        7MrHchVzyZPlfC8SSdvEdl7jggctmoR9W3ya2bAOGQ==
X-Google-Smtp-Source: ABdhPJxiFq3B8jlTT9x7nauQdsmNfihA1P3qjy444B4xcH0rdSqORKjG5/PBTkWaTxe+K+cHUMN2/QSg9zhjmrkuP9c=
X-Received: by 2002:a02:c84b:: with SMTP id r11mr16265122jao.66.1597698631501;
 Mon, 17 Aug 2020 14:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200807224941.3440722-1-lokeshgidra@google.com>
 <20200807224941.3440722-2-lokeshgidra@google.com> <20200807230225.GW1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200807230225.GW1236603@ZenIV.linux.org.uk>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 17 Aug 2020 14:10:20 -0700
Message-ID: <CA+EESO5kDbSCcpzxij6M0aWXqKDyFds+azksQFrXES6ACzTFtA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] Add a new LSM-supporting anonymous inode interface
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 7, 2020 at 4:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Aug 07, 2020 at 03:49:39PM -0700, Lokesh Gidra wrote:
>
> > The new functions accept an optional context_inode parameter that
> > callers can use to provide additional contextual information to
> > security modules, e.g., indicating that one anonymous struct file is a
> > logical child of another, allowing a security model to propagate
> > security information from one to the other.
>
> What the hell is "logical child" and what are the lifetime rules implied
> by that relationship?

context_inode provides the security context required by the security
modules for granting/denying permission to create an anon inode of the
same type.

In case of userfaultfd, the relationship between the context_inode and
the created inode is described as that of =E2=80=98logical child=E2=80=99 b=
ecause the
context_inode (userfaultfd inode of the parent process) provides the
security context required for creation of child process=E2=80=99 userfaultf=
d
inode. But there is no relationship beyond this point. Therefore, no
reference to context_inode is held anywhere.
