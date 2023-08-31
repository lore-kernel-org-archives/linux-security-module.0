Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B37C83F17
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Aug 2023 09:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbjHaJUI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Aug 2023 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjHaJUH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Aug 2023 05:20:07 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041E0E7C
        for <linux-security-module@vger.kernel.org>; Thu, 31 Aug 2023 02:19:44 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58d70c441d5so7128527b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 31 Aug 2023 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693473573; x=1694078373; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cbrhq38paxu0xySM9f3IPWoiWkUTnk9D5gKI2jM47E=;
        b=6ChA0ZmY6HfHM/+kUAZQ2L9jhyeL9HY0g46tbWHzDMypPE4knP9/Vr94oMZYfpccMn
         1IZT8hYX4W0tHYbMSh8EsALxNpqEABKlS5nMdPNVKY8W4sJA8JS7mwvoBrd5kFB++6+N
         E8Ji7eUFqzs7vIuvSh52NkP/yfVWn0qDUGaWmdkmF13K6E0OU9tWQZ0zpcTy1+Z6ZDrL
         9iVE4vOg+VSqzZLN5Dr6jl/QAk2yLp+e4V0ReqCKpdL38Hyiy61zlGkADa+m7JBkwblp
         zPnmZqHgEtq0bMX3IvYLAGCzyqqCFQ+Y1w2Bzy2gtBfL4ddJUzfcX3FbJqem5/uGzms4
         GhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693473573; x=1694078373;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cbrhq38paxu0xySM9f3IPWoiWkUTnk9D5gKI2jM47E=;
        b=SoAl6jVQnUCVdOhD9w6Tb1s2XB4W6O2t5oyQo+R7nT7SEY3qUuyVDZUfNKA5kwNE4Z
         W/FT+o3rszrXN/R3anLhL4Ou9ZHI66DAFN6loUh0W0WD8awDAzTdo6CxETde0XoeGBSz
         ZweN4h90EdnTBc8KJuRKSX5kxOYj+CiPJNFVv/IjAp3zvle8hCgyb/UgQxCWdG2SOzn4
         WN98JaT5tupoK8JM8imuMDobMkwC0vYbo1zCZj9U/P96CatBU+2LgWLOn7/4v5IFASV9
         qkIQtUKmOyghsucoh8yMpxxuidF6rsCFbka+CxsfjuyXfFwcx2FBpsRDXVdt9Nr6WNQ3
         TJfg==
X-Gm-Message-State: AOJu0YwBcgQfCZU8pakcn0Ppa6YB3LKbyTuvOyu1UaSF9AnOWqFx/rPo
        h4k6OYFWzajvdnQgd7BaIol7dT0UMMrbYFQLyMX2hw==
X-Google-Smtp-Source: AGHT+IFThEVwm5PdQ/QiEIcAo8WglpblQRWl0MFWrXvjJuNLD0Kr5QEj6RbRV7hyCCkRaORZMOKarA==
X-Received: by 2002:a0d:c483:0:b0:592:9236:9460 with SMTP id g125-20020a0dc483000000b0059292369460mr4914737ywd.31.1693473572920;
        Thu, 31 Aug 2023 02:19:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i185-20020a8191c2000000b00583e52232f1sm293607ywg.112.2023.08.31.02.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:19:32 -0700 (PDT)
Date:   Thu, 31 Aug 2023 02:19:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Paul Moore <paul@paul-moore.com>
cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-mm@kvack.org, linux-integrity@vger.kernel.org
Subject: Re: LSM hook ordering in shmem_mknod() and shmem_tmpfile()?
In-Reply-To: <CAHC9VhQr2cpes2W0oWa8OENPFAgFKyGZQu3_m7-hjEdib_3s3Q@mail.gmail.com>
Message-ID: <f75539a8-adf0-159b-15b9-4cc4a674e623@google.com>
References: <CAHC9VhQr2cpes2W0oWa8OENPFAgFKyGZQu3_m7-hjEdib_3s3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 30 Aug 2023, Paul Moore wrote:

> Hello all,
> 
> While looking at some recent changes in mm/shmem.c I noticed that the
> ordering between simple_acl_create() and
> security_inode_init_security() is different between shmem_mknod() and
> shmem_tmpfile().  In shmem_mknod() the ACL call comes before the LSM
> hook, and in shmem_tmpfile() the LSM call comes before the ACL call.
> 
> Perhaps this is correct, but it seemed a little odd to me so I wanted
> to check with all of you to make sure there is a good reason for the
> difference between the two functions.  Looking back to when
> shmem_tmpfile() was created ~2013 I don't see any explicit mention as
> to why the ordering is different so I'm looking for a bit of a sanity
> check to see if I'm missing something obvious.
> 
> My initial thinking this morning is that the
> security_inode_init_security() call should come before
> simple_acl_create() in both cases, but I'm open to different opinions
> on this.

Good eye.  The crucial commit here appears to be Mimi's 3.11 commit
37ec43cdc4c7 "evm: calculate HMAC after initializing posix acl on tmpfs"
which intentionally moved shmem_mknod()'s generic_acl_init() up before
the security_inode_init_security(), around the same time as Al was
copying shmem_mknod() to introduce shmem_tmpfile().

I'd have agreed with you, Paul, until reading Mimi's commit:
now it looks more like shmem_tmpfile() is the one to be changed,
except (I'm out of my depth) maybe it's irrelevant on tmpfiles.

Anyway, I think it's a question better answered by Mimi and Al.

Thanks,
Hugh
