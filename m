Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAA6C04A95
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 08:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiI2I0J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiI2IZ7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 04:25:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86345A5715;
        Thu, 29 Sep 2022 01:25:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E213268BFE; Thu, 29 Sep 2022 10:25:55 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:25:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 29/29] acl: remove a slew of now unused helpers
Message-ID: <20220929082555.GD3699@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-30-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-30-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 28, 2022 at 06:08:43PM +0200, Christian Brauner wrote:
> Now that the posix acl api is active we can remove all the hacky helpers
> we had to keep around for all these years and also remove the set and
> get posix acl xattr handler methods as they aren't needed anymore.

I think we can also remove all the xattr handlers for ACLs now, can't we?
