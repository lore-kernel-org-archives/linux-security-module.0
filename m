Return-Path: <SRS0=wiIN=6U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6BCC47247
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 01:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABE920735
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 01:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgEFBOn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 May 2020 21:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729509AbgEFBOn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 May 2020 21:14:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AB0C061A0F;
        Tue,  5 May 2020 18:14:43 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jW8dr-001qeZ-HD; Wed, 06 May 2020 01:14:31 +0000
Date:   Wed, 6 May 2020 02:14:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] securityfs: Add missing d_delete() call on removal
Message-ID: <20200506011431.GB23230@ZenIV.linux.org.uk>
References: <202005051626.7648DC65@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005051626.7648DC65@keescook>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 05, 2020 at 04:40:35PM -0700, Kees Cook wrote:
> After using simple_unlink(), a call to d_delete() is needed in addition
> to dput().
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Is this correct? I went looking around and there are a lot of variations
> on the simple_unlink() pattern...
> 
> Many using explicit locking and combinations of d_drop(), __d_drop(), etc.

Quite a few of those should switch to simple_recursive_removal().  As for
securityfs...  d_drop() is _probably_ a saner variant, but looking at the
callers of that thing... at least IMA ones seem to be garbage.

They _might_ work since nobody else is around that early to screw them over,
but... I'm not too optimistic about that.  And the lack of d_delete()/d_drop()
here is the least of the problems, really - look at e.g. the bulk of those
suckers in ima_fs_init().  And check the callchain - it'll lead you to this
        if (error && strcmp(hash_algo_name[ima_hash_algo],
                            CONFIG_IMA_DEFAULT_HASH) != 0) {
                pr_info("Allocating %s failed, going to use default hash algorithm %s\n",
                        hash_algo_name[ima_hash_algo], CONFIG_IMA_DEFAULT_HASH);
                hash_setup_done = 0;
                hash_setup(CONFIG_IMA_DEFAULT_HASH);
                error = ima_init();
        }

        error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);

And the other IMA caller (in ima_release_policy()) is... misguided, to put it
politely.  This kind of "unlink on final close" makes no sense - if nothing
else, it can be looked up until that very point.  Moreover, this
        inode->i_mode &= ~S_IWUSR;
is obviously racy wrt permission(), and there's no damn reason to do it there.
These checks belong in ->open() and they shouldn't rely upon the damn thing
disappearing from directory or permission() failing, etc..

And looking at their ->open()... ouch.  ->f_flags & O_ACCMODE is almost
never the right thing to check.  It should be looking at ->f_mode &
FMODE_{READ,WRITE}.

I hadn't looked into details for EVM, but at the first glance it's similar
to IMA failure handling.  And probably relies upon nobody being able to
open that stuff while the things are being set up.  There seems to be
something in TPM as well - and by the look of it they are trying to work
around the use of unsuitable primitive, and none too well, at that.
I mean,
        int err;
        struct seq_file *seq;
        struct tpm_chip_seqops *chip_seqops;
        const struct seq_operations *seqops;
        struct tpm_chip *chip;

        inode_lock(inode);
        if (!inode->i_private) {
                inode_unlock(inode);
                return -ENODEV;
        }
        chip_seqops = (struct tpm_chip_seqops *)inode->i_private;
        seqops = chip_seqops->seqops;
        chip = chip_seqops->chip;
        get_device(&chip->dev);
        inode_unlock(inode);

        /* now register seq file */
        err = seq_open(file, seqops);
        if (!err) {
                seq = file->private_data;
                seq->private = chip;
        }

        return err;
doesn't look sane - late error would appear to leak &chip->dev...
