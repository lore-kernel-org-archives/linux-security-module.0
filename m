Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB74C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jun 2022 17:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiF1RqL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiF1RqK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jun 2022 13:46:10 -0400
X-Greylist: delayed 1382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 10:46:10 PDT
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F76260B;
        Tue, 28 Jun 2022 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9fZi2wVpseV5qaJLN8cZxnxeYMl08M5K1Z2WID49zDo=; b=v4FWrxlcBnWQ6N/88GLnrGBy7o
        tKSMy1wSolOLXEeAlE6mtFmhU+uBhrQoOQFkstc7W0HnfL4giQhmOp6ashAMtoP+3cNgr9+B+5S6H
        xBQ2ir1IkhQZIY1oLL77pocaVYstTjvr7qbgXIv7vKrNd6ldKwX69fl1LtU484zB/wa7/brRjYv8S
        lQTreRU21Al1j0tMJpquq73DtUdkScha8HvIFQag4yrXiOCrvo3G0gkD5RZErjIS8wdRBVBQ8FFQj
        57Z8MyoUShjtQZGLoLhK35+SvJWgf1Efcqh/YZqUeHX1r5Ldz+gK+LSYH+I36Z2XCN4FsFDhOuU2+
        e92sqrCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o6EvZ-005gwn-Aj;
        Tue, 28 Jun 2022 17:23:05 +0000
Date:   Tue, 28 Jun 2022 18:23:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v5 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
Message-ID: <Yrs4+ThR4ACb5eD/@ZenIV>
References: <20220628161948.475097-1-kpsingh@kernel.org>
 <20220628161948.475097-5-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628161948.475097-5-kpsingh@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 28, 2022 at 04:19:47PM +0000, KP Singh wrote:
> LSMs like SELinux store security state in xattrs. bpf_getxattr enables
> BPF LSM to implement similar functionality. In combination with
> bpf_local_storage, xattrs can be used to develop more complex security
> policies.
> 
> This kfunc wraps around __vfs_getxattr which can sleep and is,
> therefore, limited to sleepable programs using the newly added
> sleepable_set for kfuncs.

"Sleepable" is nowhere near enough - for a trivial example, consider
what e.g. ext2_xattr_get() does.
        down_read(&EXT2_I(inode)->xattr_sem);
in there means that having that thing executed in anything that happens
to hold ->xattr_sem is a deadlock fodder.

"Can't use that in BPF program executed in non-blocking context" is
*not* sufficient to make it safe.
