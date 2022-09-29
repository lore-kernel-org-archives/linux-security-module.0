Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B038FC433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 11:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiI2Lkv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiI2Lkt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 07:40:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85010F72A;
        Thu, 29 Sep 2022 04:40:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D46268BFE; Thu, 29 Sep 2022 13:40:44 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:40:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 29/29] acl: remove a slew of now unused helpers
Message-ID: <20220929114044.GA19911@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-30-brauner@kernel.org> <20220929082555.GD3699@lst.de> <20220929082822.yhy7szlt3gpbqh34@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929082822.yhy7szlt3gpbqh34@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 29, 2022 at 10:28:22AM +0200, Christian Brauner wrote:
> I would like to do this in a follow-up series because afaict we need to
> massage how the ->list() handler is currently used to infer xattrs
> support. I think adressing this in a follow-up series would be better.
> There'll be more cleanups possibly anyway, I think.

True, the weird list handling complicates things a bit.  But it is a lot
of dead wood now and we should clean it up rather sooner than later.
