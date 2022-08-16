Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC2C25B0E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Aug 2022 23:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiHPXRw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiHPXRv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Aug 2022 19:17:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8278B980
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 16:17:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy5so21693320ejc.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AMn3B3jYdCVxak8yksa8T7jS8rFLGuSxkkP5+8axw1A=;
        b=Vm9rZhcUXu8DUu2U13LfpsCp0dP7Fg/9rAJeZp9YtlQ9Rq7Y9VtHRIc4gUGBrf6ABe
         +ZW0OMEq5BRJFyJbSJSx/y9p2lZo+15ohYnjJN9vM+Oe2v51uKNkPu3wDgexSVnVScq8
         +r2XB8pHGFS6YRv4syJ3wdNKjMUHxv1d12zww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AMn3B3jYdCVxak8yksa8T7jS8rFLGuSxkkP5+8axw1A=;
        b=c+2RFqxzTWL0oH5Jjc/1IvByvh8dstqKI1md7+fmOEp2OPwZAmKVaDjY8BoSaXoMQk
         PbFmYDLJDmc6jbHaQaTmHMv3/jlQucmvxe8UENFGDoj36J2AIjeL9RMXjCyTt1d0kRwj
         42Y8bqdpniXFp1B2D9YIaqvHx8Xy+Map3fVu19NO5Ea7suX7TkNE9I5LVlA5pTFKHOis
         VvOY24q7+XHcnua968QX7l/hiIadF2ETfGSR6SUkgFO0wSAH/YPbiDm8/r9ex0qmQG21
         2/g9NVNLRaX2bD0ollMjBNVT+FrGtzIR7cDl21inDD/tAcww7X2iQB4d7A2D0gBoCNDJ
         Qq0Q==
X-Gm-Message-State: ACgBeo09S4D1j7L9aMGaZqAcoxUvzyI43g3P3vRRgTWvjdnLBZgOoZHE
        M5Ki0ieAibyOB5NqWuS9tO1gIhVZOaGOnkG+61k=
X-Google-Smtp-Source: AA6agR6w26Ycw/J/ZrBtqjggt8p/DpbMbKdujj3nO5i7EoXBVTBoGwz7yslWWnfck7QRvRK0Xb205w==
X-Received: by 2002:a17:907:1361:b0:732:fefd:a25c with SMTP id yo1-20020a170907136100b00732fefda25cmr15171343ejb.669.1660691868694;
        Tue, 16 Aug 2022 16:17:48 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090640c300b00731335b7ceasm5976404ejk.14.2022.08.16.16.17.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 16:17:48 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso150378wmb.2
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 16:17:48 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr383338wme.8.1660691398572; Tue, 16 Aug
 2022 16:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <YvvBs+7YUcrzwV1a@ZenIV> <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org> <b05cf115-e329-3c4f-dee5-e0d4f61b4cd5@schaufler-ca.com>
In-Reply-To: <b05cf115-e329-3c4f-dee5-e0d4f61b4cd5@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Aug 2022 16:09:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRs8k0pKy36cXYnBFVCJDP5DQMf6JM7FnRJz5tF4cMBA@mail.gmail.com>
Message-ID: <CAHk-=wiRs8k0pKy36cXYnBFVCJDP5DQMf6JM7FnRJz5tF4cMBA@mail.gmail.com>
Subject: Re: Switching to iterate_shared
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        jfs-discussion@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 16, 2022 at 3:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Smack passes all tests and seems perfectly content with the change.
> I can't say that the tests stress this interface.

All the security filesystems really seem to boil down to just calling
that 'proc_pident_readdir()' function with different sets of 'const
struct pid_entry' arrays.

And all that does is to make sure the pidents are filled in by that
proc_fill_cache(), which basically does a filename lookup.

And a filename lookup *already* has to be able to handle being called
in parallel, because that's how filename lookup works:

  [.. miss in dcache ..]
  lookup_slow ->
      inode_lock_shared(dir);
      __lookup_slow -> does the
      inode_unlock_shared(dir);

so as long as the proc_fill_cache() handles the d_in_lookup()
situation correctly (where we serialize on one single _name_ in the
directory), that should all be good.

And proc_fill_cache() does indeed seem to handle it right - and if it
didn't, it would be fundamentally racy with regular lookups - so I
think all those security layer proc_##LSM##_attr_dir_iterate cases can
be moved over to iterate_shared with no code change.

But again, maybe there's something really subtle I'm overlooking. Or
maybe not something subtle at all, and I'm just missing a big honking
issue.

            Linus
