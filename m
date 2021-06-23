Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A7FC4743C
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jun 2021 12:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB366108E
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jun 2021 12:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhFWMbn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jun 2021 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhFWMbf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jun 2021 08:31:35 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898DC035468
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jun 2021 05:26:55 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4G92ZP0TT1zMprpm;
        Wed, 23 Jun 2021 14:26:53 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4G92ZN3lv2zlmrrs;
        Wed, 23 Jun 2021 14:26:52 +0200 (CEST)
Subject: Re: [PATCH v2 27/29] docs: userspace-api: landlock.rst: avoid using
 ReST :doc:`foo` markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
 <24888a9c5da3c505b2bc274fcd83be348dbaf972.1623824363.git.mchehab+huawei@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <7ebe5a4d-8835-6737-c006-3d065e50dc8a@digikod.net>
Date:   Wed, 23 Jun 2021 14:26:43 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <24888a9c5da3c505b2bc274fcd83be348dbaf972.1623824363.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 16/06/2021 08:27, Mauro Carvalho Chehab wrote:
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/userspace-api/landlock.rst | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Acked-by: Mickaël Salaün <mic@linux.microsoft.com>

Like others, I think it would be nice to explain the reason of this
change in the commit message, and why it is better than the current way
to do it.

> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 62c9361a3c7f..f35552ff19ba 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -145,7 +145,8 @@ Bind mounts and OverlayFS
>  
>  Landlock enables to restrict access to file hierarchies, which means that these
>  access rights can be propagated with bind mounts (cf.
> -:doc:`/filesystems/sharedsubtree`) but not with :doc:`/filesystems/overlayfs`.
> +Documentation/filesystems/sharedsubtree.rst) but not with
> +Documentation/filesystems/overlayfs.rst.
>  
>  A bind mount mirrors a source file hierarchy to a destination.  The destination
>  hierarchy is then composed of the exact same files, on which Landlock rules can
> @@ -170,8 +171,8 @@ Inheritance
>  
>  Every new thread resulting from a :manpage:`clone(2)` inherits Landlock domain
>  restrictions from its parent.  This is similar to the seccomp inheritance (cf.
> -:doc:`/userspace-api/seccomp_filter`) or any other LSM dealing with task's
> -:manpage:`credentials(7)`.  For instance, one process's thread may apply
> +Documentation/userspace-api/seccomp_filter.rst) or any other LSM dealing with
> +task's :manpage:`credentials(7)`.  For instance, one process's thread may apply
>  Landlock rules to itself, but they will not be automatically applied to other
>  sibling threads (unlike POSIX thread credential changes, cf.
>  :manpage:`nptl(7)`).
> @@ -278,7 +279,7 @@ Memory usage
>  ------------
>  
>  Kernel memory allocated to create rulesets is accounted and can be restricted
> -by the :doc:`/admin-guide/cgroup-v1/memory`.
> +by the Documentation/admin-guide/cgroup-v1/memory.rst.
>  
>  Questions and answers
>  =====================
> @@ -303,7 +304,7 @@ issues, especially when untrusted processes can manipulate them (cf.
>  Additional documentation
>  ========================
>  
> -* :doc:`/security/landlock`
> +* Documentation/security/landlock.rst
>  * https://landlock.io
>  
>  .. Links
> 
