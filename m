Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D30C04A95
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 07:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiI2HwC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiI2Hv5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 03:51:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5FD13A974;
        Thu, 29 Sep 2022 00:51:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2692C68BFE; Thu, 29 Sep 2022 09:51:54 +0200 (CEST)
Date:   Thu, 29 Sep 2022 09:51:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 02/29] fs: pass dentry to set acl method
Message-ID: <20220929075153.GB3097@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-3-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(except that as usual I'd prefer to not add externs on any new
or changed prototype.  But I'm not going to repeat that for every
patch)
