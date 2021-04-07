Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377BDC433B4
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Apr 2021 12:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B8D61260
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Apr 2021 12:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351996AbhDGMHT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Apr 2021 08:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231315AbhDGMHO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Apr 2021 08:07:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB32861359;
        Wed,  7 Apr 2021 12:07:00 +0000 (UTC)
Date:   Wed, 7 Apr 2021 14:06:58 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, mjg59@google.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v5 08/12] evm: Pass user namespace to set/remove xattr
 hooks
Message-ID: <20210407120658.rlu2epcbicbwb5k5@wittgenstein>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
 <20210407105252.30721-9-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407105252.30721-9-roberto.sassu@huawei.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 07, 2021 at 12:52:48PM +0200, Roberto Sassu wrote:
> In preparation for 'evm: Allow setxattr() and setattr() for unmodified
> metadata', this patch passes mnt_userns to the inode set/remove xattr hooks
> so that the GID of the inode on an idmapped mount is correctly determined
> by posix_acl_update_mode().
> 
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

Looks good,
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
