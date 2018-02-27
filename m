From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 26 Feb 2018 20:08:49 -0600
Subject: [PATCH v2 0/4] ima: unverifiable file signatures
In-Reply-To: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
	(Mimi Zohar's message of "Thu, 22 Feb 2018 16:33:00 -0500")
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <87k1uzw5e6.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> For local filesystems, the kernel prevents files being executed from
> being modified.  With IMA-measurement enabled, the kernel also emits
> audit "time of measure, time of use" messages for files opened for
> read, and subsequently opened for write.
>
> Files on fuse are initially measured, appraised, and audited.  Although
> the file data can change dynamically any time, making re-measuring,
> re-appraising, or re-auditing pointless, this patch set attempts to
> differentiate between unprivileged non-init root and privileged
> mounted fuse filesystems.
>
> This patch set addresses three different scenarios:
> - Unprivileged non-init root mounted fuse filesystems are untrusted.
>   Signature verification should always fail and re-measuring,
>   re-appraising, re-auditing files makes no sense.
>
>   Always enabled.
>
> - For privileged mounted filesystems in a "secure" environment, with a
>   correctly enforced security policy, which is willing to assume the
>   inherent risk of specific fuse filesystems, it is reasonable to
>   re-measure, re-appraise, and re-audit files.
>
>   Enabled by default to prevent breaking existing systems.
>
> - Privileged mounted filesystems unwilling to assume the risks and
>   prefers to fail safe.
>
>   Enabled based on policy.

I really like the way the flags work in this patchset.

There is a lot of other nit-picking and bike-shedding I would like to
do.  However those are details specific to IMA.  So my opion really
doesn't count.

Those two flags set as you have them in the last patch make it possible
to slightly alter details of when they get set, that are in the perview
of filesystems without having too big a debate over them.

The changes I imagine most easily are:
In fuse_fill_super:
	if (!fc->allow_other)
		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;

In sget_user_ns:
	if (sb->s_user_ns != &init_user_ns)
        	sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;


My biggest nitpick is I would be inclined to flip the sense of the
unverifiable_sigs policy.  By default not trust and trust only if
a special command line option was given.   But I realize this could
run into backwards compatibility concerns.  And it is IMA specific so
not really my call.

But the important part is what winds up in the core of ima.  Baring
typo's I think you have something we can all live with.

So double check yourself and let's start getting this merged.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
