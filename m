From: mtk.manpages@gmail.com (Michael Kerrisk (man-pages))
Date: Fri, 13 Apr 2018 21:29:20 +0200
Subject: [manpages PATCH] capabilities.7: describe namespaced file
	capabilities
In-Reply-To: <20180116173803.GA15538@mail.hallyn.com>
References: <20180109185218.GA21753@mail.hallyn.com>
	<CAG48ez39UyiqE539rS6RSayj4tPBfQPHPiQ=48Roi55qFJLT7g@mail.gmail.com>
	<20180116173803.GA15538@mail.hallyn.com>
Message-ID: <770ed948-c807-36d8-b946-ce6f60ffbf67@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 01/16/2018 06:38 PM, Serge E. Hallyn wrote:
> Quoting Jann Horn (jannh at google.com):
>> On Tue, Jan 9, 2018 at 7:52 PM, Serge E. Hallyn <serge@hallyn.com> wrote:

[...]

>>> +A VFS_CAP_REVISION_3 file capability will take effect only when run in a user namespace
>>> +whose UID 0 maps to the saved "nsroot", or a descendant of such a namespace.
>>> +.PP
>>> +Users with the required privilege may use
>>> +.BR setxattr(2)
>>> +to request either a VFS_CAP_REVISION_2 or VFS_CAP_REVISION_3 write.
>>> +The kernel will automatically convert a VFS_CAP_REVISION_2 to a
>>> +VFS_CAP_REVISION_3 extended attribute with the "nsroot"
>>> +set to the root user in the writer's user namespace, or, if a VFS_CAP_REVISION_3
>>> +extended attribute is specified, then the kernel will map the
>>> +specified root user ID (which must be a valid user ID mapped in the caller's
>>> +user namespace) into the initial user namespace.
>>
>> Really, "into the initial user namespace"? That may be true for the
>> kernel-internal representation, but the on-disk representation is the
>> mapping into the user namespace that contains the mount namespace into
>> which the file system was mounted, right?
> 
> Ah, yes, it is.
> 
>>  This would become observable
>> when a file system is mounted in a different namespace than before, or
>> when working with FUSE in a namespace.
> 
> Yes it would.
> 
> Michael, you said you were reworking it, do you mind working this into
> it as well?

So, I must confess that I don't really understand this piece of the
conversation--neither Jann's comments nor Serge's response (Serge, are
you saying Jann is right or wrong in his comments?). Perhaps this can
be clarified as a response to the man page text in the other mail I
just sent?

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
