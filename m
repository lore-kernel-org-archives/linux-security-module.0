Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F996C6FA82
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiI2IRf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiI2IRb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 04:17:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF913E7F2;
        Thu, 29 Sep 2022 01:17:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DB8D68BFE; Thu, 29 Sep 2022 10:17:27 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:17:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 14/29] acl: add vfs_set_acl()
Message-ID: <20220929081727.GB3699@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-15-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-15-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> +EXPORT_SYMBOL(vfs_set_acl);

I think all this stackable file system infrastucture should be
EXPORT_SYMBOL_GPL, like a lot of the other internal stuff.

> +int xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
> +		     const char *name, int mask)

Hmm.  The only think ACLs actually need from xattr_permission are
the immutable / append check and the HAS_UNMAPPED_ID one.  I'd rather
open code that, or if you cane come up with a sane name do a smaller
helper rather than doing all the strcmp on the prefixes for now
good reason.

> +static inline int vfs_set_acl(struct user_namespace *mnt_userns,
> +			      struct dentry *dentry, const char *name,
> +			      struct posix_acl *acl)
> +{
> +	return 0;

Should this really return 0 if ACLs are not supported?
