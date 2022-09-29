Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A068DC07E9D
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 07:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiI2Hu6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiI2Hue (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 03:50:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1305B794;
        Thu, 29 Sep 2022 00:50:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3747168BFE; Thu, 29 Sep 2022 09:50:26 +0200 (CEST)
Date:   Thu, 29 Sep 2022 09:50:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 01/29] orangefs: rework posix acl handling when
 creating new filesystem objects
Message-ID: <20220929075026.GA3097@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-2-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> +extern int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl,
> +			      int type);

No real need for the extern here (or any other function prototype in
headers).

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
